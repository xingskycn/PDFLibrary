//
//  PDFLibraryAppDelegate.m
//  PDFLibrary
//
//  Created by Gonzalo Aizpun on 7/18/11.
//  Copyright 2011 TheAppMaster. All rights reserved.
//

#import "PDFLibraryAppDelegate.h"
#import "HomeController.h"
#import "StartUpController.h"

@implementation PDFLibraryAppDelegate

@synthesize window;
@synthesize startUpController;
@synthesize rootController;
@synthesize homeViewController;

// Override point for customization after app launch  
- (void)applicationDidFinishLaunching:(UIApplication *)application {    
    
    //[[[DBManager getInstance] initWithDatabaseFile: @"Unav_v1.0.sql"] connect];
    
    // Override point for customization after app launch.
    [self.window addSubview:startUpController.view];
    [self.window makeKeyAndVisible];
    
}

- (void)application:(UIApplication *)app didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken { 
}


- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
}

- (void)application:(UIApplication *)app didFailToRegisterForRemoteNotificationsWithError:(NSError *)err { 
}

- (void) applicationDidEnterBackground:(UIApplication *)application {
    exit(EXIT_SUCCESS);
}

- (void)applicationWillTerminate:(UIApplication *)application {
	// Save data if appropriate
	//[[DBManager getInstance] disconnect];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    
    return UIInterfaceOrientationIsPortrait(interfaceOrientation);
}

- (void)dealloc {
    [rootController release];
    [homeViewController release];
	[startUpController release];
	[window release];
	[super dealloc];
}

- (void)showRootController {
	[startUpController.view removeFromSuperview];
    [window addSubview:rootController.view];	
}
@end
