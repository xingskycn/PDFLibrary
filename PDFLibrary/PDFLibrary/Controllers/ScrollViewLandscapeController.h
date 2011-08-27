//
//  ScrollViewLandscapeController.h
//  PDFLibrary
//
//  Created by Marcelo German De Luca on 27/08/11.
//  Copyright 2011 TheAppMaster. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ScrollViewLandscapeController : UIViewController {
 
    NSArray* documents;
}

- (void)initWithDocuments:(NSArray*)docs;

@end
