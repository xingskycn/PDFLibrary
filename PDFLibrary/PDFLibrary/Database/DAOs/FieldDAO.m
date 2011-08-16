//
//  FieldDAO.m
//  PDFLibrary
//
//  Created by Gonzalo Aizpun on 8/15/11.
//  Copyright 2011 TheAppMaster. All rights reserved.
//

#import "FieldDAO.h"


@implementation FieldDAO

+ (Field *)castFromStatement:(sqlite3_stmt*)statement {
	Field * item = [Field alloc];
	
	item.id = (NSInteger)sqlite3_column_int(statement, 0);
	item.idForm = (NSInteger)sqlite3_column_int(statement, 1);
	item.name = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 2)];
	item.value = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 3)];
    
	return item;
}



+ (NSArray*)getFieldsForForm:(int)idForm {
    
	NSMutableArray * list = [[NSMutableArray alloc] init];
    sqlite3_stmt * compiledStatement;
    const char * sqlStatement = "SELECT * FROM Field WHERE idForm = ?";
    
    if (sqlite3_prepare_v2([self database], sqlStatement, -1, &compiledStatement, NULL) != SQLITE_OK) {
        return list;
    }
    
    sqlite3_bind_int(compiledStatement, 1, idForm);
    
    while(sqlite3_step(compiledStatement) == SQLITE_ROW) {
        Field * item = [self castFromStatement:compiledStatement];
        [list addObject:item];
        [item release];
    }
    sqlite3_finalize(compiledStatement);
    return list;
}

@end
