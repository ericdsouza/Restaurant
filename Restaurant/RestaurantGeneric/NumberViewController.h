//
//  NumberViewController.h
//  TheRealJerk
//
//  Created by Eric D'Souza on 12-02-24.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NumberDelegate <NSObject>

- (void)numberViewControllerDidReturnNumber:(int)aNumber;

@end


@interface NumberViewController : UIViewController {
    
    id <NumberDelegate> __unsafe_unretained delegate;
    
    int aNumber;
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil currentNumber:(int)currentNumber;

- (IBAction)buttonNumberDidTouchUp:(id)sender;
- (IBAction)buttonDoneDidTouchUp:(id)sender;


@property (nonatomic, unsafe_unretained) id <NumberDelegate> delegate;

@end
