//
//  VersionDAO.h
//  PDFLibrary
//
//  Created by Gonzalo Aizpun on 8/16/11.
//  Copyright 2011 TheAppMaster. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommonDAO.h"
#import "Version.h"


@interface VersionDAO : CommonDAO {
    
}

+ (Version *)getCurrentVersion;
+ (void)saveNewUpdates:(NSDictionary * )data;

@end
