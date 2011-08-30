//
//  EbookController.m
//  PDFLibrary
//
//  Created by Gonzalo Aizpun on 7/18/11.
//  Copyright 2011 TheAppMaster. All rights reserved.
//

#import "EbookController.h"
#import "RequestCopyController.h"

#import "MFDocumentManager.h"
#import "ReaderViewController.h"

#import "DocumentDAO.h"

@implementation EbookController
@synthesize document;

- (void)viewWillAppear:(BOOL)animated
{
    UIDeviceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    
    BOOL isPortrait = UIInterfaceOrientationIsPortrait(orientation);
    
    if(!isPortrait) {
        self.view = landscape;
    } else {
        self.view = portrait;
    }
    
    [self setMenuControllers];    
    [self setGestureRecognizer:self];    
}

- (IBAction) btnRequestCopyPressed {
    
    RequestCopyController * controller = [[RequestCopyController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
    [controller release];
    
}

- (IBAction) btnSendByMail:(id)sender
{
    if(![MFMailComposeViewController canSendMail])
    {
        UIAlertView* loadingAlert = [[UIAlertView alloc] initWithTitle:nil message:@"There is no configured mail account." delegate:self 
                                                     cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [loadingAlert show];
		[loadingAlert release];  
        return;
    }
    
	mailController = [[MFMailComposeViewController alloc] init];
	mailController.mailComposeDelegate = self;
	mailController.navigationBar.barStyle = UIBarStyleBlack;
	[mailController setSubject:@"Tenaris Library"];
    
    NSString *documentName = @"Wedge_Brochure";
    NSString *pdfPath = [[NSBundle mainBundle] pathForResource:documentName ofType:@"pdf"];
    NSData *pdfData = [NSData dataWithContentsOfFile:pdfPath];
    [mailController addAttachmentData:pdfData mimeType:@"application/pdf" fileName:documentName];
	
	[self presentModalViewController:mailController animated:YES];
	
}


// ******************************************


- (void)dealloc
{
    [mailController release];
    [super dealloc];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
}


- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch 
{
    [self hideMenu];    
    return YES;
}


- (void) willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    if(!UIInterfaceOrientationIsPortrait(toInterfaceOrientation)) {
        self.view = landscape;
    } else {
        self.view = portrait;
    }
}

- (IBAction) btnUpdateLibraryPressed {
    
    // BOOL shouldAdd = !self.document.inLibrary;

    // replace this line with the commented line (Domain Document should have the new attribute ex. inLibrary)
    BOOL shouldAdd = YES; 
    
    [DocumentDAO updateLibraryStatus:shouldAdd forDocument:self.document.id];
    
    NSString * strFilename = shouldAdd ? @"btn-my-library-off.png" : @"btn-my-library.png";
    [btnUpdateLibrary setBackgroundImage:[UIImage imageNamed:strFilename] forState:UIControlStateNormal];
    
    
    // Remove commented line when Domain Document have the new attribute ex. inLibrary
    // self.document.inLibrary = !self.document.inLibrary;
}


// ***************************************************

-(IBAction)actionOpenPlainDocument:(id)sender  {
    
    NSString *documentName = @"Wedge_Brochure";
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);

    NSString *thumbnailsPath = [[paths objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",documentName]];
    
    NSURL *documentUrl = [NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:documentName ofType:@"pdf"]];
    
    MFDocumentManager *documentManager = [[MFDocumentManager alloc]initWithFileUrl:documentUrl];
    
    ReaderViewController *pdfViewController = [[ReaderViewController alloc]initWithDocumentManager:documentManager];
    
    documentManager.resourceFolder = thumbnailsPath;

    pdfViewController.documentId = documentName;    
    pdfViewController.searchBarButtonItem.enabled = FALSE;
    

    [self presentModalViewController:pdfViewController animated:YES];
    [pdfViewController release];
    
}


-(void)mailComposeController:(MFMailComposeViewController*)controller 
       didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error {
    
	[self dismissModalViewControllerAnimated:TRUE];
}

@end
