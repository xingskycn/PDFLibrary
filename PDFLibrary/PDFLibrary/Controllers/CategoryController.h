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

#import "Category.h"

@interface CategoryController : UIViewController<UIGestureRecognizerDelegate> {

    IBOutlet UIButton * btnPopoverCategories;
    IBOutlet UIButton * btnPopoverLanguages;
    IBOutlet UIButton * btnSort1;
    IBOutlet UIButton * btnSort2;
    
    IBOutlet UILabel  * lblTitlePortrait;
    
    IBOutlet UIScrollView * scrollView;
    
    // *******************************************
    
    IBOutlet UIView * landscape;
    IBOutlet UIView * portrait;

    // *******************************************    
    
    IBOutlet UIButton * btnPopoverCategoriesLandscape;
    IBOutlet UIButton * btnPopoverLanguagesLandscape;
    IBOutlet UIButton * btnSort1Landscape;
    IBOutlet UIButton * btnSort2Landscape;
    
    IBOutlet UILabel  * lblTitleLandscape;
    
    IBOutlet UIScrollView * scrollViewLandscape;
    
    // ******************************************* 
    
    Category * category;
}

@property (nonatomic, retain) IBOutlet UIView * landscape;
@property (nonatomic, retain) IBOutlet UIView * portrait;

@property (nonatomic, retain) UIScrollView * scrollView;
@property (nonatomic, retain) UIScrollView * scrollViewLandscape;

@property (nonatomic, retain) Category * category;

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

// LibraryController Actions
- (IBAction) btnFilterBySortingPressed:(id)sender;



@end
