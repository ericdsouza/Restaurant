//
//  MenuItemViewController.m
//  TheRealJerk
//
//  Created by Eric D'Souza on 12-02-16.
//  Copyright (c) 2012 Eric D'Souza. All rights reserved.
//

#import "MenuItemViewController.h"
#import "GlobalFunctions.h"
#import "UIColorExtensions.h"
#import <QuartzCore/QuartzCore.h>


@implementation MenuItemViewController

@synthesize delegate;

@synthesize labelMenuItem;
@synthesize itemId;
@synthesize tableViewItem;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil showMenuItem:(NSString *)selectedItemId
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    
    itemId = selectedItemId;
    
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - self delegate

- (void)didFinish
{
    [self.delegate menuItemViewControllerDidFinish];
}


#pragma mark - table methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}


- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section 
{
    int rowCount;
    
    switch (section) 
    {
        case 0:
            rowCount = 1;    
            break;

        case 1:
        {
            // if this item is part of the order, then show the notes line
            if ([GlobalFunctions orderContainsItemId:itemId])
                rowCount = 3;    
            else
                rowCount = 2;    

            break;
        }

        case 2:
            rowCount = 1;    
            break;

        case 3:
            rowCount = 1;    
            break;

        case 4:
            rowCount = 1;    
            break;
}
    
    return rowCount;
}


- (UITableViewCell *)tableView:(UITableView *)tableView
		 cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
    
	static NSString *SimpleTableIdentifier = @"SimpleTableIdentifier";
	UITableViewCell * cell = [tableView
                              dequeueReusableCellWithIdentifier: SimpleTableIdentifier];
	if(cell == nil) 
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2
                                      reuseIdentifier:SimpleTableIdentifier];
    }
    
	NSUInteger section = [indexPath section];
	NSUInteger row = [indexPath row];

    // default values for cell
    [[cell viewWithTag:100] removeFromSuperview];
    [cell setBackgroundColor:[UIColor whiteColor]];
    cell.textLabel.text = @"";
    cell.detailTextLabel.text = @"";
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    

    switch (section) 
    {
        // item image
        case 0:
        {
            // image
            UIImageView *imageViewMenuItem = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 302, 187)];
            imageViewMenuItem.image  = [UIImage imageNamed:[GlobalFunctions menuImageNameForItemId:itemId]];
            [cell.contentView addSubview:imageViewMenuItem];
            
            // frame
            UILabel *labelPictureFrame = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 302, 187)];
            labelPictureFrame.layer.borderColor = [[UIColor blackColor] CGColor];
            labelPictureFrame.layer.borderWidth = 1.0;
            labelPictureFrame.layer.cornerRadius = 8.0;
            labelPictureFrame.layer.masksToBounds = YES;
            labelPictureFrame.backgroundColor = [UIColor clearColor];
            [cell.contentView addSubview:labelPictureFrame];
            
            // clip
            UILabel *labelPictureClip = [[UILabel alloc] initWithFrame:CGRectMake(-4, -4, 310, 195)];
            labelPictureClip.layer.borderColor = [[UIColor blackColor] CGColor];
            labelPictureClip.layer.borderWidth = 4.0;
            labelPictureClip.layer.cornerRadius = 12.0;
            labelPictureClip.layer.masksToBounds = YES;
            labelPictureClip.backgroundColor = [UIColor clearColor];
            [cell.contentView addSubview:labelPictureClip];
            
            // item description background
            UILabel *labelItemDescBackground = [[UILabel alloc] initWithFrame:CGRectMake(0, 137, 302, 50)];
            labelItemDescBackground.backgroundColor = [UIColor blackColor];
            labelItemDescBackground.alpha = 0.6f;
            
            // item description
            UILabel *labelItemDesc = [[UILabel alloc] initWithFrame:CGRectMake(10, 137, 282, 50)];
            labelItemDesc.backgroundColor = [UIColor clearColor];
            labelItemDesc.textColor = [UIColor whiteColor];
            labelItemDesc.text = [GlobalFunctions menuItemDescForItemId:itemId];
            labelItemDesc.lineBreakMode = UILineBreakModeWordWrap;
            labelItemDesc.numberOfLines = 0;
            [labelItemDesc sizeToFit];
            
            // adjust item desc frames and add as subview (now that we've sizedToFit label text)
            int verticalBuffer = 5;
            CGRect adjustedItemDescFrame = CGRectMake(labelItemDesc.frame.origin.x, 
                                                      labelPictureFrame.frame.size.height - labelItemDesc.frame.size.height - verticalBuffer, 
                                                      labelItemDesc.frame.size.width, 
                                                      labelItemDesc.frame.size.height);
            labelItemDesc.frame = adjustedItemDescFrame;

            CGRect adjustedItemDescBackgroundFrame = CGRectMake(labelItemDescBackground.frame.origin.x, 
                                                                labelPictureFrame.frame.size.height - labelItemDesc.frame.size.height - verticalBuffer * 2, 
                                                                labelItemDescBackground.frame.size.width, 
                                                                labelItemDesc.frame.size.height + verticalBuffer * 2);
            labelItemDescBackground.frame = adjustedItemDescBackgroundFrame;

            [cell.contentView addSubview:labelItemDescBackground];
            [cell.contentView addSubview:labelItemDesc];

            
            break;
        }

        case 1:
        {
            switch (row) 
            {
                // price
                case 0:
                {
                    cell.textLabel.text = @"price";
                    cell.detailTextLabel.text = [GlobalFunctions menuPriceForItemId:itemId];
                    break;
                }   

                // qty
                case 1:
                {
                    cell.textLabel.text = @"order qty";
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                    cell.selectionStyle = UITableViewCellSelectionStyleBlue;
                    
                    int quantity = [GlobalFunctions orderQuantityForItemId:itemId];
                    if (quantity == 0)
                        cell.detailTextLabel.text = @"-";
                    else
                        cell.detailTextLabel.text = [NSString stringWithFormat:@"%d",quantity];
                    
                    break;
                }   

                // notes
                case 2:
                {
                    cell.textLabel.text = @"notes";
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                    cell.selectionStyle = UITableViewCellSelectionStyleBlue;

                    NSString *note = [GlobalFunctions orderNoteForItemId:itemId];
                    if ([note isEqualToString:@""])
                        cell.detailTextLabel.text = @"-";
                    else
                        cell.detailTextLabel.text = note;

                    
                    break;
                }   
            }
            break;
            
        }   

        // add to order 
        case 2:
        {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];

            button.frame = CGRectMake(0.0, 0.0, 302, 40);
            button.titleLabel.font = [UIFont boldSystemFontOfSize:16];
            button.tag = 100;

            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [button setBackgroundColor:[UIColor clearColor]];
            
            [button addTarget:self action:@selector(buttonAddToOrderDidTouchUp:)  forControlEvents:UIControlEventTouchUpInside];

            NSString *buttonText = @"";
            if ([GlobalFunctions orderContainsItemId:itemId])
                buttonText = @"Add +1 to Order";
            else
                buttonText = @"Add to Order";
                
            
            [button setTitle:buttonText forState:UIControlStateNormal];
            
            [cell.contentView addSubview:button];
            [cell setSelectionStyle:UITableViewCellSelectionStyleBlue];
            [cell setBackgroundColor:[UIColor whiteColor]];
            break;
        }
            
        // delete from order 
        case 3:
        {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(0.0, 0.0, 302, 40);
            button.titleLabel.font = [UIFont boldSystemFontOfSize:16];
            button.tag = 100;
            
            [button addTarget:self action:@selector(buttonDeleteFromOrderDidTouchUp:)  forControlEvents:UIControlEventTouchUpInside];
            [button setBackgroundColor:[UIColor clearColor]];
            [button setTitle:@"Delete from Order" forState:UIControlStateNormal];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            
            if ([GlobalFunctions orderContainsItemId:itemId])
            {
                [cell setBackgroundColor:[UIColor appleDeleteRedColor]];
                button.alpha = 1.0;
                button.enabled = TRUE;
            } else {
                [cell setBackgroundColor:[UIColor lightGrayColor]];
                button.alpha = 0.5;
                button.enabled = FALSE;
            }
            
            [cell.contentView addSubview:button];
            break;
                
        }
            
        // add to favourites 
        case 4:
        {
            cell.selectionStyle = UITableViewCellSelectionStyleBlue;
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(0.0, 0.0, 302, 40);
            button.titleLabel.font = [UIFont boldSystemFontOfSize:16];
            button.tag = 100;
            
            [button addTarget:self action:@selector(buttonAddToFavouritesDidTouchUp:)  forControlEvents:UIControlEventTouchUpInside];
            [button setBackgroundColor:[UIColor clearColor]];
            [button setTitle:@"Add to Favourites" forState:UIControlStateNormal];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            
            [cell.contentView addSubview:button];
            [cell setBackgroundColor:[UIColor whiteColor]];
            break;
        }
            
    }
    
	return cell;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

	NSUInteger section = [indexPath section];
    
    if (section == 0)
        return 187;  // image

    else
        return 44;   // standard height
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
    
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
    
	NSUInteger row = [indexPath row];
	NSUInteger section = [indexPath section];
    
    NSLog(@"Selected row %d section %d", row, section);
    
    // quantity
    if ((section == 1) && (row == 1))
    {
        int aNumber = [GlobalFunctions orderQuantityForItemId:itemId];
        
        NumberViewController *numberViewController = [[NumberViewController alloc] initWithNibName:nil bundle:nil currentNumber:aNumber];
        
        numberViewController.delegate = self;
        [numberViewController setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
        [self presentModalViewController:numberViewController animated:YES];
    }
        
    
    // note
    if ((section == 1) && (row == 2))
    {
        NSString *note = [GlobalFunctions orderNoteForItemId:itemId];
        
        NoteViewController *noteViewController = [[NoteViewController alloc] initWithNibName:nil bundle:nil currentNote:note];
        
        noteViewController.delegate = self;
        [noteViewController setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
        [self presentModalViewController:noteViewController animated:YES];
    }

}


#pragma mark - delegate methods

- (void)noteViewControllerDidReturnNote:(NSString *)note
{
    
    [GlobalFunctions updateOrder:itemId withNote:note];
    
    [self dismissModalViewControllerAnimated:YES];
    [GlobalFunctions archiveAppData];
    [tableViewItem reloadData];
    
}


-(void)numberViewControllerDidReturnNumber:(int)aNumber
{
    [self dismissModalViewControllerAnimated:YES];

    if (aNumber == 0)
        [GlobalFunctions deleteItemFromOrder:itemId];
    else
        [GlobalFunctions updateOrder:itemId withQuantity:aNumber];
      
    [GlobalFunctions archiveAppData];
    [tableViewItem reloadData];
}


#pragma mark - IB Actions

- (IBAction)buttonDoneDidTouchUp:(id)sender 
{    
    [self didFinish];
}


- (IBAction)buttonAddToOrderDidTouchUp:(id)sender 
{    
    // this should highlight the cell, but I don't know why it's not working
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:2];
    [tableViewItem selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];

    int quantity = [GlobalFunctions orderQuantityForItemId:itemId];
    quantity ++;
    int result = [GlobalFunctions updateOrder:itemId withQuantity:quantity];
    
    NSLog(@"result = %d", result);
    
    [GlobalFunctions archiveAppData];
    [self didFinish];
}


- (IBAction)buttonAddToFavouritesDidTouchUp:(id)sender 
{    
    // this should highlight the cell, but I don't know why it's not working
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:4];
    [tableViewItem selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        
    int result = [GlobalFunctions addItemToFavs:itemId];
    NSLog(@"result = %d", result);
    
    [GlobalFunctions archiveAppData];
    [tableViewItem reloadData];
    
    UIAlertView *alert;
    alert = [[UIAlertView alloc] initWithTitle:@"Favourites" 
                                       message:@"Item has been added to favourites."
                                      delegate:nil
                             cancelButtonTitle:@"OK" 
                             otherButtonTitles:nil];
    [alert show];
    
}


- (IBAction)buttonDeleteFromOrderDidTouchUp:(id)sender 
{    
    int result = [GlobalFunctions deleteItemFromOrder:itemId];
    NSLog(@"result = %d", result);
    
    [GlobalFunctions archiveAppData];
    [self didFinish];
}



#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    // instantiate the Singleton Class
    sharedData = [SingletonClass sharedDataInstance]; 
    restaurantData = [RestaurantClass restaurantDataInstance];
    
    // set background color for iPad
    if ([tableViewItem respondsToSelector:@selector(backgroundView)]) 
    {
        tableViewItem.backgroundView = nil;
        [tableViewItem setBackgroundView:[[UIView alloc] init]];
    }
    
    tableViewItem.backgroundColor = [UIColor blackColor];

}


- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [tableViewItem reloadData];
    
    labelMenuItem.text = [GlobalFunctions menuItemForItemId:itemId];
    
}


- (void)viewDidUnload
{
    [self setLabelMenuItem:nil];
    [self setTableViewItem:nil];
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
