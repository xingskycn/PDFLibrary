//
//  PDFLibraryAppDelegate.h
//  PDFLibrary
//
//  Created by Gonzalo Aizpun on 7/18/11.
//  Copyright 2011 TheAppMaster. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeController.h"
#import "StartUpController.h"
#import "DBManager.h"

@class StockControllerViewController;
@class StartUpController;
@class HomeController;

@interface PDFLibraryAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    
	StartUpController* startUpController;
    HomeController* homeViewController;
	UIViewController* rootController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet StartUpController* startUpController;
@property (nonatomic, retain) IBOutlet HomeController* homeViewController;
@property (nonatomic, retain) IBOutlet UIViewController* rootController;

- (void)showRootController; 
@end
