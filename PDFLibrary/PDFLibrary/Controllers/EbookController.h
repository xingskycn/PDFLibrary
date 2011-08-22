//
//  EbookController.h
//  PDFLibrary
//
//  Created by Gonzalo Aizpun on 7/18/11.
//  Copyright 2011 TheAppMaster. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TenarisViewController.h"

#import <MessageUI/MessageUI.h>

@class MFDocumentManager;
@interface EbookController : TenarisViewController<UIGestureRecognizerDelegate, 
                                              MFMailComposeViewControllerDelegate> {

    MFMailComposeViewController* mailController;

}

// Ebook Actions
- (IBAction) btnRequestCopyPressed;
- (IBAction) actionOpenPlainDocument:(id)sender;;
- (IBAction) btnSendByMail:(id)sender;

@end
