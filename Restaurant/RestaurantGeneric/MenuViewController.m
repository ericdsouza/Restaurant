//
//  MenuViewController.m
//  TheRealJerk
//
//  Created by Eric D'Souza on 12-02-15.
//  Copyright (c) 2012 Eric D'Souza. All rights reserved.
//

#import "MenuViewController.h"
#import "GlobalFunctions.h"
#import "UIColorExtensions.h"
#import <QuartzCore/QuartzCore.h>


@implementation MenuViewController

@synthesize tableViewMenu;
@synthesize labelAboveTableView;
@synthesize buttonPlaceOrder;
@synthesize imageViewPhone;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Menu", @"Menu");
        self.tabBarItem.image = [UIImage imageNamed:@"48-fork-and-knife"];
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - custom stuff

- (void)placeOrderButtonText
{
    // check device capabilities
    if ([GlobalFunctions canMakePhoneCalls])
    {
        buttonPlaceOrder.enabled = TRUE;
        [buttonPlaceOrder setTitle:@"Order Now" forState:UIApplicationStateActive];
    } 
    else 
    {
        buttonPlaceOrder.enabled = FALSE;
        [buttonPlaceOrder setTitle:[GlobalFunctions phoneNumberForActiveLocation] forState:UIApplicationStateActive];
    }
}


#pragma mark - table methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    int sectionCount = 0;
    
    switch (menuDisplayState) {
        case kDisplayFullMenu:
            sectionCount = [restaurantData.menuSections count];

            // favs are 1st section if they exist
            if ([sharedData.favItems count] > 0)
                sectionCount ++;
            
            break;
            
        case kDisplayMenuSections:
            sectionCount = 1;
            
            // favs are 1st section if they exist
            if ([sharedData.favItems count] > 0)
                sectionCount ++;
            
            break;

        case kDisplayMenuSectionDetail:
            sectionCount = 1;
            break;
    }

    return sectionCount;
    
}


- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section 
{    
    NSString *headerText = @"";

    switch (menuDisplayState) {
        case kDisplayFullMenu: {

            // favs are 1st section if they exist
            if ([sharedData.favItems count] > 0)
            {
                if (section == 0)
                    headerText = @"Favourites";
                else
                    headerText = [(NSDictionary *)[restaurantData.menuSections objectAtIndex:(section - 1)] objectForKey:kSectionHeader];
            }
            else
                headerText = [(NSDictionary *)[restaurantData.menuSections objectAtIndex:section] objectForKey:kSectionHeader];
            
            
            break;
        }
            
        case kDisplayMenuSections:{
            
            // favs are 1st section if they exist
            if ([sharedData.favItems count] > 0 && section == 0)
                headerText = @"Favourites";
            else
                headerText = @"Menu";

            break;
        }
            
        case kDisplayMenuSectionDetail:{

            headerText = [(NSDictionary *)[restaurantData.menuSections objectAtIndex:activeMenuSection] objectForKey:kSectionHeader];
            break;
        }
    }
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 40)];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 13, tableView.bounds.size.width - 10, 18)];
    
    headerView.backgroundColor = [UIColor clearColor];
    label.text = headerText;
    label.textColor = [UIColor tableHeaderColor];
    label.backgroundColor = [UIColor clearColor];
    [label setFont:[UIFont boldSystemFontOfSize:18]];
    
    [headerView addSubview:label];
    return headerView;

}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}


- (UIView *) tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section 
{
    NSString *footerText = @"";
    
    
    switch (menuDisplayState) {
        case kDisplayFullMenu: {
            
            // favs are 1st section if they exist
            if ([sharedData.favItems count] > 0)
            {
                if (section == 0)
                    footerText = @"Tap Favourite to Add to Order";
                else
                    footerText = [(NSDictionary *)[restaurantData.menuSections objectAtIndex:(section - 1)] objectForKey:kSectionFooter];
            }
            else
                footerText = [(NSDictionary *)[restaurantData.menuSections objectAtIndex:section] objectForKey:kSectionFooter];
            
            break;
        }
            
        case kDisplayMenuSections:{
            
            // favs are 1st section if they exist
            if ([sharedData.favItems count] > 0 && section == 0)
                footerText = @"Tap Favourite to Add to Order";
            else
                footerText = @"";

            break;
        }
            
        case kDisplayMenuSectionDetail:{

            footerText = [(NSDictionary *)[restaurantData.menuSections objectAtIndex:activeMenuSection] objectForKey:kSectionFooter];
            break;
        }
    }

    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 30)];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 3, tableView.bounds.size.width - 10, 18)];
    
    footerView.backgroundColor = [UIColor clearColor];
    label.text = footerText;
    label.textColor = [UIColor tableFooterColor];
    label.textAlignment = UITextAlignmentCenter;
    [label setFont:[UIFont systemFontOfSize:14]];

    label.backgroundColor = [UIColor clearColor];
    [footerView addSubview:label];
    return footerView;

}


- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    switch (menuDisplayState) {
        case kDisplayFullMenu: {
            
            // favs are 1st section if they exist
            if (([sharedData.favItems count] > 0) && (section == 0))
                return 30;
            
            // adjust for favs if they exist
            int menuSection = section;
            if ([sharedData.favItems count] > 0)
                menuSection --;
            
            
            if ([[(NSDictionary *)[restaurantData.menuSections objectAtIndex:menuSection] objectForKey:kSectionFooter] isEqualToString:@""])
                return 0;
            else
                return 30;
            
            break;
        }
            
        case kDisplayMenuSections:{
            
            // favs are 1st section if they exist
            if (([sharedData.favItems count] > 0) && (section == 0))
                return 30;

            else
                return 0;
            
            break;
        }
            
        case kDisplayMenuSectionDetail:{
            
            if ([[(NSDictionary *)[restaurantData.menuSections objectAtIndex:activeMenuSection] objectForKey:kSectionFooter] isEqualToString:@""])
                return 0;
            else
                return 30;

            break;
        }
    }

    
    return 0;
    
}


- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section 
{
    
    switch (menuDisplayState) {
        case kDisplayFullMenu: {
            
            // favs are 1st section if they exist
            if (([sharedData.favItems count] > 0) && (section == 0))
                return [sharedData.favItems count];
            
            // adjust for favs if they exist
            int menuSection = section;
            if ([sharedData.favItems count] > 0)
                menuSection --;
            
            NSString *sectionName = [(NSDictionary *)[restaurantData.menuSections objectAtIndex:menuSection] objectForKey:kSectionName];
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(%K == %@)", kSectionName, sectionName];
            NSArray *filteredArray = [restaurantData.menuItems filteredArrayUsingPredicate:predicate];
            
            NSInteger rowCount = [filteredArray count];
            return rowCount;
            
            break;
        }
            
        case kDisplayMenuSections:{
            
            // favs are 1st section if they exist
            if (([sharedData.favItems count] > 0) && (section == 0))
                return [sharedData.favItems count];
            else
                return [restaurantData.menuSections count];
            
            break;
        }
            
        case kDisplayMenuSectionDetail:{
            
            NSString *sectionName = [(NSDictionary *)[restaurantData.menuSections objectAtIndex:activeMenuSection] objectForKey:kSectionName];
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(%K == %@)", kSectionName, sectionName];
            NSArray *filteredArray = [restaurantData.menuItems filteredArrayUsingPredicate:predicate];
            
            NSInteger rowCount = [filteredArray count];
            return rowCount;

            break;
        }
    }
    
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

    // remove any subviews we've added programmatically in case the cell is being reused
    int tag = 100;
    [[cell viewWithTag:tag] removeFromSuperview];
    cell.detailTextLabel.text = @"";

	NSUInteger row = [indexPath row];
	NSUInteger section = [indexPath section];
    
    switch (menuDisplayState) {
        case kDisplayFullMenu: {
            
            // favs are 1st section if they exist
            if (([sharedData.favItems count] > 0) && (section == 0))
            {
                NSString *favItemId = [(NSDictionary *)[sharedData.favItems objectAtIndex:row] objectForKey:kItemId];
                
                // textLabel (hack to add indentation by buffering with spaces)
                cell.textLabel.text = [GlobalFunctions menuItemForItemId:favItemId];
                
                // accessoryType
                cell.accessoryType = UITableViewCellAccessoryNone;
                
                // detailTextLabel
                cell.detailTextLabel.text = [GlobalFunctions detailTextLabelForArray:[NSArray arrayWithArray:sharedData.favItems] andRow:row];
                
                // image
                if ([GlobalFunctions orderContainsItemId:favItemId])
                    [cell.contentView addSubview:[GlobalFunctions greenCircleWithTag:tag]];
                
                return cell;
            }
            
            // adjust for favs if they exist
            int menuSection = section;
            if ([sharedData.favItems count] > 0)
                menuSection --;
            
            
            NSString *itemId = [GlobalFunctions itemIdForSection:menuSection andRow:row];
            cell.textLabel.text = [GlobalFunctions menuItemForItemId:itemId];
            
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.detailTextLabel.text = [GlobalFunctions menuItemDescForItemId:itemId];
            
            // add green circle if item's in order
            if ([GlobalFunctions orderContainsItemId:itemId])
                [cell.contentView addSubview:[GlobalFunctions greenCircleWithTag:tag]];
            
            return cell;

            break;
        }
            
        case kDisplayMenuSections:{
            
            // favs are 1st section if they exist
            if (([sharedData.favItems count] > 0) && (section == 0))
            {
                NSString *favItemId = [(NSDictionary *)[sharedData.favItems objectAtIndex:row] objectForKey:kItemId];
                
                // textLabel (hack to add indentation by buffering with spaces)
                cell.textLabel.text = [GlobalFunctions menuItemForItemId:favItemId];
                
                // accessoryType
                cell.accessoryType = UITableViewCellAccessoryNone;
                
                // detailTextLabel
                cell.detailTextLabel.text = [GlobalFunctions detailTextLabelForArray:[NSArray arrayWithArray:sharedData.favItems] andRow:row];
                
                // image
                if ([GlobalFunctions orderContainsItemId:favItemId])
                    [cell.contentView addSubview:[GlobalFunctions greenCircleWithTag:tag]];
                
                return cell;
            }
            
            cell.textLabel.text = [(NSDictionary *)[restaurantData.menuSections objectAtIndex:row] objectForKey:kSectionHeader];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            return cell;

            break;
        }
            
        case kDisplayMenuSectionDetail:{
            
            NSString *itemId = [GlobalFunctions itemIdForSection:activeMenuSection andRow:row];
            cell.textLabel.text = [GlobalFunctions menuItemForItemId:itemId];
            
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            cell.detailTextLabel.text = [GlobalFunctions menuItemDescForItemId:itemId];
            
            // add green circle if item's in order
            if ([GlobalFunctions orderContainsItemId:itemId])
                [cell.contentView addSubview:[GlobalFunctions greenCircleWithTag:tag]];
            
            return cell;

            break;
        }
    }

    return nil;
    
}

- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath 
{
	return 1;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
    
	[tableView deselectRowAtIndexPath:indexPath animated:YES];

	NSUInteger row = [indexPath row];
	NSUInteger section = [indexPath section];

    NSLog(@"Selected section %d row %d", row, section);
    
    switch (menuDisplayState) {
        case kDisplayFullMenu: {
            
            // favs are 1st section if they exist
            if (([sharedData.favItems count] > 0) && (section == 0))
            {
                // if user selects item from favs, then add to order
                
                NSString *favItemId = [(NSDictionary *)[sharedData.favItems objectAtIndex:row] objectForKey:kItemId];
                int result = [GlobalFunctions addItemToOrderFromFavs:favItemId];
                NSLog(@"result = %d", result);
                
                [GlobalFunctions archiveAppData];
                [tableViewMenu reloadData];
                
                return;
            } 
            
            // adjust for favs if they exist
            int menuSection = section;
            if ([sharedData.favItems count] > 0)
                menuSection --;
            
            NSString *itemId = [GlobalFunctions itemIdForSection:menuSection andRow:row];
            
            MenuItemViewController *menuItemViewController = [[MenuItemViewController alloc] initWithNibName:nil bundle:nil showMenuItem:itemId];
            
            menuItemViewController.delegate = self;
            [menuItemViewController setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
            [self presentModalViewController:menuItemViewController animated:YES];
            
            break;
        }
            
        case kDisplayMenuSections:{
            
            // favs are 1st section if they exist
            if (([sharedData.favItems count] > 0) && (section == 0))
            {
                // if user selects item from favs, then add to order
                
                NSString *favItemId = [(NSDictionary *)[sharedData.favItems objectAtIndex:row] objectForKey:kItemId];
                int result = [GlobalFunctions addItemToOrderFromFavs:favItemId];
                NSLog(@"result = %d", result);
                
                [GlobalFunctions archiveAppData];
                [tableViewMenu reloadData];
                
                return;
            } 
            
            activeMenuSection = row;
            menuDisplayState = kDisplayMenuSectionDetail;
            
            imageViewPhone.hidden = TRUE;
            buttonPlaceOrder.enabled = TRUE;
            [buttonPlaceOrder setTitle:@"Back to Main Menu" forState:UIControlStateNormal];
            
            [tableViewMenu reloadData];
            [tableViewMenu scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
            
            break;
        }
            
        case kDisplayMenuSectionDetail:{
            
            NSString *itemId = [GlobalFunctions itemIdForSection:activeMenuSection andRow:row];
            
            MenuItemViewController *menuItemViewController = [[MenuItemViewController alloc] initWithNibName:nil bundle:nil showMenuItem:itemId];
            
            menuItemViewController.delegate = self;
            [menuItemViewController setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
            [self presentModalViewController:menuItemViewController animated:YES];
            
            break;
        }
    }

}


- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath 
{
    NSUInteger section = [indexPath section];

    if (   ([sharedData.favItems count] > 0)
        && (section == 0) 
        && (menuDisplayState == kDisplayFullMenu || menuDisplayState == kDisplayMenuSections))
        
        return UITableViewCellEditingStyleDelete;
    else
        return UITableViewCellEditingStyleNone;
    
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath 
{
    NSUInteger row = [indexPath row];
    [sharedData.favItems removeObjectAtIndex:row];
    [GlobalFunctions archiveAppData];
    
    [tableViewMenu reloadData];
}



#pragma mark - delegate methods

- (void)menuItemViewControllerDidFinish
{
    [self dismissModalViewControllerAnimated:YES];
}



#pragma mark - IB Actions

- (IBAction)buttonPlaceOrderDidTouchUp:(id)sender 
{    
    switch (menuDisplayState) {
        case kDisplayFullMenu:
            
            [GlobalFunctions placeOrderByPhone];
            break;
    
            
        case kDisplayMenuSections:
            
            [GlobalFunctions placeOrderByPhone];
            break;
            
        case kDisplayMenuSectionDetail:
            
            menuDisplayState = kDisplayMenuSections;
            
            imageViewPhone.hidden = FALSE;
            [self placeOrderButtonText];

            [tableViewMenu reloadData];
            [tableViewMenu scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
            break;
    }

}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    // instantiate the Singleton Class
    sharedData = [SingletonClass sharedDataInstance]; 
    restaurantData = [RestaurantClass restaurantDataInstance];

    // set background color for iPad
    if ([tableViewMenu respondsToSelector:@selector(backgroundView)]) 
    {
        tableViewMenu.backgroundView = nil;
        [tableViewMenu setBackgroundView:[[UIView alloc] init]];
    }
    
    tableViewMenu.backgroundColor = [UIColor myTableBackgroundColor];
    labelAboveTableView.backgroundColor = [UIColor myTableBackgroundColor];

    // check device capabilities
    [self placeOrderButtonText];
 
    menuDisplayState = kDisplayMenuSections;
}


- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [tableViewMenu reloadData];
    
}


- (void)viewDidUnload
{
    [self setTableViewMenu:nil];
    [self setLabelAboveTableView:nil];
    [self setButtonPlaceOrder:nil];
    [self setImageViewPhone:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
