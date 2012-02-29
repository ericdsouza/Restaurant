//
//  NoteViewController.m
//  TheRealJerk
//
//  Created by Eric D'Souza on 12-02-22.
//  Copyright (c) 2012 Eric D'Souza. All rights reserved.
//

#import "NoteViewController.h"
#import <QuartzCore/QuartzCore.h>

@implementation NoteViewController

@synthesize delegate;

@synthesize textNote;
@synthesize note;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil currentNote:(NSString *)currentNote
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    
    note = currentNote;
    
    return self;
}

- (void)didReceiveMemoryWarning 
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}


#pragma mark - IB Actions

- (IBAction)buttonDoneDidTouchUp:(id)sender 
{    
    [self.delegate noteViewControllerDidReturnNote:textNote.text];
}


#pragma mark - keyboard stuff

- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
}


- (void)unregisterForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter]removeObserver:self
                                                   name:UIKeyboardDidShowNotification object:nil];
}


- (void)keyboardWasShown:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    textNote.frame = CGRectMake(5, 44 + 5, kbSize.width - 10, self.view.frame.size.height - 44 - kbSize.height - 10);
    NSLog(@"textNote height %f",textNote.frame.size.height);
    NSLog(@"view height %f",self.view.frame.size.height);
    
    
    // once we get keyboard size and resize uitextview, we don't really care about the notification anymore
    [self unregisterForKeyboardNotifications];
    
}


- (BOOL)textFieldShouldReturn:(UITextField *)theTextField 
{
    textNote.text = [textNote.text stringByAppendingString:@"\n"];
    return YES;
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self registerForKeyboardNotifications];
    
    textNote.layer.borderColor = [[UIColor blackColor] CGColor];
    textNote.layer.borderWidth = 1.0;
    textNote.layer.cornerRadius = 5.0;
    textNote.layer.masksToBounds = YES;

    textNote.text = note;
    [textNote becomeFirstResponder];
    
}

- (void)viewDidUnload
{
    [self setTextNote:nil];
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
