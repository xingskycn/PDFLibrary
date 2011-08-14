//
//  RequestCopyController.m
//  PDFLibrary
//
//  Created by Gonzalo Aizpun on 7/18/11.
//  Copyright 2011 TheAppMaster. All rights reserved.
//

#import "RequestCopyController.h"


@implementation RequestCopyController
@synthesize portrait, landscape;
bool hardCopyPressed = NO;
bool isPortrait = false;

- (void)viewWillAppear:(BOOL)animated
{
    UIDeviceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    
    /*
     if (orientation == UIDeviceOrientationUnknown || orientation == UIDeviceOrientationFaceUp 
     || orientation == UIDeviceOrientationFaceDown)
     [[UIDevice currentDevice] setOrientation:UIInterfaceOrientationLandscapeLeft];
     */
    
    
    isPortrait = UIInterfaceOrientationIsPortrait(orientation);
    
    if(!isPortrait)
        self.view = landscape;
    else
        self.view = portrait;
}

- (IBAction) btnSendPressed {
    [[[[UIAlertView alloc] initWithTitle:@"TODO" message:@"Send Tapped. Request WebService" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil] autorelease] show]; 
}

- (IBAction) btnSendCopyPressed {
    hardCopyPressed = !hardCopyPressed;
    if(hardCopyPressed) {
        [btnSendHardCopy setBackgroundImage:[UIImage imageNamed:@"btn-checkbox-on.png"] forState:UIControlStateNormal];
        [btnSendHardCopyLandscape setBackgroundImage:[UIImage imageNamed:@"btn-checkbox-on.png"] forState:UIControlStateNormal];        
    } else {
        [btnSendHardCopy setBackgroundImage:[UIImage imageNamed:@"btn-checkbox-off.png"] forState:UIControlStateNormal];
        [btnSendHardCopyLandscape setBackgroundImage:[UIImage imageNamed:@"btn-checkbox-off.png"] forState:UIControlStateNormal];        
    }
}

// **********************************************

- (IBAction) btnHomePressed {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction) btnCategoriesPressed {
    btnPopoverCategories.hidden = NO; 
    btnPopoverCategoriesLandscape.hidden = NO;
}

- (IBAction) btnLanguagesPressed {
    btnPopoverLanguages.hidden = NO; 
    btnPopoverLanguagesLandscape.hidden = NO;
}

- (IBAction) btnMyLibraryPressed {

    LibraryController * controller = [[LibraryController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
    [controller release];

}

- (IBAction) btnContactPressed {

    ContactController * controller = [[ContactController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
    [controller release];

}

- (IBAction) btnSearchPressed {
    [[[[UIAlertView alloc] initWithTitle:@"TODO" message:@"Search Tapped. Load SearchController" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil] autorelease] show];    
}

- (IBAction) btnCategoryPressed:(id)sender {
   // int index = [(UIButton *)sender tag];
    [[[[UIAlertView alloc] initWithTitle:@"TODO" message:@"Category Tapped. Load CategoryController" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil] autorelease] show];
}

- (IBAction) btnPopoverLanguagesPressed {
    
    FiltersController * controller = [[FiltersController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
    [controller release];
   
}

- (IBAction) btnPopoverCategoriesPressed {
    
    CategoryController * controller = [[CategoryController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
    [controller release];

}

- (IBAction) btnBackPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


// ********************************

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [portrait release];
    [landscape release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{ 
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    btnPopoverLanguages.hidden = YES;
    btnPopoverCategories.hidden = YES;
    btnPopoverLanguagesLandscape.hidden = YES;
    btnPopoverCategoriesLandscape.hidden = YES;
    
    UIGestureRecognizer *recognizer;
    recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self   action:@selector(doubleTapMethod)];
    [(UITapGestureRecognizer *)recognizer setNumberOfTapsRequired:2];
    [self.view addGestureRecognizer:recognizer];
    recognizer.delegate = self;
    [recognizer release];
}


- (void)doubleTapMethod
{
    btnPopoverCategories.hidden = YES;
    btnPopoverLanguages.hidden = YES;      
    btnPopoverLanguagesLandscape.hidden = YES;
    btnPopoverCategoriesLandscape.hidden = YES;
}


- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch 
{
    btnPopoverCategories.hidden = YES;
    btnPopoverLanguages.hidden = YES;
    btnPopoverLanguagesLandscape.hidden = YES;
    btnPopoverCategoriesLandscape.hidden = YES;
    
    return YES;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

- (void) willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    isPortrait = UIInterfaceOrientationIsPortrait(toInterfaceOrientation);
    
    if(isPortrait)
    {
        self.view = portrait;
        txtName.text = txtNameLandscape.text;
        txtCompany.text = txtCompanyLandscape.text;
        txtMail.text = txtMailLandscape.text;
        txtPhone.text = txtPhoneLandscape.text;
        txtStreet1.text = txtStreet1Landscape.text;
        txtStreet2.text = txtStreet2Landscape.text;
        txtCity.text = txtCityLandscape.text;
        txtState.text = txtStateLandscape.text;
        txtZip.text = txtZipLandscape.text;
        txtCountry.text = txtCountryLandscape.text;
        txtMessage.text = txtMessageLandscape.text;
    }
    else
    {
        self.view = landscape;
        txtNameLandscape.text = txtName.text;
        txtCompanyLandscape.text = txtCompany.text;
        txtMailLandscape.text = txtMail.text;
        txtPhoneLandscape.text = txtPhone.text;  
        txtStreet1Landscape.text = txtStreet1.text;
        txtStreet2Landscape.text = txtStreet2.text;
        txtCityLandscape.text = txtCity.text;
        txtStateLandscape.text = txtState.text;
        txtZipLandscape.text = txtZip.text;
        txtCountryLandscape.text = txtCountry.text;
        txtMessageLandscape.text = txtMessage.text;        
    }
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [txtName resignFirstResponder];
    [txtCompany resignFirstResponder];
    [txtMail resignFirstResponder];
    [txtPhone resignFirstResponder];
    [txtStreet1 resignFirstResponder];
    [txtStreet2 resignFirstResponder];
    [txtCity resignFirstResponder];
    [txtState resignFirstResponder];
    [txtZip resignFirstResponder];
    [txtCountry resignFirstResponder];
    [txtMessage resignFirstResponder];
    
    [txtNameLandscape resignFirstResponder];
    [txtCompanyLandscape resignFirstResponder];
    [txtMailLandscape resignFirstResponder];
    [txtPhoneLandscape resignFirstResponder];
    [txtStreet1Landscape resignFirstResponder];
    [txtStreet2Landscape resignFirstResponder];
    [txtStateLandscape resignFirstResponder];
    [txtCityLandscape resignFirstResponder];
    [txtZipLandscape resignFirstResponder];
    [txtCountryLandscape resignFirstResponder];
    [txtMessageLandscape resignFirstResponder];
    
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text 
{
    if([text isEqualToString:@"\n"]) 
    {
        [[[[UIAlertView alloc] initWithTitle:@"TODO" message:@"Validate Form and Send" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil] autorelease] show];  
    
        [txtName resignFirstResponder];
        [txtCompany resignFirstResponder];
        [txtMail resignFirstResponder];
        [txtPhone resignFirstResponder];
        [txtStreet1 resignFirstResponder];
        [txtStreet2 resignFirstResponder];
        [txtCity resignFirstResponder];
        [txtState resignFirstResponder];
        [txtZip resignFirstResponder];
        [txtCountry resignFirstResponder];
        [txtMessage resignFirstResponder];
    
        [txtNameLandscape resignFirstResponder];
        [txtCompanyLandscape resignFirstResponder];
        [txtMailLandscape resignFirstResponder];
        [txtPhoneLandscape resignFirstResponder];
        [txtStreet1Landscape resignFirstResponder];
        [txtStreet2Landscape resignFirstResponder];
        [txtStateLandscape resignFirstResponder];
        [txtCityLandscape resignFirstResponder];
        [txtZipLandscape resignFirstResponder];
        [txtCountryLandscape resignFirstResponder];
        [txtMessageLandscape resignFirstResponder];
        
        return NO;
	}
    return YES;
}



- (void) animateTextField: (UITextField*) textField up: (BOOL) up
{
    
    int movementDistance;
    const float movementDuration = 0.3f;
    
    if(isPortrait)
        movementDistance = textField.frame.origin.y < 265 ? textField.frame.origin.y - 30 : 265;
    else
        movementDistance = textField.frame.origin.y < 350 ? textField.frame.origin.y - 30 : 350;

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
    
    int movementDistance;
    const float movementDuration = 0.3f;
    
    if(isPortrait)
        movementDistance = textField.frame.origin.y < 265 ? textField.frame.origin.y - 30 : 265;
    else
        movementDistance = textField.frame.origin.y < 350 ? textField.frame.origin.y - 30 : 350;
    
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

@end
