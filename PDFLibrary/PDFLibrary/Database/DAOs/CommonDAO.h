//
//  CommonDAO.h
//  WorldCup
//
//  Created by Tomas on 13/04/10.
//  Copyright 2010 TheAppMaster. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DBManager.h"

@interface CommonDAO : NSObject {

}

+ (sqlite3*)database;
@end
