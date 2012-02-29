//
//  RestaurantAppDelegate.h
//  Restaurant
//
//  Created by Eric D'Souza on 12-02-28.
//  Copyright (c) 2012 Eric D'Souza. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SingletonClass.h"


@interface RestaurantAppDelegate : UIResponder <UIApplicationDelegate, UITabBarControllerDelegate>{
    
    @private SingletonClass *sharedData;
    
}



@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) UITabBarController *tabBarController;

@end
