//
//  SearchOverlayController.m
//  PDFLibrary
//
//  Created by Gonzalo Aizpun on 8/22/11.
//  Copyright 2011 TheAppMaster. All rights reserved.
//

#import "SearchOverlayController.h"


@implementation SearchOverlayController

- (void)viewDidLoad {
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide) name:UIKeyboardWillHideNotification object:nil];
}

- (id)initWithDelegate:(id)del
{
	if ((self = [super init])) {
		delegate = del;
	}
	return self;
}


- (void)resize:(BOOL)isPortrait {
    
    int viewW  = isPortrait ? 768  : 1024;
    int viewH  = isPortrait ? 1024 : 768;
    int center = viewW / 2 - 331 / 2;
    
    self.view.frame     = CGRectMake(0, 0, viewW, viewH);
    imgBackground.frame = CGRectMake(center, 30, 331, 29);
    txtSearch.frame     = CGRectMake(center + 30, 30, 285, 31);
    
    txtSearch.text = @"";
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)keyboardWillHide {
    [delegate doSearch:txtSearch.text];
}

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}


@end
