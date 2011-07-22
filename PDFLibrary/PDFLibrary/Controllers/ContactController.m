//
//  ContactController.m
//  PDFLibrary
//
//  Created by Gonzalo Aizpun on 7/18/11.
//  Copyright 2011 TheAppMaster. All rights reserved.
//

#import "ContactController.h"


@implementation ContactController
bool copyPressed = NO;

- (IBAction) btnSendPressed {
        [[[[UIAlertView alloc] initWithTitle:@"TODO" message:@"Send Tapped. Request WebService" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil] autorelease] show]; 
}

- (IBAction) btnSendCopyPressed {
    copyPressed = !copyPressed;
    if(copyPressed) {
        [btnSendCopy setBackgroundImage:[UIImage imageNamed:@"btn-checkbox-on.png"] forState:UIControlStateNormal];
    } else {
        [btnSendCopy setBackgroundImage:[UIImage imageNamed:@"btn-checkbox-off.png"] forState:UIControlStateNormal];
        
    }
    
}

// *******************************

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
    imgPopoverCategories.hidden = NO; 
}

- (IBAction) btnLanguagesPressed {
    imgPopoverLanguages.hidden = NO; 
}

- (IBAction) btnMyLibraryPressed {
    [[[[UIAlertView alloc] initWithTitle:@"TODO" message:@"My Library Tapped. Load MyLibraryController" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil] autorelease] show];   
}

- (IBAction) btnContactPressed {
    // We're on ContactController
}

- (IBAction) btnSearchPressed {
    [[[[UIAlertView alloc] initWithTitle:@"TODO" message:@"Search Tapped. Load SearchController" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil] autorelease] show];    
}

- (IBAction) btnCategoryPressed:(id)sender {
   // int index = [(UIButton *)sender tag];
    [[[[UIAlertView alloc] initWithTitle:@"TODO" message:@"Category Tapped. Load CategoryController" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil] autorelease] show];
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
    
    imgPopoverLanguages.hidden = YES;
    imgPopoverCategories.hidden = YES;
    
    UIGestureRecognizer *recognizer;
    recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self   action:@selector(doubleTapMethod)];
    [(UITapGestureRecognizer *)recognizer setNumberOfTapsRequired:2];
    [self.view addGestureRecognizer:recognizer];
    recognizer.delegate = self;
    [recognizer release];
}

- (void)doubleTapMethod
{
    imgPopoverCategories.hidden = YES;
    imgPopoverLanguages.hidden = YES;       
}


- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch 
{
    imgPopoverCategories.hidden = YES;
    imgPopoverLanguages.hidden = YES;
    
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
    ContactController * controller;

    if(UIInterfaceOrientationIsPortrait(toInterfaceOrientation)) 
    {
        controller = [[ContactController alloc] initWithNibName:@"ContactController-portrait" bundle:nil];
        CGAffineTransform transform = controller.view.transform;
        
        if(toInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown)
            transform = CGAffineTransformRotate(transform, (-M_PI));
        
        if(toInterfaceOrientation == UIInterfaceOrientationPortrait)
            transform = CGAffineTransformRotate(transform, (2*M_PI));

        controller.view.transform = transform;
    } 
    else if(UIInterfaceOrientationIsLandscape(toInterfaceOrientation))
    {		
        controller = [[ContactController alloc] initWithNibName:@"ContactController-landscape" bundle:nil];
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
