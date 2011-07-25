//
//  FiltersController.h
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
#import "CategoryController.h"


@interface FiltersController : UIViewController<UIGestureRecognizerDelegate> {
    IBOutlet UIButton * btnPopoverCategories;
    IBOutlet UIButton * btnPopoverLanguages;
    
    IBOutlet UIButton * btnCategory0;
    IBOutlet UIButton * btnCategory1;
    IBOutlet UIButton * btnCategory2;
    IBOutlet UIButton * btnCategory3;
    IBOutlet UIButton * btnCategory4;
    IBOutlet UIButton * btnCategory5;
    IBOutlet UIButton * btnCategory6;
    
    IBOutlet UIButton * btnSort1;
    IBOutlet UIButton * btnSort2;
}

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

// FiltersController Actions
- (IBAction) btnFilterByCategoryPressed:(id)sender;
- (IBAction) btnFilterBySortingPressed:(id)sender;



@end
