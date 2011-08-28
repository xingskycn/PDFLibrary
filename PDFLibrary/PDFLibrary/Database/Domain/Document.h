//
//  Document.h
//  PDFLibrary
//
//  Created by Marcelo German De Luca on 26/08/11.
//  Copyright 2011 TheAppMaster. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Document : NSObject {
    
    NSInteger id;
    NSInteger idType;
    NSString * title;
    NSString * description;
    NSString * keyword;
    BOOL mainScreenFeatured;
    BOOL categoryFeatured;
    NSString * version;
    NSString * date;
    NSString * updateDate;
    NSString * code;
    NSArray  * languages;
    NSArray  * categories;    
}

@property (nonatomic) NSInteger id;
@property (nonatomic) NSInteger idType;
@property (nonatomic,retain) NSString * title;
@property (nonatomic,retain) NSString * description;
@property (nonatomic,retain) NSString * keyword;
@property (nonatomic) BOOL mainScreenFeatured;
@property (nonatomic) BOOL categoryFeatured;
@property (nonatomic,retain) NSString * version;
@property (nonatomic,retain) NSString * date;
@property (nonatomic,retain) NSString * updateDate;
@property (nonatomic,retain) NSString * code;
@property (nonatomic,retain) NSArray  * languages;
@property (nonatomic,retain) NSArray  * categories;

@end
