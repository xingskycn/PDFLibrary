//
//  DocumentCommonCell.m
//  PDFLibrary
//
//  Created by Gonzalo Aizpun on 8/28/11.
//  Copyright 2011 TheAppMaster. All rights reserved.
//

#import "DocumentCommonCell.h"


@implementation DocumentCommonCell
@synthesize btnTitle, btnFeatured, btnThumbail, btnDescription, btnLastUpdateTitle, 
            btnLastUpdateValue, btnSubtitlesAvailablesTitle, document, delegate;


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

- (void)updateFields {
    
    [self.btnTitle       setTitle:self.document.title forState:UIControlStateNormal];
    [self.btnDescription setTitle:[self.document.description uppercaseString] forState:UIControlStateNormal];
    [self.btnLastUpdateValue setTitle:[self formatDate:self.document.updateDate] forState:UIControlStateNormal];
    
    if (document.categoryFeatured || document.mainScreenFeatured) {
        self.btnFeatured.hidden = NO;
    } else {
        self.btnFeatured.hidden = YES;
    }
    
}


- (IBAction)btnDocumentPressed {
    
    [delegate goToDocument:self.document];
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
