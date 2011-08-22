//
//  ContactController.h
//  PDFLibrary
//
//  Created by Gonzalo Aizpun on 7/18/11.
//  Copyright 2011 TheAppMaster. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TenarisViewController.h"
#import "ServiceManager.h"

@interface ContactController : TenarisViewController<ServiceManagerDelegate, UIGestureRecognizerDelegate> {
    
    IBOutlet UITextView * txtMessage;
    IBOutlet UITextField * txtName;
    IBOutlet UITextField * txtCompany;
    IBOutlet UITextField * txtEmail;
    IBOutlet UITextField * txtPhone;
    IBOutlet UIButton * btnSendCopy;
    IBOutlet UIButton * btnSend;
    
    IBOutlet UILabel * lblTextField1Portrait;
    IBOutlet UILabel * lblTextField2Portrait;
    IBOutlet UILabel * lblTextField3Portrait;
    IBOutlet UILabel * lblTextField4Portrait;
    IBOutlet UILabel * lblTextField5Portrait;
    IBOutlet UILabel * lblTextFieldSendCopyPortrait;
    IBOutlet UILabel * lblMessageResultPortrait;
    
        
    IBOutlet UITextView * txtMessageLandscape;
    IBOutlet UITextField * txtNameLandscape;
    IBOutlet UITextField * txtCompanyLandscape;
    IBOutlet UITextField * txtEmailLandscape;
    IBOutlet UITextField * txtPhoneLandscape;
    IBOutlet UIButton * btnSendCopyLandscape;
    IBOutlet UIButton * btnSendLandscape;
    
    IBOutlet UILabel * lblTextField1Landscape;
    IBOutlet UILabel * lblTextField2Landscape;
    IBOutlet UILabel * lblTextField3Landscape;
    IBOutlet UILabel * lblTextField4Landscape;
    IBOutlet UILabel * lblTextField5Landscape;
    IBOutlet UILabel * lblTextFieldSendCopyLandscape;
    IBOutlet UILabel * lblMessageResultLandscape;
    
    NSString * messageSuccess;
    NSString * messageFailure;
    NSString * messageIncomplete;
}


// ContactActions
- (IBAction) btnSendPressed;
- (IBAction) btnSendCopyPressed;

@end
