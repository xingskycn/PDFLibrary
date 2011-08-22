//
//  TenarisViewController.m
//  PDFLibrary
//
//  Created by Gonzalo Aizpun on 8/21/11.
//  Copyright 2011 TheAppMaster. All rights reserved.
//

#import "TenarisViewController.h"

#import "HomeController.h"
#import "EbookController.h"
#import "LibraryController.h"
#import "CategoryController.h"
#import "ContactController.h"
#import "FiltersController.h"

#import "CategoryDAO.h"
#import "LanguageDAO.h"

#import "Category.h"
#import "Language.h"

#define kFadeInTimer 0.3

@implementation TenarisViewController
@synthesize portrait, landscape, indicatorController;
@synthesize menuCategoryControllerLandscape, menuCategoryControllerPortrait, 
            menuLanguageControllerPortrait, menuLanguageControllerLandscape;

- (BOOL)isPortrait {
    UIDeviceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    return UIInterfaceOrientationIsPortrait(orientation);
}

- (BOOL)pressedOnMyOwnClass:(NSString *)myClass {
    
    NSString * className = NSStringFromClass([self class]); 
    return [className isEqualToString:myClass];
    
}

- (void)relocateMenuViews {

    // view's size & position
    CGRect lP = menuLanguageControllerPortrait.view.frame;
    CGRect lL = menuLanguageControllerLandscape.view.frame;    
    CGRect cP = menuCategoryControllerPortrait.view.frame;
    CGRect cL = menuCategoryControllerLandscape.view.frame;    
    
    float yForLanguageL = 768  - 62 - lL.size.height;
    float yForLanguageP = 1024 - 62 - lP.size.height;
    
    menuCategoryControllerLandscape.view.frame = CGRectMake(89,  450, cL.size.width, cL.size.height);
    menuLanguageControllerLandscape.view.frame = CGRectMake(270,yForLanguageL, lL.size.width, lL.size.height);    
    menuLanguageControllerPortrait.view.frame  = CGRectMake(230,yForLanguageP, lP.size.width, lP.size.height);    
    menuCategoryControllerPortrait.view.frame  = CGRectMake(63,  705, cP.size.width, cP.size.height); 
    
}


- (void)setMenuControllers {
    
    
    // menuController to view's
    menuCategoryControllerLandscape = [[MenuCategoriesController alloc] initWithDelegate:self];
    menuCategoryControllerPortrait  = [[MenuCategoriesController alloc] initWithDelegate:self];        
    menuLanguageControllerLandscape = [[MenuLanguageController alloc]   initWithDelegate:self];
    menuLanguageControllerPortrait  = [[MenuLanguageController alloc]   initWithDelegate:self];    
    
    [self relocateMenuViews];
    
    // Add all views
    [menuCategoryControllerPortrait.view removeFromSuperview];
    [menuLanguageControllerLandscape.view removeFromSuperview];
    [menuLanguageControllerPortrait.view removeFromSuperview];
    [menuCategoryControllerPortrait.view removeFromSuperview];    
    
    
    [self.landscape addSubview:menuCategoryControllerLandscape.view];
    [self.landscape addSubview:menuLanguageControllerLandscape.view];
    [self.portrait  addSubview:menuLanguageControllerPortrait.view];
    [self.portrait  addSubview:menuCategoryControllerPortrait.view];
    
    [self.landscape bringSubviewToFront:menuCategoryControllerLandscape.view];
    [self.landscape bringSubviewToFront:menuLanguageControllerLandscape.view];
    [self.portrait  bringSubviewToFront:menuLanguageControllerPortrait.view];
    [self.portrait  bringSubviewToFront:menuCategoryControllerPortrait.view];

    
    [self hideMenu];
    
}

// ***************************************************


- (IBAction) btnHomePressed 
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction) btnMyLibraryPressed {
    
    if ([self pressedOnMyOwnClass:@"LibraryController"]) {
        return;
    }
    LibraryController * controller = [[LibraryController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
    [controller release];
    
}

- (IBAction) btnContactPressed {

    if ([self pressedOnMyOwnClass:@"ContactController"]) {
        return;
    }
    ContactController * controller = [[ContactController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
    [controller release];
}

- (IBAction) btnSearchPressed {
    [[[[UIAlertView alloc] initWithTitle:@"TODO" message:@"Search Tapped. Load SearchController" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil] autorelease] show];    
}

- (void)fadeInEffect:(UIView *)view {
    
    [self relocateMenuViews];
    
    view.alpha = 0.0f;    
    view.hidden = NO;        
    [UIView beginAnimations:@"fadeInSecondView" context:NULL];
    [UIView setAnimationDuration:kFadeInTimer];
    view.alpha = 1.0f;
    [UIView commitAnimations];
    
    [self.view bringSubviewToFront:view];
    
}

- (IBAction) btnLanguagesPressed { 
    
    [self setMenuControllers];
    
    if ([self isPortrait]) {
        
        [self fadeInEffect:menuLanguageControllerPortrait.view];       
    } else {
        
        [self fadeInEffect:menuLanguageControllerLandscape.view];       
    }
    
}

- (IBAction) btnCategoriesPressed {

    [self setMenuControllers];
    
    if ([self isPortrait]) {
        
        [self fadeInEffect:menuCategoryControllerPortrait.view];
    } else {
        
        [self fadeInEffect:menuCategoryControllerLandscape.view];
    }

}

- (IBAction) btnBackPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


// ********************************

- (void)menuCategoryTapped:(int)categoryId {
    
    Category * category = [CategoryDAO getCategoryById:categoryId];
    CategoryController * controller = [[CategoryController alloc] init];
    controller.category = category;
    [self.navigationController pushViewController:controller animated:YES];
    [controller release];
    
}


- (void)menuLanguageTapped:(int)languageId {
    
    Language * language = [LanguageDAO getLanguageById:languageId];
    FiltersController * controller = [[FiltersController alloc] init];
    controller.language = language;
    [self.navigationController pushViewController:controller animated:YES];
    [controller release];
    
}


// ********************************


#pragma mark - View lifecycle

- (void)dealloc
{
    [portrait release];
    [landscape release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES if indicatorController is not loaded. Otherwise, return NO (modal action)
	return !(self.indicatorController.view.superview == self.view);
}


- (void)hideMenu {
    
    menuCategoryControllerLandscape.view.hidden = YES;
    menuCategoryControllerPortrait.view.hidden = YES;

    menuLanguageControllerLandscape.view.hidden = YES;
    menuLanguageControllerPortrait.view.hidden = YES;    
    
}


- (void)setGestureRecognizer:(id)sender {

    UIGestureRecognizer *recognizer;
    
    recognizer = [[UITapGestureRecognizer alloc] initWithTarget:sender action:@selector(hideMenu)];
    [(UITapGestureRecognizer *)recognizer setNumberOfTapsRequired:2];
    [self.portrait addGestureRecognizer:recognizer];
    recognizer.delegate = sender;
    [recognizer release];
    
    recognizer = [[UITapGestureRecognizer alloc] initWithTarget:sender action:@selector(hideMenu)];
    [(UITapGestureRecognizer *)recognizer setNumberOfTapsRequired:2];
    [self.landscape addGestureRecognizer:recognizer];
    recognizer.delegate = sender;
    [recognizer release];

}


@end
