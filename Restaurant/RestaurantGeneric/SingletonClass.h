//
//  SingletonClass.h
//
//  Created by Eric D'Souza on 11-08-25.
//  Copyright 2012 Eric D'Souza. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum apiCall {
    kAPILogout,
    kAPIGraphUserPermissionsDelete,
    kDialogPermissionsExtended,
    kDialogFeedUser,
    kAPIGraphPhotoData,
    kAPIGraphUserPermissions,
    kAPIGraphUserPhotosPost,
    kAPIGraphUserPhotosTag,
    kAPIGraphUserFriends,
    kAPIGraphMe
} apiCall;

typedef enum menuDisplayStates {
    kDisplayMenuSections,
    kDisplayMenuSectionDetail,
    kDisplayFullMenu
} menuDisplayStates;

extern NSString * const kSectionHeader;
extern NSString * const kSectionFooter;
extern NSString * const kSectionName;
extern NSString * const kItem;
extern NSString * const kItemId;
extern NSString * const kItemDesc;
extern NSString * const kPrice;
extern NSString * const kImageName;
extern NSString * const kQuantity;
extern NSString * const kNote;
extern NSString * const kLocation;
extern NSString * const kPhoneNumber;
extern NSString * const kPointTitle;
extern NSString * const kPointSubtitle;


@interface SingletonClass : NSObject {
    
    NSMutableArray *orderItems;
    NSMutableArray *favItems;
    NSInteger activeLocation;

    @private
}

@property (nonatomic, strong) NSMutableArray *orderItems;
@property (nonatomic, strong) NSMutableArray *favItems;
@property (readwrite) NSInteger activeLocation;

+(SingletonClass*) sharedDataInstance;

@end

