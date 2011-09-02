//
//  HomeController.h
//  PDFLibrary
//
//  Created by Gonzalo Aizpun on 7/18/11.
//  Copyright 2011 TheAppMaster. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TenarisViewController.h"
#import "ScrollViewDocumentCommonController.h"
#import "ServiceManager.h"
#import "ServiceImage.h"
#import "Document.h"
#import "DocumentDAO.h"
#import "DocumentCommonCell.h"


@interface HomeController : TenarisViewController<UIGestureRecognizerDelegate, ServiceManagerDelegate, DocumentCommonCellDelegate> {

    Document * document;
    IBOutlet UIView * viewForFeaturedPortrait;
    IBOutlet UIView * viewForFeaturedLandscape;
}

- (void)loadCategories;

@end
