//
//  GlobalFunctions.m
//
//  Created by Eric D'Souza on 11-11-04.
//  Copyright (c) 2012 Eric D'Souza. All rights reserved.
//

#import "GlobalFunctions.h"
#import "SingletonClass.h"
#import "RestaurantClass.h"
#import "UIColorExtensions.h"
#import <QuartzCore/QuartzCore.h>
#import "Reachability.h"

#import "MenuViewController.h"
#import "OrderViewController.h"
#import "LocationViewController.h"
#import "SpecialOffersViewController.h"
#import "AboutViewController.h"


@implementation GlobalFunctions

static GlobalFunctions* _theGlobalFunctions = nil;


+ (GlobalFunctions*) theGlobalFunctions;
{
    if (!_theGlobalFunctions)
        _theGlobalFunctions = [[GlobalFunctions alloc] init];
    return _theGlobalFunctions;
}

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

#pragma mark - start up tasks

+ (NSMutableArray *)createTabBarControllers
{
    // build tabs based on restaurant settings
    NSMutableArray *tabArray = [[NSMutableArray alloc] initWithCapacity:5];
    
    // menu tab
    UIViewController *viewController1 = [[MenuViewController alloc] initWithNibName:@"MenuViewController" bundle:nil];
    [tabArray addObject:viewController1];
    
    // order tab
    UIViewController *viewController2 = [[OrderViewController alloc] initWithNibName:@"OrderViewController" bundle:nil];
    [tabArray addObject:viewController2];
    
    // offers tab
    UIViewController *viewController3 = [[SpecialOffersViewController alloc] initWithNibName:@"SpecialOffersViewController" bundle:nil];
    if (kShowOffersTab)
        [tabArray addObject:viewController3];
    
    // location tab
    UIViewController *viewController4 = [[LocationViewController alloc] initWithNibName:@"LocationViewController" bundle:nil];
    [tabArray addObject:viewController4];
    
    // about tab
    UIViewController *viewController5 = [[AboutViewController alloc] initWithNibName:@"AboutViewController" bundle:nil];
    [tabArray addObject:viewController5];
    
    return tabArray;
    
}


#pragma mark - device capabilities

+ (BOOL)canConnectToInternet
{
    BOOL hasAccess;
    
    Reachability *r = [Reachability reachabilityWithHostName:@"www.google.com"];
    NetworkStatus internetStatus = [r currentReachabilityStatus];
    if ((internetStatus != ReachableViaWiFi) && (internetStatus != ReachableViaWWAN))
        hasAccess = FALSE;
    else
        hasAccess = TRUE;
    
    return hasAccess;
}

+ (BOOL)canMakePhoneCalls
{
	return [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"tel://"]];
}

+ (BOOL)canTweet
{
    BOOL hasTwitterIntegration;

    Class tweeterClass = NSClassFromString(@"TWTweetComposeViewController");
    if(tweeterClass == nil)    
        hasTwitterIntegration = FALSE;
    else
        hasTwitterIntegration = TRUE;
    
    return hasTwitterIntegration;
}


#pragma mark - custom stuff

+ (UIButton *)greenCircleWithTag:(NSInteger)tag
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(5,17,10,10);
    [button setBackgroundColor:[UIColor appleHighlightBlueColor]];
    button.layer.cornerRadius = 5.0;
    button.layer.masksToBounds = YES;
    button.tag = tag;
    
    return button;
}


+ (NSString *)detailTextLabelForArray:(NSArray *)myArray andRow:(NSInteger)row
{
    NSString *detailText = @"";
    
    NSString *quantity = [(NSDictionary *)[myArray objectAtIndex:row] objectForKey:kQuantity];
    if (![quantity isEqualToString:@"1"])
        detailText = [NSString stringWithFormat:@"Qty %@", quantity];
    
    
    NSString *note = [(NSDictionary *)[myArray objectAtIndex:row] objectForKey:kNote];
    
    if  (! ((!note) || [note isEqualToString:@""]))
    {
        if (![detailText isEqualToString:@""])
            detailText = [detailText stringByAppendingString:@" - "];
        
        detailText = [detailText stringByAppendingString:note];
    }
    
    return detailText;
}


#pragma mark - retrieving values

+ (NSString *)phoneNumberForActiveLocation
{
    NSString *phoneNumber = [(NSDictionary *)[[RestaurantClass restaurantDataInstance].restaurants objectAtIndex:[SingletonClass sharedDataInstance].activeLocation] objectForKey:kPhoneNumber];
    
    return phoneNumber;
}


+ (NSString *)pointTitleForActiveLocation
{
    NSString *pointTitle = [(NSDictionary *)[[RestaurantClass restaurantDataInstance].restaurants objectAtIndex:[SingletonClass sharedDataInstance].activeLocation] objectForKey:kPointTitle];
    
    return pointTitle;
}

+ (NSString *)pointSubtitleForActiveLocation
{
    NSString *pointSubtitle = [(NSDictionary *)[[RestaurantClass restaurantDataInstance].restaurants objectAtIndex:[SingletonClass sharedDataInstance].activeLocation] objectForKey:kPointSubtitle];
    
    return pointSubtitle;
}

+ (CLLocation *)clLocationForActiveLocation
{
    CLLocation *theLocation = [[CLLocation alloc] init];
    theLocation = [(NSDictionary *)[[RestaurantClass restaurantDataInstance].restaurants objectAtIndex:[SingletonClass sharedDataInstance].activeLocation] objectForKey:kLocation];    
    
    return theLocation;
}


+ (int)orderQuantityForItemId:(NSString *)itemId
{
    SingletonClass *sharedData = [SingletonClass sharedDataInstance];

    int quantity = 0;
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(%K == %@)", kItemId, itemId];
    NSArray *filteredArray = [sharedData.orderItems filteredArrayUsingPredicate:predicate];
    if ([filteredArray count] > 0)
        quantity = [[(NSDictionary *)[filteredArray objectAtIndex:0] objectForKey:kQuantity] integerValue];
    
    return quantity;
}

+ (NSString *)orderNoteForItemId:(NSString *)itemId
{
    SingletonClass *sharedData = [SingletonClass sharedDataInstance];
    
    NSString *note = @"";
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(%K == %@)", kItemId, itemId];
    NSArray *filteredArray = [sharedData.orderItems filteredArrayUsingPredicate:predicate];
    if ([filteredArray count] > 0)
        note = [(NSDictionary *)[filteredArray objectAtIndex:0] objectForKey:kNote];
    
    return note;
}

+ (BOOL)orderContainsItemId:(NSString *)itemId
{
    SingletonClass *sharedData = [SingletonClass sharedDataInstance];

    BOOL itemExists = FALSE;
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(%K == %@)", kItemId, itemId];
    NSArray *filteredArray = [sharedData.orderItems filteredArrayUsingPredicate:predicate];
    if ([filteredArray count] > 0)
        itemExists = TRUE;
    
    return itemExists;
}

+ (NSString *)menuItemForItemId:(NSString *)itemId
{
    RestaurantClass *restaurantData = [RestaurantClass restaurantDataInstance];
    
    NSString *item = @"";
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(%K == %@)", kItemId, itemId];
    NSArray *filteredArray = [restaurantData.menuItems filteredArrayUsingPredicate:predicate];
    if ([filteredArray count] > 0)
        item = [(NSDictionary *)[filteredArray objectAtIndex:0] objectForKey:kItem];
    
    return item;
}

+ (NSString *)menuItemDescForItemId:(NSString *)itemId
{
    RestaurantClass *restaurantData = [RestaurantClass restaurantDataInstance];
    
    NSString *itemDesc = @"";
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(%K == %@)", kItemId, itemId];
    NSArray *filteredArray = [restaurantData.menuItems filteredArrayUsingPredicate:predicate];
    if ([filteredArray count] > 0)
        itemDesc = [(NSDictionary *)[filteredArray objectAtIndex:0] objectForKey:kItemDesc];
    
    return itemDesc;
}

+ (NSString *)menuImageNameForItemId:(NSString *)itemId
{
    RestaurantClass *restaurantData = [RestaurantClass restaurantDataInstance];
    
    NSString *imageName = @"";
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(%K == %@)", kItemId, itemId];
    NSArray *filteredArray = [restaurantData.menuItems filteredArrayUsingPredicate:predicate];
    if ([filteredArray count] > 0)
        imageName = [(NSDictionary *)[filteredArray objectAtIndex:0] objectForKey:kImageName];
    
    if ([imageName isEqualToString:@""])
        imageName =  @"default-item-image";
    
    return imageName;
}

+ (NSString *)menuPriceForItemId:(NSString *)itemId
{
    RestaurantClass *restaurantData = [RestaurantClass restaurantDataInstance];
    
    NSString *unformattedPrice = @"";
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(%K == %@)", kItemId, itemId];
    NSArray *filteredArray = [restaurantData.menuItems filteredArrayUsingPredicate:predicate];
    if ([filteredArray count] > 0)
        unformattedPrice = [(NSDictionary *)[filteredArray objectAtIndex:0] objectForKey:kPrice];
    
    float floatPrice = [unformattedPrice floatValue];
    NSString *formattedPrice = [NSString stringWithFormat:@"$%.02f", floatPrice];
    
    return formattedPrice;
}

+ (NSString *)itemIdForSection:(int)section andRow:(int)row
{
    RestaurantClass *restaurantData = [RestaurantClass restaurantDataInstance];
    
    // get sectionName from section
    NSString *sectionName = [(NSDictionary *)[restaurantData.menuSections objectAtIndex:section] objectForKey:kSectionName];

    // filter menuItems for those in sectionName
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(%K == %@)", kSectionName, sectionName];
    NSArray *filteredArray = [restaurantData.menuItems filteredArrayUsingPredicate:predicate];

    // get itemId at row
    NSString *itemId = [(NSDictionary *)[filteredArray objectAtIndex:row] objectForKey:kItemId];
    
    return itemId;
}

#pragma mark - order management

+ (int)updateOrder:(NSString *)itemId withQuantity:(int)updatedQuantity
{
    SingletonClass *sharedData = [SingletonClass sharedDataInstance];
    NSLog(@"updateOrder itemId %@ withQuantity %d", itemId, updatedQuantity);
    
    // this seems like a very round-a-bout way of changing a value in a NSMutableArray of NSDictionary objects
    // but I couldn't figure out an easier way
    
    // retrieve dictionary item that needs updating
    NSPredicate *itemPredicate = [NSPredicate predicateWithFormat:@"(%K == %@)", kItemId, itemId];
    NSArray *itemInOrder = [sharedData.orderItems filteredArrayUsingPredicate:itemPredicate];
    
    NSString *itemNote = @"";
    NSString *quantity = [NSString stringWithFormat:@"%d",updatedQuantity];
    
    // save other values if item exists 
    if ([itemInOrder count] > 0)
        itemNote = [(NSDictionary *)[itemInOrder objectAtIndex:0] objectForKey:kNote];
    
    // create new dictionary item with update
    NSDictionary *orderItem = [[NSDictionary alloc] initWithObjectsAndKeys:
                               itemId, kItemId,
                               quantity, kQuantity,
                               itemNote, kNote,
                               nil];
    
    // retrieve rest of dictionary items 
    NSPredicate *restOfOrderPredicate = [NSPredicate predicateWithFormat:@"(%K != %@)", kItemId, itemId];
    NSMutableArray *restOfItemsInOrder = [NSMutableArray arrayWithArray:[sharedData.orderItems filteredArrayUsingPredicate:restOfOrderPredicate]];
    
    // add just-created dictionary item to rest ot items
    [restOfItemsInOrder addObject:orderItem];
    
    // replace original array
    sharedData.orderItems = [NSMutableArray arrayWithArray:restOfItemsInOrder];
    
    return 0;  
    
}


+ (int)deleteItemFromOrder:(NSString *)itemId
{
    SingletonClass *sharedData = [SingletonClass sharedDataInstance];
        
    NSPredicate *itemPredicate = [NSPredicate predicateWithFormat:@"(%K == %@)", kItemId, itemId];
    NSArray *itemInOrder = [sharedData.orderItems filteredArrayUsingPredicate:itemPredicate];
    
    if ([itemInOrder count] > 0)
    {
        NSPredicate *restOfOrderPredicate = [NSPredicate predicateWithFormat:@"(%K != %@)", kItemId, itemId];
        NSMutableArray *restOfItemsInOrder = [NSMutableArray arrayWithArray:[sharedData.orderItems filteredArrayUsingPredicate:restOfOrderPredicate]];
        
        sharedData.orderItems = [NSMutableArray arrayWithArray:restOfItemsInOrder];
    }
        
    return 1;  // maybe in the future we'll add error codes
    
}


+ (int)addItemToOrderFromFavs:(NSString *)itemId
{
    SingletonClass *sharedData = [SingletonClass sharedDataInstance];
        
    NSPredicate *orderPredicate = [NSPredicate predicateWithFormat:@"(%K == %@)", kItemId, itemId];
    NSArray *itemInOrder = [sharedData.orderItems filteredArrayUsingPredicate:orderPredicate];
    
    NSPredicate *favsPredicate = [NSPredicate predicateWithFormat:@"(%K == %@)", kItemId, itemId];
    NSArray *itemInFavs = [sharedData.favItems filteredArrayUsingPredicate:favsPredicate];

    // only add to order if it's not there already
    // ie, we don't want to override any changes to the item that user may have made
    // the item *should* be in favs, but we check just in case
    if (([itemInOrder count] == 0) && ([itemInFavs count] > 0))
    {
        NSString *quantity = [(NSDictionary *)[itemInFavs objectAtIndex:0] objectForKey:kQuantity];
        NSString *note = [(NSDictionary *)[itemInFavs objectAtIndex:0] objectForKey:kNote];

        NSDictionary *orderItem = [[NSDictionary alloc] initWithObjectsAndKeys:
                                   itemId, kItemId,
                                   quantity, kQuantity,
                                   note, kNote,
                                   nil];
        
        [sharedData.orderItems addObject:orderItem];
    }
    
    return 0;
    
}


+ (int)updateOrder:(NSString *)itemId withNote:(NSString *)updatedNote
{
    SingletonClass *sharedData = [SingletonClass sharedDataInstance];
    NSLog(@"updateOrder itemId %@ updatedNote %@", itemId, updatedNote);
       
    // this seems like a very round-a-bout way of changing a value in a NSMutableArray of NSDictionary objects
    // but I couldn't figure out an easier way
    
    // retrieve dictionary item that needs updating
    NSPredicate *itemPredicate = [NSPredicate predicateWithFormat:@"(%K == %@)", kItemId, itemId];
    NSArray *itemInOrder = [sharedData.orderItems filteredArrayUsingPredicate:itemPredicate];

    if ([itemInOrder count] == 0)
        return 1;
        
    // save other values 
    NSString *itemQuantity = [(NSDictionary *)[itemInOrder objectAtIndex:0] objectForKey:kQuantity];
    
    // create new dictionary item with update
    NSDictionary *orderItem = [[NSDictionary alloc] initWithObjectsAndKeys:
                               itemId, kItemId,
                               itemQuantity, kQuantity,
                               updatedNote, kNote,
                               nil];
    
    // retrieve rest of dictionary items 
    NSPredicate *restOfOrderPredicate = [NSPredicate predicateWithFormat:@"(%K != %@)", kItemId, itemId];
    NSMutableArray *restOfItemsInOrder = [NSMutableArray arrayWithArray:[sharedData.orderItems filteredArrayUsingPredicate:restOfOrderPredicate]];
    
    // add just-created dictionary item to rest ot items
    [restOfItemsInOrder addObject:orderItem];
    
    // replace original array
    sharedData.orderItems = [NSMutableArray arrayWithArray:restOfItemsInOrder];

    return 0;  
    
}


#pragma mark - place order

+ (void)placeOrderByPhone
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@", [GlobalFunctions phoneNumberForActiveLocation]]];
    [[UIApplication sharedApplication] openURL:url];
    
    NSLog(@"call completed");
}


#pragma mark - favs management

+ (int)addItemToFavs:(NSString *)itemId
{
    SingletonClass *sharedData = [SingletonClass sharedDataInstance];
    
    int returnCode = 0;
    
    
    // if item exists in order, then grab quantity and notes
    NSPredicate *orderPredicate = [NSPredicate predicateWithFormat:@"(%K == %@)", kItemId, itemId];
    NSArray *itemInOrder = [sharedData.orderItems filteredArrayUsingPredicate:orderPredicate];
    
    NSString *quantity = @"1";
    NSString *note = @"";
    
    if ([itemInOrder count] > 0)
    {
        quantity = [(NSDictionary *)[itemInOrder objectAtIndex:0] objectForKey:kQuantity];
        note = [(NSDictionary *)[itemInOrder objectAtIndex:0] objectForKey:kNote];
    }

    // create fav dictionary item 
    NSDictionary *favItem = [[NSDictionary alloc] initWithObjectsAndKeys:
                               itemId, kItemId,
                               quantity, kQuantity,
                               note, kNote,
                               nil];
    

    
    // check if item exists in favs
    NSPredicate *itemPredicate = [NSPredicate predicateWithFormat:@"(%K == %@)", kItemId, itemId];
    NSArray *itemInFavs = [sharedData.favItems filteredArrayUsingPredicate:itemPredicate];
    
    if ([itemInFavs count] == 0)
    {
        [sharedData.favItems addObject:favItem];
    }
    else
    {
        // this seems like a very round-a-bout way of changing a value in a NSMutableArray of NSDictionary objects
        // but I couldn't figure out an easier way
        
        NSPredicate *restOfFavsPredicate = [NSPredicate predicateWithFormat:@"(%K != %@)", kItemId, itemId];
        NSMutableArray *restOfFavItems = [NSMutableArray arrayWithArray:[sharedData.favItems filteredArrayUsingPredicate:restOfFavsPredicate]];
        
        [restOfFavItems addObject:favItem];
        
        sharedData.favItems = [NSMutableArray arrayWithArray:restOfFavItems];
    }
    
    NSLog(@"favs %@", sharedData.favItems);
    
    return returnCode;
    
}


+ (int)deleteItemFromFavs:(NSString *)itemId
{
    SingletonClass *sharedData = [SingletonClass sharedDataInstance];
    
    NSPredicate *favPredicate = [NSPredicate predicateWithFormat:@"(%K == %@)", kItemId, itemId];
    NSArray *itemInFavs = [sharedData.favItems filteredArrayUsingPredicate:favPredicate];
    
    if ([itemInFavs count] > 0)
    {
        NSPredicate *restOfFavsPredicate = [NSPredicate predicateWithFormat:@"(%K != %@)", kItemId, itemId];
        NSMutableArray *restOfFavItems = [NSMutableArray arrayWithArray:[sharedData.favItems filteredArrayUsingPredicate:restOfFavsPredicate]];
            
        sharedData.favItems = [NSMutableArray arrayWithArray:restOfFavItems];
    }
    
    NSLog(@"order %@", sharedData.favItems);
    
    return 1;  // maybe in the future we'll add error codes
    
}


#pragma mark - app data archiving

+ (void)archiveAppData
{
    NSLog(@"archiveAppData");
    SingletonClass *sharedData = [SingletonClass sharedDataInstance];

    
    NSMutableArray *appData = [[NSMutableArray alloc] init];
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
    
    NSArray *tmpArray = [NSArray arrayWithArray:sharedData.orderItems];
    [dictionary setObject:tmpArray forKey:@"orderItems"];

    tmpArray = [NSArray arrayWithArray:sharedData.favItems];
    [dictionary setObject:tmpArray forKey:@"favItems"];
    
    [appData addObject:dictionary];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDirectory = [paths objectAtIndex:0];
    NSString *fullFilePath = [docDirectory stringByAppendingPathComponent:kAppArchiveDatafile];   
    NSLog(@"fullFilePath %@", fullFilePath);
    [NSKeyedArchiver archiveRootObject: appData toFile:fullFilePath];
    
}

+ (void)deleteArchivedAppData
{
    NSLog(@"deleteArchivedAppData");
    
    NSMutableArray *emptyArray = [[NSMutableArray alloc] init];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDirectory = [paths objectAtIndex:0];
    NSString *fullFilePath = [docDirectory stringByAppendingPathComponent:kAppArchiveDatafile];    
    [NSKeyedArchiver archiveRootObject: emptyArray toFile:fullFilePath];
    
}

+ (BOOL)archivedAppDataExists
{
    NSLog(@"archivedAppDataExists");

    BOOL archiveExists = FALSE;
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDirectory = [paths objectAtIndex:0];
    NSString *fullFilePath = [docDirectory stringByAppendingPathComponent:kAppArchiveDatafile];    
    NSArray *appData = [NSKeyedUnarchiver unarchiveObjectWithFile:fullFilePath];
    
    if ([appData count] > 0)
        archiveExists = TRUE;
        
    else
        archiveExists = FALSE;
    
    
    // get all files in directory
    NSError * error;
    NSArray * directoryContents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:docDirectory error:&error];
    NSLog(@"directory contents %@",directoryContents);        
    
    // get size of file
    NSError *err = nil;
    NSDictionary *fattrib = [[NSFileManager defaultManager] attributesOfItemAtPath:fullFilePath error:&err];
    if (fattrib != nil)            
        NSLog(@"file size %llu", [fattrib fileSize]);

    return archiveExists;
    
}

+ (void)unarchiveAppData
{
    SingletonClass *sharedData = [SingletonClass sharedDataInstance];

    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDirectory = [paths objectAtIndex:0];
    NSString *fullFilePath = [docDirectory stringByAppendingPathComponent:kAppArchiveDatafile];    
    NSArray *appData = [NSKeyedUnarchiver unarchiveObjectWithFile:fullFilePath];

    NSMutableDictionary *dictionary = [appData objectAtIndex:0];

    NSArray *tmpArray = [(NSDictionary *)dictionary objectForKey:@"orderItems"];
    sharedData.orderItems = [NSMutableArray arrayWithArray:tmpArray];

    tmpArray = [(NSDictionary *)dictionary objectForKey:@"favItems"];
    sharedData.favItems = [NSMutableArray arrayWithArray:tmpArray];
    
}


@end
