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

@synthesize devIntroView;
@synthesize appIntroView;
@synthesize timer;


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	[super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated {
	NSInvocation *updateDisplayInvocation = [NSInvocation invocationWithMethodSignature:[self methodSignatureForSelector: @selector (changeIntroView)]];
	[updateDisplayInvocation setSelector: @selector (changeIntroView)];
	[updateDisplayInvocation setTarget: self];
	timer = [NSTimer scheduledTimerWithTimeInterval:0.0 invocation:updateDisplayInvocation repeats:NO];	
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	devIntroView = nil;
	appIntroView = nil;
}


- (void)dealloc {
	[devIntroView release];
	[appIntroView release];
    [super dealloc];
}

- (void)changeIntroView {
	NSLog(@"Timer called changeView");
	
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0];
	[self.view setAlpha: 0];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(fadedOutDevIntro:finished:context:)];
	[UIView commitAnimations];
}

- (void)fadedOutDevIntro:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {
	NSLog(@"DevIntro faded out");
	[appIntroView setAlpha:0];
	[UIView beginAnimations:nil context:nil];
	self.view = appIntroView;
	[UIView setAnimationDuration:3];
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

#pragma mark -
#pragma mark UIAlertView delegate methods
- (void)didPresentAlertView:(UIAlertView *)alertView {
	[self doStartUp];
}


@end
