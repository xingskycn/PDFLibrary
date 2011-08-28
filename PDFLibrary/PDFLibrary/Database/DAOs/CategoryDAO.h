//
//  CategoryDAO.h
//  PDFLibrary
//
//  Created by Marcelo German De Luca on 18/08/11.
//  Copyright 2011 TheAppMaster. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommonDAO.h"
#import "Category.h"


@interface CategoryDAO : CommonDAO {
    
}

+ (NSArray*)getCategories;
+ (NSArray*)getCategoriesForDocument:(NSInteger)idDocument;
+ (Category*)getCategoryById:(NSInteger)id;
+ (NSArray*)getDocumentsByCategoryId:(NSInteger)id;
@end
