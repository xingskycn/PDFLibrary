//
//  HomeController.h
//  PDFLibrary
//
//  Created by Gonzalo Aizpun on 7/18/11.
//  Copyright 2011 TheAppMaster. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface HomeController : UIViewController {
    IBOutlet UIButton * btnHome;
    IBOutlet UIButton * btnCategories;
    IBOutlet UIButton * btnLanguages;
    IBOutlet UIButton * btnMyLibrary;
    IBOutlet UIButton * btnContact;
    IBOutlet UIButton * btnSearch;
}

- (IBAction) btnHomePressed;
- (IBAction) btnCategoriesPressed;
- (IBAction) btnLanguagesPressed;
- (IBAction) btnMyLibraryPressed;
- (IBAction) btnContactPressed;
- (IBAction) btnSearchPressed;


@end
