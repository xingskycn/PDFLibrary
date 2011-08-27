//
//  DocumentDAO.h
//  PDFLibrary
//
//  Created by Marcelo German De Luca on 27/08/11.
//  Copyright 2011 TheAppMaster. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommonDAO.h"
#import "Document.h"

@interface DocumentDAO : CommonDAO {
    
}

+ (NSArray  *)getDocuments;
+ (Document *)getDocumentById:(NSInteger)id;
@end
