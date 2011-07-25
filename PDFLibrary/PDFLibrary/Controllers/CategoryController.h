//
//  CategoryController.h
//  PDFLibrary
//
//  Created by Gonzalo Aizpun on 7/18/11.
//  Copyright 2011 TheAppMaster. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContactController.h"
#import "EbookController.h"
#import "HomeController.h"
#import "LibraryController.h"


@interface CategoryController : UIViewController<UIGestureRecognizerDelegate> {
    IBOutlet UIButton * btnPopoverCategories;
    IBOutlet UIButton * btnPopoverLanguages;
    
    IBOutlet UIButton * btnSort1;
    IBOutlet UIButton * btnSort2;
    
    IBOutlet UIScrollView * scrollView;
}

@property (nonatomic, retain) UIScrollView *scrollView;

- (IBAction) btnHomePressed;
- (IBAction) btnCategoriesPressed;
- (IBAction) btnLanguagesPressed;
- (IBAction) btnMyLibraryPressed;
- (IBAction) btnContactPressed;
- (IBAction) btnSearchPressed;
- (IBAction) btnCategoryPressed:(id)sender;
- (IBAction) btnFeaturedPressed;
- (IBAction) btnPopoverLanguagesPressed;
- (IBAction) btnPopoverCategoriesPressed;

// LibraryController Actions
- (IBAction) btnFilterBySortingPressed:(id)sender;



@end
