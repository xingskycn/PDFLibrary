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

//- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)
interfaceOrientation duration:(NSTimeInterval)duration {
    if (interfaceOrientation == UIInterfaceOrientationPortrait ||
        interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) {

        // Load Portrait
        //HomeController * controller = [[HomeController alloc] initWithNibName:@"HomeController-portrait" bundle:nil];
        //[self.navigationController pushViewController:controller animated:NO];
        //[[NSBundle mainBundle] loadNibNamed:@"HomeController-portrait" owner:self options:nil];			
        
        UINib *nib = [UINib nibWithNibName:@"HomeController-portrait" bundle:nil];
        UIView *portraitView = [[nib instantiateWithOwner:self options:nil] objectAtIndex:0];
        self.view = portraitView;
        
        
    } else {
        
        //[self.navigationController popViewControllerAnimated:NO];
        //[[NSBundle mainBundle] loadNibNamed:@"HomeController-landscape" owner:self options:nil];			
        
        UINib *nib = [UINib nibWithNibName:@"HomeController-landscape2" bundle:nil];
        UIView *landscapeView = [[nib instantiateWithOwner:self options:nil] objectAtIndex:0];
        self.view = landscapeView;
        
    }
}

@end
