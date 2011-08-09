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
#import "LibraryController.h"
#import "CategoryController.h"

@class MFDocumentManager;
@interface EbookController : UIViewController<UIGestureRecognizerDelegate> {
    IBOutlet UIButton * btnPopoverCategories;
    IBOutlet UIButton * btnPopoverLanguages;
    
    IBOutlet UIView * landscape;
    IBOutlet UIView * portrait;

    IBOutlet UIButton * btnPopoverCategoriesLandscape;
    IBOutlet UIButton * btnPopoverLanguagesLandscape;

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

// Ebook Actions
- (IBAction) btnRequestCopyPressed;
- (IBAction)actionOpenPlainDocument:(id)sender;
- (IBAction)back:(id)sender;

@end
