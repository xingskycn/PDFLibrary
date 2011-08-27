//
//  DocumentDAO.m
//  PDFLibrary
//
//  Created by Marcelo German De Luca on 27/08/11.
//  Copyright 2011 TheAppMaster. All rights reserved.
//

#import "DocumentDAO.h"


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
	return item;
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

@end
