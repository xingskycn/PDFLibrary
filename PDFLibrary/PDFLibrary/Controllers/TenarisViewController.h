//
//  TenarisViewController.h
//  PDFLibrary
//
//  Created by Gonzalo Aizpun on 8/21/11.
//  Copyright 2011 TheAppMaster. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MenuCategoriesController.h"
#import "MenuLanguageController.h"
#import "IndicatorController.h"


@interface TenarisViewController : UIViewController<MenuCategoriesControllerDelegate, 
                                                    MenuLanguageControllerDelegate> {
    
    MenuCategoriesController * menuCategoryControllerLandscape;
    MenuLanguageController   * menuLanguageControllerLandscape;
    MenuCategoriesController * menuCategoryControllerPortrait;
    MenuLanguageController   * menuLanguageControllerPortrait;      
    
    IndicatorController * indicatorController;
    
    IBOutlet UIView * landscape;
    IBOutlet UIView * portrait;
    
}

@property (nonatomic, retain) IBOutlet UIView * landscape;
@property (nonatomic, retain) IBOutlet UIView * portrait;
@property (nonatomic, retain) IndicatorController * indicatorController;
@property (nonatomic, retain) MenuCategoriesController * menuCategoryControllerLandscape;
@property (nonatomic, retain) MenuCategoriesController * menuCategoryControllerPortrait;
@property (nonatomic, retain) MenuLanguageController   * menuLanguageControllerLandscape;
@property (nonatomic, retain) MenuLanguageController   * menuLanguageControllerPortrait;


- (IBAction) btnHomePressed;
- (IBAction) btnMyLibraryPressed;
- (IBAction) btnContactPressed;
- (IBAction) btnSearchPressed;
- (IBAction) btnLanguagesPressed;
- (IBAction) btnCategoriesPressed;
- (IBAction) btnBackPressed:(id)sender;

- (void)setGestureRecognizer:(id)sender;
- (void)setMenuControllers;
- (BOOL)isPortrait;
- (void)hideMenu;

@end
