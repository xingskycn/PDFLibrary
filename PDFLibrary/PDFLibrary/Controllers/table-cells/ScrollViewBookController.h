//
//  ScrollViewDocumentController.h
//  PDFLibrary
//
//  Created by Marcelo German De Luca on 30/08/11.
//  Copyright 2011 TheAppMaster. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Document.h"

@protocol DocumentCommonCellDelegate<NSObject>
- (void)goToDocument:(Document *)document;
- (void)removeFromLibrary:(Document *)document;
@end

@interface ScrollViewBookController : UIViewController {
    
    IBOutlet UIButton * btnDescription;
    IBOutlet UIButton * btnTitle;
    IBOutlet UIButton * btnLastUpdateTitle;
    IBOutlet UIButton * btnLastUpdateValue;
    IBOutlet UIButton * btnSubtitlesAvailablesTitle;
    IBOutlet UIButton * btnThumbail;
    IBOutlet UIButton * btnFeatured;
    IBOutlet UIButton * btnMyLibrary;
    IBOutlet UIButton * btnCaseStudy;
    
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

@property (nonatomic, retain) Document * document;
@property (nonatomic, retain) id delegate;

- (id)initWithDocument:(Document*)doc:(BOOL)hideLibrary;
- (IBAction)btnDocumentPressed;
- (IBAction)btnRemoveMyLibraryPressed;
- (void)updateFields;
- (void)updateFieldsForLibrary;


@end
