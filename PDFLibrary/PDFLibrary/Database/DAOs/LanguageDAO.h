//
//  LanguageDAO.h
//  PDFLibrary
//
//  Created by Gonzalo Aizpun on 8/21/11.
//  Copyright 2011 TheAppMaster. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommonDAO.h"
#import "Language.h"

@interface LanguageDAO : CommonDAO {
    
}

+ (NSArray  *)getLanguages;
+ (Language *)getLanguageById:(NSInteger)id;
+ (NSArray *)getLanguageByIdDocument:(NSInteger)idDocument;

@end
