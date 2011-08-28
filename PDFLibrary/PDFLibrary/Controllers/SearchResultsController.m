//
//  SearchResultsController.m
//  PDFLibrary
//
//  Created by Gonzalo Aizpun on 7/18/11.
//  Copyright 2011 TheAppMaster. All rights reserved.
//

#import "SearchResultsController.h"
#import "EbookController.h"
#import "DocumentDAO.h"

@implementation SearchResultsController
@synthesize scrollView, scrollViewLandscape, phrase;

- (void) updateLabels {
    
    lblTitlePortrait.text = @"Search Results";
    lblTitleLandscape.text = @"Search Results";

    NSLog(@"updateLabels con %@", phrase);
    
    lblMatchesPortrait.text = [NSString stringWithFormat:@"\"%@\"", phrase];
    lblMatchesLandscape.text = [NSString stringWithFormat:@"\"%@\"", phrase];   
    
}

- (void)viewWillAppear:(BOOL)animated
{
    UIDeviceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    BOOL isPortrait = UIInterfaceOrientationIsPortrait(orientation);
    
    if(!isPortrait) {
        self.view = landscape;
    } else {
        self.view = portrait;
    }
    
    [self setMenuControllers];    
    [self setGestureRecognizer:self];   
    [self updateLabels];

    currentList = [DocumentDAO getDocumentsByCategory:category.id
                                             language:0 keyword:phrase myLibrary:NO sort:lastSort];
    
    NSString * strResult = [NSString stringWithFormat:@"SHOWING %u MATCHES FOR:", [currentList count]];
    lblResultsPortrait.text  = strResult;
    lblResultsLandscape.text = strResult;    
}

- (IBAction) btnFilterByCategoryPressed:(id)sender {
    
    int tag = [sender tag];
    
    for (int i=1; i<=7; i++){
        UIButton * button = (UIButton*)[self.view viewWithTag:i];
        NSString * imgName = [NSString stringWithFormat:@"btn-category%u-off.png", (i-1)];
        if(i==tag) {
            imgName = [NSString stringWithFormat:@"btn-category%u-on.png", (i-1)];
        }
        [button setBackgroundImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];    
    }
    
    int categoryId = tag - 1;
    category = [CategoryDAO getCategoryById:categoryId];
    
    currentList = [DocumentDAO getDocumentsByCategory:category.id
                                             language:0 keyword:phrase myLibrary:NO sort:lastSort];
    
    NSString * strResult = [NSString stringWithFormat:@"SHOWING %u MATCHES FOR:", [currentList count]];
    lblResultsPortrait.text  = strResult;
    lblResultsLandscape.text = strResult;    
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
                                             language:0 keyword:phrase myLibrary:NO sort:lastSort];
    
    NSString * strResult = [NSString stringWithFormat:@"SHOWING %u MATCHES FOR:", [currentList count]];
    lblResultsPortrait.text  = strResult;
    lblResultsLandscape.text = strResult;    
}

- (IBAction) btnFeaturedPressed {
    
    EbookController * controller = [[EbookController alloc] init];    
    [self.navigationController pushViewController:controller animated:YES];
    [controller release];
    
}

// ***************************************************

#pragma mark - View lifecycle

- (void) initScrollView {
    
    UIImageView * imageView = [[UIImageView alloc] initWithImage:
                               [UIImage imageNamed:@"img-library-portrait.png"]];
    
    UIImageView * imageViewLandscape = [[UIImageView alloc] initWithImage:
                                        [UIImage imageNamed:@"img-library-landscape.png"]];
    
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

- (void)viewDidUnload
{
    [super viewDidUnload];
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
