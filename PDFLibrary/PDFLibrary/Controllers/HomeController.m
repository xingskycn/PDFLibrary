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
    NSLog(@"HomePressed");
}

- (IBAction) btnCategoriesPressed {
    NSLog(@"CategoriesPressed");    
}

- (IBAction) btnLanguagesPressed {
    NSLog(@"LanguagesPressed");    
}

- (IBAction) btnMyLibraryPressed {
    NSLog(@"MyLibraryPressed");    
}

- (IBAction) btnContactPressed {
    NSLog(@"ContactPressed");    
}

- (IBAction) btnSearchPressed {
    NSLog(@"SearchPressed");    
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
    if(UIInterfaceOrientationIsPortrait(toInterfaceOrientation)) 
    {
        HomeController* port = [[HomeController alloc] initWithNibName:@"HomeController-portrait" bundle:[NSBundle mainBundle]];
        CGAffineTransform transform = port.view.transform;
        
        if(toInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown)
            transform = CGAffineTransformRotate(transform, (-M_PI));
        
        if(toInterfaceOrientation == UIInterfaceOrientationPortrait)
            transform = CGAffineTransformRotate(transform, (2*M_PI));
        
        port.view.transform = transform;
        
        self.view = port.view;
        [port release];
        
        
    } 
    else if(UIInterfaceOrientationIsLandscape(toInterfaceOrientation))
    {		
        HomeController* land = [[HomeController alloc] initWithNibName:@"HomeController-landscape" bundle:[NSBundle mainBundle]];
        CGAffineTransform transform = land.view.transform;
        
        if(toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft)
            transform = CGAffineTransformRotate(transform, (-M_PI/2));
        
        if(toInterfaceOrientation == UIInterfaceOrientationLandscapeRight)
            transform = CGAffineTransformRotate(transform, (+M_PI/2));
        
        land.view.transform = transform;
        
        self.view = land.view;
        [land release];
        
    }
}

@end
