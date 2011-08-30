//
//  DocumentCommonCell.m
//  PDFLibrary
//
//  Created by Gonzalo Aizpun on 8/28/11.
//  Copyright 2011 TheAppMaster. All rights reserved.
//

#import "DocumentCommonCell.h"
#import "FileSystem.h"
#import "Language.h"


@implementation DocumentCommonCell
@synthesize btnTitle, btnFeatured, btnThumbail, btnDescription, btnLastUpdateTitle, 
            btnLastUpdateValue, btnSubtitlesAvailablesTitle, btnMyLibrary,
            document, delegate, isBiggerCell;


- (NSString *)formatDate:(NSString *)documentDate {
    NSArray *components = [documentDate componentsSeparatedByString:@"/"];
    NSString * month    = [components objectAtIndex:1];
    NSString *  year    = [components objectAtIndex:2];

    if([month isEqualToString:@"01"]) return [NSString stringWithFormat:@"JAN %@", year];
    if([month isEqualToString:@"02"]) return [NSString stringWithFormat:@"FEB %@", year];
    if([month isEqualToString:@"03"]) return [NSString stringWithFormat:@"MAR %@", year];
    if([month isEqualToString:@"04"]) return [NSString stringWithFormat:@"APR %@", year];
    if([month isEqualToString:@"05"]) return [NSString stringWithFormat:@"MAY %@", year];
    if([month isEqualToString:@"06"]) return [NSString stringWithFormat:@"JUN %@", year];
    if([month isEqualToString:@"07"]) return [NSString stringWithFormat:@"JUL %@", year];
    if([month isEqualToString:@"08"]) return [NSString stringWithFormat:@"AUG %@", year];
    if([month isEqualToString:@"09"]) return [NSString stringWithFormat:@"SEP %@", year];
    if([month isEqualToString:@"10"]) return [NSString stringWithFormat:@"OCT %@", year];
    if([month isEqualToString:@"11"]) return [NSString stringWithFormat:@"NOV %@", year];
    if([month isEqualToString:@"12"]) return [NSString stringWithFormat:@"DEC %@", year];    
    
    return @"";
}

- (void)hideSubtitles {
    for (int i=10; i <= 25; i++) {
        UIButton * btn = (UIButton *)[self viewWithTag:i];
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
        
        UIButton * btn = (UIButton *)[self viewWithTag:(i + 10)];
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
    
    NSString * strNoImage;
    
    if (self.isBiggerCell) {
        strNoImage = self.document.isEbook ? @"table-noimage-big-book.png" : @"table-noimage-big-video.png" ;
    } else {
        strNoImage = self.document.isEbook ? @"table-noimage-small-book.png" : @"table-noimage-small-video.png" ;
    }
    
    NSString * strImage   = [NSString stringWithFormat:@"%@.png", self.document.code];
    UIImage * imgDocument = [FileSystem getImageFromFileSystem:strImage defaultImage:strNoImage];
    
    [btnThumbail setImage:imgDocument forState:UIControlStateNormal];
}

- (void)updateFields {
    
    [self hideSubtitles];
    [self showSubtitles];
    [self setDocumentImage];
    
    [self.btnTitle       setTitle:self.document.title forState:UIControlStateNormal];
    [self.btnDescription setTitle:[self.document.description uppercaseString] forState:UIControlStateNormal];
    [self.btnLastUpdateValue setTitle:[self formatDate:self.document.updateDate] forState:UIControlStateNormal];
    
    if (document.categoryFeatured || document.mainScreenFeatured) {
        self.btnFeatured.hidden = NO;
    } else {
        self.btnFeatured.hidden = YES;
    }

    self.btnMyLibrary.hidden = YES;
    
    
}


- (IBAction)btnDocumentPressed {
    
    [delegate goToDocument:self.document];
}

- (IBAction)btnRemoveMyLibraryPressed {
    [delegate removeFromLibrary:self.document];
}

// ************************************************************

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc
{
    [super dealloc];
}

@end
