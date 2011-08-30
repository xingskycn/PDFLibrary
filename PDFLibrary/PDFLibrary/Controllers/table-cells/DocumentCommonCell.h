//
//  DocumentCommonCell.h
//  PDFLibrary
//
//  Created by Gonzalo Aizpun on 8/28/11.
//  Copyright 2011 TheAppMaster. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Document.h"

#define kDocumentHeightCellSmallBook  70
#define kDocumentHeightCellSmallVideo 70
#define kDocumentHeightCellBigBook    185
#define kDocumentHeightCellBigVideo   175

@protocol DocumentCommonCellDelegate<NSObject>
    - (void)goToDocument:(Document *)document;
    - (void)removeFromLibrary:(Document *)document;
@end

@interface DocumentCommonCell : UITableViewCell {
    
    IBOutlet UIButton * btnDescription;
    IBOutlet UIButton * btnTitle;
    IBOutlet UIButton * btnLastUpdateTitle;
    IBOutlet UIButton * btnLastUpdateValue;
    IBOutlet UIButton * btnSubtitlesAvailablesTitle;
    IBOutlet UIButton * btnThumbail;
    IBOutlet UIButton * btnFeatured;
    IBOutlet UIButton * btnMyLibrary;
    
    Document * document;
    
    id delegate;
    BOOL isBiggerCell;
    
}

@property (nonatomic, retain) UIButton * btnDescription;
@property (nonatomic, retain) UIButton * btnTitle;
@property (nonatomic, retain) UIButton * btnLastUpdateTitle;
@property (nonatomic, retain) UIButton * btnLastUpdateValue;
@property (nonatomic, retain) UIButton * btnSubtitlesAvailablesTitle;
@property (nonatomic, retain) UIButton * btnThumbail;
@property (nonatomic, retain) UIButton * btnFeatured;
@property (nonatomic, retain) UIButton * btnMyLibrary;

@property (nonatomic, retain) Document * document;
@property (nonatomic, retain) id delegate;
@property BOOL isBiggerCell;

- (IBAction)btnDocumentPressed;
- (IBAction)btnRemoveMyLibraryPressed;
- (void)updateFields;
- (void)updateFieldsForLibrary;

@end
