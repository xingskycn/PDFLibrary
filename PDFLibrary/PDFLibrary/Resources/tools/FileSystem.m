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


+ (NSString *)formatDate:(NSString *)documentDate {
    
    NSArray *components = [documentDate componentsSeparatedByString:@"/"];
    NSString * month    = [components objectAtIndex:1];
    NSString *  year    = [components objectAtIndex:2];
    
    if([month isEqualToString:@"01"]) return [NSString stringWithFormat:@"JAN %@", year];
    if([month isEqualToString:@"02"]) return [NSString stringWithFormat:@"FEB %@", year];
    if([month isEqualToString:@"03"]) return [NSString stringWithFormat:@"MAR %@", year];
    if([month isEqualToString:@"04"]) return [NSString stringWithFormat:@"APR %@", year];
    if([month isEqualToString:@"05"]) return [NSString stringWithFormat:@"MAY %@", year];
    if([month isEqualToString:@"06"]) return [NSString stringWithFormat:@"JUN %@", year];
    if([month isEqualToString:@"07"]) return [NSString stringWithFormat:@"JUL %@", year];
    if([month isEqualToString:@"08"]) return [NSString stringWithFormat:@"AUG %@", year];
    if([month isEqualToString:@"09"]) return [NSString stringWithFormat:@"SEP %@", year];
    if([month isEqualToString:@"10"]) return [NSString stringWithFormat:@"OCT %@", year];
    if([month isEqualToString:@"11"]) return [NSString stringWithFormat:@"NOV %@", year];
    if([month isEqualToString:@"12"]) return [NSString stringWithFormat:@"DEC %@", year];    
    
    return @"";
}

@end


