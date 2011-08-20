//
//  ServiceImage.m
//  PDFLibrary
//
//  Created by Marcelo German De Luca on 19/08/11.
//  Copyright 2011 TheAppMaster. All rights reserved.
//

#import "ServiceImage.h"


@implementation ServiceImage

+(void) downloadNewImages
{
    NSArray* images = [UpdatedImageDAO getUpdatedImages];
    
    for (UpdatedImage * img in images)
        [self downloadImage:img.url code: img.code];
}

+ (void)downloadImage:(NSString *)url code:(NSString *)code
{
	ASIHTTPRequest * aRequest = nil;
	
	NSFileManager * fileManager = [[NSFileManager alloc]init];
	NSURL *_url = [NSURL URLWithString:url];
	
	NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString * documentsDirectory = [paths objectAtIndex:0];
	NSString * imgSavedPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png", code]];

    aRequest = [ASIHTTPRequest requestWithURL:_url];
	aRequest.username = code;
	
    [aRequest setDelegate:self];
    [aRequest setDidStartSelector:@selector(requestStartedDownloadImg:)];
    [aRequest setDidFinishSelector:@selector(requestFinishedDownloadImg:)];   
    [aRequest setDidFailSelector:@selector(requestFailedDownloadImg:)];
    [aRequest setUseKeychainPersistence:YES];
    [aRequest setDownloadDestinationPath:imgSavedPath];
    [aRequest startSynchronous];
		
	[fileManager release];
}

+(void)requestStartedDownloadImg:(ASIHTTPRequest *)request
{
    NSString* code = request.username;
    [UpdatedImageDAO deleteByCode:code];
}

+(void)requestFinishedDownloadImg:(ASIHTTPRequest *)request
{
}

+(void)requestFailedDownloadImg:(ASIHTTPRequest *)request
{
}

@end
