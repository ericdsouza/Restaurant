//
//  RestaurantClass.m
//
//  Created by Eric D'Souza on 12-02-23.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RestaurantClass.h"
#import "SingletonClass.h"
#import "LocationViewController.h"


NSString * const kFacebookAppId = @"198087950267379";
NSString * const kAppArchiveDatafile = @"restaurant.dat";

NSString * const kRestaurantName = @"Any Restaurant";
NSString * const kContactEmail = @"restaurant@gmail.com";
NSString * const kTwitterScreenName = @"ericdsouza"; // change this before go-live
NSString * const kRestaurantFacebookPage = @"";

BOOL const kShowOffersTab = TRUE;

NSString * const kOrderTakingCapabilities = @"This restaurant currently\ntakes orders only by phone.";


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
    
    CLLocation *restaurant0Location = [[CLLocation alloc] initWithLatitude:43.66218 longitude:-79.33456];
    NSDictionary *restaurant0 = [[NSDictionary alloc] initWithObjectsAndKeys:
                                 @"416.555.1234", kPhoneNumber,
                                 restaurant0Location, kLocation,
                                 @"Leslieville", kPointTitle,
                                 @"1135 Queen St E", kPointSubtitle,
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
                              @"House Specialties", kSectionName,
                              @"House Specialties", kSectionHeader,
                              @"", kSectionFooter,
                              nil];
    
    NSDictionary *section3 = [[NSDictionary alloc] initWithObjectsAndKeys:
                              @"Pho", kSectionName,
                              @"Pho - Famous Rice Noodle Soups", kSectionHeader,
                              @"", kSectionFooter,
                              nil];
    
    NSDictionary *section4 = [[NSDictionary alloc] initWithObjectsAndKeys:
                              @"Main Dishes", kSectionName,
                              @"Main Dishes", kSectionHeader,
                              @"Served with Rice or Vermicelli — your choice! Vegetarian versions of these dishes come with Spring Roll, Vegetables & Tofu.", kSectionFooter,
                              nil];
    
    NSDictionary *section5 = [[NSDictionary alloc] initWithObjectsAndKeys:
                              @"Desserts", kSectionName,
                              @"Desserts & Drinks", kSectionHeader,
                              @"", kSectionFooter,
                              nil];
    
    self.menuSections = [[NSArray alloc] initWithObjects:
                         section1,
                         section2,
                         section3,
                         section4,
                         section5,
                         nil];
    
    
    // menu items
    // (formatted and cut-and-pasted from Excel)
    
    NSDictionary *menuItem1 = [[NSDictionary alloc] initWithObjectsAndKeys: @"Appetizers", kSectionName, @"1 Goi Cuon", kItem, @"1", kItemId, @"3", kPrice, @"", kImageName, @"Fresh Shrimp Rolls (Vegetarian version contains Tofu", kItemDesc, nil];
    NSDictionary *menuItem2 = [[NSDictionary alloc] initWithObjectsAndKeys: @"Appetizers", kSectionName, @"2 Cha Gio", kItem, @"2", kItemId, @"3", kPrice, @"", kImageName, @"Spring Rolls", kItemDesc, nil];
    NSDictionary *menuItem3 = [[NSDictionary alloc] initWithObjectsAndKeys: @"Appetizers", kSectionName, @"3 Cha Tom Cuon", kItem, @"3", kItemId, @"3", kPrice, @"", kImageName, @"Crispy Mini Shrimps", kItemDesc, nil];
    NSDictionary *menuItem4 = [[NSDictionary alloc] initWithObjectsAndKeys: @"Appetizers", kSectionName, @"4 Nom Ngo Sen", kItem, @"4", kItemId, @"5", kPrice, @"", kImageName, @"Fresh Shrimp & Lotus Shoot Salad", kItemDesc, nil];
    NSDictionary *menuItem5 = [[NSDictionary alloc] initWithObjectsAndKeys: @"Appetizers", kSectionName, @"5 Cha gio Cha Muc", kItem, @"5", kItemId, @"5", kPrice, @"", kImageName, @"Spring Rolls and Calamari Patties", kItemDesc, nil];
    NSDictionary *menuItem6 = [[NSDictionary alloc] initWithObjectsAndKeys: @"Appetizers", kSectionName, @"6 Hen", kItem, @"6", kItemId, @"7", kPrice, @"", kImageName, @"Sautéed Spicy Baby Clams served with Crispy Rice Crackers", kItemDesc, nil];
    NSDictionary *menuItem7 = [[NSDictionary alloc] initWithObjectsAndKeys: @"Appetizers", kSectionName, @"7 So Hap Gung Xa Ot", kItem, @"7", kItemId, @"8", kPrice, @"", kImageName, @"Steamed Mussels with Ginger & Lemon Grass", kItemDesc, nil];
    NSDictionary *menuItem8 = [[NSDictionary alloc] initWithObjectsAndKeys: @"House Specialties", kSectionName, @"8 Bun Canh Tom Hanoi", kItem, @"8", kItemId, @"9.5", kPrice, @"", kImageName, @"Spicy Shrimp with Lemon Grass & Tamarind Soup", kItemDesc, nil];
    NSDictionary *menuItem9 = [[NSDictionary alloc] initWithObjectsAndKeys: @"House Specialties", kSectionName, @"9 Pho Do Bien", kItem, @"9", kItemId, @"9.5", kPrice, @"", kImageName, @"Spicy Shrimp, Calamari & Mussels with Tamarind Soup", kItemDesc, nil];
    NSDictionary *menuItem10 = [[NSDictionary alloc] initWithObjectsAndKeys: @"House Specialties", kSectionName, @"10 Cha Ca – Hanoi 3 Seasons", kItem, @"10", kItemId, @"12", kPrice, @"", kImageName, @"Hanoi-style Grouper with Dill & Shrimp Paste", kItemDesc, nil];
    NSDictionary *menuItem10A = [[NSDictionary alloc] initWithObjectsAndKeys: @"House Specialties", kSectionName, @"10A Buddhist’s Treat (Vegetarian)", kItem, @"10A", kItemId, @"12", kPrice, @"", kImageName, @"Stir-fried King Mushroom, Viet Celery & Baby Bok Choy with Sweet Potato Glass Noodle", kItemDesc, nil];
    NSDictionary *menuItem11 = [[NSDictionary alloc] initWithObjectsAndKeys: @"House Specialties", kSectionName, @"11 Bun Cha Muc", kItem, @"11", kItemId, @"9.5", kPrice, @"", kImageName, @"Calamari Patties with Dill Soup", kItemDesc, nil];
    NSDictionary *menuItem12 = [[NSDictionary alloc] initWithObjectsAndKeys: @"House Specialties", kSectionName, @"12 Bun Bo Hue", kItem, @"12", kItemId, @"9.5", kPrice, @"", kImageName, @"Hue Citadel’s Famous Beef Soup", kItemDesc, nil];
    NSDictionary *menuItem13 = [[NSDictionary alloc] initWithObjectsAndKeys: @"Pho", kSectionName, @"13 Pho Dac Biet", kItem, @"13", kItemId, @"8.5", kPrice, @"", kImageName, @"Hanoi 3 Seasons Special", kItemDesc, nil];
    NSDictionary *menuItem14 = [[NSDictionary alloc] initWithObjectsAndKeys: @"Pho", kSectionName, @"14 Pho bo vien", kItem, @"14", kItemId, @"8.5", kPrice, @"", kImageName, @"Meatballs (Beef)", kItemDesc, nil];
    NSDictionary *menuItem15 = [[NSDictionary alloc] initWithObjectsAndKeys: @"Pho", kSectionName, @"15 Pho nam", kItem, @"15", kItemId, @"8.5", kPrice, @"", kImageName, @"Well-done Beef", kItemDesc, nil];
    NSDictionary *menuItem16 = [[NSDictionary alloc] initWithObjectsAndKeys: @"Pho", kSectionName, @"16 Pho tai", kItem, @"16", kItemId, @"8.5", kPrice, @"", kImageName, @"Rare Beef", kItemDesc, nil];
    NSDictionary *menuItem17 = [[NSDictionary alloc] initWithObjectsAndKeys: @"Pho", kSectionName, @"17 Pho tai nam", kItem, @"17", kItemId, @"8.5", kPrice, @"", kImageName, @"Rare Beef & Well-done Beef", kItemDesc, nil];
    NSDictionary *menuItem18 = [[NSDictionary alloc] initWithObjectsAndKeys: @"Pho", kSectionName, @"18 Pho Ga", kItem, @"18", kItemId, @"8.5", kPrice, @"", kImageName, @"Chicken with Basil & Lemon Leaf", kItemDesc, nil];
    NSDictionary *menuItem19 = [[NSDictionary alloc] initWithObjectsAndKeys: @"Pho", kSectionName, @"19 Pho chay", kItem, @"19", kItemId, @"8.5", kPrice, @"", kImageName, @"Mixed Vegetables & Tofu", kItemDesc, nil];
    NSDictionary *menuItem20 = [[NSDictionary alloc] initWithObjectsAndKeys: @"Main Dishes", kSectionName, @"20 Bo Xao Sate", kItem, @"20", kItemId, @"10.5", kPrice, @"", kImageName, @"Spicy Beef Sate with Basil", kItemDesc, nil];
    NSDictionary *menuItem21 = [[NSDictionary alloc] initWithObjectsAndKeys: @"Main Dishes", kSectionName, @"21 Bo Xao Rau Cai", kItem, @"21", kItemId, @"10.5", kPrice, @"", kImageName, @"Garlic Beef with Stir-fried Bok Choy", kItemDesc, nil];
    NSDictionary *menuItem22 = [[NSDictionary alloc] initWithObjectsAndKeys: @"Main Dishes", kSectionName, @"22 Ga Nuong Gung", kItem, @"22", kItemId, @"10.5", kPrice, @"", kImageName, @"Ginger Chicken", kItemDesc, nil];
    NSDictionary *menuItem23 = [[NSDictionary alloc] initWithObjectsAndKeys: @"Main Dishes", kSectionName, @"23 Ga Nuong Xa Sua Dua", kItem, @"23", kItemId, @"10.5", kPrice, @"", kImageName, @"Chicken with Lemon Grass & Coconut Milk", kItemDesc, nil];
    NSDictionary *menuItem24 = [[NSDictionary alloc] initWithObjectsAndKeys: @"Main Dishes", kSectionName, @"24 Ga Xao Rau Cai", kItem, @"24", kItemId, @"10.5", kPrice, @"", kImageName, @"Garlic Chicken & Stir-fried Bok Choy", kItemDesc, nil];
    NSDictionary *menuItem25 = [[NSDictionary alloc] initWithObjectsAndKeys: @"Main Dishes", kSectionName, @"25 Ca-ri Ga Sate", kItem, @"25", kItemId, @"10.5", kPrice, @"", kImageName, @"Curried Sate Chicken", kItemDesc, nil];
    NSDictionary *menuItem26 = [[NSDictionary alloc] initWithObjectsAndKeys: @"Main Dishes", kSectionName, @"26 Do Bien Xao Rau Cai", kItem, @"26", kItemId, @"10.5", kPrice, @"", kImageName, @"Savory Seafood & Stir-fried Bok Choy & Celery", kItemDesc, nil];
    NSDictionary *menuItem27 = [[NSDictionary alloc] initWithObjectsAndKeys: @"Main Dishes", kSectionName, @"27 Tom Nuong Xa", kItem, @"27", kItemId, @"10.5", kPrice, @"", kImageName, @"Spicy Shrimp with Lemon Grass", kItemDesc, nil];
    NSDictionary *menuItem28 = [[NSDictionary alloc] initWithObjectsAndKeys: @"Main Dishes", kSectionName, @"28 Thit Lon Nuong", kItem, @"28", kItemId, @"10.5", kPrice, @"", kImageName, @"Seasoned Pork", kItemDesc, nil];
    NSDictionary *menuItem29 = [[NSDictionary alloc] initWithObjectsAndKeys: @"Desserts", kSectionName, @"29 Café", kItem, @"29", kItemId, @"3", kPrice, @"", kImageName, @"Vietnamese Coffee (hot/cold) ", kItemDesc, nil];
    NSDictionary *menuItem30 = [[NSDictionary alloc] initWithObjectsAndKeys: @"Desserts", kSectionName, @"30 Sinh to", kItem, @"30", kItemId, @"3", kPrice, @"", kImageName, @"Smoothie", kItemDesc, nil];
    NSDictionary *menuItem31 = [[NSDictionary alloc] initWithObjectsAndKeys: @"Desserts", kSectionName, @"31 Creme", kItem, @"31", kItemId, @"3", kPrice, @"", kImageName, @"Ice Cream (Green Tea, Ginger, or Black Sesame) ", kItemDesc, nil];
    NSDictionary *menuItem32 = [[NSDictionary alloc] initWithObjectsAndKeys: @"Desserts", kSectionName, @"32 Hanoi 3 Seasons’ signature dessert", kItem, @"32", kItemId, @"12", kPrice, @"", kImageName, @"Fried Banana with Exotic Ice Cream Flavours", kItemDesc, nil];
    NSDictionary *menuItem33 = [[NSDictionary alloc] initWithObjectsAndKeys: @"Desserts", kSectionName, @"33 Mineral Water", kItem, @"33", kItemId, @"2.5", kPrice, @"", kImageName, @"Perrier or San Pellegrino", kItemDesc, nil];
    NSDictionary *menuItem34 = [[NSDictionary alloc] initWithObjectsAndKeys: @"Desserts", kSectionName, @"34 Nuoc/Nuoc Ngot", kItem, @"34", kItemId, @"1.5", kPrice, @"", kImageName, @"Assorted soft drinks and bottled water", kItemDesc, nil];
    
    
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
                      menuItem10A,
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
                      nil];

    return self;
    
}




@end
