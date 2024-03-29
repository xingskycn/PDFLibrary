//
//  IndicatorController.m
//  PDFLibrary
//
//  Created by Marcelo German De Luca on 10/01/11.
//  Copyright 2011 TheAppMaster. All rights reserved.
//

#import "IndicatorController.h"


@implementation IndicatorController
@synthesize actIndicatorView, lblDocument, lblLibrary;

- (void)viewDidLoad {
	[actIndicatorView startAnimating];
    [super viewDidLoad];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (void)viewDidUnload {
    [super viewDidUnload];
}


- (void)dealloc {
    [lblLibrary release];
    [lblDocument release];
    [actIndicatorView release];
    [super dealloc];
}


@end
