//
//  FiltersController.h
//  PDFLibrary
//
//  Created by Gonzalo Aizpun on 7/18/11.
//  Copyright 2011 TheAppMaster. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TenarisViewController.h"

#import "Language.h"
#import "Category.h"

#import "DocumentCommonCell.h"


@interface FiltersController : TenarisViewController<UIGestureRecognizerDelegate, UITableViewDelegate,
                                                     DocumentCommonCellDelegate> {
    
    IBOutlet UIButton * btnCategory0;
    IBOutlet UIButton * btnCategory1;
    IBOutlet UIButton * btnCategory2;
    IBOutlet UIButton * btnCategory3;
    IBOutlet UIButton * btnCategory4;
    IBOutlet UIButton * btnCategory5;
    IBOutlet UIButton * btnCategory6;
    
    IBOutlet UIButton * btnSort1;
    IBOutlet UIButton * btnSort2;
    
    IBOutlet UILabel  * lblTitlePortrait;
    IBOutlet UILabel  * lblMatchesPortrait;    
    IBOutlet UILabel  * lblResultsPortrait;
    
    IBOutlet UITableView * tablePortrait;
    
    // ***************************************
    
    IBOutlet UIButton * btnCategory0Landscape;
    IBOutlet UIButton * btnCategory1Landscape;
    IBOutlet UIButton * btnCategory2Landscape;
    IBOutlet UIButton * btnCategory3Landscape;
    IBOutlet UIButton * btnCategory4Landscape;
    IBOutlet UIButton * btnCategory5Landscape;
    IBOutlet UIButton * btnCategory6Landscape;
    
    IBOutlet UIButton * btnSort1Landscape;
    IBOutlet UIButton * btnSort2Landscape;
    
    IBOutlet UILabel  * lblTitleLandscape;
    IBOutlet UILabel  * lblMatchesLandscape;
    IBOutlet UILabel  * lblResultsLandscape;
    
    IBOutlet UITableView * tableLandscape;
    
    // ***************************************
    
    Language * language;
    Category * category;
    
    NSArray * currentList;
    
    int lastSort;

}

@property (nonatomic, retain) Language * language;

// FiltersController Actions
- (IBAction) btnFilterByCategoryPressed:(id)sender;
- (IBAction) btnFilterBySortingPressed:(id)sender;


@end
