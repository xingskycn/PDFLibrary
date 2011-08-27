//
//  FiltersController.m
//  PDFLibrary
//
//  Created by Gonzalo Aizpun on 7/18/11.
//  Copyright 2011 TheAppMaster. All rights reserved.
//

#import "FiltersController.h"
#import "EbookController.h"

@implementation FiltersController
@synthesize language;

- (void)viewWillAppear:(BOOL)animated
{
    UIDeviceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    BOOL isPortrait = UIInterfaceOrientationIsPortrait(orientation);
    
    if(!isPortrait) {
        self.view = landscape;
    } else {
        self.view = portrait;
    }
    
    lblTitlePortrait.text    = self.language.name;
    lblTitleLandscape.text   = self.language.name;    
    lblMatchesPortrait.text  = self.language.name;
    lblMatchesLandscape.text = self.language.name;   
    
    [self setMenuControllers];    
    [self setGestureRecognizer:self];    
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
}

- (IBAction) btnFeaturedPressed {
    
    EbookController * controller = [[EbookController alloc] init];    
    [self.navigationController pushViewController:controller animated:YES];
    [controller release];
    
}
// ***************************************************


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
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
