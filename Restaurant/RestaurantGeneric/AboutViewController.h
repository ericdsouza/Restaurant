//
//  AboutViewController.h
//  TheRealJerk
//
//  Created by Eric D'Souza on 12-02-25.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "RestaurantClass.h"

@interface AboutViewController : UIViewController <UIActionSheetDelegate, MFMailComposeViewControllerDelegate> {
    
    RestaurantClass *restaurantData;    
    
}

- (IBAction)buttonInfoDidTouchUp:(id)sender;
- (IBAction)buttonContactUsDidTouchUp:(id)sender; 

@property (unsafe_unretained, nonatomic) IBOutlet UIScrollView *scrollViewAbout;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *labelAbout;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *labelRestaurantName;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *labelEricDSouzaInfo;

@property (unsafe_unretained, nonatomic) IBOutlet UIActivityIndicatorView *myActivityIndicator;

@end

