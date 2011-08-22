//
//  LibraryController.h
//  PDFLibrary
//
//  Created by Gonzalo Aizpun on 7/18/11.
//  Copyright 2011 TheAppMaster. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TenarisViewController.h"


@interface LibraryController : TenarisViewController<UIGestureRecognizerDelegate> {
    
    IBOutlet UIButton * btnSort1;
    IBOutlet UIButton * btnSort2;
    
    IBOutlet UIScrollView * scrollView;
    
    IBOutlet UIButton * btnSort1Landscape;
    IBOutlet UIButton * btnSort2Landscape;
    
    IBOutlet UIScrollView * scrollViewLandscape;
}

@property (nonatomic, retain) UIScrollView *scrollView;
@property (nonatomic, retain) UIScrollView *scrollViewLandscape;

// LibraryController Actions
- (IBAction) btnFilterBySortingPressed:(id)sender;



@end
