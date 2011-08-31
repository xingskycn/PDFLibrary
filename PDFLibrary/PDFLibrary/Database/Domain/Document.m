//
//  Document.m
//  PDFLibrary
//
//  Created by Marcelo German De Luca on 26/08/11.
//  Copyright 2011 TheAppMaster. All rights reserved.
//

#import "Document.h"


@implementation Document
@synthesize id, idType, title, upperTitle, description, keyword, mainScreenFeatured;
@synthesize categoryFeatured, version, date, updateDate, code;
@synthesize languages, categories, isEbook, isCaseStudy, inLibrary;

- (void)dealloc {
    [self.upperTitle release];
    [self.title release];
    [self.description release];
    [self.keyword release];
    [self.version release];
    [self.date release];
    [self.updateDate release]; 
    [self.code release];    
    [self.languages release]; 
    [self.categories release];    
    [super dealloc];
}
@end
