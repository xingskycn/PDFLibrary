//
//  CategoryDAO.m
//  PDFLibrary
//
//  Created by Marcelo German De Luca on 18/08/11.
//  Copyright 2011 TheAppMaster. All rights reserved.
//

#import "CategoryDAO.h"
#import "DocumentDAO.h"

@implementation CategoryDAO

+ (Category *)castFromStatement:(sqlite3_stmt*)statement {
	Category * item = [Category alloc];
	
	item.id = (NSInteger)sqlite3_column_int(statement, 0);
	item.idSorted = (NSInteger)sqlite3_column_int(statement, 1);
	item.name = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 2)];
	item.description = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 3)];
	item.code = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 4)];
    
	return item;
}

+ (Category*)getCategoryById:(NSInteger)id
{
    Category* category = nil;
    NSString * sql = @"Select * From Category where id = ?";
    const char * sqlstatement = [sql UTF8String];
    sqlite3_stmt* compiled;
    sqlite3* db = [DBManager getInstance].database;
    int prepare = sqlite3_prepare_v2(db, sqlstatement, -1, &compiled, NULL);
    if(prepare == SQLITE_OK)
    {
        sqlite3_bind_int(compiled, 1, id);
        while(sqlite3_step(compiled) == SQLITE_ROW)
        {
            category = [CategoryDAO castFromStatement:compiled] ;
        }
        sqlite3_finalize(compiled);
    }
    
    return category;
}

+ (NSArray*)getCategories
{
	NSMutableArray * list = [[NSMutableArray alloc] init];
    sqlite3_stmt * compiledStatement;
    const char * sqlStatement = "SELECT * FROM Category";
    
    if (sqlite3_prepare_v2([self database], sqlStatement, -1, &compiledStatement, NULL) != SQLITE_OK) {
        return list;
    }
    
    while(sqlite3_step(compiledStatement) == SQLITE_ROW) {
        Category * item = [self castFromStatement:compiledStatement];
        [list addObject:item];
        [item release];
    }
    sqlite3_finalize(compiledStatement);
    return list;
}


+ (NSArray*)getDocumentsByCategoryId:(NSInteger)idCategory
{
    NSMutableArray * list = [[NSMutableArray alloc] init];
    sqlite3_stmt * compiledStatement;
    const char * sqlStatement = "SELECT * FROM Document_Category WHERE idCategory = ?";
    
    if (sqlite3_prepare_v2([self database], sqlStatement, -1, &compiledStatement, NULL) != SQLITE_OK) {
        return list;
    }
    
    sqlite3_bind_int(compiledStatement, 1, idCategory);
    
    while(sqlite3_step(compiledStatement) == SQLITE_ROW) {
        int idDocument = (NSInteger)sqlite3_column_int(compiledStatement, 1);
        
        Document * item = [DocumentDAO getDocumentById:idDocument];
        [list addObject:item];
        [item release];
    }
    
    sqlite3_finalize(compiledStatement);
    
    return list;

}
@end
