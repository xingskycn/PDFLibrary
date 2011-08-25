//
//  SearchResultsController.h
//  PDFLibrary
//
//  Created by Gonzalo Aizpun on 7/18/11.
//  Copyright 2011 TheAppMaster. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TenarisViewController.h"


@interface SearchResultsController : TenarisViewController<UIGestureRecognizerDelegate> {
    
    IBOutlet UIButton * btnSort1;
    IBOutlet UIButton * btnSort2;
    
    IBOutlet UILabel  * lblTitlePortrait;
    IBOutlet UILabel  * lblMatchesPortrait; 
    
    IBOutlet UIScrollView * scrollView;
    
    // *************************************
    
    IBOutlet UIButton * btnSort1Landscape;
    IBOutlet UIButton * btnSort2Landscape;
    
    IBOutlet UIScrollView * scrollViewLandscape;
    
    IBOutlet UILabel  * lblTitleLandscape;
    IBOutlet UILabel  * lblMatchesLandscape; 
    
    NSString * phrase;
}

@property (nonatomic, retain) UIScrollView *scrollView;
@property (nonatomic, retain) UIScrollView *scrollViewLandscape;
@property (nonatomic, retain) NSString * phrase;

// LibraryController Actions
- (IBAction) btnFilterByCategoryPressed:(id)sender;
- (IBAction) btnFilterBySortingPressed:(id)sender;
- (IBAction) btnFeaturedPressed;
- (void) updateLabels;

@end
