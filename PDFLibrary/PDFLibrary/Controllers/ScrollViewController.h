//
//  ScrollViewLandscapeController.h
//  PDFLibrary
//
//  Created by Marcelo German De Luca on 27/08/11.
//  Copyright 2011 TheAppMaster. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DocumentCommonCell.h"


@interface ScrollViewController : UIViewController<DocumentCommonCellDelegate> {
    UINavigationController * nav;
    NSArray* documents;
    int pageIndex;
    BOOL hideMyLibrary;
    id delegate;
}

@property (nonatomic, retain)  UINavigationController * nav;


- (id)initWithDocuments:(NSArray*)docs:(int)page:(BOOL)hideLibrary;
@property (nonatomic, retain) id delegate;

@end
