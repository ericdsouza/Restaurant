//
//  MenuViewController.h
//  TheRealJerk
//
//  Created by Eric D'Souza on 12-02-15.
//  Copyright (c) 2012 Eric D'Souza. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuItemViewController.h"
#import "SingletonClass.h"
#import "RestaurantClass.h"


@interface MenuViewController : UIViewController <MenuItemDelegate> {
    
    SingletonClass *sharedData;
    RestaurantClass *restaurantData;
    
    int menuDisplayState;
    int activeMenuSection;
}

- (IBAction)buttonPlaceOrderDidTouchUp:(id)sender; 

@property (unsafe_unretained, nonatomic) IBOutlet UITableView *tableViewMenu;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *labelAboveTableView;
@property (unsafe_unretained, nonatomic) IBOutlet UIButton *buttonPlaceOrder;
@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *imageViewPhone;

@end
