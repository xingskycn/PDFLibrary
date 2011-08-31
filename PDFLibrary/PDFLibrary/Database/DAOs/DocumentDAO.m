//
//  DocumentDAO.m
//  PDFLibrary
//
//  Created by Marcelo German De Luca on 27/08/11.
//  Copyright 2011 TheAppMaster. All rights reserved.
//

#import "DocumentDAO.h"
#import "LanguageDAO.h"
#import "CategoryDAO.h"


@implementation DocumentDAO

+ (Document *)castFromStatement:(sqlite3_stmt *)statement {
	Document * item = [Document alloc];
	
	item.id = (NSInteger)sqlite3_column_int(statement, 0);
	item.idType = (NSInteger)sqlite3_column_int(statement, 1);
	item.title = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 2)];
	item.description = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 3)];
	item.keyword = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 4)];
    item.mainScreenFeatured = (NSInteger)sqlite3_column_int(statement, 5) == 1;
    item.categoryFeatured = (NSInteger)sqlite3_column_int(statement, 6) == 1;
	item.version = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 7)];
	item.date = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 8)];
	item.updateDate = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 9)];
	item.code = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 10)];
    item.isCaseStudy = (NSInteger)sqlite3_column_int(statement, 11) == 1;
    item.inLibrary = (NSInteger)sqlite3_column_int(statement, 12) == 1;
    item.languages = [LanguageDAO getLanguagesForDocument:item.id];
    item.categories = [CategoryDAO getCategoriesForDocument:item.id];
    item.isEbook = (item.idType == 1);
	return item;
}


// Unique method for Get all possibilities and response with the right array
+ (NSArray  *)getDocumentsByCategory:(NSInteger)categoryId 
                            language:(NSInteger)languageId 
                             keyword:(NSString *)keyword
                           myLibrary:(BOOL)myLibrary
                                sort:(int)sortId {
    
    
    NSMutableArray * list = [[NSMutableArray alloc] init];
    NSString * sql = @"SELECT d.* FROM Document d";
    
    // Joins
    if(categoryId) {
        sql = [NSString stringWithFormat:@"%@ INNER JOIN Document_Category dc ON dc.IdDocument = d.id ", sql];
    }
    if (languageId) {
        sql = [NSString stringWithFormat:@"%@ INNER JOIN Document_Language dl ON dl.IdDocument = d.id ", sql];
    }
    
    // Filters
    if (categoryId) {
        sql = [NSString stringWithFormat:@"%@ WHERE dc.IdCategory = %u ", sql, categoryId];
    }
    if (languageId) {
        if (categoryId) {
            sql = [NSString stringWithFormat:@"%@ AND dl.IdLanguage = %u ", sql, languageId];
        } else {
            sql = [NSString stringWithFormat:@"%@ WHERE dl.IdLanguage = %u ", sql, languageId];
        }
    }
    if (keyword) {
        if(categoryId || languageId) {
            sql = [NSString stringWithFormat:@"%@ AND d.keyword LIKE \"%%%@%%\" ", sql, keyword];
        } else {
            sql = [NSString stringWithFormat:@"%@ WHERE d.keyword LIKE '%%%@%%' ", sql, keyword];
        }
    }
    
    if (myLibrary) {
        if(categoryId || languageId || keyword) {
            sql = [NSString stringWithFormat:@"%@ AND d.InLibrary = 1 ", sql];
        } else {
            sql = [NSString stringWithFormat:@"%@ WHERE d.InLibrary = 1 ", sql];
        }
    }
    
    // Sorting
    if(sortId == kSortLastUpdate) {
        sql = [NSString stringWithFormat:@"%@ ORDER BY d.UpdateDate DESC ", sql];
        
    } else if (sortId == kSortAlphabetical) {
        sql = [NSString stringWithFormat:@"%@ ORDER BY d.title ASC ", sql];
        
    }

    NSLog(@"SQL: %@", sql);

    const char * sqlStatement = [sql UTF8String];
    sqlite3_stmt * compiled;
    sqlite3 * db = [DBManager getInstance].database;
    int prepare = sqlite3_prepare_v2(db, sqlStatement, -1, &compiled, NULL);
    if(prepare == SQLITE_OK)
    {

        while(sqlite3_step(compiled) == SQLITE_ROW)
        {
            Document * item = [self castFromStatement:compiled];
            [list addObject:item];
            [item release];
        }
        sqlite3_finalize(compiled);
    }
    
    
    NSLog(@"***** Documents Found: %u", [list count]);
    
    return list;
    
    
}



+ (Document *)getDocumentById:(NSInteger)id
{
    Document * item = nil;
    NSString * sql = @"SELECT * FROM Document WHERE id = ?";
    const char * sqlstatement = [sql UTF8String];
    sqlite3_stmt* compiled;
    sqlite3* db = [DBManager getInstance].database;
    int prepare = sqlite3_prepare_v2(db, sqlstatement, -1, &compiled, NULL);
    if(prepare == SQLITE_OK)
    {
        sqlite3_bind_int(compiled, 1, id);
        while(sqlite3_step(compiled) == SQLITE_ROW)
        {
            item = [self castFromStatement:compiled] ;
        }
        sqlite3_finalize(compiled);
    }
    
    return item;
}


+ (NSArray *)getDocuments
{
	NSMutableArray * list = [[NSMutableArray alloc] init];
    sqlite3_stmt * compiledStatement;
    const char * sqlStatement = "SELECT * FROM Document";
    
    if (sqlite3_prepare_v2([self database], sqlStatement, -1, &compiledStatement, NULL) != SQLITE_OK) {
        return list;
    }
    
    while(sqlite3_step(compiledStatement) == SQLITE_ROW) {
        Document * item = [self castFromStatement:compiledStatement];
        [list addObject:item];
        [item release];
    }
    sqlite3_finalize(compiledStatement);
    return list;
}


+ (void)updateLibraryStatus:(BOOL)inLibrary forDocument:(NSInteger)documentId
{
    NSString * sql = @"UPDATE Document SET inLibrary = ? WHERE id = ?";
    const char * sqlstatement = [sql UTF8String];
    sqlite3_stmt* compiled;
    sqlite3* db = [DBManager getInstance].database;
    int prepare = sqlite3_prepare_v2(db, sqlstatement, -1, &compiled, NULL);
    if(prepare == SQLITE_OK)
    {
        sqlite3_bind_int(compiled, 1, inLibrary);
        sqlite3_bind_int(compiled, 2, documentId);        
        sqlite3_step(compiled);
        sqlite3_finalize(compiled);
    }
}

@end
