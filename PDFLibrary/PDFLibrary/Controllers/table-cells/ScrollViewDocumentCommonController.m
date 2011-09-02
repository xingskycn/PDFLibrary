//
//  ScrollViewDocumentCommonController.m
//  PDFLibrary
//
//  Created by Gonzalo Aizpun on 8/31/11.
//  Copyright 2011 TheAppMaster. All rights reserved.
//

#import "ScrollViewDocumentCommonController.h"
#import "FileSystem.h"
#import "Language.h"

@implementation ScrollViewDocumentCommonController
@synthesize btnTitle, btnFeatured, btnThumbail, btnDescription, btnLastUpdateTitle, 
btnLastUpdateValue, btnSubtitlesAvailablesTitle, btnMyLibrary,
document, delegate, btnCaseStudy, btnUpperTitle;


- (id)initWithDocument:(Document*)doc:(BOOL)hideLibrary
{
    hideMyLibrary = hideLibrary;
    document = doc;
    return self;
}

- (void)hideSubtitles {
    for (int i=10; i <= 25; i++) {
        UIButton * btn = (UIButton *)[self.view viewWithTag:i];
        if (btn) {
            btn.hidden = YES;
        }
    }
}

- (void)showSubtitles {
    
    int qty = [document.languages count];
    
    if(!qty) {
        return;
    }
    
    // Max items on screen
    if (qty > 15) {
        qty = 15;
    }
    
    // Visible
    for(int i = 0; i < qty; i++) {
        
        Language * language = (Language *)[document.languages objectAtIndex:i];
        
        UIButton * btn = (UIButton *)[self.view viewWithTag:(i + 10)];
        btn.hidden = NO;
        [btn setTitle:language.code forState:UIControlStateNormal];
    }
}

- (void)updateFieldsForLibrary {
    
    [self updateFields];
    [self hideSubtitles];
    
    self.btnMyLibrary.hidden = NO;
    self.btnSubtitlesAvailablesTitle.hidden = YES;
}

- (void)setDocumentImage {
    
    NSString * strImage   = [NSString stringWithFormat:@"%@.png", self.document.code];
    UIImage * imgDocument = [FileSystem getImageFromFileSystem:strImage];
    
    [btnThumbail setImage:imgDocument forState:UIControlStateNormal];
}

- (void)updateFields {
    
    [self hideSubtitles];
    [self showSubtitles];
    [self setDocumentImage];
    
    [self.btnTitle       setTitle:self.document.title       forState:UIControlStateNormal];
    [self.btnUpperTitle  setTitle:self.document.upperTitle  forState:UIControlStateNormal];
    [self.btnDescription setTitle:self.document.description forState:UIControlStateNormal];
    
    [self.btnLastUpdateValue setTitle:[FileSystem formatDate:self.document.updateDate] 
                             forState:UIControlStateNormal];
    
    if (document.categoryFeatured || document.mainScreenFeatured) {
        self.btnFeatured.hidden = NO;
    } else {
        self.btnFeatured.hidden = YES;
    }
    
    if(document.isCaseStudy) {
        btnCaseStudy.hidden = NO;
    }
    
    self.btnMyLibrary.hidden = hideMyLibrary;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self updateFields];
}

- (IBAction)btnDocumentPressed {
    [delegate goToDocument:self.document];
}

- (IBAction)btnRemoveMyLibraryPressed {
    [delegate removeFromLibrary:self.document];
}


- (void)dealloc
{
    [super dealloc];
}

@end
