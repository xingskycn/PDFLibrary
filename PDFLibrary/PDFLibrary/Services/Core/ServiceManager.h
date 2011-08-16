//
//  ServiceManager.h
//  PDFLibrary
//
//  Created by Gonzalo Aizpun on 8/15/11.
//  Copyright 2011 TheAppMaster. All rights reserved.
//

#import <Foundation/Foundation.h>

// Services tools
#import "JSONKit.h"
#import "ASIFormDataRequest.h"

// Database
#import "VersionDAO.h"

// Models
#import "Version.h"

// Protocol
@protocol ServiceManagerDelegate <NSObject>
@required
    - (void)serviceSuccess:(NSDictionary * )data;
    - (void)serviceFailed:(NSString * )errorMsg;
@end


@interface ServiceManager : NSObject {
     id <ServiceManagerDelegate> delegate;
}

@property (retain) id delegate;

// Services Available
- (void)callUpdateData:(id<ServiceManagerDelegate>)delegate;
- (void)sendFormHardCopy:(id<ServiceManagerDelegate>)_delegate arguments:(NSMutableDictionary *)arguments;
- (void)sendFormContact:(id<ServiceManagerDelegate>)_delegate arguments:(NSMutableDictionary *)arguments;

@end
