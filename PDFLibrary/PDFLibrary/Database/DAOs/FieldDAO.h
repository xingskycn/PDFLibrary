//
//  FieldDAO.h
//  PDFLibrary
//
//  Created by Gonzalo Aizpun on 8/15/11.
//  Copyright 2011 TheAppMaster. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommonDAO.h"
#import "Field.h"


@interface FieldDAO : CommonDAO {
    
}

+ (NSArray*)getFieldsForForm:(int)idForm;

@end
