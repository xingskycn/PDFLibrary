//
//  DocumentDAO.h
//  PDFLibrary
//
//  Created by Marcelo German De Luca on 27/08/11.
//  Copyright 2011 TheAppMaster. All rights reserved.
//

typedef enum {
    kSortBestMatch,
    kSortAlphabetical,
    kSortLastUpdate
} SortType;


#import <Foundation/Foundation.h>
#import "CommonDAO.h"
#import "Document.h"

@interface DocumentDAO : CommonDAO {
    
}

+ (NSArray  *)getDocuments;

+ (NSArray  *)getDocumentsByCategory:(NSInteger)categoryId 
                            language:(NSInteger)languageId 
                            keyword:(NSString *)keyword
                            myLibrary:(BOOL)myLibrary
                            sort:(int)sortId;

+ (Document *)getDocumentById:(NSInteger)id;
+ (Document *)getDocumentForHomepage;

+ (void)updateLibraryStatus:(BOOL)inLibrary forDocument:(NSInteger)documentId;

@end
