//
//  Document.m
//  PDFLibrary
//
//  Created by Marcelo German De Luca on 26/08/11.
//  Copyright 2011 TheAppMaster. All rights reserved.
//

#import "Document.h"


@implementation Document
@synthesize id, idType, title, description, keyword, mainScreenFeatured;
@synthesize categoryFeatured, version, date, updateDate, code;

- (void)dealloc {
    [self.title release];
    [self.description release];
    [self.keyword release];
    [self.version release];
    [self.date release];
    [self.updateDate release]; 
    [self.code release];    
    [super dealloc];
}
@end
