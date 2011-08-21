//
//  Language.m
//  PDFLibrary
//
//  Created by Gonzalo Aizpun on 8/21/11.
//  Copyright 2011 TheAppMaster. All rights reserved.
//

#import "Language.h"


@implementation Language
@synthesize id, name, code;

- (void)dealloc {    
    [self.name release];
    [self.code release];
    [super dealloc];
}

@end
