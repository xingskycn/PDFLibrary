//
//  CommonDAO.m
//  WorldCup
//
//  Created by Tomas on 13/04/10.
//  Copyright 2010 TheAppMaster. All rights reserved.
//

#import "CommonDAO.h"

@implementation CommonDAO

+ (sqlite3*)database {
	return [[DBManager getInstance] database];
}

@end
