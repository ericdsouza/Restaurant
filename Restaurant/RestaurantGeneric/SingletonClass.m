//
//  SingletonClass.m
//
//  Created by Eric D'Souza on 11-08-25.
//  Copyright 2012 Eric D'Souza. All rights reserved.
//

#import "SingletonClass.h"
#import "GlobalFunctions.h"

NSString * const kSectionHeader = @"SectionHeader";
NSString * const kSectionFooter = @"SectionFooter";
NSString * const kSectionName = @"SectionName";
NSString * const kItem = @"Item";
NSString * const kItemId = @"ItemId";
NSString * const kItemDesc = @"ItemDesc";
NSString * const kPrice = @"Price";
NSString * const kImageName = @"ImageName";
NSString * const kQuantity = @"Quantity";
NSString * const kNote = @"Note";
NSString * const kLocation = @"Location";
NSString * const kPhoneNumber = @"PhoneNumber";

NSString * const kPointTitle = @"PointTitle";
NSString * const kPointSubtitle = @"PointSubtitle";



@implementation SingletonClass

@synthesize orderItems, favItems;
@synthesize activeLocation;


+(SingletonClass*) sharedDataInstance {
    static SingletonClass *sharedDataInstance;
    @synchronized(self) {
        if(!sharedDataInstance){
            sharedDataInstance = [[SingletonClass alloc] init];
        }
    }
    return sharedDataInstance;
}

-(id) init;
{
    self = [super init];
    if (!self) return nil;

    // capacity:10 is just a number for memory managment, and does not restrict table size
    self.orderItems = [NSMutableArray arrayWithCapacity:10];
    self.favItems = [NSMutableArray arrayWithCapacity:10];
    
    activeLocation = 0;
    
    return self;

}


@end