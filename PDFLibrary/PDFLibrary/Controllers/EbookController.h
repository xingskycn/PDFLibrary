//
//  EbookController.h
//  PDFLibrary
//
//  Created by Gonzalo Aizpun on 7/18/11.
//  Copyright 2011 TheAppMaster. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HomeController.h"
#import "ContactController.h"
#import "RequestCopyController.h"


@interface EbookController : UIViewController<UIGestureRecognizerDelegate> {
    IBOutlet UIImageView * imgPopoverCategories;
    IBOutlet UIImageView * imgPopoverLanguages;
}

- (IBAction) btnHomePressed;
- (IBAction) btnCategoriesPressed;
- (IBAction) btnLanguagesPressed;
- (IBAction) btnMyLibraryPressed;
- (IBAction) btnContactPressed;
- (IBAction) btnSearchPressed;
- (IBAction) btnCategoryPressed:(id)sender;

// Ebook Actions
- (IBAction) btnRequestCopyPressed;


@end
