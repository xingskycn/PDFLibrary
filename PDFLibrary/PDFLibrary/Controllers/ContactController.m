//
//  ContactController.m
//  PDFLibrary
//
//  Created by Gonzalo Aizpun on 7/18/11.
//  Copyright 2011 TheAppMaster. All rights reserved.
//

#import "ContactController.h"


@implementation ContactController
@synthesize portrait, landscape;

bool is_portrait = false;
bool copyPressed = NO;

- (void)setOrientation {
    UIDeviceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    
    is_portrait = UIInterfaceOrientationIsPortrait(orientation);
    
    if(!is_portrait) {
        self.view = landscape;
    } else {
        self.view = portrait;
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
            default:
                break;
        }
    }
    
}

- (void)viewWillAppear:(BOOL)animated {
    [self setOrientation];
    [self setFormLabelsFromDatabase];
}

// ******************************

- (IBAction) btnSendPressed {
        [[[[UIAlertView alloc] initWithTitle:@"TODO" message:@"Send Tapped. Request WebService" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil] autorelease] show]; 
}

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

- (IBAction) btnHomePressed 
{
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
    // We're on ContactController
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
    is_portrait = UIInterfaceOrientationIsPortrait(toInterfaceOrientation);
    
    if(is_portrait)
    {
        self.view = portrait;
        txtName.text = txtNameLandscape.text;
        txtCompany.text = txtCompanyLandscape.text;
        txtEmail.text = txtEmailLandscape.text;
        txtMessage.text = txtMessageLandscape.text;
        txtPhone.text = txtPhoneLandscape.text;
    }
    else
    {
        self.view = landscape;
        txtNameLandscape.text = txtName.text;
        txtCompanyLandscape.text = txtCompany.text;
        txtEmailLandscape.text = txtEmail.text;
        txtMessageLandscape.text = txtMessage.text;
        txtPhoneLandscape.text = txtPhone.text;  
    }
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
        [[[[UIAlertView alloc] initWithTitle:@"TODO" message:@"Validate Form and Send" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil] autorelease] show];  
    
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

@end
