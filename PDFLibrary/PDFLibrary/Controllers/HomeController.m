//
//  HomeController.m
//  PDFLibrary
//
//  Created by Gonzalo Aizpun on 7/18/11.
//  Copyright 2011 TheAppMaster. All rights reserved.
//

#import "HomeController.h"

@implementation HomeController
@synthesize portrait, landscape, indicatorController;
BOOL alreadyCallUpdateService = NO;

- (IBAction) btnHomePressed {
    // We're on HomeController
}

- (IBAction) btnCategoriesPressed {
    btnPopoverCategories.hidden = NO; 
    btnPopoverCategoriesPortrait.hidden = NO; 
}

- (IBAction) btnLanguagesPressed {
    btnPopoverLanguages.hidden = NO; 
    btnPopoverLanguagesPortrait.hidden = NO;
}

- (IBAction) btnMyLibraryPressed {

    LibraryController * controller = [[LibraryController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
    [controller release];
    
}

- (IBAction) btnContactPressed {
    
    ContactController * controller = [[ContactController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
    [controller release];
    
}

- (IBAction) btnSearchPressed {
    [[[[UIAlertView alloc] initWithTitle:@"TODO" message:@"Search Tapped. Load SearchController" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil] autorelease] show];    
}

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


- (IBAction) btnFeaturedPressed {
    
    EbookController * controller = [[EbookController alloc] init];    
    [self.navigationController pushViewController:controller animated:YES];
    [controller release];
    
}

- (IBAction) btnPopoverLanguagesPressed {
        
    FiltersController * controller = [[FiltersController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
    [controller release];
    
}

- (IBAction) btnPopoverCategoriesPressed {
    
    CategoryController * controller = [[CategoryController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
    [controller release]; 

}

// ********************************

- (void)dealloc
{
    [portrait release];
    [landscape release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    btnPopoverLanguages.hidden = YES;
    btnPopoverCategories.hidden = YES;
    btnPopoverLanguagesPortrait.hidden = YES;
    btnPopoverCategoriesPortrait.hidden = YES;
    
    UIGestureRecognizer *recognizer;
    recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTapMethod)];
    [(UITapGestureRecognizer *)recognizer setNumberOfTapsRequired:2];
    [self.view addGestureRecognizer:recognizer];
    recognizer.delegate = self;
    [recognizer release];
    
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
        [serviceManager callUpdateData:self];
        alreadyCallUpdateService = YES;
    }

}

- (void)doubleTapMethod
{
    btnPopoverCategories.hidden = YES;
    btnPopoverLanguages.hidden = YES;  
    btnPopoverCategoriesPortrait.hidden = YES;
    btnPopoverLanguagesPortrait.hidden = YES;  
}


- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch 
{
    btnPopoverCategories.hidden = YES;
    btnPopoverLanguages.hidden = YES;
    btnPopoverCategoriesPortrait.hidden = YES;
    btnPopoverLanguagesPortrait.hidden = YES; 
    
    return YES;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
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


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES if indicatorController is not loaded. Otherwise, return NO (modal action)
	return !(self.indicatorController.view.superview == self.view);
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
    [self loadCategories];
    
    [self.indicatorController.view removeFromSuperview];
}

- (void)serviceFailed:(NSString * )errorMsg 
{
    [self.indicatorController.view removeFromSuperview];
}

@end
