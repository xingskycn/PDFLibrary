//
//  RequestCopyController.h
//  PDFLibrary
//
//  Created by Gonzalo Aizpun on 7/18/11.
//  Copyright 2011 TheAppMaster. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HomeController.h"
#import "ContactController.h"


@interface RequestCopyController : UIViewController<UIGestureRecognizerDelegate> {
    IBOutlet UIImageView * imgPopoverCategories;
    IBOutlet UIImageView * imgPopoverLanguages;
    
    IBOutlet UIButton * btnSendHardCopy;
}

- (IBAction) btnHomePressed;
- (IBAction) btnCategoriesPressed;
- (IBAction) btnLanguagesPressed;
- (IBAction) btnMyLibraryPressed;
- (IBAction) btnContactPressed;
- (IBAction) btnSearchPressed;
- (IBAction) btnCategoryPressed:(id)sender;


// RequestCopy Actions
- (IBAction) btnSendPressed;
- (IBAction) btnSendCopyPressed;


@end
