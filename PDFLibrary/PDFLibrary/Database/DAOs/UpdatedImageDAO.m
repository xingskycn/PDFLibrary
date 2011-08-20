//
//  UpdatedImages.m
//  PDFLibrary
//
//  Created by Marcelo German De Luca on 18/08/11.
//  Copyright 2011 TheAppMaster. All rights reserved.
//

#import "UpdatedImageDAO.h"


@implementation UpdatedImageDAO

+ (UpdatedImage *)castFromStatement:(sqlite3_stmt*)statement {
	UpdatedImage * item = [UpdatedImage alloc];
	
	item.code = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)];
    item.url = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 1)];
	return item;
}

+ (NSArray*)getUpdatedImages
{
	NSMutableArray * list = [[NSMutableArray alloc] init];
    sqlite3_stmt * compiledStatement;
    const char * sqlStatement = "SELECT * FROM UpdatedImage";
    
    if (sqlite3_prepare_v2([self database], sqlStatement, -1, &compiledStatement, NULL) != SQLITE_OK) {
        return list;
    }
    
    while(sqlite3_step(compiledStatement) == SQLITE_ROW) {
        UpdatedImage * item = [self castFromStatement:compiledStatement];
        [list addObject:item];
        [item release];
    }
    sqlite3_finalize(compiledStatement);
    return list;
}

+ (void)deleteAllUpdatedImages;
{
	const char *sqlStatement = "delete from UpdatedImage";
	sqlite3_stmt *compiledStatement;
	
	if(sqlite3_prepare_v2([self database], sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) 
	{
		sqlite3_step(compiledStatement);				
		sqlite3_finalize(compiledStatement);
	}
	
}


+ (void)deleteByCode:(NSString*)code
{
    const char * sqlStatement = "delete From UpdatedImage where code = ?";
    sqlite3_stmt *compiledStatement;
	
	if(sqlite3_prepare_v2([self database], sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) 
	{
        sqlite3_bind_text(compiledStatement, 1, [code UTF8String], -1, SQLITE_STATIC);
        
        sqlite3_step(compiledStatement);				
		sqlite3_finalize(compiledStatement);
    }
}
@end
