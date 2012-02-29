//
//  AboutViewController.m
//  TheRealJerk
//
//  Created by Eric D'Souza on 12-02-25.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AboutViewController.h"
#import "UIColorExtensions.h"
#import <QuartzCore/QuartzCore.h>
#import "RestaurantClass.h"
#import "GlobalFunctions.h"
#import "Twitter/Twitter.h"
#import <Accounts/Accounts.h>


@implementation AboutViewController
@synthesize scrollViewAbout;
@synthesize labelAbout;
@synthesize labelRestaurantName;
@synthesize labelEricDSouzaInfo;
@synthesize myActivityIndicator;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"About", @"About");
        self.tabBarItem.image = [UIImage imageNamed:@"42-info"];
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - twitter stuff

- (void)followOnTwitterDidSucceedforAccount:(NSString *)twitterAccount
{    
    NSLog(@"followOnTwitterDidSucceedforAccount %@", twitterAccount);
    
    [NSThread detachNewThreadSelector: @selector(spinEnd) toTarget:self withObject:nil];
    
    UIAlertView *alert;
    alert = [[UIAlertView alloc] initWithTitle:twitterAccount
                                       message:[NSString stringWithFormat:@"You're now following @%@", kTwitterScreenName]
                                      delegate:nil
                             cancelButtonTitle:@"OK" 
                             otherButtonTitles:nil];
    [alert show];
}


- (void)followOnTwitterDidFailWithError:(NSString *)statusCode
{    
    NSLog(@"followOnTwitterDidFailWithError %@", statusCode);
    
    [NSThread detachNewThreadSelector: @selector(spinEnd) toTarget:self withObject:nil];

    UIAlertView *alert;
    //   alert = [[UIAlertView alloc] initWithTitle:[twitterAccount accountDescription] 
    alert = [[UIAlertView alloc] initWithTitle:@"Twitter"
                                       message:[NSString stringWithFormat:@"There was an error, you are not yet following @%@", kTwitterScreenName]
                                      delegate:nil
                             cancelButtonTitle:@"OK" 
                             otherButtonTitles:nil];
    [alert show];
}


- (int)followOnTwitter
{
    
    // check for Twitter integration
    if (![GlobalFunctions canTweet])
        return 10;
    
    // check Twitter accessibility and at least one account is setup
    if(! [TWTweetComposeViewController canSendTweet]) 
        return 20;
    
    // check for internet access
    if (![GlobalFunctions canConnectToInternet])
        return 30;
    
    ACAccountStore *accountStore = [[ACAccountStore alloc] init];
    ACAccountType *accountType = [accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
    
    [accountStore requestAccessToAccountsWithType:accountType withCompletionHandler:^(BOOL granted, NSError *error) 
     {
         if(granted) 
         {
             // Get the list of Twitter accounts.
             NSArray *accountsArray = [accountStore accountsWithAccountType:accountType];
             
             // ideally we'd ask which acccount to use, if there are multiple set up on the device
             if ([accountsArray count] > 0) 
             {
                 // Grab the initial Twitter account to tweet from.
                 ACAccount *twitterAccount = [accountsArray objectAtIndex:0];
                 NSLog(@"twitterAccount %@", twitterAccount);
                 NSLog(@"twitter accountDescription %@", [twitterAccount accountDescription]);
                 
                 NSMutableDictionary *tempDict = [[NSMutableDictionary alloc] init];
                 [tempDict setValue:kTwitterScreenName forKey:@"screen_name"];
                 [tempDict setValue:@"true" forKey:@"follow"];
                 NSLog(@"tempDict %@", tempDict);
                 
                 TWRequest *postRequest = [[TWRequest alloc] initWithURL:[NSURL URLWithString:@"http://api.twitter.com/1/friendships/create.json"] 
                                                              parameters:tempDict 
                                                           requestMethod:TWRequestMethodPOST];
                 
                 
                 [postRequest setAccount:twitterAccount];
                 
                 [postRequest performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) 
                  {
                      int statusCode = [urlResponse statusCode];
                      NSLog(@"HTTP response status: %i", statusCode);     
                      NSLog(@"error: %@", error);
                      
                      if (statusCode == 200)
                      {
                          [self performSelectorOnMainThread:@selector(followOnTwitterDidSucceedforAccount:)  withObject:[twitterAccount accountDescription] waitUntilDone:NO];
                      } 
                      else
                      {
                          [self performSelectorOnMainThread:@selector(followOnTwitterDidFailWithError:)  withObject:[NSString stringWithFormat:@"%i",statusCode] waitUntilDone:NO];
                      }
                  }];                
             }
         }
     }];
    
    return 0;
}



#pragma mark - custom stuff

- (void)contactUsByEmail
{
    // we'll let email go to outbox if there's no internet connection
    // if (![GlobalFunctions canConnectToInternet])
    //    return;
    
    // network connection exists, so launch feedback email
    MFMailComposeViewController *email = [[MFMailComposeViewController alloc] init];
    email.mailComposeDelegate = self;
    [email setSubject:kRestaurantName];
    
    NSArray *toRecipients = [NSArray arrayWithObjects:kContactEmail, nil];
    [email setToRecipients:toRecipients];
    
    // leave text blank for user to enter feedback
    NSString *emailBody = @"";
    [email setMessageBody:emailBody isHTML:NO];
    
    // present email interface
    [self presentModalViewController:email animated:YES];    
    
}


- (void)contactUsByPhone
{    
    [GlobalFunctions placeOrderByPhone];
}


- (void)likeUsOnFacebook
{    
    
    // https://developers.facebook.com/docs/reference/plugins/like-box/
    // URL https://www.facebook.com/pages/The-Real-Jerk-Restaurant/52893441959
    // http://www.raywenderlich.com/1626/how-to-post-to-a-users-wall-upload-photos-and-add-a-like-button-from-your-iphone-app
}


- (void)spinBegin 
{
    [myActivityIndicator startAnimating];
}

- (void)spinEnd 
{
    [myActivityIndicator stopAnimating];
}


- (void)followUsOnTwitter
{   
    // this takes long enough that we want to show activity
    int error = [self followOnTwitter];
    
    NSString *alertMessage = @"";
    switch (error) 
    {
        case 0:
            return;
            break;
            
        case 10:
            alertMessage = @"Tweeting from the app is only available in iOS5 and beyond.";
            break;
            
        case 20:
            alertMessage = @"Please set up a User Account in the Twitter app first.";
            break;
            
        case 30:
            alertMessage = @"You require an internet connection to tweet.";
            break;
            
    }

    // if there was return code 0 it doesn't make it this far; we want to keep spinner until asynchronous return from Twitter
    [NSThread detachNewThreadSelector: @selector(spinEnd) toTarget:self withObject:nil];

    UIAlertView *myAlert = [[UIAlertView alloc]
                            initWithTitle:@"Unable to Follow"   
                            message:alertMessage
                            delegate:self
                            cancelButtonTitle:@"OK"
                            otherButtonTitles:nil];
    [myAlert show];
    
}






#pragma mark - delegate methods

- (void)mailComposeController:(MFMailComposeViewController *)controller
          didFinishWithResult:(MFMailComposeResult)result
                        error:(NSError *)error
{
    [self dismissModalViewControllerAnimated:YES];      
}


-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    NSString *title = [actionSheet buttonTitleAtIndex:buttonIndex];

    if ([title isEqualToString:@"Call Us"])
        [self contactUsByPhone];
    
    if ([title isEqualToString:@"Email Us"])
        [self contactUsByEmail];
    
    if ([title isEqualToString:@"Follow Us"])
    {
        [NSThread detachNewThreadSelector: @selector(spinBegin) toTarget:self withObject:nil];
        [self followUsOnTwitter];
    }
    
    if ([title isEqualToString:@"Like Us"])
        [self likeUsOnFacebook];

}



#pragma mark - IB actions 


- (IBAction)buttonContactUsDidTouchUp:(id)sender 
{
        
    NSMutableArray *otherButtons = [NSMutableArray arrayWithCapacity:5];
    NSMutableArray *otherIcons = [NSMutableArray arrayWithCapacity:5];

    
    // determine contact methods available (both from restaurant and user perspective)
    
    // phone
    if ([GlobalFunctions canMakePhoneCalls]) 
    {
        [otherButtons addObject:@"Call Us"];
        [otherIcons addObject:[UIImage imageNamed:@"epd-phone.png"]];
    }
        
    // email
    [otherButtons addObject:@"Email Us"];
    [otherIcons addObject:[UIImage imageNamed:@"epd-mail.png"]];
    
    // twitter
    if ([GlobalFunctions canTweet] && ![kTwitterScreenName isEqualToString:@""]) 
    {
        [otherButtons addObject:@"Follow Us"];
        [otherIcons addObject:[UIImage imageNamed:@"epd-twitter.png"]];
    }
    
    // facebook
    if (![kRestaurantFacebookPage isEqualToString:@""]) 
    {
        [otherButtons addObject:@"Like Us"];
        [otherIcons addObject:[UIImage imageNamed:@"epd-facebook.png"]];
    }
    
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"" 
                                                             delegate:self 
                                                    cancelButtonTitle:nil 
                                               destructiveButtonTitle:nil 
                                                    otherButtonTitles:nil];
    
    
    for (NSString *buttonTitle in otherButtons)
        [actionSheet addButtonWithTitle:buttonTitle];

    // add cancel button (this is done manually so we can set the position to be at the bottom)
	[actionSheet addButtonWithTitle:@"Cancel"];
	// set cancel button index to the one we just added so that we know which one it is in delegate call
	// (this also causes this button to be shown with a black background)
	actionSheet.cancelButtonIndex = actionSheet.numberOfButtons - 1;

    
    for (int i = 0; i < [otherIcons count]; i++)
    {
        [[[actionSheet valueForKey:@"_buttons"] objectAtIndex:i] setImage:[otherIcons objectAtIndex:i] forState:UIControlStateNormal];
        [[[actionSheet valueForKey:@"_buttons"] objectAtIndex:i] setImage:[otherIcons objectAtIndex:i] forState:UIControlStateHighlighted];
    }
            
    [actionSheet showFromTabBar:self.tabBarController.tabBar];
}



- (IBAction)buttonInfoDidTouchUp:(id)sender 
{
    
    //  there's no real indication that there's a button here, so no need to display alert
    if (![GlobalFunctions canConnectToInternet])
        return;
            
    // network connection exists, so launch feedback email
    MFMailComposeViewController *email = [[MFMailComposeViewController alloc] init];
    email.mailComposeDelegate = self;
    [email setSubject:@"iPhone apps for restaurants"];
    
    NSArray *toRecipients = [NSArray arrayWithObjects:@"info@ericdsouza.com", nil];
    [email setToRecipients:toRecipients];
    
    // leave text blank for user to enter feedback
    NSString *emailBody = @"";
    [email setMessageBody:emailBody isHTML:NO];
    
    // present email interface
    [self presentModalViewController:email animated:YES];    
        
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // add Restaurant Name to about box
    labelRestaurantName.text = kRestaurantName;
    
    // add About text and size to fit
    NSString *pathToFile = [[NSBundle mainBundle] pathForResource:@"about" ofType:@"txt"];  
    NSString *aboutText = [NSString stringWithContentsOfFile:pathToFile encoding:NSUTF8StringEncoding error:nil];
    labelAbout.text = aboutText;
    [labelAbout sizeToFit];
    scrollViewAbout.contentSize = CGSizeMake(scrollViewAbout.contentSize.width, labelAbout.frame.size.height + 70);

    // set background color 
    self.view.backgroundColor = [UIColor myTableBackgroundColor];

    // set info@ericdsouza.com color 
    labelEricDSouzaInfo.textColor = [UIColor ericdsouzaInfoColor];
    
    // make it look good
    scrollViewAbout.layer.borderColor = [[UIColor grayColor] CGColor];
    scrollViewAbout.layer.borderWidth = 1.0;
    scrollViewAbout.layer.cornerRadius = 11.0;
    scrollViewAbout.layer.masksToBounds = YES;

}

- (void)viewDidUnload
{
    [self setScrollViewAbout:nil];
    [self setLabelAbout:nil];
    [self setLabelRestaurantName:nil];
    [self setMyActivityIndicator:nil];
    [self setLabelEricDSouzaInfo:nil];
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
