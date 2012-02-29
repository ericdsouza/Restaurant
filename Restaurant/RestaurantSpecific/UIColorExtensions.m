//
//  UIColorExtensions.m
//  TheRealJerk
//
//  Created by Eric D'Souza on 12-02-23.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "UIColorExtensions.h"

@implementation UIColor (Extensions)

+ (UIColor *)appleDeleteRedColor 
{
    static UIColor* appleDeleteRed = nil;
    if (appleDeleteRed == nil)
    {
        appleDeleteRed = [UIColor colorWithRed:189.0/255.0 green:20.0/255.0 blue:33.0/255.0 alpha:1.0];
    }
    return appleDeleteRed;
}

+ (UIColor *)appleHighlightBlueColor 
{
    static UIColor* appleHighlightBlue = nil;
    if (appleHighlightBlue == nil)
    {
        appleHighlightBlue = [UIColor colorWithRed:60.0/255.0 green:128.0/255.0 blue:232.0/255.0 alpha:1.0];
    }
    return appleHighlightBlue;
}

+ (UIColor *)appleButtonBlueColor 
{
    static UIColor* appleAppleButtonBlue = nil;
    if (appleAppleButtonBlue == nil)
    {
        appleAppleButtonBlue = [UIColor colorWithRed:50.0/255.0 green:79.0/255.0 blue:133.0/255.0 alpha:1.0];
    }
    return appleAppleButtonBlue;
}

+ (UIColor *)restaurantBackgroundDarkColor 
{
    static UIColor* restaurantBackgroundDark = nil;
    if (restaurantBackgroundDark == nil)
    {
        restaurantBackgroundDark = [UIColor colorWithRed:112.0/255.0 green:110.0/255.0 blue:0.0/255.0 alpha:1.0];
    }
    return restaurantBackgroundDark;
}

+ (UIColor *)restaurantBackgroundLightColor 
{
    static UIColor* restaurantBackgroundLight = nil;
    if (restaurantBackgroundLight == nil)
    {
        restaurantBackgroundLight = [UIColor colorWithRed:191.0/255.0 green:180.0/255.0 blue:0.0/255.0 alpha:1.0];
    }
    return restaurantBackgroundLight;
}

+ (UIColor *)restaurantTextColor 
{
    static UIColor* restaurantText = nil;
    if (restaurantText == nil)
    {
        restaurantText = [UIColor colorWithRed:241.0/255.0 green:234.0/255.0 blue:12.0/255.0 alpha:1.0];
    }
    return restaurantText;
}


+ (UIColor *)myTableBackgroundColor 
{
    static UIColor* myTableBackground = nil;
    if (myTableBackground == nil)
    {
        myTableBackground = [UIColor restaurantBackgroundLightColor];
    }
    return myTableBackground;
}

+ (UIColor *)tableHeaderColor 
{
    static UIColor* tableHeader = nil;
    if (tableHeader == nil)
    {
        tableHeader = [UIColor whiteColor];
    }
    return tableHeader;
}

+ (UIColor *)tableFooterColor 
{
    static UIColor* tableFooter = nil;
    if (tableFooter == nil)
    {
        tableFooter = [UIColor restaurantTextColor];
    }
    return tableFooter;
}

+ (UIColor *)ericdsouzaInfoColor 
{
    static UIColor* ericdsouzaInfo = nil;
    if (ericdsouzaInfo == nil)
    {
        ericdsouzaInfo = [UIColor whiteColor];
    }
    return ericdsouzaInfo;
}

@end