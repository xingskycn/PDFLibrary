//
//  UpdatedImages.h
//  PDFLibrary
//
//  Created by Marcelo German De Luca on 18/08/11.
//  Copyright 2011 TheAppMaster. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UpdatedImage.h"
#import "CommonDAO.h"


@interface UpdatedImageDAO : CommonDAO {
    
}

+ (NSArray*)getUpdatedImages;
+ (void)deleteAllUpdatedImages;
+ (void)deleteByCode:(NSString*)code;
@end
