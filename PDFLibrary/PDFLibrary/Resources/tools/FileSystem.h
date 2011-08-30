//
//  FileSystem.h
//  PDFLibrary
//
//  Created by Gonzalo Aizpun on 8/20/11.
//  Copyright 2011 TheAppMaster. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface FileSystem : NSObject {
    
}

+ (NSString *)getFileFromMyDocuments:(NSString *)filename;
+ (BOOL)existsFileOnMyDocuments:(NSString * )filename;
+ (UIImage *)getImageFromFileSystem:(NSString *)filename;
+ (UIImage *)getImageFromFileSystem:(NSString *)filename defaultImage:(NSString *)noImageFilename;

@end
