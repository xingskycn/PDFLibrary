//
//  ScrollViewLandscapeController.m
//  PDFLibrary
//
//  Created by Marcelo German De Luca on 27/08/11.
//  Copyright 2011 TheAppMaster. All rights reserved.
//

#import "ScrollViewLandscapeController.h"
#import "Document.h"

@implementation ScrollViewLandscapeController

- (void)initWithDocuments:(NSArray*)docs
{
	documents = docs;
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


- (void)viewDidUnload
{
    [super viewDidUnload];
    
    for(Document* doc in documents)
    {
        UIImageView* image = (UIImageView*)[self.view viewWithTag:1];
    }
        
}

@end
