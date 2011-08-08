//
//  StartUpController.h
//  Mundial
//
//  Created by Tomas on 28/03/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface StartUpController : UIViewController <UIAlertViewDelegate>{
	IBOutlet UIView* devIntroView;
	IBOutlet UIView* appIntroView;
	NSTimer* timer;
}

@property (nonatomic,retain) IBOutlet UIView* devIntroView;
@property (nonatomic,retain) IBOutlet UIView* appIntroView;
@property (nonatomic,retain) NSTimer* timer;

- (void)changeIntroView;
- (void)fadedOutDevIntro:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context;
- (void)fadedInAppIntro:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context;
- (void)doStartUp;

@end

