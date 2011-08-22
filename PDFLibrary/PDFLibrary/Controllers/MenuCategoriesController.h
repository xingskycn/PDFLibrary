//
//  MenuCategoriesController.h
//  PDFLibrary
//
//  Created by Gonzalo Aizpun on 8/20/11.
//  Copyright 2011 TheAppMaster. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CategoryCell.h"
#import "CategoryHeaderCell.h"
#import "CategoryFooterCell.h"

#import "CategoryDAO.h"
#import "Category.h"

@protocol MenuCategoriesControllerDelegate <NSObject>
    - (void)menuCategoryTapped:(int)categoryId;
@end

@interface MenuCategoriesController : UIViewController<UITableViewDelegate> {

    IBOutlet UITableView * categoriesTableView;
    NSArray * itemList;
    id delegate;

}

- (id)initWithDelegate:(id)del;

@end
