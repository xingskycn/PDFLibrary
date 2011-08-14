//
//  Field.m
//  PDFLibrary
//
//  Created by Gonzalo Aizpun on 8/14/11.
//  Copyright 2011 TheAppMaster. All rights reserved.
//

#import "Field.h"


@implementation Field
@synthesize id, idForm, name, value;

- (void)dealloc {
    [self.name release];
    [self.value release];    
    [super dealloc];
}

@end
