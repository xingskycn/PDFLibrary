//
//  Recipient.m
//  PDFLibrary
//
//  Created by Gonzalo Aizpun on 8/14/11.
//  Copyright 2011 TheAppMaster. All rights reserved.
//

#import "Recipient.h"


@implementation Recipient
@synthesize id, idForm, idMailType, value;

- (void)dealloc {
    [self.value release];    
    [super dealloc];
}

@end
