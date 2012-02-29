//
//  RestaurantClass.h
//
//  Created by Eric D'Souza on 12-02-23.
//  Copyright (c) 2012 Eric D'Souza. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const kFacebookAppId;
extern NSString * const kAppArchiveDatafile;

extern NSString * const kOrderTakingCapabilities;
extern NSString * const kRestaurantName;
extern NSString * const kContactEmail;
extern NSString * const kTwitterScreenName;
extern NSString * const kRestaurantFacebookPage;
extern BOOL const kShowOffersTab;


@interface RestaurantClass : NSObject 
{
    
    NSArray *menuSections;
    NSArray *menuItems;
    NSArray *restaurants;
    
    @private
    
}

@property (nonatomic, strong) NSArray *menuSections;
@property (nonatomic, strong) NSArray *menuItems;
@property (nonatomic, strong) NSArray *restaurants;

+(RestaurantClass*) restaurantDataInstance;

@end
