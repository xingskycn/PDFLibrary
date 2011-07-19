//
//  HomeController.m
//  PDFLibrary
//
//  Created by Gonzalo Aizpun on 7/18/11.
//  Copyright 2011 TheAppMaster. All rights reserved.
//

#import "HomeController.h"


@implementation HomeController

- (IBAction) btnHomePressed {
    [[[[UIAlertView alloc] initWithTitle:@"TODO" message:@"Home Tapped. Load HomeController" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil] autorelease] show];
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
    [[[[UIAlertView alloc] initWithTitle:@"TODO" message:@"Contact Tapped. Load ContactController" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil] autorelease] show];    
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
    HomeController * controller;
    
    if(UIInterfaceOrientationIsPortrait(toInterfaceOrientation)) 
    {
        controller = [[HomeController alloc] initWithNibName:@"HomeController-portrait" bundle:nil];
        CGAffineTransform transform = controller.view.transform;
        
        if(toInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown)
            transform = CGAffineTransformRotate(transform, (-M_PI));
        
        if(toInterfaceOrientation == UIInterfaceOrientationPortrait)
            transform = CGAffineTransformRotate(transform, (2*M_PI));

        controller.view.transform = transform;
    } 
    else if(UIInterfaceOrientationIsLandscape(toInterfaceOrientation))
    {		
        controller = [[HomeController alloc] initWithNibName:@"HomeController-landscape" bundle:nil];
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


// ******************************************

- (void) touchesEnded: (NSSet *) touches withEvent: (UIEvent *) event 
{
    // Process the single tap here
    //NSLog(@"Scroll view single tapped. touches count : %d", touches.count);
    //UITouch *touch = [touches anyObject]; 
    //UIImageView *imgView = (UIImageView*)touch.view;
    //NSLog(@"tag is %@", imgView.tag);
    
    imgPopoverCategories.hidden = YES;
    imgPopoverLanguages.hidden = YES;
}

@end
