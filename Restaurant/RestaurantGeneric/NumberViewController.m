//
//  NumberViewController.m
//  TheRealJerk
//
//  Created by Eric D'Souza on 12-02-24.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NumberViewController.h"
#import "UIColorExtensions.h"
#import <QuartzCore/QuartzCore.h>


@implementation NumberViewController

@synthesize delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil currentNumber:(int)currentNumber
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }

    aNumber = currentNumber;
    
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - custom stuff

-(void)highlightNumber
{
    for (UIButton *button in [self.view subviews]) 
        if (button.tag > 0 && button.tag < 120)
        {
            if (button.tag == 100 + aNumber)
            {
                [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [button setBackgroundColor:[UIColor appleHighlightBlueColor]];
            }
            else
            {
                [button setTitleColor:[UIColor appleButtonBlueColor] forState:UIControlStateNormal];
                [button setBackgroundColor:[UIColor whiteColor]];
            }
        }
}


#pragma mark - IB Actions

- (IBAction)buttonDoneDidTouchUp:(id)sender 
{    
    [self.delegate numberViewControllerDidReturnNumber:aNumber];
}


- (IBAction)buttonNumberDidTouchUp:(id)sender 
{    
    aNumber = [sender tag] - 100;
    [self highlightNumber];
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // mimic rounded rect (need to keep it custom so we can change the background color)
    for (UIButton *button in [self.view subviews]) 
        if (button.tag > 0 && button.tag < 120)
        {
            button.layer.borderColor = [[UIColor grayColor] CGColor];
            button.layer.borderWidth = 1.0;
            button.layer.cornerRadius = 11.0;
            button.layer.masksToBounds = YES;
        }
    
    [self highlightNumber];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
