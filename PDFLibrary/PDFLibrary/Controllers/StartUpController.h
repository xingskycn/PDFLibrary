//
//  StartUpController.h
//  Mundial
//
//  Created by Tomas on 28/03/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface StartUpController : UIViewController <UIAlertViewDelegate>{
	NSTimer* timer;
    IBOutlet UIView * portrait;
    
    IBOutlet UIImageView* imgLand;
    IBOutlet UIImageView* imgPor;
}

@property (nonatomic,retain) NSTimer* timer;
@property (nonatomic,retain) IBOutlet UIView* portrait;
@property (nonatomic,retain) IBOutlet UIImageView* imgLand;
@property (nonatomic,retain) IBOutlet UIImageView* imgPor;

- (void)changeIntroView;
- (void)fadedInAppIntro:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context;
- (void)doStartUp;

@end

