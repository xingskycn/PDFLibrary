//
//  HomeController.h
//  PDFLibrary
//
//  Created by Gonzalo Aizpun on 7/18/11.
//  Copyright 2011 TheAppMaster. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ContactController.h"
#import "EbookController.h"
#import "FiltersController.h"
#import "LibraryController.h"
#import "CategoryController.h"
#import "IndicatorController.h"

#import "ServiceManager.h"
#import "VersionDAO.h"

#import "FileSystem.h"


@interface HomeController : UIViewController<UIGestureRecognizerDelegate, ServiceManagerDelegate> {
    IBOutlet UIButton * btnPopoverCategories;
    IBOutlet UIButton * btnPopoverLanguages;
    IBOutlet UIButton * btnPopoverCategoriesPortrait;
    IBOutlet UIButton * btnPopoverLanguagesPortrait;
    
    IBOutlet UIView * landscape;
    IBOutlet UIView * portrait;
    
    IndicatorController * indicatorController;
    
    IBOutlet UIImageView * imgCatOnePortrait;
    IBOutlet UILabel * lblCatOneTitlePortrait;
    IBOutlet UILabel * lblCatOneDescriptionPortrait;
}

@property (nonatomic, retain) IBOutlet UIView* landscape;
@property (nonatomic, retain) IBOutlet UIView* portrait;
@property (nonatomic, retain) IndicatorController * indicatorController;


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


@end
