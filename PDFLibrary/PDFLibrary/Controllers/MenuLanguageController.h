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

@protocol MenuLanguageControllerDelegate <NSObject>
    - (void)menuLanguageTapped:(int)languageId;
@end

@interface MenuLanguageController : UIViewController<UITableViewDelegate> {
    
    IBOutlet UITableView * languageTableView;
    NSArray * itemList;
    id delegate;
    
}

- (id)initWithDelegate:(id)del;

@end
