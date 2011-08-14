//
//  ItemDAO.h
//  StockController
//
//  Created by Marcelo German De Luca on 03/05/11.
//  Copyright 2011 The App Master. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommonDAO.h"
#import "Item.h"

@interface ItemDAO : CommonDAO {
        
}

+ (NSArray*)getItems;

+ (void)updateItem:(NSInteger)id:(NSString*)type:(NSString*)explanation:(NSString*)branch:(NSString*)location:(NSString*)item:(NSString*)quantity;

+ (void)addItem:(NSString*)type:(NSString*)explanation:(NSString*)branch:(NSString*)location:(NSString*)item:(NSString*)quantity: (NSString*)unit;

+ (void)deleteItems;

+ (void)deleteItem:(NSInteger)id;

+ (Item*)getItemById:(NSInteger)id;
@end

