//
//  MailType.h
//  PDFLibrary
//
//  Created by Gonzalo Aizpun on 8/14/11.
//  Copyright 2011 TheAppMaster. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MailType : NSObject {
    
    NSInteger id;
    NSString * name;
    
}

@property (nonatomic) NSInteger id;
@property (nonatomic,retain) NSString * name;

@end
