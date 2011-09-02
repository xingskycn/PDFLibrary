//
//  DocumentController.m
//  PDFLibrary
//
//  Created by Gonzalo Aizpun on 7/18/11.
//  Copyright 2011 TheAppMaster. All rights reserved.
//

#import "DocumentController.h"
#import "RequestCopyController.h"

#import "MFDocumentManager.h"
#import "ReaderViewController.h"

#import "DocumentDAO.h"
#import "LanguageDAO.h"
#import "FileSystem.h"

@implementation DocumentController
@synthesize document, progressDownload, language;


// **************************************************

- (void)hideSubtitles {
    
    for (int i=10; i <= 22; i++) {
        
        UIButton * btnLandscape = (UIButton *)[self.landscape viewWithTag:(i)];
        UIButton * btnPortrait  = (UIButton *)[self.portrait viewWithTag:(i + 13)]; 
        btnLandscape.hidden = YES;
        btnPortrait.hidden  = YES;
        
        [btnLandscape setBackgroundImage:[UIImage imageNamed:@"btn-subtitle-off.png"] 
                      forState:UIControlStateNormal];
        [btnPortrait setBackgroundImage:[UIImage imageNamed:@"btn-subtitle-off.png"] 
                     forState:UIControlStateNormal];
    }
}

- (void)showSubtitles {
    
    int qty = [document.languages count];
    
    if(!qty) {
        return;
    }
    
    // Max items on screen
    if (qty > 13) {
        qty = 13;
    }
    
    // Visible
    for(int i = 0; i < qty; i++) {
        
        Language * currentLanguage = (Language *)[document.languages objectAtIndex:i];
        
        UIButton * btnLandscape = (UIButton *)[self.landscape viewWithTag:(i + 10)];
        UIButton * btnPortrait  = (UIButton *)[self.portrait viewWithTag:(i + 10 + 13)];        
        btnLandscape.hidden = NO;
        btnPortrait.hidden = NO;
        
        [btnLandscape setTitle:currentLanguage.code forState:UIControlStateNormal];
        [btnPortrait  setTitle:currentLanguage.code forState:UIControlStateNormal];        
        
        if(currentLanguage.id == language.id) {
            
            [btnLandscape setBackgroundImage:[UIImage imageNamed:@"btn-subtitle-on.png"] forState:UIControlStateNormal];
            [btnPortrait setBackgroundImage:[UIImage imageNamed:@"btn-subtitle-on.png"] forState:UIControlStateNormal];
        }
    }
    
}

- (IBAction) btnSelectLanguagePressed:(id)sender {
    
    UIDeviceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    BOOL isPortrait = UIInterfaceOrientationIsPortrait(orientation);
    
    UIButton * btn = (UIButton *)sender;
    int tag = btn.tag;
    int index = 0;
    if (isPortrait) {
        index = tag - 23;
    } else {
        index = tag - 10;
    }
    
    language = [self.document.languages objectAtIndex:index];
    
    [self hideSubtitles];
    [self showSubtitles];
    [self actionOpenPlainDocument:nil];
    
}

// *************************************************************


- (void)updateMyLibraryImage:(BOOL)currentStatus {
    
    NSString * strFilename = currentStatus ? @"btn-my-library-off.png" : @"btn-my-library.png";
    [btnUpdateLibraryPortrait  setBackgroundImage:[UIImage imageNamed:strFilename] forState:UIControlStateNormal];
    [btnUpdateLibraryLandscape setBackgroundImage:[UIImage imageNamed:strFilename] forState:UIControlStateNormal];    
}

- (void)updateViewFromDocument:(Document *)_document andLanguage:(Language *)newLanguage {
    
    language = newLanguage;
    [self updateViewFromDocument:_document];
    
}

- (void)updateViewFromDocument:(Document *)_document {
    
    self.document = _document;
    
    lblTitlePortrait.text = self.document.title;
    lblLastUpdatePortrait.text = [FileSystem formatDate:self.document.updateDate];
    lblUpperTitlePortrait.text = self.document.upperTitle;
    lblDescriptionPortrait.text = self.document.description;

    
    lblTitleLandscape.text = self.document.title;
    lblLastUpdateLandscape.text = [FileSystem formatDate:self.document.updateDate];
    lblUpperTitleLandscape.text = self.document.upperTitle;
    lblDescriptionLandscape.text = self.document.description;    
    
    NSString * strFilename = [NSString stringWithFormat:@"%@.png", self.document.code];
    UIImage * imgThumbail = [FileSystem getImageFromFileSystem:strFilename defaultImage:@"img-ebook-big.png"];
    [btnThumbailLandscape setBackgroundImage:imgThumbail forState:UIControlStateNormal];
    [btnThumbailPortrait  setBackgroundImage:imgThumbail forState:UIControlStateNormal];
    
    [self updateMyLibraryImage:self.document.inLibrary];
    
    [self hideSubtitles];
    [self showSubtitles];
}

// *********************************************************


- (void)viewWillAppear:(BOOL)animated
{
    UIDeviceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    
    BOOL isPortrait = UIInterfaceOrientationIsPortrait(orientation);
    
    if(!isPortrait) {
        self.view = landscape;
        self.indicatorController = [[IndicatorController alloc] 
                                    initWithNibName:@"IndicatorControllerLandscape" bundle:nil];  
    } else {
        self.view = portrait;
        self.indicatorController = [[IndicatorController alloc] 
                                    initWithNibName:@"IndicatorControllerPortrait" bundle:nil];   
    }
    
    [self setMenuControllers];    
    [self setGestureRecognizer:self];   
    
    //-----------------------------------------------------------------
    UIProgressView* aProgressView = [[UIProgressView alloc] initWithFrame:CGRectMake(50, 50, 100, 10)];
	aProgressView.progressViewStyle = UIActivityIndicatorViewStyleGray;
	aProgressView.progress= 0.0;
	aProgressView.hidden = TRUE;
	[[self view] addSubview:aProgressView];
	self.progressDownload = aProgressView;
	[aProgressView release];
    
    if(!language) {
        language = [LanguageDAO getLanguageById:3];
    }
    
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
        UIAlertView* loadingAlert = [[UIAlertView alloc] initWithTitle:nil 
                                                         message:@"There is no configured mail account." 
                                                         delegate:self 
                                                         cancelButtonTitle:@"OK"
                                                         otherButtonTitles:nil];
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

-(void)mailComposeController:(MFMailComposeViewController*)controller 
         didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error {
    
	[self dismissModalViewControllerAnimated:TRUE];
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
        self.indicatorController = [[IndicatorController alloc] 
                                    initWithNibName:@"IndicatorControllerLandscape" bundle:nil];  
    } else {
        self.view = portrait;
        self.indicatorController = [[IndicatorController alloc] 
                                    initWithNibName:@"IndicatorControllerPortrait" bundle:nil];   
    }
}

- (IBAction) btnUpdateLibraryPressed {
    
    BOOL shouldAdd = !self.document.inLibrary;

    [DocumentDAO updateLibraryStatus:shouldAdd forDocument:self.document.id];
    
    NSString * strFilename = shouldAdd ? @"btn-my-library-off.png" : @"btn-my-library.png";
    [btnUpdateLibraryPortrait  setBackgroundImage:[UIImage imageNamed:strFilename] forState:UIControlStateNormal];
    [btnUpdateLibraryLandscape setBackgroundImage:[UIImage imageNamed:strFilename] forState:UIControlStateNormal];    
    
    self.document.inLibrary = !self.document.inLibrary;
}


// ***************************************************

-(void)downloadPDF:(NSString *)sourceURL andName:(NSString *)name andLanguage:(NSString*) currentLanguage
{	
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString* documentsDirectory = [paths objectAtIndex:0];
    NSError **error;

    NSString *pdfPath = [documentsDirectory stringByAppendingPathComponent:
                         [NSString stringWithFormat:@"PDFs/%@/%@.pdf", currentLanguage, name]];
    NSString *directory = [documentsDirectory stringByAppendingPathComponent:
                           [NSString stringWithFormat:@"PDFs/%@/", currentLanguage]];
	NSURL *url = [NSURL URLWithString:
                  [NSString stringWithFormat:@"%@/%@/%@.pdf", sourceURL, currentLanguage, name]];
    
    NSFileManager *filemanager = [[NSFileManager alloc]init];
	[filemanager createDirectoryAtPath:directory withIntermediateDirectories:YES attributes:nil error:error];
    
    [filemanager release];
    
    
	ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
	[request setDelegate:self];	
	[request setUseKeychainPersistence:YES];
	[request setDownloadDestinationPath:pdfPath];
	[request setDidFinishSelector:@selector(requestFinished:)];
	[request setDidFailSelector:@selector(requestFailed:)];
	
	// Get the progressview from the mainviewcontroller and set it as the progress delegate.
	[request setDownloadProgressDelegate:self.progressDownload];
	[request setShouldPresentAuthenticationDialog:YES];
	[request setDownloadDestinationPath:pdfPath];
    [request setAllowResumeForFileDownloads:NO]; //set YEs if resume is supported 
	
	[request startAsynchronous];
}

-(void)requestFinished:(ASIHTTPRequest *)request{
	// Hide the progress view.	
	self.progressDownload.hidden = YES;
    [self actionOpenPlainDocument:nil];
    [self.indicatorController.view removeFromSuperview];
}

-(void)requestFailed:(ASIHTTPRequest *)request
{	
    // Hide the progress view.	
	self.progressDownload.hidden = YES;
    
    UIAlertView* loadingAlert = [[UIAlertView alloc] initWithTitle:@"No conection" message:@"Please check your internet connection" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [loadingAlert show];
    [loadingAlert release];
    [self.indicatorController.view removeFromSuperview];
}

-(void)requestStarted:(ASIHTTPRequest *)request{
    [self.view addSubview:indicatorController.view];
    self.indicatorController.lblDocument.hidden = NO;
}

-(IBAction)actionOpenPlainDocument:(id)sender  
{
    NSString* selectedLang = language.code;
 
    if(document.isEbook)
    {
        NSFileManager *fileManager = [[NSFileManager alloc]init];
        NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString* documentsDirectory = [paths objectAtIndex:0];
        NSString *pdfPath = [documentsDirectory stringByAppendingPathComponent:
                             [NSString stringWithFormat:@"PDFs/%@/%@.pdf", selectedLang, document.code]];
	
        if([fileManager fileExistsAtPath: pdfPath]) 
        {
            NSString *thumbnailsPath = [[paths objectAtIndex:0] 
                                        stringByAppendingPathComponent:
                                        [NSString stringWithFormat:@"%@_%@", document.code, selectedLang]];
     
            NSURL *documentUrl = [NSURL fileURLWithPath:pdfPath];
            MFDocumentManager *documentManager = [[MFDocumentManager alloc]initWithFileUrl:documentUrl];
            ReaderViewController *pdfViewController = [[ReaderViewController alloc] 
                                                       initWithDocumentManager:documentManager];
     
            documentManager.resourceFolder = thumbnailsPath;
            pdfViewController.documentId = [NSString stringWithFormat:@"%@_%@", document.code, selectedLang];    
            pdfViewController.searchBarButtonItem.enabled = FALSE;
            
            [self presentModalViewController:pdfViewController animated:YES];
            [pdfViewController release];
        }
        else {
            [self downloadPDF:@"http://tenarisbackend.theappmaster.com/elements" 
                      andName:document.code andLanguage:selectedLang];
        }
    }
}
@end
