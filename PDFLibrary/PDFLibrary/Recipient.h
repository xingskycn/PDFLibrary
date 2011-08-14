//
//  Recipient.h
//  PDFLibrary
//
//  Created by Gonzalo Aizpun on 8/14/11.
//  Copyright 2011 TheAppMaster. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Recipient : NSObject {
    
    NSInteger id;
    NSInteger idMailType;
    NSInteger idForm;
    NSString * value;
    
}

@property (nonatomic) NSInteger id;
@property (nonatomic) NSInteger idMailType;
@property (nonatomic) NSInteger idForm;
@property (nonatomic,retain) NSString * value;

@end
