//
//  UpdatedImages.m
//  PDFLibrary
//
//  Created by Marcelo German De Luca on 18/08/11.
//  Copyright 2011 TheAppMaster. All rights reserved.
//

#import "UpdatedImage.h"


@implementation UpdatedImage
@synthesize url, code;

- (void)dealloc {
    [self.code release]; 
    [self.url release];  
    [super dealloc];
}
@end
