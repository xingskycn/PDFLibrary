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
