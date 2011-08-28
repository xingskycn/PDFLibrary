//
//  CategoryController.m
//  PDFLibrary
//
//  Created by Gonzalo Aizpun on 7/18/11.
//  Copyright 2011 TheAppMaster. All rights reserved.
//

#import "CategoryController.h"
#import "DocumentDAO.h"


@implementation CategoryController

@synthesize scrollView, scrollViewLandscape;
@synthesize category;

- (void)viewWillAppear:(BOOL)animated
{
    UIDeviceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    
    BOOL isPortrait = UIInterfaceOrientationIsPortrait(orientation);
    
    if(!isPortrait) {
        self.view = landscape;
    } else {
        self.view = portrait;
    }
    
     lblTitlePortrait.text = self.category.name;
    lblTitleLandscape.text = self.category.name;  
    [self setMenuControllers];    
    [self setGestureRecognizer:self];    
    
    currentList = [DocumentDAO getDocumentsByCategory:category.id 
                               language:0 keyword:nil myLibrary:NO sort:lastSort];
}

- (IBAction) btnFilterBySortingPressed:(id)sender {
    
    int tag = [sender tag];
    UIButton * btnLastUpdate = (UIButton*)[self.view viewWithTag:8];
    UIButton * btnAlphabetical = (UIButton*)[self.view viewWithTag:9];
    
    if(tag==8) {
        [btnLastUpdate setBackgroundImage:[UIImage imageNamed:@"btn-sort1-on.png"] 
                                 forState:UIControlStateNormal];
        [btnAlphabetical setBackgroundImage:[UIImage imageNamed:@"btn-sort2-off.png"] 
                                   forState:UIControlStateNormal];
    } else {
        [btnLastUpdate setBackgroundImage:[UIImage imageNamed:@"btn-sort1-off.png"] 
                                 forState:UIControlStateNormal];
        [btnAlphabetical setBackgroundImage:[UIImage imageNamed:@"btn-sort2-on.png"] 
                                   forState:UIControlStateNormal];
    }
    
    lastSort  = (tag == 8 ? kSortLastUpdate : kSortAlphabetical);
    currentList = [DocumentDAO getDocumentsByCategory:category.id 
                                             language:0 keyword:nil myLibrary:NO sort:lastSort];
    
}

// ***************************************************

#pragma mark - View lifecycle

- (void) initScrollView {
    
    UIImageView * imageView = [[UIImageView alloc] initWithImage:
                                    [UIImage imageNamed:@"img-portrait-category.png"]];
    
    UIImageView * imageViewLandscape = [[UIImageView alloc] initWithImage:
                                            [UIImage imageNamed:@"img-landscape-category.png"]];

    scrollView.contentSize = CGSizeMake(imageView.frame.size.width, 
                                        imageView.frame.size.height);
    scrollView.maximumZoomScale = 4.0;
    scrollView.minimumZoomScale = 0.75;
    scrollView.clipsToBounds = YES;
    [scrollView addSubview:imageView];

    scrollViewLandscape.contentSize = CGSizeMake(imageViewLandscape.frame.size.width, 
                                                 imageViewLandscape.frame.size.height);
    scrollViewLandscape.maximumZoomScale = 4.0;
    scrollViewLandscape.minimumZoomScale = 0.75;
    scrollViewLandscape.clipsToBounds = YES;
    [scrollViewLandscape addSubview:imageViewLandscape];
}

- (void)viewDidLoad
{
    [super viewDidLoad];    
    [self initScrollView];
    lastSort = kSortLastUpdate;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch 
{
    [self hideMenu];
    return YES;
}


- (void) willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    if(!UIInterfaceOrientationIsPortrait(toInterfaceOrientation)) {
        self.view = landscape;
    } else {
        self.view = portrait;
    }
}




@end
