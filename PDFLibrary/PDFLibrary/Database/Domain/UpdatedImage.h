//
//  UpdatedImages.h
//  PDFLibrary
//
//  Created by Marcelo German De Luca on 18/08/11.
//  Copyright 2011 TheAppMaster. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface UpdatedImage : NSObject {
     NSString * code;
     NSString * url;    
}

@property (nonatomic,retain) NSString * code;
@property (nonatomic,retain) NSString * url;

@end
