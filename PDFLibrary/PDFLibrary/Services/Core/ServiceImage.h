//
//  ServiceImage.h
//  PDFLibrary
//
//  Created by Marcelo German De Luca on 19/08/11.
//  Copyright 2011 TheAppMaster. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
#import "UpdatedImageDAO.h"

@interface ServiceImage : NSObject {

}

+ (void)downloadNewImages;
+ (void)downloadImage:(NSString *)url code:(NSString *)code;

@end
