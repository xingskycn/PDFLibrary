//
//  ContactController.h
//  PDFLibrary
//
//  Created by Gonzalo Aizpun on 7/18/11.
//  Copyright 2011 TheAppMaster. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeController.h"
#import "EbookController.h"
#import "LibraryController.h"
#import "CategoryController.h"
#import "IndicatorController.h"

#import "ServiceManager.h"

#import "FieldDAO.h"
#import "Field.h"

@interface ContactController : UIViewController<UIGestureRecognizerDelegate, ServiceManagerDelegate> {

    IBOutlet UIButton * btnPopoverCategories;
    IBOutlet UIButton * btnPopoverLanguages;
    IBOutlet UITextView * txtMessage;
    IBOutlet UITextField * txtName;
    IBOutlet UITextField * txtCompany;
    IBOutlet UITextField * txtEmail;
    IBOutlet UITextField * txtPhone;
    IBOutlet UIButton * btnSendCopy;
    IBOutlet UIButton * btnSend;
    
    IBOutlet UIView * landscape;
    IBOutlet UIView * portrait;
    
    IBOutlet UIButton * btnPopoverCategoriesLandscape;
    IBOutlet UIButton * btnPopoverLanguagesLandscape;
    IBOutlet UITextView * txtMessageLandscape;
    IBOutlet UITextField * txtNameLandscape;
    IBOutlet UITextField * txtCompanyLandscape;
    IBOutlet UITextField * txtEmailLandscape;
    IBOutlet UITextField * txtPhoneLandscape;
    IBOutlet UIButton * btnSendCopyLandscape;
    IBOutlet UIButton * btnSendLandscape;
    
    IBOutlet UILabel * lblTextField1Portrait;
    IBOutlet UILabel * lblTextField2Portrait;
    IBOutlet UILabel * lblTextField3Portrait;
    IBOutlet UILabel * lblTextField4Portrait;
    IBOutlet UILabel * lblTextField5Portrait;
    IBOutlet UILabel * lblTextFieldSendCopyPortrait;
    
    IBOutlet UILabel * lblTextField1Landscape;
    IBOutlet UILabel * lblTextField2Landscape;
    IBOutlet UILabel * lblTextField3Landscape;
    IBOutlet UILabel * lblTextField4Landscape;
    IBOutlet UILabel * lblTextField5Landscape;
    IBOutlet UILabel * lblTextFieldSendCopyLandscape;
    
    IndicatorController * indicatorController;

}

@property (nonatomic, retain) IBOutlet UIView* landscape;
@property (nonatomic, retain) IBOutlet UIView* portrait;
@property (nonatomic, retain) IndicatorController * indicatorController;

- (IBAction) btnHomePressed;
- (IBAction) btnCategoriesPressed;
- (IBAction) btnLanguagesPressed;
- (IBAction) btnMyLibraryPressed;
- (IBAction) btnContactPressed;
- (IBAction) btnSearchPressed;
- (IBAction) btnCategoryPressed:(id)sender;
- (IBAction) btnPopoverLanguagesPressed;
- (IBAction) btnPopoverCategoriesPressed;
- (IBAction) btnBackPressed:(id)sender;

// ContactActions
- (IBAction) btnSendPressed;
- (IBAction) btnSendCopyPressed;

@end
