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
    
    IBOutlet UIView * landscape;
    IBOutlet UIView * portrait;

    IBOutlet UIButton * btnPopoverCategoriesLandscape;
    IBOutlet UIButton * btnPopoverLanguagesLandscape;
    
    IBOutlet UIButton * btnCategory0Landscape;
    IBOutlet UIButton * btnCategory1Landscape;
    IBOutlet UIButton * btnCategory2Landscape;
    IBOutlet UIButton * btnCategory3Landscape;
    IBOutlet UIButton * btnCategory4Landscape;
    IBOutlet UIButton * btnCategory5Landscape;
    IBOutlet UIButton * btnCategory6Landscape;
    
    IBOutlet UIButton * btnSort1Landscape;
    IBOutlet UIButton * btnSort2Landscape;

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
- (IBAction) btnFeaturedPressed;
- (IBAction) btnPopoverLanguagesPressed;
- (IBAction) btnPopoverCategoriesPressed;
- (IBAction) btnBackPressed:(id)sender;

// FiltersController Actions
- (IBAction) btnFilterByCategoryPressed:(id)sender;
- (IBAction) btnFilterBySortingPressed:(id)sender;



@end
