//
//  CategoryController.m
//  PDFLibrary
//
//  Created by Gonzalo Aizpun on 7/18/11.
//  Copyright 2011 TheAppMaster. All rights reserved.
//

#import "CategoryController.h"
#import "EbookController.h"
#import "DocumentDAO.h"


@implementation CategoryController

@synthesize scrollViewLandscape;
@synthesize category;

#pragma mark - UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [currentList count];
    
}


- (UITableViewCell *)createDocumentCell:(UITableView *)tableView document:(Document *)document{
    
    NSString * identifier = document.isEbook ? @"ListingBigBookCell" : @"ListingBigVideoCell";
    
    DocumentCommonCell * cell = (DocumentCommonCell *)
    [tableView dequeueReusableCellWithIdentifier:identifier];
    if(cell == nil){
        NSArray* nib = [[NSBundle mainBundle] loadNibNamed:identifier owner:self options:nil];
        for(id oneObject in nib) {
            if([oneObject isKindOfClass:[DocumentCommonCell class]]) {
                cell = (DocumentCommonCell *)oneObject;
            }
        }	
    }
    
    cell.delegate = self;
    cell.document = document;
    cell.isBiggerCell = YES;
    [cell updateFields];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;        
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView 
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Document * document = (Document *)[currentList objectAtIndex:indexPath.row];
    return [self createDocumentCell:tableView document:document];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Document * document = (Document *)[currentList objectAtIndex:indexPath.row];
    float height = document.isEbook ? kDocumentHeightCellBigBook : kDocumentHeightCellBigVideo;
    
    return height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // Nothing to do > see: (void)goToDocument:(Document *)document
}


// ********** DocumentCommonCellProtocol **************

- (void)removeFromLibrary:(Document *)document {
    // unused here.
}

- (void)goToDocument:(Document *)document {
    
    EbookController * controller = [[EbookController alloc] init];    
    [self.navigationController pushViewController:controller animated:YES];
    [controller updateViewFromDocument:document];    
    [controller release];
    
}


// ****************************************************

- (void)doDocumentsSearch {
    
    currentList = nil;
    [tablePortrait reloadData];
    
    [self.view addSubview:indicatorController.view];
    
    currentList = [DocumentDAO getDocumentsByCategory:category.id
                                             language:0 keyword:nil myLibrary:NO sort:lastSort];
    
    
    [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:1]];
    
    [indicatorController.view removeFromSuperview];
    [tablePortrait reloadData];
}

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
    
     lblTitlePortrait.text = self.category.name;
    lblTitleLandscape.text = self.category.name;  
    [self setMenuControllers];    
    [self setGestureRecognizer:self];    
    
    [self doDocumentsSearch];
}

- (IBAction) btnFilterBySortingPressed:(id)sender {
    
    int tag = [sender tag];
    UIButton * btnLastUpdate = (UIButton*)[self.view viewWithTag:8];
    UIButton * btnAlphabetical = (UIButton*)[self.view viewWithTag:9];
    
    if(tag==8) {
        [btnLastUpdate setBackgroundImage:[UIImage imageNamed:@"btn-sort1-on.png"] 
                                 forState:UIControlStateNormal];
        [btnAlphabetical setBackgroundImage:[UIImage imageNamed:@"btn-sort2-off.png"] 
                                   forState:UIControlStateNormal];
    } else {
        [btnLastUpdate setBackgroundImage:[UIImage imageNamed:@"btn-sort1-off.png"] 
                                 forState:UIControlStateNormal];
        [btnAlphabetical setBackgroundImage:[UIImage imageNamed:@"btn-sort2-on.png"] 
                                   forState:UIControlStateNormal];
    }
    
    lastSort  = (tag == 8 ? kSortLastUpdate : kSortAlphabetical);
    [self doDocumentsSearch];
    
}

// ***************************************************

#pragma mark - View lifecycle

- (void) initScrollView {
    
    UIImageView * imageViewLandscape = [[UIImageView alloc] initWithImage:
                                            [UIImage imageNamed:@"img-landscape-category.png"]];


    scrollViewLandscape.contentSize = CGSizeMake(imageViewLandscape.frame.size.width, 
                                                 imageViewLandscape.frame.size.height);
    scrollViewLandscape.maximumZoomScale = 4.0;
    scrollViewLandscape.minimumZoomScale = 0.75;
    scrollViewLandscape.clipsToBounds = YES;
    [scrollViewLandscape addSubview:imageViewLandscape];
}

- (void)viewDidLoad
{
    [super viewDidLoad];    
    [self initScrollView];
    lastSort = kSortLastUpdate;
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




@end
