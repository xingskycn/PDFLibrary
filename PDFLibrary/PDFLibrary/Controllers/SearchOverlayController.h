//
//  SearchOverlayController.h
//  PDFLibrary
//
//  Created by Gonzalo Aizpun on 8/22/11.
//  Copyright 2011 TheAppMaster. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SearchOverlayControllerDelegate <NSObject>
    - (void)doSearch:(NSString *)phrase;
@end

@interface SearchOverlayController : UIViewController<UITextFieldDelegate> {
    
    IBOutlet UIImageView * imgBackground;
    IBOutlet UITextField * txtSearch;
    id delegate;
    
}

- (void)resize:(BOOL)isPortrait;
- (id)initWithDelegate:(id)del;

@end
