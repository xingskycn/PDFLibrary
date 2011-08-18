//
//  MessageDAO.h
//  PDFLibrary
//
//  Created by Gonzalo Aizpun on 8/17/11.
//  Copyright 2011 TheAppMaster. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommonDAO.h"
#import "Message.h"

@interface MessageDAO : CommonDAO {
    
}

+ (NSArray*)getMessagesForForm:(int)idForm;


@end
