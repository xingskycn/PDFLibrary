//
//  Form.m
//  PDFLibrary
//
//  Created by Gonzalo Aizpun on 8/14/11.
//  Copyright 2011 TheAppMaster. All rights reserved.
//

#import "Form.h"


@implementation Form
@synthesize id, value;

- (void)dealloc {
    [self.value release];    
    [super dealloc];
}

@end
