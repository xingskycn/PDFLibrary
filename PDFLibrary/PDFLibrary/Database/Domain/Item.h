//
//  Item.h
//  StockController
//
//  Created by Marcelo German De Luca on 03/05/11.
//  Copyright 2011 The App Master. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Item: NSObject {
    NSInteger id;
	NSString* type;
	NSString* explanation;
	NSString* branch;
    NSString* location;
	NSString* item;
	NSString* quantity;
    NSString* unit;
}

@property (nonatomic) NSInteger id;
@property (nonatomic,retain) NSString* type;
@property (nonatomic,retain) NSString* explanation;
@property (nonatomic,retain) NSString* branch;
@property (nonatomic,retain) NSString* location;
@property (nonatomic,retain) NSString* item;
@property (nonatomic,retain) NSString* quantity;
@property (nonatomic,retain) NSString* unit;

@end
