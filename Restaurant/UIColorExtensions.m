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

+ (UIColor *)theRealJerkGreenColor 
{
    static UIColor* theRealJerkGreen = nil;
    if (theRealJerkGreen == nil)
    {
        theRealJerkGreen = [UIColor colorWithRed:17.0/255.0 green:126.0/255.0 blue:53.0/255.0 alpha:1.0];
    }
    return theRealJerkGreen;
}

+ (UIColor *)theRealJerkRedColor 
{
    static UIColor* theRealJerkRed = nil;
    if (theRealJerkRed == nil)
    {
        theRealJerkRed = [UIColor colorWithRed:224.0/255.0 green:32.0/255.0 blue:37.0/255.0 alpha:1.0];
    }
    return theRealJerkRed;
}

+ (UIColor *)theRealJerkYellowColor 
{
    static UIColor* theRealJerkYellow = nil;
    if (theRealJerkYellow == nil)
    {
        theRealJerkYellow = [UIColor colorWithRed:250.0/255.0 green:237.0/255.0 blue:32.0/255.0 alpha:1.0];
    }
    return theRealJerkYellow;
}


+ (UIColor *)myTableBackgroundColor 
{
    static UIColor* myTableBackground = nil;
    if (myTableBackground == nil)
    {
        myTableBackground = [UIColor theRealJerkGreenColor];
    }
    return myTableBackground;
}

+ (UIColor *)tableHeaderColor 
{
    static UIColor* tableHeader = nil;
    if (tableHeader == nil)
    {
        tableHeader = [UIColor theRealJerkYellowColor];
    }
    return tableHeader;
}

+ (UIColor *)tableFooterColor 
{
    static UIColor* tableFooter = nil;
    if (tableFooter == nil)
    {
        tableFooter = [UIColor whiteColor];
    }
    return tableFooter;
}

@end