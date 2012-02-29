//
//  OrderViewController.h
//  TheRealJerk
//
//  Created by Eric D'Souza on 12-02-20.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SingletonClass.h"
#import "RestaurantClass.h"
#import "MenuItemViewController.h"


@interface OrderViewController : UIViewController <MenuItemDelegate>{
    
    SingletonClass *sharedData;
    RestaurantClass *restaurantData;
    
}

@property (unsafe_unretained, nonatomic) IBOutlet UITableView *tableViewOrderItems;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *labelAboveTableView;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *labelNoItems;
@property (unsafe_unretained, nonatomic) IBOutlet UIButton *buttonPhone;

- (IBAction)buttonPlaceOrderDidTouchUp:(id)sender; 

@end
