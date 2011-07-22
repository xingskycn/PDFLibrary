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


@interface ContactController : UIViewController<UIGestureRecognizerDelegate> {
    IBOutlet UIImageView * imgPopoverCategories;
    IBOutlet UIImageView * imgPopoverLanguages;
    
    IBOutlet UITextView * txtMessage;
    IBOutlet UITextField * txtName;
    IBOutlet UITextField * txtCompany;
    IBOutlet UITextField * txtEmail;
    IBOutlet UITextField * txtPhone;
    IBOutlet UIButton * btnSendCopy;
}

- (IBAction) btnHomePressed;
- (IBAction) btnCategoriesPressed;
- (IBAction) btnLanguagesPressed;
- (IBAction) btnMyLibraryPressed;
- (IBAction) btnContactPressed;
- (IBAction) btnSearchPressed;
- (IBAction) btnCategoryPressed:(id)sender;

// ContactActions
- (IBAction) btnSendPressed;
- (IBAction) btnSendCopyPressed;

@end
