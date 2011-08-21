//
//  Language.h
//  PDFLibrary
//
//  Created by Gonzalo Aizpun on 8/21/11.
//  Copyright 2011 TheAppMaster. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Language : NSObject {
    NSInteger id;
    NSString * name;
    NSString * code;
}

@property (nonatomic) NSInteger id;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * code;

@end
