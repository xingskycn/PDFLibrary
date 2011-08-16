//
//  RequestCopyController.h
//  PDFLibrary
//
//  Created by Gonzalo Aizpun on 7/18/11.
//  Copyright 2011 TheAppMaster. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HomeController.h"
#import "ContactController.h"
#import "LibraryController.h"
#import "CategoryController.h"

#import "FieldDAO.h"
#import "Field.h"

@interface RequestCopyController : UIViewController<UIGestureRecognizerDelegate> {
    IBOutlet UIButton * btnPopoverCategories;
    IBOutlet UIButton * btnPopoverLanguages;
    IBOutlet UIButton * btnSendHardCopy;
    
    IBOutlet UIView * landscape;
    IBOutlet UIView * portrait;

    IBOutlet UIButton * btnPopoverCategoriesLandscape;
    IBOutlet UIButton * btnPopoverLanguagesLandscape;
    IBOutlet UIButton * btnSendHardCopyLandscape;
    
    IBOutlet UITextField * txtName;
    IBOutlet UITextField * txtCompany;
    IBOutlet UITextField * txtMail;
    IBOutlet UITextField * txtPhone;
    IBOutlet UITextField * txtStreet1;
    IBOutlet UITextField * txtStreet2;
    IBOutlet UITextField * txtCity;
    IBOutlet UITextField * txtState;
    IBOutlet UITextField * txtZip;
    IBOutlet UITextField * txtCountry;
    IBOutlet UITextView * txtMessage;
    
    
    IBOutlet UITextField * txtNameLandscape;
    IBOutlet UITextField * txtCompanyLandscape;
    IBOutlet UITextField * txtMailLandscape;
    IBOutlet UITextField * txtPhoneLandscape;
    IBOutlet UITextField * txtStreet1Landscape;
    IBOutlet UITextField * txtStreet2Landscape;
    IBOutlet UITextField * txtCityLandscape;
    IBOutlet UITextField * txtStateLandscape;
    IBOutlet UITextField * txtZipLandscape;
    IBOutlet UITextField * txtCountryLandscape;
    IBOutlet UITextView * txtMessageLandscape;
    
    
    IBOutlet UILabel * lblTextField1Portrait;
    IBOutlet UILabel * lblTextField2Portrait;
    IBOutlet UILabel * lblTextField3Portrait;
    IBOutlet UILabel * lblTextField4Portrait;
    IBOutlet UILabel * lblTextField5Portrait;
    IBOutlet UILabel * lblTextField6Portrait;
    IBOutlet UILabel * lblTextField7Portrait;
    IBOutlet UILabel * lblTextField8Portrait;
    IBOutlet UILabel * lblTextField9Portrait;
    IBOutlet UILabel * lblTextField10Portrait;
    IBOutlet UILabel * lblTextField11Portrait;    
    IBOutlet UILabel * lblTextFieldSendCopyPortrait;
    IBOutlet UILabel * lblTextFieldMailingAddressPortrait;
    
    IBOutlet UILabel * lblTextField1Landscape;
    IBOutlet UILabel * lblTextField2Landscape;
    IBOutlet UILabel * lblTextField3Landscape;
    IBOutlet UILabel * lblTextField4Landscape;
    IBOutlet UILabel * lblTextField5Landscape;
    IBOutlet UILabel * lblTextField6Landscape;
    IBOutlet UILabel * lblTextField7Landscape;
    IBOutlet UILabel * lblTextField8Landscape;
    IBOutlet UILabel * lblTextField9Landscape;
    IBOutlet UILabel * lblTextField10Landscape;
    IBOutlet UILabel * lblTextField11Landscape;    
    IBOutlet UILabel * lblTextFieldSendCopyLandscape;
    IBOutlet UILabel * lblTextFieldMailingAddressLandscape;
}

@property (nonatomic,retain) IBOutlet UIView* landscape;
@property (nonatomic,retain) IBOutlet UIView* portrait;


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


// RequestCopy Actions
- (IBAction) btnSendPressed;
- (IBAction) btnSendCopyPressed;


@end
