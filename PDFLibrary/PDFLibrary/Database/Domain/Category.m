//
//  Category.m
//  PDFLibrary
//
//  Created by Marcelo German De Luca on 18/08/11.
//  Copyright 2011 TheAppMaster. All rights reserved.
//

#import "Category.h"


@implementation Category
@synthesize id, idSorted, name, description, code;

- (void)dealloc {
    [self.name release];
    [self.description release];  
    [self.code release];     
    [super dealloc];
}

@end
