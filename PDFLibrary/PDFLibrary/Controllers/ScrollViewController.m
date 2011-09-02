//
//  ScrollViewLandscapeController.m
//  PDFLibrary
//
//  Created by Marcelo German De Luca on 27/08/11.
//  Copyright 2011 TheAppMaster. All rights reserved.
//

#import "ScrollViewController.h"
#import "ScrollViewBookController.h"
#import "ScrollViewVideoController.h"
#import "DocumentController.h"
#import "Document.h"

#define DOCSxPAGE 6

@implementation ScrollViewController
@synthesize nav, delegate;

- (id)initWithDocuments:(NSArray*)docs:(int)page:(BOOL)hideLibrary;
{
    hideMyLibrary = hideLibrary;
	documents = docs;
    pageIndex = page;
    return self;
}

- (void)dealloc
{
    [documents release];
    [nav release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    for(int i = pageIndex * DOCSxPAGE, j = 0; i < [documents count] && j < 6; j++, i++)
    {
        Document* doc = (Document*) [documents objectAtIndex:i];
        UIViewController* item;
        
        if(doc.idType == 1)
        {
            item = [[ScrollViewBookController alloc] initWithDocument:doc:hideMyLibrary];
            ((ScrollViewBookController*)item).delegate = self;
        }
        else
        {
            item = [[ScrollViewVideoController alloc] initWithDocument:doc:hideMyLibrary];
            ((ScrollViewVideoController*)item).delegate = self;
        }
            
        CGRect r = item.view.frame;
        r.origin.y = (j%3) * 185;
        r.origin.x = (j<3)?0:475;
        item.view.frame = r;
        [self.view addSubview:item.view];
        //[item release];
    }
}

- (void)goToDocument:(Document *)document {
    
    DocumentController * controller;
    if(document.isEbook) {
        controller = [[DocumentController alloc] init];    
    } else {
        controller = [[DocumentController alloc] initWithNibName:@"VideoController" bundle:nil];    
    }
    [self.nav pushViewController:controller animated:YES];
    [controller updateViewFromDocument:document];
    [controller release];
    
}

- (void)removeFromLibrary:(Document *)document {
    [self.delegate removeFromLibrary:document];
}
@end
