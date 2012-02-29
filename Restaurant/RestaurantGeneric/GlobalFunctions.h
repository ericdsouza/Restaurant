//
//  GlobalFunctions.h
//
//  Created by Eric D'Souza on 11-11-04.
//  Copyright (c) 2012 Eric D'Souza. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LocationViewController.h"


@interface GlobalFunctions : NSObject {
    
    @private
    
}

+ (GlobalFunctions*) theGlobalFunctions;

+ (NSMutableArray *)createTabBarControllers;


+ (BOOL)canConnectToInternet;
+ (BOOL)canMakePhoneCalls;
+ (BOOL)canTweet;

+ (UIButton *)greenCircleWithTag:(NSInteger)tag;
+ (NSString *)detailTextLabelForArray:(NSArray *)myArray andRow:(NSInteger)row;


// retrieving values
+ (NSString *)phoneNumberForActiveLocation;
+ (CLLocation *)clLocationForActiveLocation;
+ (NSString *)pointTitleForActiveLocation;
+ (NSString *)pointSubtitleForActiveLocation;

+ (int)orderQuantityForItemId:(NSString *)itemId;
+ (NSString *)orderNoteForItemId:(NSString *)itemId;

+ (BOOL)orderContainsItemId:(NSString *)itemId;

+ (NSString *)menuItemForItemId:(NSString *)itemId;
+ (NSString *)menuItemDescForItemId:(NSString *)itemId;
+ (NSString *)menuImageNameForItemId:(NSString *)itemId;
+ (NSString *)menuPriceForItemId:(NSString *)itemId;

+ (NSString *)itemIdForSection:(int)section andRow:(int)row;



// order management
+ (int)updateOrder:(NSString *)itemId withNote:(NSString *)updatedNote;
+ (int)updateOrder:(NSString *)itemId withQuantity:(int)updatedQuantity;
+ (int)addItemToOrderFromFavs:(NSString *)itemId;
+ (int)deleteItemFromOrder:(NSString *)itemId;

// fav management
+ (int)addItemToFavs:(NSString *)itemId;
+ (int)deleteItemFromFavs:(NSString *)itemId;

// place order
+ (void) placeOrderByPhone;

// app data archive
+ (void) archiveAppData;
+ (BOOL) archivedAppDataExists;
+ (void) unarchiveAppData;
+ (void) deleteArchivedAppData;

@end


