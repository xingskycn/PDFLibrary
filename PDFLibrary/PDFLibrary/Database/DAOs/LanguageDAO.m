//
//  LanguageDAO.m
//  PDFLibrary
//
//  Created by Gonzalo Aizpun on 8/21/11.
//  Copyright 2011 TheAppMaster. All rights reserved.
//

#import "LanguageDAO.h"


@implementation LanguageDAO

+ (Language *)castFromStatement:(sqlite3_stmt *)statement {
	Language * item = [Language alloc];
	
	item.id = (NSInteger)sqlite3_column_int(statement, 0);
	item.name = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 1)];
	item.code = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 2)];
    
	return item;
}

+ (Language *)getLanguageById:(NSInteger)id
{
    Language * item = nil;
    NSString * sql = @"SELECT * FROM Language WHERE id = ?";
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

+ (NSArray *)getLanguages
{
	NSMutableArray * list = [[NSMutableArray alloc] init];
    sqlite3_stmt * compiledStatement;
    const char * sqlStatement = "SELECT * FROM Language";
    
    if (sqlite3_prepare_v2([self database], sqlStatement, -1, &compiledStatement, NULL) != SQLITE_OK) {
        return list;
    }
    
    while(sqlite3_step(compiledStatement) == SQLITE_ROW) {
        Language * item = [self castFromStatement:compiledStatement];
        [list addObject:item];
        [item release];
    }
    sqlite3_finalize(compiledStatement);
    return list;
}

// Method used by DocumentoDAO in order to get All Languages for a DocumentId
+ (NSArray*)getLanguagesForDocument:(NSInteger)idDocument {

	NSMutableArray * list = [[NSMutableArray alloc] init];
    sqlite3_stmt * compiledStatement;
    const char * sqlStatement = "SELECT IdLanguage FROM Document_Language WHERE IdDocument = ?";
    
    if (sqlite3_prepare_v2([self database], sqlStatement, -1, &compiledStatement, NULL) != SQLITE_OK) {
        return list;
    }
    
    sqlite3_bind_int(compiledStatement, 1, idDocument);
    
    while(sqlite3_step(compiledStatement) == SQLITE_ROW) {

        int idLanguage  = (NSInteger)sqlite3_column_int(compiledStatement, 0);
        
        Language * item = [self getLanguageById:idLanguage];
        [list addObject:item];
        [item release];
    }
    
    sqlite3_finalize(compiledStatement);
    return list;    
    
}


@end
