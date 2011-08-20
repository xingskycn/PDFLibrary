//
//  ServiceManager.m
//  PDFLibrary
//
//  Created by Gonzalo Aizpun on 8/15/11.
//  Copyright 2011 TheAppMaster. All rights reserved.
//

#import "ServiceManager.h"


@implementation ServiceManager
@synthesize delegate;


// ****************************************************************

- (NSString *)getServerURL {
    return @"http://tenarisservices.theappmaster.com";
}

- (NSString *)getUsername {
    return @"Tenaris";    
}

- (NSString *)getPassword {
    return @"Tenaris";
}

// FINAL METHOD. Don't change it. This applies for each service.
// -------------------------------------------------------------
- (void)callService:(NSString *)serviceURL 
       arguments:(NSMutableDictionary *)arguments 
       errorMessage:(NSString *)errorMessage {
    
    // URL
    // --------------------------------
    NSString * completePath = [NSString stringWithFormat:@"%@/%@", [self getServerURL], serviceURL];
       NSURL * url          = [NSURL URLWithString:completePath];
    
    // BLOCK
    // --------------------------------    
    __block ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    
    // HEADERS W/ARGS
    // --------------------------------    
    [request addRequestHeader:@"Accept" value:@"application/json"];
    [request setValidatesSecureCertificate:NO];
    
        for (NSString * key in [arguments keyEnumerator]) {
            [request setPostValue:[arguments objectForKey:key] forKey:key];
        }
    
    // LOG
    // --------------------------------
    NSLog(@"SERVICE: %@\nARGUMENTS: \n%@", completePath, arguments);
    
    // BLOCK REQUEST OK
    // --------------------------------    
    [request setCompletionBlock:^{

        NSError *error;
        NSString * jsonString = [request responseString];
        NSLog(@"SERVICE 200 OK: \n%@", jsonString);
        
        // FAIL CASE
        // --------------------------------
        if([jsonString rangeOfString:@"Error"].location != NSNotFound) {
            [self.delegate serviceFailed:errorMessage];
            return;
        }
        
        // SUCCESS CASE
        // --------------------------------
        NSDictionary * data = [jsonString objectFromJSONStringWithParseOptions:JKParseOptionLooseUnicode 
                                          error:&error];
        
        [self.delegate serviceSuccess:data];
    }];
    
    // BLOCK BAD REQUEST
    // --------------------------------
    [request setFailedBlock:^{
        NSLog(@"SERVICE 500 ERROR");
        [self.delegate serviceFailed:errorMessage];
    }];
    
    // CALL SERVICE
    // --------------------------------    
    [request startAsynchronous];   
}

// ****************************************************************

- (void)callUpdateData:(id<ServiceManagerDelegate>)_delegate {

    self.delegate = _delegate;
    
    NSString * serviceURL = @"updatedata.ashx";
    NSString * errorMessage = @"Sorry, we can't update the database from the WebServices.";
    
    Version * version = [VersionDAO getCurrentVersion];
    
    NSMutableDictionary * arguments = [[NSMutableDictionary alloc] init];
    [arguments setValue:[self getUsername] forKey:@"User"];
    [arguments setValue:[self getPassword] forKey:@"Password"];
    [arguments setValue:[NSString stringWithFormat:@"%u", version.id] forKey:@"IdVersion"];    
    
    [self callService:serviceURL arguments:arguments errorMessage:errorMessage];
}


- (void)sendFormContact:(id<ServiceManagerDelegate>)_delegate arguments:(NSMutableDictionary *)arguments {
 
    self.delegate = _delegate;
    
    NSString * serviceURL = @"contactus.ashx";
    NSString * errorMessage = @"Sorry, we can't send this form.";
    
    [arguments setValue:[self getUsername] forKey:@"User"];
    [arguments setValue:[self getPassword] forKey:@"Password"];


    [self callService:serviceURL arguments:arguments errorMessage:errorMessage];
    
}


- (void)sendFormHardCopy:(id<ServiceManagerDelegate>)_delegate arguments:(NSMutableDictionary *)arguments {
    
    self.delegate = _delegate;
    
    NSString * serviceURL = @"requesthardcopy.ashx";
    NSString * errorMessage = @"Sorry, we can't request for hard copy form.";
    
    [arguments setValue:[self getUsername] forKey:@"User"];
    [arguments setValue:[self getPassword] forKey:@"Password"];
    
    
    [self callService:serviceURL arguments:arguments errorMessage:errorMessage];
    
}


@end
