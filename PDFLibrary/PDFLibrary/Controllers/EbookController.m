//
//  EbookController.m
//  PDFLibrary
//
//  Created by Gonzalo Aizpun on 7/18/11.
//  Copyright 2011 TheAppMaster. All rights reserved.
//

#import "EbookController.h"


@implementation EbookController


- (IBAction) btnRequestCopyPressed {
    RequestCopyController * controller;
    
    if(UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)){
        controller = [[RequestCopyController alloc] initWithNibName:@"RequestCopyController-landscape" bundle:nil];
    } else {
        controller = [[RequestCopyController alloc] initWithNibName:@"RequestCopyController-portrait" bundle:nil];
    }   
    
    [self presentModalViewController:controller animated:YES];
    [self dismissModalViewControllerAnimated:NO];
}


// ******************************************

- (IBAction) btnHomePressed {
    HomeController * controller;
    
    if(UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)){
        controller = [[HomeController alloc] initWithNibName:@"HomeController-landscape" bundle:nil];
    } else {
        controller = [[HomeController alloc] initWithNibName:@"HomeController-portrait" bundle:nil];
    }   
    
    [self presentModalViewController:controller animated:YES];
    [self dismissModalViewControllerAnimated:NO];
}

- (IBAction) btnCategoriesPressed {
    btnPopoverCategories.hidden = NO; 
}

- (IBAction) btnLanguagesPressed {
    btnPopoverLanguages.hidden = NO; 
}

- (IBAction) btnMyLibraryPressed {
    LibraryController * controller;
    
    if(UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)){
        controller = [[LibraryController alloc] initWithNibName:@"LibraryController-landscape" bundle:nil];
    } else {
        controller = [[LibraryController alloc] initWithNibName:@"LibraryController-portrait" bundle:nil];
    }   
    
    [self presentModalViewController:controller animated:YES];
    [self dismissModalViewControllerAnimated:NO];   
}

- (IBAction) btnContactPressed {
    ContactController * controller;
    
    if(UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)){
        controller = [[ContactController alloc] initWithNibName:@"ContactController-landscape" bundle:nil];
    } else {
        controller = [[ContactController alloc] initWithNibName:@"ContactController-portrait" bundle:nil];
    }   
    
    [self presentModalViewController:controller animated:YES];
    [self dismissModalViewControllerAnimated:NO];
}

- (IBAction) btnSearchPressed {
    [[[[UIAlertView alloc] initWithTitle:@"TODO" message:@"Search Tapped. Load SearchController" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil] autorelease] show];    
}

- (IBAction) btnCategoryPressed:(id)sender {
   // int index = [(UIButton *)sender tag];
    [[[[UIAlertView alloc] initWithTitle:@"TODO" message:@"Category Tapped. Load CategoryController" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil] autorelease] show];
}

- (IBAction) btnPopoverLanguagesPressed {
    
    FiltersController * controller;
    
    if(UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)){
        controller = [[FiltersController alloc] initWithNibName:@"FiltersController-landscape" bundle:nil];
    } else {
        controller = [[FiltersController alloc] initWithNibName:@"FiltersController-portrait" bundle:nil];
    }   
    
    [self presentModalViewController:controller animated:YES];
    [self dismissModalViewControllerAnimated:NO];    
}

- (IBAction) btnPopoverCategoriesPressed {
    
}

// ********************************

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    btnPopoverLanguages.hidden = YES;
    btnPopoverCategories.hidden = YES;
    
    UIGestureRecognizer *recognizer;
    recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self   action:@selector(doubleTapMethod)];
    [(UITapGestureRecognizer *)recognizer setNumberOfTapsRequired:2];
    [self.view addGestureRecognizer:recognizer];
    recognizer.delegate = self;
    [recognizer release];
}

- (void)doubleTapMethod
{
    btnPopoverCategories.hidden = YES;
    btnPopoverLanguages.hidden = YES;       
}


- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch 
{
    btnPopoverCategories.hidden = YES;
    btnPopoverLanguages.hidden = YES;
    
    return YES;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

- (void) willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    EbookController * controller;
    
    if(UIInterfaceOrientationIsPortrait(toInterfaceOrientation)) 
    {
        controller = [[EbookController alloc] initWithNibName:@"EbookController-portrait" bundle:nil];
        CGAffineTransform transform = controller.view.transform;
        
        if(toInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown)
            transform = CGAffineTransformRotate(transform, (-M_PI));
        
        if(toInterfaceOrientation == UIInterfaceOrientationPortrait)
            transform = CGAffineTransformRotate(transform, (2*M_PI));

        controller.view.transform = transform;
    } 
    else if(UIInterfaceOrientationIsLandscape(toInterfaceOrientation))
    {		
        controller = [[EbookController alloc] initWithNibName:@"EbookController-landscape" bundle:nil];
        CGAffineTransform transform = controller.view.transform;
        
        if(toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft)
            transform = CGAffineTransformRotate(transform, (-M_PI/2));
        
        if(toInterfaceOrientation == UIInterfaceOrientationLandscapeRight)
            transform = CGAffineTransformRotate(transform, (+M_PI/2));
     
        controller.view.transform = transform;
    }
    
    self.view = controller.view;
    //[controller release];   NUNCAAAAA!!! FUCK! 
}




@end
