//
//  MenuItemViewController.h
//  TheRealJerk
//
//  Created by Eric D'Souza on 12-02-16.
//  Copyright (c) 2012 Eric D'Souza. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SingletonClass.h"
#import "RestaurantClass.h"
#import "NoteViewController.h"
#import "NumberViewController.h"

@protocol MenuItemDelegate <NSObject>

- (void)menuItemViewControllerDidFinish;

@end



@interface MenuItemViewController : UIViewController <NoteDelegate, NumberDelegate> {
    
    id <MenuItemDelegate> __unsafe_unretained delegate;
    SingletonClass *sharedData;
    RestaurantClass *restaurantData;
    
    NSString *itemId;

}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil showMenuItem:(NSString *)itemId;

- (IBAction)buttonDoneDidTouchUp:(id)sender; 
- (IBAction)buttonAddToOrderDidTouchUp:(id)sender;

@property (nonatomic, unsafe_unretained) id <MenuItemDelegate> delegate;
@property (nonatomic, strong) NSString *itemId;

@property (unsafe_unretained, nonatomic) IBOutlet UILabel *labelMenuItem;
@property (unsafe_unretained, nonatomic) IBOutlet UITableView *tableViewItem;

@end
