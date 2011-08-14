//
//  ItemDAO.m
//  StockController
//
//  Created by Marcelo German De Luca on 03/05/11.
//  Copyright 2011 The App Master. All rights reserved.
//

#import "ItemDAO.h"


@implementation ItemDAO

+ (Item*)getItemFromStatement:(sqlite3_stmt*)statement 
{
	Item* item = [Item alloc];
	
	item.id = (NSInteger)sqlite3_column_int(statement, 0);
	item.type = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 1)];
	item.explanation = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 2)];
	item.branch = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 3)];
	item.location = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 4)];
	item.item = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 5)];
	item.quantity = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 6)];
	item.unit = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 7)];
    
	return item;
}

+ (NSArray*)getItems 
{
	NSMutableArray* items = [[NSMutableArray alloc] init];
	const char *sqlStatement = "Select * from items";
	sqlite3_stmt *compiledStatement;
	
	if(sqlite3_prepare_v2([self database], sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) 
	{
		// Loop through the results and add them to the feeds array
		while(sqlite3_step(compiledStatement) == SQLITE_ROW) 
		{
			// Read the data from the result row
			Item* item = [self getItemFromStatement: compiledStatement];
			[items addObject: item];
			[item release];
		}
		
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);
	}
	
	return items;
}

+ (void)updateItem:(NSInteger)id:(NSString*)type:(NSString*)explanation:(NSString*)branch:(NSString*)location:(NSString*)item:(NSString*)quantity
{
	const char *sqlStatement = "update items set type = ?, explanation = ?, branch = ?, location = ?, item = ?, quantity = ? where id = ?";
	sqlite3_stmt *compiledStatement;
	
	if(sqlite3_prepare_v2([self database], sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) 
	{
		
		sqlite3_bind_text(compiledStatement, 1, [type UTF8String], -1, SQLITE_STATIC);
		sqlite3_bind_text(compiledStatement, 2, [explanation UTF8String], -1, SQLITE_STATIC);
		sqlite3_bind_text(compiledStatement, 3, [branch UTF8String], -1, SQLITE_STATIC);
		sqlite3_bind_text(compiledStatement, 4, [location UTF8String], -1, SQLITE_STATIC);        
		sqlite3_bind_text(compiledStatement, 5, [item UTF8String], -1, SQLITE_STATIC);
		sqlite3_bind_text(compiledStatement, 6, [quantity UTF8String], -1, SQLITE_STATIC);
        sqlite3_bind_int(compiledStatement, 7, id);
        
        sqlite3_step(compiledStatement);				
		
		
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);
	}
	
}

+ (void)addItem:(NSString*)type:(NSString*)explanation:(NSString*)branch:(NSString*)location:(NSString*)item:(NSString*)quantity: (NSString*)unit
{
	const char *sqlStatement = "insert into items (id, type, explanation, branch, location, item, quantity, unit) values (NULL, ?, ?, ?, ?, ?, ?, ?)";
	sqlite3_stmt *compiledStatement;
	
	if(sqlite3_prepare_v2([self database], sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) 
	{
		sqlite3_bind_text(compiledStatement, 1, [type UTF8String], -1, SQLITE_STATIC);
		sqlite3_bind_text(compiledStatement, 2, [explanation UTF8String], -1, SQLITE_STATIC);
		sqlite3_bind_text(compiledStatement, 3, [branch UTF8String], -1, SQLITE_STATIC);
        sqlite3_bind_text(compiledStatement, 4, [location UTF8String], -1, SQLITE_STATIC);
		sqlite3_bind_text(compiledStatement, 5, [item UTF8String], -1, SQLITE_STATIC);
		sqlite3_bind_text(compiledStatement, 6, [quantity UTF8String], -1, SQLITE_STATIC);
		sqlite3_bind_text(compiledStatement, 7, [unit UTF8String], -1, SQLITE_STATIC);
        

		// Loop through the results and add them to the feeds array
		
		sqlite3_step(compiledStatement);				
		
		
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);
	}
	
}

+ (void)deleteItem:(NSInteger)id
{
	const char *sqlStatement = "delete from items where id = ?";
	sqlite3_stmt *compiledStatement;
	
	if(sqlite3_prepare_v2([self database], sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) 
	{
		sqlite3_bind_int(compiledStatement, 1, id);        
        
		
		sqlite3_step(compiledStatement);
		sqlite3_finalize(compiledStatement);
	}	
}

+ (void)deleteItems;
{
	const char *sqlStatement = "delete from items";
	sqlite3_stmt *compiledStatement;
	
	if(sqlite3_prepare_v2([self database], sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) 
	{
		sqlite3_step(compiledStatement);				
		
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);
	}
	
}

+ (Item*)getItemById:(NSInteger)id
{
	Item* item = nil;
	const char *sqlStatement = "select * from items where id = ?";
	sqlite3_stmt *compiledStatement;
	
	if(sqlite3_prepare_v2([self database], sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) 
	{
		sqlite3_bind_int(compiledStatement, 1, id);
		
		// Loop through the results and add them to the feeds array
		while(sqlite3_step(compiledStatement) == SQLITE_ROW) 
		{
			// Read the data from the result row
			item = [self getItemFromStatement: compiledStatement];
		}
		
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);
	}
	return item;
}


@end
