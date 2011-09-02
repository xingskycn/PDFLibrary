//
//  ScrollViewDocumentCommonController.h
//  PDFLibrary
//
//  Created by Gonzalo Aizpun on 8/31/11.
//  Copyright 2011 TheAppMaster. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Document.h"
#import "DocumentCommonCell.h"

@interface ScrollViewDocumentCommonController : UIViewController {
    
    IBOutlet UIButton * btnDescription;
    IBOutlet UIButton * btnTitle;
    IBOutlet UIButton * btnLastUpdateTitle;
    IBOutlet UIButton * btnLastUpdateValue;
    IBOutlet UIButton * btnSubtitlesAvailablesTitle;
    IBOutlet UIButton * btnThumbail;
    IBOutlet UIButton * btnFeatured;
    IBOutlet UIButton * btnMyLibrary;
    IBOutlet UIButton * btnCaseStudy;
    IBOutlet UIButton * btnUpperTitle;
    
    Document * document;
    BOOL hideMyLibrary;
    id delegate; 
}

@property (nonatomic, retain) UIButton * btnDescription;
@property (nonatomic, retain) UIButton * btnTitle;
@property (nonatomic, retain) UIButton * btnLastUpdateTitle;
@property (nonatomic, retain) UIButton * btnLastUpdateValue;
@property (nonatomic, retain) UIButton * btnSubtitlesAvailablesTitle;
@property (nonatomic, retain) UIButton * btnThumbail;
@property (nonatomic, retain) UIButton * btnFeatured;
@property (nonatomic, retain) UIButton * btnMyLibrary;
@property (nonatomic, retain) UIButton * btnCaseStudy;
@property (nonatomic, retain) UIButton * btnUpperTitle;

@property (nonatomic, retain) Document * document;
@property (nonatomic, retain) id delegate;

- (id)initWithDocument:(Document*)doc:(BOOL)hideLibrary;
- (IBAction)btnDocumentPressed;
- (IBAction)btnRemoveMyLibraryPressed;
- (void)updateFields;
- (void)updateFieldsForLibrary;

@end
