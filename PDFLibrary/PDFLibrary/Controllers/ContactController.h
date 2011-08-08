//
//  ContactController.h
//  PDFLibrary
//
//  Created by Gonzalo Aizpun on 7/18/11.
//  Copyright 2011 TheAppMaster. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeController.h"
#import "EbookController.h"
#import "LibraryController.h"
#import "CategoryController.h"

@interface ContactController : UIViewController<UIGestureRecognizerDelegate> {
    IBOutlet UIButton * btnPopoverCategories;
    IBOutlet UIButton * btnPopoverLanguages;
    
    IBOutlet UITextView * txtMessage;
    IBOutlet UITextField * txtName;
    IBOutlet UITextField * txtCompany;
    IBOutlet UITextField * txtEmail;
    IBOutlet UITextField * txtPhone;
    IBOutlet UIButton * btnSendCopy;
    
    IBOutlet UIView * landscape;
    IBOutlet UIView * portrait;
}

@property (nonatomic,retain) IBOutlet UIView* landscape;
@property (nonatomic,retain) IBOutlet UIView* portrait;

- (IBAction) btnHomePressed;
- (IBAction) btnCategoriesPressed;
- (IBAction) btnLanguagesPressed;
- (IBAction) btnMyLibraryPressed;
- (IBAction) btnContactPressed;
- (IBAction) btnSearchPressed;
- (IBAction) btnCategoryPressed:(id)sender;
- (IBAction) btnPopoverLanguagesPressed;
- (IBAction) btnPopoverCategoriesPressed;

// ContactActions
- (IBAction) btnSendPressed;
- (IBAction) btnSendCopyPressed;

@end
