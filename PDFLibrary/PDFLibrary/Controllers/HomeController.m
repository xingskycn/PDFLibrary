//
//  HomeController.m
//  PDFLibrary
//
//  Created by Gonzalo Aizpun on 7/18/11.
//  Copyright 2011 TheAppMaster. All rights reserved.
//

#import "HomeController.h"
#import "CategoryController.h"
#import "DocumentController.h"

#import "VersionDAO.h"
#import "CategoryDAO.h"
#import "DocumentDAO.h"

#import "Document.h"
#import "FileSystem.h"


@implementation HomeController
BOOL alreadyCallUpdateService = NO;


- (IBAction) btnCategoryPressed:(id)sender {

    int intTag     = ([sender tag] - 1000);
    NSString * tag = [NSString stringWithFormat:@"%u", intTag]; // 1x, .., 6x, ex: 23    
    int categoryId = [[tag substringToIndex:1] intValue];       // 1, 6, ex: 2

    Category * cat = [CategoryDAO getCategoryById:categoryId];
    CategoryController * controller = [[CategoryController alloc] init];
    controller.category = cat;
    [self.navigationController pushViewController:controller animated:YES];
    [controller release];
}


// ********************************


- (void)loadFeaturedView {
    
    NSString * nibPortrait  = @"";
    NSString * nibLandscape = @"";
    
    if (document.isEbook) {
            
        nibPortrait  = @"HomeEbookPortrait";
        nibLandscape = @"HomeEbookLandscape";
            
    } else {

        nibPortrait  = @"HomeVideoPortrait";
        nibLandscape = @"HomeVideoLandscape";        
        
    }
    
    
    ScrollViewDocumentCommonController * controllerP = 
        [[ScrollViewDocumentCommonController alloc] initWithNibName:nibPortrait bundle:nil];

    
    ScrollViewDocumentCommonController * controllerL = 
    [[ScrollViewDocumentCommonController alloc] initWithNibName:nibLandscape bundle:nil];
    
    
    controllerL.document = document;
    controllerL.delegate = self;
    controllerP.document = document;
    controllerP.delegate = self;
    
    [viewForFeaturedPortrait addSubview:controllerP.view];
    [viewForFeaturedLandscape addSubview:controllerL.view];
    
}


- (void)viewWillAppear:(BOOL)animated
{
    [self loadCategories];
    
    UIDeviceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
        
    BOOL isPortrait = UIInterfaceOrientationIsPortrait(orientation);
    
    if(isPortrait) {
        self.view = portrait;
        self.indicatorController = [[IndicatorController alloc] 
                                    initWithNibName:@"IndicatorControllerPortrait" bundle:nil];
    } else {
        self.view = landscape;
        self.indicatorController = [[IndicatorController alloc] 
                                    initWithNibName:@"IndicatorControllerLandscape" bundle:nil];
    }
    
    // Just one call, when app is loaded and not when navigationController is back to this view
    if(!alreadyCallUpdateService) {
        ServiceManager * serviceManager = [[ServiceManager alloc] init];
        [self.view addSubview:self.indicatorController.view];
        self.indicatorController.lblLibrary.hidden = NO;
        [serviceManager callUpdateData:self];
        alreadyCallUpdateService = YES;
    }
    
    [self setMenuControllers];    
    [self setGestureRecognizer:self];   
    
    document = [DocumentDAO getDocumentForHomepage];
    document.description = [NSString stringWithFormat:@"%@...",
                            [document.description substringToIndex:230]];
    [self loadFeaturedView];

}


- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch 
{
    [self hideMenu];    
    return YES;
}


-(void) loadCategories {
    
    for(int i=1; i<=6; i++) {
        
        Category * cat = [CategoryDAO getCategoryById:i];        
        int baseTag = (i * 10) + 1000; // 1010, 1020, 1030, 1040, 1050, 1060
        
        // Title (landscape & portrait)
        [(UIButton *)[self.view viewWithTag:baseTag + 1] setTitle:cat.name forState:UIControlStateNormal];
        [(UIButton *)[self.view viewWithTag:baseTag + 4] setTitle:cat.name forState:UIControlStateNormal];
        
        // Description (landscape & portrait)
        [(UIButton *)[self.view viewWithTag:baseTag + 2] setTitle:cat.description forState:UIControlStateNormal];
        [(UIButton *)[self.view viewWithTag:baseTag + 5] setTitle:cat.description forState:UIControlStateNormal];
        
        // Image (lanfscape & portrait)
        UIImage * imgCategory = [FileSystem getImageFromFileSystem:
                                 [NSString stringWithFormat:@"%@.png", cat.code]];
        
        [(UIButton *)[self.view viewWithTag:baseTag + 0] 
                      setImage:imgCategory forState:UIControlStateNormal];
        
        [(UIButton *)[self.view viewWithTag:baseTag + 3] 
         setImage:imgCategory forState:UIControlStateNormal];        
    }

}



- (void) willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{    
        
    if(!UIInterfaceOrientationIsPortrait(toInterfaceOrientation)) {
        self.view = landscape;
        self.indicatorController = [[IndicatorController alloc] 
                                    initWithNibName:@"IndicatorControllerLandscape" bundle:nil];
    } else {
        self.view = portrait;
        self.indicatorController = [[IndicatorController alloc] 
                                    initWithNibName:@"IndicatorControllerPortrait" bundle:nil];
    }
}


// ******************************************

- (void)serviceSuccess:(NSDictionary * )data 
{
    [VersionDAO saveNewUpdates:data];
    [ServiceImage downloadNewImages];
    document = [DocumentDAO getDocumentForHomepage];
    [self loadCategories];
    [self setMenuControllers];
    
    [self.indicatorController.view removeFromSuperview];
}

- (void)serviceFailed:(NSString * )errorMsg 
{
    [self.indicatorController.view removeFromSuperview];
}


- (void)goToDocument:(Document *)_document {
    
    DocumentController * controller;
    if(document.isEbook) {
        controller = [[DocumentController alloc] initWithNibName:@"EbookController" bundle:nil];      
    } else {
        controller = [[DocumentController alloc] initWithNibName:@"VideoController" bundle:nil];    
    } 

    [self.navigationController pushViewController:controller animated:YES];
    [controller updateViewFromDocument:document];        
    [controller release];
    
}

- (void)removeFromLibrary:(Document *)document {
    // not used here
}

@end
