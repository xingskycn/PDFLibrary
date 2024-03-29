//
//  DocumentController.h
//  PDFLibrary
//
//  Created by Gonzalo Aizpun on 7/18/11.
//  Copyright 2011 TheAppMaster. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TenarisViewController.h"
#import "ASIHTTPRequest.h"
#import "Document.h"
#import "Language.h"

#import <MessageUI/MessageUI.h>

@class MFDocumentManager;
@interface DocumentController : TenarisViewController<UIGestureRecognizerDelegate,  MFMailComposeViewControllerDelegate> {

    // *******************************************
    
    MFMailComposeViewController* mailController;
    Document * document;
    
    // *******************************************
                                                  
    IBOutlet UIButton * btnUpdateLibraryLandscape;
    IBOutlet UIButton * btnThumbailLandscape;
    IBOutlet UILabel  * lblTitleLandscape; 
    IBOutlet UILabel  * lblUpperTitleLandscape;
    IBOutlet UILabel  * lblLastUpdateLandscape;
    IBOutlet UITextView  * lblDescriptionLandscape;    
    
    // *******************************************
                                                  
    IBOutlet UIButton * btnUpdateLibraryPortrait;
    IBOutlet UIButton * btnThumbailPortrait;
    IBOutlet UILabel  * lblTitlePortrait; 
    IBOutlet UILabel  * lblUpperTitlePortrait;
    IBOutlet UILabel  * lblLastUpdatePortrait;
    IBOutlet UITextView  * lblDescriptionPortrait;    
    
    // *******************************************
    
	UIProgressView *progressDownload;
    
    Language * language;
}

@property (nonatomic, retain) Document * document;
@property (nonatomic, retain) Language * language;
@property (nonatomic, retain) IBOutlet UIProgressView *progressDownload;

// Ebook Actions
- (void)updateViewFromDocument:(Document *)_document;
- (void)updateViewFromDocument:(Document *)_document andLanguage:(Language *)language;

- (IBAction) btnRequestCopyPressed;
- (IBAction) actionOpenPlainDocument:(id)sender;
- (IBAction) btnSendByMail:(id)sender;
- (IBAction) btnUpdateLibraryPressed;
- (IBAction) btnSelectLanguagePressed:(id)sender;

@end
