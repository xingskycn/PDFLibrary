//
//  DBManager.h
//  WorldCup
//
//  Created by Tomas on 11/04/10.
//  Copyright 2010 TheAppMaster. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "/usr/include/sqlite3.h"

@interface DBManager : NSObject {
	NSString* databasePath;
	sqlite3* database;
}

@property (nonatomic, retain) NSString* databasePath;
@property (nonatomic) sqlite3* database;

- (DBManager*)initWithDatabaseFile:(NSString*)fileName;
- (void)connect;
- (void)disconnect;
+ (DBManager*)getInstance;

@end
