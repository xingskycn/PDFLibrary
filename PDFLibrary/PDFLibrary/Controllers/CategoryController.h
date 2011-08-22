//
//  CategoryController.h
//  PDFLibrary
//
//  Created by Gonzalo Aizpun on 7/18/11.
//  Copyright 2011 TheAppMaster. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TenarisViewController.h"

#import "Category.h"

@interface CategoryController : TenarisViewController<UIGestureRecognizerDelegate> {

    IBOutlet UIButton * btnSort1;
    IBOutlet UIButton * btnSort2;
    
    IBOutlet UILabel  * lblTitlePortrait;
    
    IBOutlet UIScrollView * scrollView;
    
    // *******************************************    
    
    IBOutlet UIButton * btnSort1Landscape;
    IBOutlet UIButton * btnSort2Landscape;
    
    IBOutlet UILabel  * lblTitleLandscape;
    
    IBOutlet UIScrollView * scrollViewLandscape;
    
    // ******************************************* 
    
    Category * category;
}

@property (nonatomic, retain) UIScrollView * scrollView;
@property (nonatomic, retain) UIScrollView * scrollViewLandscape;

@property (nonatomic, retain) Category * category;

// LibraryController Actions
- (IBAction) btnFilterBySortingPressed:(id)sender;



@end
