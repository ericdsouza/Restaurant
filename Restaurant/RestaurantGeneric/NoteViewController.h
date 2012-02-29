//
//  NoteViewController.h
//  TheRealJerk
//
//  Created by Eric D'Souza on 12-02-22.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NoteDelegate <NSObject>

- (void)noteViewControllerDidReturnNote:(NSString *)note;

@end


@interface NoteViewController : UIViewController {
    
    id <NoteDelegate> __unsafe_unretained delegate;
    
    NSString *note;
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil currentNote:(NSString *)currentNote;

@property (nonatomic, unsafe_unretained) id <NoteDelegate> delegate;
@property (nonatomic, strong) NSString *note;

@property (unsafe_unretained, nonatomic) IBOutlet UITextView *textNote;

@end
