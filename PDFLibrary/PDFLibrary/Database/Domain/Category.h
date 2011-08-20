//
//  Category.h
//  PDFLibrary
//
//  Created by Marcelo German De Luca on 18/08/11.
//  Copyright 2011 TheAppMaster. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Category : NSObject {
    
    NSInteger  id;
    NSInteger  idSorted;
    NSString * name;
    NSString * description;
    NSString * code;
    
}

@property (nonatomic) NSInteger id;
@property (nonatomic) NSInteger idSorted;
@property (nonatomic,retain) NSString * name;
@property (nonatomic,retain) NSString * description;
@property (nonatomic,retain) NSString * code;


@end
