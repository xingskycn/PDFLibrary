//
//  MailType.m
//  PDFLibrary
//
//  Created by Gonzalo Aizpun on 8/14/11.
//  Copyright 2011 TheAppMaster. All rights reserved.
//

#import "MailType.h"


@implementation MailType
@synthesize id, name;

- (void)dealloc {
    [self.name release];
    [super dealloc];
}

@end
