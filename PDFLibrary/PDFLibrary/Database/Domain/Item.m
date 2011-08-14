//
//  Item.m
//  StockController
//
//  Created by Marcelo German De Luca on 03/05/11.
//  Copyright 2011 The App Master. All rights reserved.
//

#import "Item.h"


@implementation Item
@synthesize id, type, explanation, branch, location, item, quantity, unit;

- (void)dealloc {
	[self.type release];
	[self.explanation release];
	[self.branch release];
	[self.location release];
	[self.item release];
	[self.quantity release];
	[self.unit release];
	[super dealloc];
}
@end
