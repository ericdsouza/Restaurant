//
//  OrderViewController.m
//  TheRealJerk
//
//  Created by Eric D'Souza on 12-02-20.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "OrderViewController.h"
#import "UIColorExtensions.h"
#import "GlobalFunctions.h"

@implementation OrderViewController
@synthesize labelAboveTableView;
@synthesize labelNoItems;
@synthesize buttonPhone;
@synthesize tableViewOrderItems;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"My Order", @"My Order");
        self.tabBarItem.image = [UIImage imageNamed:@"80-shopping-cart"];
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}


#pragma mark - table methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}


- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section 
{

    int rowCount;
    
    switch (section) {
        case 0:
            rowCount = [sharedData.orderItems count];
            
            if (rowCount == 0)
                labelNoItems.hidden = FALSE;
            else
                labelNoItems.hidden = TRUE;

            break;
            
        case 1:
            if ([sharedData.orderItems count] == 0)
                rowCount = 0;
            else
                rowCount = 1;
            
            break;
    }
            
    return rowCount;
}


- (UIView *) tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section 
{
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 60)];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 3, tableView.bounds.size.width - 10, 54)];
    
    footerView.backgroundColor = [UIColor clearColor];
    label.numberOfLines = 0;
    label.lineBreakMode = UILineBreakModeWordWrap;

    if (section == 0)
        label.text = kOrderTakingCapabilities;
    else
        label.text = @"";
    
    label.textColor = [UIColor tableFooterColor];
    label.textAlignment = UITextAlignmentCenter;
    [label setFont:[UIFont systemFontOfSize:14]];
    
    label.backgroundColor = [UIColor clearColor];
    [footerView addSubview:label];
    return footerView;

}


- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0)
        return 60;
    else
        return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView
		 cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
    
	static NSString *SimpleTableIdentifier = @"SimpleTableIdentifier";
    
	UITableViewCell * cell = [tableView
                              dequeueReusableCellWithIdentifier: SimpleTableIdentifier];
    
	if(cell == nil) {
        
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleSubtitle
                reuseIdentifier:SimpleTableIdentifier];
        
    }
    
	NSUInteger row = [indexPath row];
	NSUInteger section = [indexPath section];
    
    // default for all cells
    [[cell viewWithTag:100] removeFromSuperview];
    [cell setBackgroundColor:[UIColor whiteColor]];
    cell.textLabel.text = @"";
    cell.detailTextLabel.text = @"";
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    switch (section) {
        case 0:
        {
            NSString *itemId = [(NSDictionary *)[sharedData.orderItems objectAtIndex:row] objectForKey:kItemId];
            
            cell.textLabel.text = [GlobalFunctions menuItemForItemId:itemId];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            cell.detailTextLabel.text = [GlobalFunctions detailTextLabelForArray:[NSArray arrayWithArray:sharedData.orderItems] andRow:row];
            
            break;
        }   
    
        case 1:
        {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(0.0, 0.0, 302, 40);
            button.titleLabel.font = [UIFont boldSystemFontOfSize:16];
            button.tag = 100;
            
            [button addTarget:self action:@selector(buttonDeleteAllDidTouchUp:)  forControlEvents:UIControlEventTouchUpInside];
            [button setBackgroundColor:[UIColor clearColor]];
            [button setTitle:@"Delete All Items" forState:UIControlStateNormal];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            
            [cell setBackgroundColor:[UIColor appleDeleteRedColor]];
            button.alpha = 1.0;
            button.enabled = TRUE;
            
            cell.selectionStyle = UITableViewCellSelectionStyleBlue;
            [cell.contentView addSubview:button];
            break;
        }
    }
    
    
    
	return cell;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
	NSUInteger row = [indexPath row];
	NSUInteger section = [indexPath section];

    switch (section) {
        case 0:
        {
            NSString *itemId = [(NSDictionary *)[sharedData.orderItems objectAtIndex:row] objectForKey:kItemId];
            
            MenuItemViewController *menuItemViewController = [[MenuItemViewController alloc] initWithNibName:nil bundle:nil showMenuItem:itemId];
            
            menuItemViewController.delegate = self;
            [menuItemViewController setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
            [self presentModalViewController:menuItemViewController animated:YES];
            
            break;
        }   
            
        case 1:
        {
            break;
        }
    }        
}


- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath 
{
    NSUInteger section = [indexPath section];
    
    UITableViewCellEditingStyle style;
    
    switch (section) {
        case 0:
            style = UITableViewCellEditingStyleDelete;
            break;
            
        case 1:
            style = UITableViewCellEditingStyleNone;
            break;
    }
    
    return style;

}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath 
{
    NSUInteger row = [indexPath row];
    [sharedData.orderItems removeObjectAtIndex:row];
    [GlobalFunctions archiveAppData];

    [tableViewOrderItems reloadData];
}



#pragma mark - delegate methods

- (void)menuItemViewControllerDidFinish
{

    [self dismissModalViewControllerAnimated:YES];
    [tableViewOrderItems reloadData];

}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    
    if([title isEqualToString:@"Delete All"])
    {
        [sharedData.orderItems removeAllObjects];
        [GlobalFunctions archiveAppData];
        [tableViewOrderItems reloadData];
    }
    else if([title isEqualToString:@"Cancel"])
    {
        // don't do anything, cause the user wants to fix the non-adding-up tricks taken
    }
    
}



#pragma mark - IB Actions

- (IBAction)buttonPlaceOrderDidTouchUp:(id)sender 
{    
    
    switch ([sender tag]) 
    {
        case 1:
            [GlobalFunctions placeOrderByPhone];
            break;
    }    
}


- (IBAction)buttonDeleteAllDidTouchUp:(id)sender 
{
    UIAlertView *alert;
    alert = [[UIAlertView alloc] initWithTitle:@"Confirm Delete" 
                                       message:@"This will delete all items in your order"
                                      delegate:self 
                             cancelButtonTitle:@"Cancel" 
                             otherButtonTitles:@"Delete All", nil];
    [alert show];

}



#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    // instantiate the Singleton Class
    sharedData = [SingletonClass sharedDataInstance]; 
    restaurantData = [RestaurantClass restaurantDataInstance];
    
    // set background color for iPad
    if ([tableViewOrderItems respondsToSelector:@selector(backgroundView)]) 
    {
        tableViewOrderItems.backgroundView = nil;
        [tableViewOrderItems setBackgroundView:[[UIView alloc] init]];
    }
    
    tableViewOrderItems.backgroundColor = [UIColor myTableBackgroundColor];
    labelAboveTableView.backgroundColor = [UIColor myTableBackgroundColor];
    
    // check device capabilities
    if ([GlobalFunctions canMakePhoneCalls])
    {
        buttonPhone.enabled = TRUE;
        [buttonPhone setTitle:@"Order Now" forState:UIApplicationStateActive];
    } 
    else 
    {
        buttonPhone.enabled = FALSE;
        [buttonPhone setTitle:[GlobalFunctions phoneNumberForActiveLocation] forState:UIApplicationStateActive];
    }
    
}

- (void) viewWillAppear:(BOOL)animated
{

    [super viewWillAppear:animated];

    [tableViewOrderItems reloadData];
    
}


- (void)viewDidUnload
{
    [self setTableViewOrderItems:nil];
    [self setLabelAboveTableView:nil];
    [self setLabelNoItems:nil];
    [self setButtonPhone:nil];
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
