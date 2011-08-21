//
//  MenuLanguageController.h
//  PDFLibrary
//
//  Created by Gonzalo Aizpun on 8/21/11.
//  Copyright 2011 TheAppMaster. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LanguageCell.h"
#import "LanguageHeaderCell.h"
#import "LanguageFooterCell.h"

#import "LanguageDAO.h"
#import "Language.h"

@interface MenuLanguageController : UIViewController<UITableViewDelegate> {
    
    IBOutlet UITableView * languageTableView;
    NSArray * itemList;
    
}

@end
