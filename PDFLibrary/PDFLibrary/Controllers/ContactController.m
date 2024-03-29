//
//  ContactController.m
//  PDFLibrary
//
//  Created by Gonzalo Aizpun on 7/18/11.
//  Copyright 2011 TheAppMaster. All rights reserved.
//

#import "ContactController.h"
#import "MessageDAO.h"
#import "Message.h"
#import "FieldDAO.h"
#import "Field.h"

@implementation ContactController

bool is_portrait = false;
bool copyPressed = NO;

- (void)setOrientation {
    
    UIDeviceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    
    is_portrait = UIInterfaceOrientationIsPortrait(orientation);
    
    if(is_portrait) {
        self.view = portrait;
        self.indicatorController = [[IndicatorController alloc] 
                                    initWithNibName:@"IndicatorControllerPortrait" bundle:nil];
    } else {
        self.view = landscape;
        self.indicatorController = [[IndicatorController alloc] 
                                    initWithNibName:@"IndicatorControllerLandscape" bundle:nil];
    }
}

- (void)cleanFormResult {
    
    lblMessageResultLandscape.text = @"";
    lblMessageResultPortrait.text  = @"";
    
    for(UIView * view in self.view.subviews){
        if([view isKindOfClass:[UIImageView class]] && view.tag > 100) {
            ((UIImageView*)view).hidden=YES;
        }
    }
}

- (void)setMessagesFromDatabase {
    
    NSArray * items = [MessageDAO getMessagesForForm:1];
    for (Message * message in items) {
        
        switch (message.id) {
                
            case 1:
                messageSuccess    = message.value;
                break;
            case 2:
                messageIncomplete = message.value;
                break;
            case 3:
                messageFailure    = message.value;
                break;
        }
        
    }
    
}

- (void)setFormLabelsFromDatabase {

    NSArray * items = [FieldDAO getFieldsForForm:1];

    for (Field * field in items) {
        switch (field.id) {
            case 1:
                lblTextField1Landscape.text = field.value;
                lblTextField1Portrait.text = field.value;
                break;
            case 2:
                lblTextField2Landscape.text = field.value;
                lblTextField2Portrait.text = field.value;
                break;
            case 3:
                lblTextField3Landscape.text = field.value;
                lblTextField3Portrait.text = field.value;
                break;
            case 4:
                lblTextField4Landscape.text = field.value;
                lblTextField4Portrait.text = field.value;
                break;
            case 5:
                lblTextFieldSendCopyLandscape.text = field.value;
                lblTextFieldSendCopyPortrait.text = field.value;
                break;
            case 6:
                lblTextField5Landscape.text = field.value;
                lblTextField5Portrait.text = field.value;
                break; 
            case 7:
                [btnSendLandscape setTitle:field.value forState:UIControlStateNormal];
                [btnSend setTitle:field.value forState:UIControlStateNormal];
                break;               
            default:
                break;
        }
    }
    
}



- (void)viewWillAppear:(BOOL)animated {
    
    [self setOrientation];
    [self setFormLabelsFromDatabase];
    [self setMessagesFromDatabase];
    [self cleanFormResult];
    [self setMenuControllers];    
    [self setGestureRecognizer:self];    
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch 
{
    [self hideMenu];
    return YES;
}



// *************************************************

- (BOOL)fieldsCompleted {

    if (is_portrait) {
        return ([txtName.text    length] && [txtCompany.text length] && 
                [txtEmail.text   length] && [txtPhone.text   length] && 
                [txtMessage.text length]); 
    } 
    
    return ([txtNameLandscape.text  length] && [txtCompanyLandscape.text length] &&
            [txtEmailLandscape.text length] && [txtPhoneLandscape.text length] && 
            [txtMessageLandscape.text length]);

}


- (void)showIncompleteMessage {
    
    lblMessageResultPortrait.text  = messageIncomplete;
    lblMessageResultLandscape.text = messageIncomplete;
    
}

- (void)showIncompleteFields {
    
    [self cleanFormResult];
    int i=0;
    
    for(UIView * view in self.view.subviews){
        
        if([view isKindOfClass:[UIImageView class]] && view.tag > 100) {
            
            UITextField * field = (UITextField *) [self.view viewWithTag:(view.tag - 100)];
            if (![field.text length]) {
                ((UIImageView*)view).hidden = NO;
                i++;
            }
            
        }
    }
    

    if(i==5) {
        // All Fields are incomplete! Typical case when user rotate after view loaded
        [self cleanFormResult];
    } else {
        [self showIncompleteMessage];
    }
    
}



- (IBAction) btnSendPressed {
    
    [self touchesBegan:nil withEvent:nil];
    
    if (![self fieldsCompleted]) {
        [self showIncompleteFields];
        return;
    }
    
    NSMutableDictionary * arguments = [[NSMutableDictionary alloc] init];
    
    if(is_portrait) {
        [arguments setValue:txtName.text        forKey:@"Name"];
        [arguments setValue:txtCompany.text     forKey:@"Company"];
        [arguments setValue:txtEmail.text       forKey:@"Email"];
        [arguments setValue:txtPhone.text       forKey:@"Phone"];
        [arguments setValue:txtMessage.text     forKey:@"Message"];
        [arguments setValue:@"Default"          forKey:@"Section"];
    } else {
        [arguments setValue:txtNameLandscape.text       forKey:@"Name"];
        [arguments setValue:txtCompanyLandscape.text    forKey:@"Company"];
        [arguments setValue:txtEmailLandscape.text      forKey:@"Email"];
        [arguments setValue:txtPhoneLandscape.text      forKey:@"Phone"];
        [arguments setValue:txtMessageLandscape.text    forKey:@"Message"];
        [arguments setValue:@"Default"                  forKey:@"Section"];
    }
    
    [self.view addSubview:indicatorController.view];
    [self cleanFormResult];
    
    ServiceManager * serviceManager = [[ServiceManager alloc] init];
    [serviceManager sendFormContact:self arguments:arguments];
}


- (void)serviceSuccess:(NSDictionary * )data {
    
    [self.indicatorController.view removeFromSuperview];
    lblMessageResultPortrait.text  = messageSuccess;
    lblMessageResultLandscape.text = messageSuccess;    
}

- (void)serviceFailed:(NSString * )errorMsg {
    
    [self.indicatorController.view removeFromSuperview];
    lblMessageResultPortrait.text  = messageFailure;
    lblMessageResultLandscape.text = messageFailure;
    
}

// ****************************************

- (IBAction) btnSendCopyPressed {
    
    copyPressed = !copyPressed;
    if(copyPressed) {
        [btnSendCopy setBackgroundImage:[UIImage imageNamed:@"btn-checkbox-on.png"] forState:UIControlStateNormal];
        [btnSendCopyLandscape setBackgroundImage:[UIImage imageNamed:@"btn-checkbox-on.png"] forState:UIControlStateNormal];
    } else {
        [btnSendCopy setBackgroundImage:[UIImage imageNamed:@"btn-checkbox-off.png"] forState:UIControlStateNormal];
        [btnSendCopyLandscape setBackgroundImage:[UIImage imageNamed:@"btn-checkbox-off.png"] forState:UIControlStateNormal];
        
    }
    
}

// *******************************



- (void) willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{  
    is_portrait = UIInterfaceOrientationIsPortrait(toInterfaceOrientation);
    
    if(is_portrait)
    {
        self.view = portrait;
        txtName.text = txtNameLandscape.text;
        txtCompany.text = txtCompanyLandscape.text;
        txtEmail.text = txtEmailLandscape.text;
        txtMessage.text = txtMessageLandscape.text;
        txtPhone.text = txtPhoneLandscape.text;
        
        self.indicatorController = [[IndicatorController alloc] 
                                    initWithNibName:@"IndicatorControllerPortrait" bundle:nil];

        
    }
    else
    {
        self.view = landscape;
        txtNameLandscape.text = txtName.text;
        txtCompanyLandscape.text = txtCompany.text;
        txtEmailLandscape.text = txtEmail.text;
        txtMessageLandscape.text = txtMessage.text;
        txtPhoneLandscape.text = txtPhone.text;  
        
        self.indicatorController = [[IndicatorController alloc] 
                                    initWithNibName:@"IndicatorControllerLandscape" bundle:nil];

    }
    
    [self showIncompleteFields];
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [txtName resignFirstResponder];
    [txtNameLandscape resignFirstResponder];
    [txtCompany resignFirstResponder];
    [txtCompanyLandscape resignFirstResponder];
    [txtEmail resignFirstResponder];
    [txtEmailLandscape resignFirstResponder];
    [txtMessage resignFirstResponder];
    [txtMessageLandscape resignFirstResponder];
    [txtPhone resignFirstResponder];
    [txtPhoneLandscape resignFirstResponder];
    
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text 
{
    if([text isEqualToString:@"\n"]) 
    {
        [txtName resignFirstResponder];
        [txtNameLandscape resignFirstResponder];
        [txtCompany resignFirstResponder];
        [txtCompanyLandscape resignFirstResponder];
        [txtEmail resignFirstResponder];
        [txtEmailLandscape resignFirstResponder];
        [txtMessage resignFirstResponder];
        [txtMessageLandscape resignFirstResponder];
        [txtName resignFirstResponder];
        [txtNameLandscape resignFirstResponder];
        [txtPhone resignFirstResponder];
        [txtPhoneLandscape resignFirstResponder];
        
        [self btnSendPressed];
        
        return NO;
	}
    return YES;
}



- (void) animateTextField: (UITextField*) textField up: (BOOL) up
{
    const int movementDistance = textField.frame.origin.y < 400?textField.frame.origin.y - 30:400;
    const float movementDuration = 0.3f;

    int movement = (up ? -movementDistance : movementDistance);
	
    [UIView beginAnimations: @"anim" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self animateTextField: textField up: YES];
}


- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self animateTextField: textField up: NO];
}


- (void) animateTextView: (UITextView*) textField up: (BOOL) up
{
    int movementDistance = textField.frame.origin.y - 30;
    const float movementDuration = 0.3f;
    
    if(is_portrait)
        movementDistance = textField.frame.origin.y < 265 ? textField.frame.origin.y - 30 : 265;
        
    int movement = (up ? -movementDistance : movementDistance);
	
    [UIView beginAnimations: @"anim" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    [self animateTextView: textView up: YES];
}


- (void)textViewDidEndEditing:(UITextView *)textView
{
    [self animateTextView: textView up: NO];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end
