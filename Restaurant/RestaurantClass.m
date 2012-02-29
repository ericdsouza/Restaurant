//
//  RestaurantClass.m
//  TheRealJerk
//
//  Created by Eric D'Souza on 12-02-23.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RestaurantClass.h"
#import "SingletonClass.h"
#import "LocationViewController.h"


NSString * const kFacebookAppId = @"198087950267379";
NSString * const kAppArchiveDatafile = @"TheRealJerk.dat";

NSString * const kRestaurantName = @"The Real Jerk";
NSString * const kContactEmail = @"TheRealJerk@TheRealJerk.com";
NSString * const kTwitterScreenName = @"ericdsouza"; // change this before go-live
NSString * const kRestaurantFacebookPage = @"";

double const kLatitude = 43.65882;
double const kLongitude = -79.34965;


NSString * const kOrderTakingCapabilities = @"The Real Jerk currently\ntakes orders only by phone.";


@implementation RestaurantClass

@synthesize menuSections, menuItems;
@synthesize restaurants;


+(RestaurantClass*) restaurantDataInstance {
    static RestaurantClass *restaurantDataInstance;
    @synchronized(self) {
        if(!restaurantDataInstance){
            restaurantDataInstance = [[RestaurantClass alloc] init];
        }
    }
    return restaurantDataInstance;
}

-(id) init;
{
    self = [super init];
    if (!self) return nil;

    // restaurant locations
    
    CLLocation *restaurant0Location = [[CLLocation alloc] initWithLatitude:43.65882 longitude:-79.34965];
    NSDictionary *restaurant0 = [[NSDictionary alloc] initWithObjectsAndKeys:
                                 @"416.907.9985", kPhoneNumber,
                                 restaurant0Location, kLocation,
                                 @"The Real Jerk", kPointTitle,
                                 @"709 Queen Street East", kPointSubtitle,
                                 nil];
    
    self.restaurants = [[NSArray alloc] initWithObjects:
                         restaurant0,
                         nil];
    

    // menu sections
    
    NSDictionary *section1 = [[NSDictionary alloc] initWithObjectsAndKeys:
                              @"Appetizers", kSectionName,
                              @"Appetizers", kSectionHeader,
                              @"", kSectionFooter,
                              nil];
    
    NSDictionary *section2 = [[NSDictionary alloc] initWithObjectsAndKeys:
                              @"Soups Salads Sandwiches", kSectionName,
                              @"Soups Salads Sandwiches", kSectionHeader,
                              @"Avocado on Salad $1.00 extra", kSectionFooter,
                              nil];
    
    NSDictionary *section3 = [[NSDictionary alloc] initWithObjectsAndKeys:
                              @"Roti", kSectionName,
                              @"Roti", kSectionHeader,
                              @"Add $1.00 for any veggie in Roti", kSectionFooter,
                              nil];
    
    NSDictionary *section4 = [[NSDictionary alloc] initWithObjectsAndKeys:
                              @"Main Dishes", kSectionName,
                              @"Main Dishes", kSectionHeader,
                              @"Served with Rice & Peas and Coleslaw", kSectionFooter,
                              nil];
    
    NSDictionary *section5 = [[NSDictionary alloc] initWithObjectsAndKeys:
                              @"Combo Dishes", kSectionName,
                              @"Combo Dishes", kSectionHeader,
                              @"Served with Rice & Peas and Coleslaw", kSectionFooter,
                              nil];
    
    NSDictionary *section6 = [[NSDictionary alloc] initWithObjectsAndKeys:
                              @"Side Orders", kSectionName,
                              @"Side Orders", kSectionHeader,
                              @"Jerk Chicken white meat $0.50 extra", kSectionFooter,
                              nil];
    
    self.menuSections = [[NSArray alloc] initWithObjects:
                         section1,
                         section2,
                         section3,
                         section4,
                         section5,
                         section6,
                         nil];
    
    
    // menu items
    // (formatted and cut-and-pasted from Excel)
    
    NSDictionary *menuItem1 = [[NSDictionary alloc] initWithObjectsAndKeys: @"Appetizers", kSectionName, @"Jerk Chicken Wings", kItem, @"1", kItemId, @"6.99", kPrice, @"jerk-chicken-chicken-wings", kImageName, @"Succulent and spicy wings that will hit the spot", kItemDesc, nil];
    NSDictionary *menuItem2 = [[NSDictionary alloc] initWithObjectsAndKeys: @"Appetizers", kSectionName, @"Coconut Shrimp", kItem, @"2", kItemId, @"7.5", kPrice, @"", kImageName, @"A Real Jerk favourite", kItemDesc, nil];
    NSDictionary *menuItem3 = [[NSDictionary alloc] initWithObjectsAndKeys: @"Appetizers", kSectionName, @"Pepper Shrimp", kItem, @"3", kItemId, @"7.5", kPrice, @"", kImageName, @"You've never had shrimp like this, but you should ", kItemDesc, nil];
    NSDictionary *menuItem4 = [[NSDictionary alloc] initWithObjectsAndKeys: @"Appetizers", kSectionName, @"Cod fritters", kItem, @"4", kItemId, @"3.25", kPrice, @"", kImageName, @"Prepared just like mom use to make", kItemDesc, nil];
    NSDictionary *menuItem5 = [[NSDictionary alloc] initWithObjectsAndKeys: @"Appetizers", kSectionName, @"Banana Fritters", kItem, @"5", kItemId, @"2.75", kPrice, @"", kImageName, @"Bananas never tasted soooooooo good", kItemDesc, nil];
    NSDictionary *menuItem6 = [[NSDictionary alloc] initWithObjectsAndKeys: @"Appetizers", kSectionName, @"Fried Plantain", kItem, @"6", kItemId, @"2.25", kPrice, @"", kImageName, @"Sweet, sweet, sweet. Need we say more", kItemDesc, nil];
    NSDictionary *menuItem7 = [[NSDictionary alloc] initWithObjectsAndKeys: @"Appetizers", kSectionName, @"Patties( Beef, Chicken, or Veggie)", kItem, @"7", kItemId, @"1.5", kPrice, @"", kImageName, @"A jamaican tradition but a great starter", kItemDesc, nil];
    NSDictionary *menuItem8 = [[NSDictionary alloc] initWithObjectsAndKeys: @"Combo Dishes", kSectionName, @"Jerk Chicken / Pork", kItem, @"8", kItemId, @"12.25", kPrice, @"", kImageName, @"", kItemDesc, nil];
    NSDictionary *menuItem9 = [[NSDictionary alloc] initWithObjectsAndKeys: @"Combo Dishes", kSectionName, @"Jerk Chicken / Curry Chicken", kItem, @"9", kItemId, @"12.25", kPrice, @"", kImageName, @"", kItemDesc, nil];
    NSDictionary *menuItem10 = [[NSDictionary alloc] initWithObjectsAndKeys: @"Combo Dishes", kSectionName, @"Jerk Chicken / Oxtail", kItem, @"10", kItemId, @"12.5", kPrice, @"", kImageName, @"", kItemDesc, nil];
    NSDictionary *menuItem11 = [[NSDictionary alloc] initWithObjectsAndKeys: @"Combo Dishes", kSectionName, @"Jerk Chicken / Curry Goat", kItem, @"11", kItemId, @"12.5", kPrice, @"", kImageName, @"", kItemDesc, nil];
    NSDictionary *menuItem12 = [[NSDictionary alloc] initWithObjectsAndKeys: @"Combo Dishes", kSectionName, @"Jerk Chicken / Ribs", kItem, @"12", kItemId, @"12.5", kPrice, @"", kImageName, @"", kItemDesc, nil];
    NSDictionary *menuItem13 = [[NSDictionary alloc] initWithObjectsAndKeys: @"Combo Dishes", kSectionName, @"Jerk Pork / Ribs", kItem, @"13", kItemId, @"12.5", kPrice, @"", kImageName, @"", kItemDesc, nil];
    NSDictionary *menuItem14 = [[NSDictionary alloc] initWithObjectsAndKeys: @"Combo Dishes", kSectionName, @"Jerk Pork / Oxtail", kItem, @"14", kItemId, @"12.5", kPrice, @"", kImageName, @"", kItemDesc, nil];
    NSDictionary *menuItem15 = [[NSDictionary alloc] initWithObjectsAndKeys: @"Combo Dishes", kSectionName, @"Jerk Ribs / Oxtail", kItem, @"15", kItemId, @"12.5", kPrice, @"", kImageName, @"", kItemDesc, nil];
    NSDictionary *menuItem16 = [[NSDictionary alloc] initWithObjectsAndKeys: @"Combo Dishes", kSectionName, @"Curry Goat / Oxtail", kItem, @"16", kItemId, @"12.5", kPrice, @"", kImageName, @"", kItemDesc, nil];
    NSDictionary *menuItem17 = [[NSDictionary alloc] initWithObjectsAndKeys: @"Combo Dishes", kSectionName, @"Curry Chicken / Goat", kItem, @"17", kItemId, @"12.5", kPrice, @"", kImageName, @"", kItemDesc, nil];
    NSDictionary *menuItem18 = [[NSDictionary alloc] initWithObjectsAndKeys: @"Combo Dishes", kSectionName, @"Fried Chicken / Oxtail", kItem, @"18", kItemId, @"12.5", kPrice, @"", kImageName, @"", kItemDesc, nil];
    NSDictionary *menuItem19 = [[NSDictionary alloc] initWithObjectsAndKeys: @"Combo Dishes", kSectionName, @"Fried Chicken / Curry Goat", kItem, @"19", kItemId, @"12.5", kPrice, @"", kImageName, @"", kItemDesc, nil];
    NSDictionary *menuItem20 = [[NSDictionary alloc] initWithObjectsAndKeys: @"Main Dishes", kSectionName, @"1/4 Jerk Chicken", kItem, @"20", kItemId, @"10", kPrice, @"", kImageName, @"", kItemDesc, nil];
    NSDictionary *menuItem21 = [[NSDictionary alloc] initWithObjectsAndKeys: @"Main Dishes", kSectionName, @"1/2 Jerk Chicken", kItem, @"21", kItemId, @"9", kPrice, @"", kImageName, @"The dish that made us famous and our customers happy", kItemDesc, nil];
    NSDictionary *menuItem22 = [[NSDictionary alloc] initWithObjectsAndKeys: @"Main Dishes", kSectionName, @"Jerk Ribs", kItem, @"22", kItemId, @"12", kPrice, @"", kImageName, @"Tender, succulent, and gently falling off the bone. Mmmm!", kItemDesc, nil];
    NSDictionary *menuItem23 = [[NSDictionary alloc] initWithObjectsAndKeys: @"Main Dishes", kSectionName, @"Jerk Pork", kItem, @"23", kItemId, @"15", kPrice, @"", kImageName, @"a signature dish that'll remind you of mom's home cooking", kItemDesc, nil];
    NSDictionary *menuItem24 = [[NSDictionary alloc] initWithObjectsAndKeys: @"Main Dishes", kSectionName, @"Oxtail Dinner", kItem, @"24", kItemId, @"11", kPrice, @"", kImageName, @"Heapings of tender meat bathed in gravy on a bed of rice", kItemDesc, nil];
    NSDictionary *menuItem25 = [[NSDictionary alloc] initWithObjectsAndKeys: @"Main Dishes", kSectionName, @"Curry Chicken or Curry Goat", kItem, @"25", kItemId, @"9.25", kPrice, @"", kImageName, @"Voted the best in Toronto", kItemDesc, nil];
    NSDictionary *menuItem26 = [[NSDictionary alloc] initWithObjectsAndKeys: @"Main Dishes", kSectionName, @"Curry Beef", kItem, @"26", kItemId, @"9.5", kPrice, @"", kImageName, @"Where's the beef?  We found it.", kItemDesc, nil];
    NSDictionary *menuItem27 = [[NSDictionary alloc] initWithObjectsAndKeys: @"Main Dishes", kSectionName, @"Fried Chicken", kItem, @"27", kItemId, @"8.25", kPrice, @"", kImageName, @"Guilty pleasure never tasted so good", kItemDesc, nil];
    NSDictionary *menuItem28 = [[NSDictionary alloc] initWithObjectsAndKeys: @"Main Dishes", kSectionName, @"Curry Shrimp", kItem, @"28", kItemId, @"12.5", kPrice, @"", kImageName, @"If you love curry, this dish is a must. ", kItemDesc, nil];
    NSDictionary *menuItem29 = [[NSDictionary alloc] initWithObjectsAndKeys: @"Main Dishes", kSectionName, @"Shrimp Rundown", kItem, @"29", kItemId, @"13", kPrice, @"", kImageName, @"Ahhh now we are talkin'  from Barbodoes to you", kItemDesc, nil];
    NSDictionary *menuItem30 = [[NSDictionary alloc] initWithObjectsAndKeys: @"Main Dishes", kSectionName, @"Shrimp Creole", kItem, @"30", kItemId, @"13", kPrice, @"", kImageName, @"Not just for Mardi Gras", kItemDesc, nil];
    NSDictionary *menuItem31 = [[NSDictionary alloc] initWithObjectsAndKeys: @"Main Dishes", kSectionName, @"Curry Vegetables", kItem, @"31", kItemId, @"9.25", kPrice, @"", kImageName, @"Vegatarian's delight", kItemDesc, nil];
    NSDictionary *menuItem32 = [[NSDictionary alloc] initWithObjectsAndKeys: @"Main Dishes", kSectionName, @"Curry Chickpea & Potatoes", kItem, @"32", kItemId, @"9.25", kPrice, @"", kImageName, @"A very filling vegatarian combo", kItemDesc, nil];
    NSDictionary *menuItem33 = [[NSDictionary alloc] initWithObjectsAndKeys: @"Main Dishes", kSectionName, @"Curry Lentil", kItem, @"33", kItemId, @"9.25", kPrice, @"", kImageName, @"Lentils done with caribbean curry mmmmmmm.", kItemDesc, nil];
    NSDictionary *menuItem34 = [[NSDictionary alloc] initWithObjectsAndKeys: @"Main Dishes", kSectionName, @"Escovitch (Fried) Snapper", kItem, @"34", kItemId, @"12", kPrice, @"", kImageName, @"Fish isn't just for Fridays", kItemDesc, nil];
    NSDictionary *menuItem35 = [[NSDictionary alloc] initWithObjectsAndKeys: @"Main Dishes", kSectionName, @"Jerk Fish", kItem, @"35", kItemId, @"13", kPrice, @"", kImageName, @"", kItemDesc, nil];
    NSDictionary *menuItem36 = [[NSDictionary alloc] initWithObjectsAndKeys: @"Main Dishes", kSectionName, @"Steamed Fish", kItem, @"36", kItemId, @"12.5", kPrice, @"", kImageName, @"", kItemDesc, nil];
    NSDictionary *menuItem37 = [[NSDictionary alloc] initWithObjectsAndKeys: @"Main Dishes", kSectionName, @"Stew Fish", kItem, @"37", kItemId, @"11", kPrice, @"", kImageName, @"", kItemDesc, nil];
    NSDictionary *menuItem38 = [[NSDictionary alloc] initWithObjectsAndKeys: @"Main Dishes", kSectionName, @"Ackee & Cod Fish", kItem, @"38", kItemId, @"13.5", kPrice, @"", kImageName, @"Be sure to order dumplings with this dish....", kItemDesc, nil];
    NSDictionary *menuItem39 = [[NSDictionary alloc] initWithObjectsAndKeys: @"Roti", kSectionName, @"Chicken Roti", kItem, @"39", kItemId, @"6.99", kPrice, @"", kImageName, @"", kItemDesc, nil];
    NSDictionary *menuItem40 = [[NSDictionary alloc] initWithObjectsAndKeys: @"Roti", kSectionName, @"Beef Roti", kItem, @"40", kItemId, @"6.99", kPrice, @"", kImageName, @"", kItemDesc, nil];
    NSDictionary *menuItem41 = [[NSDictionary alloc] initWithObjectsAndKeys: @"Roti", kSectionName, @"Goat Roti", kItem, @"41", kItemId, @"6.99", kPrice, @"", kImageName, @"", kItemDesc, nil];
    NSDictionary *menuItem42 = [[NSDictionary alloc] initWithObjectsAndKeys: @"Roti", kSectionName, @"Veggie Roti", kItem, @"42", kItemId, @"6.5", kPrice, @"", kImageName, @"", kItemDesc, nil];
    NSDictionary *menuItem43 = [[NSDictionary alloc] initWithObjectsAndKeys: @"Roti", kSectionName, @"Shrimp Roti", kItem, @"43", kItemId, @"7.5", kPrice, @"", kImageName, @"", kItemDesc, nil];
    NSDictionary *menuItem44 = [[NSDictionary alloc] initWithObjectsAndKeys: @"Roti", kSectionName, @"Chick Pea Roti", kItem, @"44", kItemId, @"6.5", kPrice, @"", kImageName, @"", kItemDesc, nil];
    NSDictionary *menuItem45 = [[NSDictionary alloc] initWithObjectsAndKeys: @"Roti", kSectionName, @"Lentil Roti", kItem, @"45", kItemId, @"6.5", kPrice, @"", kImageName, @"", kItemDesc, nil];
    NSDictionary *menuItem46 = [[NSDictionary alloc] initWithObjectsAndKeys: @"Roti", kSectionName, @"Potato Roti", kItem, @"46", kItemId, @"5.75", kPrice, @"", kImageName, @"", kItemDesc, nil];
    NSDictionary *menuItem47 = [[NSDictionary alloc] initWithObjectsAndKeys: @"Side Orders", kSectionName, @"Side Oxtail", kItem, @"47", kItemId, @"6.5", kPrice, @"", kImageName, @"", kItemDesc, nil];
    NSDictionary *menuItem48 = [[NSDictionary alloc] initWithObjectsAndKeys: @"Side Orders", kSectionName, @"Side Curry Goat / Chicken", kItem, @"48", kItemId, @"6.5", kPrice, @"", kImageName, @"", kItemDesc, nil];
    NSDictionary *menuItem49 = [[NSDictionary alloc] initWithObjectsAndKeys: @"Side Orders", kSectionName, @"1/4 Jerk Chicken", kItem, @"49", kItemId, @"5", kPrice, @"", kImageName, @"", kItemDesc, nil];
    NSDictionary *menuItem50 = [[NSDictionary alloc] initWithObjectsAndKeys: @"Side Orders", kSectionName, @"1/2 Jerk Chicken", kItem, @"50", kItemId, @"10", kPrice, @"", kImageName, @"", kItemDesc, nil];
    NSDictionary *menuItem51 = [[NSDictionary alloc] initWithObjectsAndKeys: @"Side Orders", kSectionName, @"Whole Jerk Chicken", kItem, @"51", kItemId, @"19", kPrice, @"", kImageName, @"", kItemDesc, nil];
    NSDictionary *menuItem52 = [[NSDictionary alloc] initWithObjectsAndKeys: @"Side Orders", kSectionName, @"1/2 Jerk Pork", kItem, @"52", kItemId, @"6.5", kPrice, @"", kImageName, @"", kItemDesc, nil];
    NSDictionary *menuItem53 = [[NSDictionary alloc] initWithObjectsAndKeys: @"Side Orders", kSectionName, @"1 lb Jerk Pork", kItem, @"53", kItemId, @"13", kPrice, @"", kImageName, @"", kItemDesc, nil];
    NSDictionary *menuItem54 = [[NSDictionary alloc] initWithObjectsAndKeys: @"Side Orders", kSectionName, @"1/4 Rack Jerk Ribs", kItem, @"54", kItemId, @"5", kPrice, @"", kImageName, @"", kItemDesc, nil];
    NSDictionary *menuItem55 = [[NSDictionary alloc] initWithObjectsAndKeys: @"Side Orders", kSectionName, @"1/2 Rack Jerk Ribs", kItem, @"55", kItemId, @"10", kPrice, @"", kImageName, @"", kItemDesc, nil];
    NSDictionary *menuItem56 = [[NSDictionary alloc] initWithObjectsAndKeys: @"Side Orders", kSectionName, @"Full Rack Jerk Ribs", kItem, @"56", kItemId, @"19", kPrice, @"", kImageName, @"", kItemDesc, nil];
    NSDictionary *menuItem57 = [[NSDictionary alloc] initWithObjectsAndKeys: @"Side Orders", kSectionName, @"Side Fry / Stewed Chicken", kItem, @"57", kItemId, @"4.5", kPrice, @"", kImageName, @"", kItemDesc, nil];
    NSDictionary *menuItem58 = [[NSDictionary alloc] initWithObjectsAndKeys: @"Side Orders", kSectionName, @"Side Stew Fish", kItem, @"58", kItemId, @"7.5", kPrice, @"", kImageName, @"", kItemDesc, nil];
    NSDictionary *menuItem59 = [[NSDictionary alloc] initWithObjectsAndKeys: @"Side Orders", kSectionName, @"Side Shrimp", kItem, @"59", kItemId, @"9.5", kPrice, @"", kImageName, @"", kItemDesc, nil];
    NSDictionary *menuItem60 = [[NSDictionary alloc] initWithObjectsAndKeys: @"Side Orders", kSectionName, @"Side Veggies", kItem, @"60", kItemId, @"5", kPrice, @"", kImageName, @"", kItemDesc, nil];
    NSDictionary *menuItem61 = [[NSDictionary alloc] initWithObjectsAndKeys: @"Side Orders", kSectionName, @"Side Ackee & Cod Fish", kItem, @"61", kItemId, @"9", kPrice, @"", kImageName, @"", kItemDesc, nil];
    NSDictionary *menuItem62 = [[NSDictionary alloc] initWithObjectsAndKeys: @"Side Orders", kSectionName, @"Side Escovitched Snapper", kItem, @"62", kItemId, @"8.5", kPrice, @"", kImageName, @"", kItemDesc, nil];
    NSDictionary *menuItem63 = [[NSDictionary alloc] initWithObjectsAndKeys: @"Side Orders", kSectionName, @"Side Jerk / Steamed Snapper", kItem, @"63", kItemId, @"9.5", kPrice, @"", kImageName, @"", kItemDesc, nil];
    NSDictionary *menuItem64 = [[NSDictionary alloc] initWithObjectsAndKeys: @"Side Orders", kSectionName, @"Side Gravy", kItem, @"64", kItemId, @"1", kPrice, @"", kImageName, @"", kItemDesc, nil];
    NSDictionary *menuItem65 = [[NSDictionary alloc] initWithObjectsAndKeys: @"Side Orders", kSectionName, @"Side 'Real Jerk Hot Sauce'", kItem, @"65", kItemId, @"0.5", kPrice, @"", kImageName, @"", kItemDesc, nil];    NSDictionary *menuItem66 = [[NSDictionary alloc] initWithObjectsAndKeys: @"Side Orders", kSectionName, @"Roti Shell", kItem, @"66", kItemId, @"2.75", kPrice, @"", kImageName, @"", kItemDesc, nil];
    NSDictionary *menuItem67 = [[NSDictionary alloc] initWithObjectsAndKeys: @"Side Orders", kSectionName, @"Side Rice", kItem, @"67", kItemId, @"3.75", kPrice, @"", kImageName, @"", kItemDesc, nil];
    NSDictionary *menuItem68 = [[NSDictionary alloc] initWithObjectsAndKeys: @"Side Orders", kSectionName, @"Side Curry Potato", kItem, @"68", kItemId, @"4.5", kPrice, @"", kImageName, @"", kItemDesc, nil];
    NSDictionary *menuItem69 = [[NSDictionary alloc] initWithObjectsAndKeys: @"Soups Salads Sandwiches", kSectionName, @"Deluxe Salad", kItem, @"69", kItemId, @"11.75", kPrice, @"", kImageName, @"Healthy choice", kItemDesc, nil];
    NSDictionary *menuItem70 = [[NSDictionary alloc] initWithObjectsAndKeys: @"Soups Salads Sandwiches", kSectionName, @"Jerk Shrimp Salad", kItem, @"70", kItemId, @"10.25", kPrice, @"", kImageName, @"Awesome", kItemDesc, nil];
    NSDictionary *menuItem71 = [[NSDictionary alloc] initWithObjectsAndKeys: @"Soups Salads Sandwiches", kSectionName, @"Jerk Chicken Salad(large)", kItem, @"71", kItemId, @"9.75", kPrice, @"", kImageName, @"The healthy tasty combo", kItemDesc, nil];
    NSDictionary *menuItem72 = [[NSDictionary alloc] initWithObjectsAndKeys: @"Soups Salads Sandwiches", kSectionName, @"Red Pea Soup", kItem, @"72", kItemId, @"4.25", kPrice, @"", kImageName, @"Comfort food lover's best friend", kItemDesc, nil];
    NSDictionary *menuItem73 = [[NSDictionary alloc] initWithObjectsAndKeys: @"Soups Salads Sandwiches", kSectionName, @"Chicken Soup", kItem, @"73", kItemId, @"4", kPrice, @"", kImageName, @"Rich thick soup for the soul and body", kItemDesc, nil];
    
    
    self.menuItems = [[NSArray alloc] initWithObjects:
                      menuItem1,
                      menuItem2,
                      menuItem3,
                      menuItem4,
                      menuItem5,
                      menuItem6,
                      menuItem7,
                      menuItem8,
                      menuItem9,
                      menuItem10,
                      menuItem11,
                      menuItem12,
                      menuItem13,
                      menuItem14,
                      menuItem15,
                      menuItem16,
                      menuItem17,
                      menuItem18,
                      menuItem19,
                      menuItem20,
                      menuItem21,
                      menuItem22,
                      menuItem23,
                      menuItem24,
                      menuItem25,
                      menuItem26,
                      menuItem27,
                      menuItem28,
                      menuItem29,
                      menuItem30,
                      menuItem31,
                      menuItem32,
                      menuItem33,
                      menuItem34,
                      menuItem35,
                      menuItem36,
                      menuItem37,
                      menuItem38,
                      menuItem39,
                      menuItem40,
                      menuItem41,
                      menuItem42,
                      menuItem43,
                      menuItem44,
                      menuItem45,
                      menuItem46,
                      menuItem47,
                      menuItem48,
                      menuItem49,
                      menuItem50,
                      menuItem51,
                      menuItem52,
                      menuItem53,
                      menuItem54,
                      menuItem55,
                      menuItem56,
                      menuItem57,
                      menuItem58,
                      menuItem59,
                      menuItem60,
                      menuItem61,
                      menuItem62,
                      menuItem63,
                      menuItem64,
                      menuItem65,
                      menuItem66,
                      menuItem67,
                      menuItem68,
                      menuItem69,
                      menuItem70,
                      menuItem71,
                      menuItem72,
                      menuItem73,
                      nil];

    return self;
    
}




@end
