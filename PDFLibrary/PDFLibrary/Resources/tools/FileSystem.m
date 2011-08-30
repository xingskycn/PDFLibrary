//
//  FileSystem.m
//  PDFLibrary
//
//  Created by Gonzalo Aizpun on 8/20/11.
//  Copyright 2011 TheAppMaster. All rights reserved.
//

#import "FileSystem.h"


@implementation FileSystem


+ (UIImage *)getImageFromFileSystem:(NSString *)filename defaultImage:(NSString *)noImageFilename {
    
    if([self existsFileOnMyDocuments:filename]) {
        
        NSString * filePath = [self getFileFromMyDocuments:filename];
        return [UIImage imageWithContentsOfFile:filePath];
        
    } else {
        
        UIImage * imgFromApp = [UIImage imageNamed:filename];
        if(imgFromApp) {
            return imgFromApp;
        } else {
            return [UIImage imageNamed:noImageFilename];
        }
    }

}

+ (UIImage *)getImageFromFileSystem:(NSString *)filename {
    
    if([self existsFileOnMyDocuments:filename]) {
        NSString * filePath = [self getFileFromMyDocuments:filename];
        return [UIImage imageWithContentsOfFile:filePath];
        
    } else {
        return [UIImage imageNamed:filename];
    }
    
}

+ (NSString *)getFileFromMyDocuments:(NSString *)filename {
	    
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
	NSString * documentsDirectory = [paths objectAtIndex:0];
	NSString * filePath = [documentsDirectory stringByAppendingPathComponent:filename];
    return filePath;    
}
       
+ (BOOL)existsFileOnMyDocuments:(NSString * )filename {

    NSString * filePath = [self getFileFromMyDocuments:filename];
    
    if(filePath) {
        NSFileManager * fileManager = [[NSFileManager alloc] init];
        return [fileManager fileExistsAtPath:filePath];    
    }
    
    return NO;
}

@end


