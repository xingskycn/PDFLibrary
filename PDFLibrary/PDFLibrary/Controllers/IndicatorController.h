//
//  IndicatorController.h
//  PDFLibrary
//
//  Created by Marcelo German De Luca on 10/01/11.
//  Copyright 2011 TheAppMaster. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface IndicatorController : UIViewController {

	UIActivityIndicatorView * actIndicatorView;
    UILabel* lblDocument;
    UILabel* lblLibrary;
}

@property (nonatomic, retain) IBOutlet UIActivityIndicatorView * actIndicatorView;
@property (nonatomic, retain) IBOutlet UILabel* lblDocument;
@property (nonatomic, retain) IBOutlet UILabel* lblLibrary;
@end
