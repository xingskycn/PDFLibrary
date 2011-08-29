//
//  SearchResultsController.h
//  PDFLibrary
//
//  Created by Gonzalo Aizpun on 7/18/11.
//  Copyright 2011 TheAppMaster. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TenarisViewController.h"
#import "DocumentCommonCell.h"
#import "Category.h"


@interface SearchResultsController : TenarisViewController<UIGestureRecognizerDelegate, UITableViewDelegate,
                                                            DocumentCommonCellDelegate> {
    
    IBOutlet UIButton * btnSort1;
    IBOutlet UIButton * btnSort2;
    
    IBOutlet UILabel  * lblTitlePortrait;
    IBOutlet UILabel  * lblMatchesPortrait; 
    IBOutlet UILabel  * lblResultsPortrait;
    
    IBOutlet UITableView * tablePortrait;
    
    // *************************************
    
    IBOutlet UIButton * btnSort1Landscape;
    IBOutlet UIButton * btnSort2Landscape;
    
    IBOutlet UILabel  * lblTitleLandscape;
    IBOutlet UILabel  * lblMatchesLandscape; 
    IBOutlet UILabel  * lblResultsLandscape;
    
    IBOutlet UITableView * tableLandscape;
    
    // *************************************
    
    NSString * phrase;
    NSArray  * currentList;
    Category * category;
    int lastSort;
}

@property (nonatomic, retain) NSString * phrase;

// LibraryController Actions
- (IBAction) btnFilterByCategoryPressed:(id)sender;
- (IBAction) btnFilterBySortingPressed:(id)sender;
- (IBAction) btnFeaturedPressed;
- (void) updateLabels;

@end
