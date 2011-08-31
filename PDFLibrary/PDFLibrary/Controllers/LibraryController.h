//
//  LibraryController.h
//  PDFLibrary
//
//  Created by Gonzalo Aizpun on 7/18/11.
//  Copyright 2011 TheAppMaster. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TenarisViewController.h"
#import "DocumentCommonCell.h"


@interface LibraryController : TenarisViewController<UIGestureRecognizerDelegate, UITableViewDelegate,
                                                     DocumentCommonCellDelegate> {
    
    IBOutlet UIButton * btnSort1;
    IBOutlet UIButton * btnSort2;
    
    IBOutlet UITableView * tablePortrait;
    
    // ******************************************
    
    IBOutlet UIButton * btnSort1Landscape;
    IBOutlet UIButton * btnSort2Landscape;
    
    IBOutlet UIScrollView * scrollViewLandscape;
    NSMutableArray *viewControllers;
    int kNumberOfPages;

    // ******************************************
    
    NSArray * currentList;
    int lastSort;
}

@property (nonatomic, retain) UIScrollView *scrollViewLandscape;

// LibraryController Actions
- (IBAction) btnFilterBySortingPressed:(id)sender;



@end
