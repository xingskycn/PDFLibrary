//
//  Field.h
//  PDFLibrary
//
//  Created by Gonzalo Aizpun on 8/14/11.
//  Copyright 2011 TheAppMaster. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Field : NSObject {
    
    NSInteger  id;
    NSInteger  idForm;
    NSString * name;
    NSString * value;
    
}

@property (nonatomic) NSInteger id;
@property (nonatomic) NSInteger idForm;
@property (nonatomic,retain) NSString * name;
@property (nonatomic,retain) NSString * value;

@end
