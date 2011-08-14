//
//  Form.h
//  PDFLibrary
//
//  Created by Gonzalo Aizpun on 8/14/11.
//  Copyright 2011 TheAppMaster. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Form : NSObject {
    
    NSInteger id;
    NSString * value;
    
}

@property (nonatomic) NSInteger id;
@property (nonatomic,retain) NSString * value;

@end
