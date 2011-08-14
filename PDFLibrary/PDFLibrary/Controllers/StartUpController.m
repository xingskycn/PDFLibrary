//
//  StartUpController.m
//  Mundial
//
//  Created by Tomas on 28/03/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "StartUpController.h"
#import "PDFLibraryAppDelegate.h"

@implementation StartUpController
@synthesize timer;
@synthesize portrait, imgLand, imgPor;


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	[super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated {
    
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    imgLand.hidden = UIInterfaceOrientationIsPortrait(orientation);
    imgPor.hidden = !UIInterfaceOrientationIsPortrait(orientation);
    
	NSInvocation *updateDisplayInvocation = [NSInvocation invocationWithMethodSignature:[self methodSignatureForSelector: @selector (changeIntroView)]];
	[updateDisplayInvocation setSelector: @selector (changeIntroView)];
	[updateDisplayInvocation setTarget: self];
	timer = [NSTimer scheduledTimerWithTimeInterval:0.0 invocation:updateDisplayInvocation repeats:NO];	
}

- (void)viewWillAppear:(BOOL)animated
{

}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
    imgPor = nil;
    imgLand = nil;
    portrait = nil;
}


- (void)dealloc {
    [imgLand release];
    [imgPor release];
    [portrait release];
    [super dealloc];
}

- (void)changeIntroView {

    NSLog(@"DevIntro faded out");

    [portrait setAlpha:0];
    [UIView beginAnimations:nil context:nil];
    self.view = portrait;
	[UIView setAnimationDuration:4];
	[self.view setAlpha: 1];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(fadedInAppIntro:finished:context:)];
	[UIView commitAnimations];
}

- (void)fadedInAppIntro:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {
	NSLog(@"AppIntro faded in");
	[self doStartUp];
}

- (void)doStartUp {
	PDFLibraryAppDelegate *appDelegate = (PDFLibraryAppDelegate *)[[UIApplication sharedApplication] delegate];
	[appDelegate showRootController];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return YES;
}

- (void) willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{    
    imgLand.hidden = UIInterfaceOrientationIsPortrait(toInterfaceOrientation);
    imgPor.hidden = !UIInterfaceOrientationIsPortrait(toInterfaceOrientation);
}

#pragma mark -
#pragma mark UIAlertView delegate methods
- (void)didPresentAlertView:(UIAlertView *)alertView {
	[self doStartUp];
}


@end
