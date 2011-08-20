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
+ (Category*)getCategoryById:(NSInteger)id;
@end
