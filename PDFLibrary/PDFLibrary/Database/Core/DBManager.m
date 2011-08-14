//
//  DBManager.m
//  WorldCup
//
//  Created by Tomas on 11/04/10.
//  Copyright 2010 TheAppMaster. All rights reserved.
//

#import "DBManager.h"

static DBManager* DBManagerSingleton = nil;

@implementation DBManager

@synthesize databasePath;
@synthesize database;

+ (DBManager*)getInstance {
    if (DBManagerSingleton == nil) {
        DBManagerSingleton = [[super allocWithZone:NULL] init];
    }
    return DBManagerSingleton;
}

+ (id)allocWithZone:(NSZone *)zone {
    return [self getInstance];
}

- (id)copyWithZone:(NSZone *)zone {
    return self;
}

- (id)retain {
    return self;
}

- (NSUInteger)retainCount {
    return NSUIntegerMax;  //denotes an object that cannot be released
}

- (void)release {
    //do nothing
}

- (id)autorelease
{
    return self;
}

- (id)initWithDatabaseFile:(NSString*)fileName {	
	// Get the path to the documents directory and append the databaseName
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
	self.databasePath = [documentsDir stringByAppendingPathComponent:fileName];

	NSFileManager *fileManager = [NSFileManager defaultManager];
	
	// Check if the database has already been created in the users filesystem
	BOOL success = [fileManager fileExistsAtPath: self.databasePath];
	
	// If the database already exists then return without doing anything
	if(!success) {
	
		// If not then proceed to copy the database from the application to the users filesystem
	
		// Get the path to the database in the application package
		NSString *databasePathFromApp = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:fileName];
	
		// Copy the database from the package to the users filesystem
		[fileManager copyItemAtPath:databasePathFromApp toPath: self.databasePath error:nil];
	
		[fileManager release];
	}
	
	return self;
}

- (void)connect {	
	sqlite3_open([self.databasePath UTF8String], &database);
}

- (void)disconnect {
	sqlite3_close(self.database);
}

@end
