//
//  VersionDAO.m
//  PDFLibrary
//
//  Created by Gonzalo Aizpun on 8/16/11.
//  Copyright 2011 TheAppMaster. All rights reserved.
//

#import "VersionDAO.h"


@implementation VersionDAO


+ (Version *)castFromStatement:(sqlite3_stmt*)statement {
    
	Version * item = [[Version alloc] init];
	item.id = (NSInteger)sqlite3_column_int(statement, 0);
	return item;
    
}



+ (Version *)getCurrentVersion {
    
    sqlite3_stmt * compiledStatement;
    const char * sqlStatement = "SELECT * FROM Version";
    Version * item = [[Version alloc] init];
    
    if (sqlite3_prepare_v2([self database], sqlStatement, -1, &compiledStatement, NULL) != SQLITE_OK) {
        return item;
    }
    
    while(sqlite3_step(compiledStatement) == SQLITE_ROW) {
        item = [self castFromStatement:compiledStatement];
    }
    
    sqlite3_finalize(compiledStatement);
    return item;
}





+ (void)saveNewUpdates:(NSDictionary * )data {
    
    NSDictionary *results = [data valueForKeyPath:@"Query"];
    
    for (NSString * query in results) {
    
        const char * sql = (const char*)[query cStringUsingEncoding:NSUTF8StringEncoding];
        sqlite3_stmt * compiled;
        
        if(sqlite3_prepare_v2([self database], sql, -1, &compiled, NULL) == SQLITE_OK) {
            sqlite3_step(compiled);				
            sqlite3_finalize(compiled);
        }
        
    }
    
}


@end
