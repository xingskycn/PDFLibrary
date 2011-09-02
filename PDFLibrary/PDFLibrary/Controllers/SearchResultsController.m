//
//  SearchResultsController.m
//  PDFLibrary
//
//  Created by Gonzalo Aizpun on 7/18/11.
//  Copyright 2011 TheAppMaster. All rights reserved.
//

#import "SearchResultsController.h"
#import "DocumentController.h"
#import "DocumentDAO.h"

@implementation SearchResultsController
@synthesize phrase;

#pragma mark - UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [currentList count];
    
}


- (UITableViewCell *)createDocumentCell:(UITableView *)tableView document:(Document *)document{
    
    NSString * identifier = document.isEbook ? @"ListingSmallBookCell" : @"ListingSmallVideoCell";
    
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
    cell.isBiggerCell = NO;
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
    float height = document.isEbook ? kDocumentHeightCellSmallBook : kDocumentHeightCellSmallVideo;
    
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
    
    DocumentController * controller;
    if(document.isEbook) {
        controller = [[DocumentController alloc] init];    
    } else {
        controller = [[DocumentController alloc] initWithNibName:@"VideoController" bundle:nil];    
    }
    [self.navigationController pushViewController:controller animated:YES];
    [controller updateViewFromDocument:document];
    [controller release];
    
}


// ****************************************************

- (void)doDocumentsSearch {
    
    currentList = nil;
    [tableLandscape reloadData];
    [tablePortrait  reloadData];
    
    [self.view addSubview:indicatorController.view];
    
    currentList = [DocumentDAO getDocumentsByCategory:category.id
                                             language:0 keyword:phrase myLibrary:NO sort:lastSort];
    
    NSString * strResult = [NSString stringWithFormat:@"SHOWING %u MATCHES FOR:", [currentList count]];
    lblResultsPortrait.text  = strResult;
    lblResultsLandscape.text = strResult;    
    
    [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:1]];
    
    [indicatorController.view removeFromSuperview];
    [tablePortrait  reloadData];
    [tableLandscape reloadData];
}

- (void) updateLabels {
    
    lblTitlePortrait.text = @"Search Results";
    lblTitleLandscape.text = @"Search Results";
    
    lblMatchesPortrait.text = [NSString stringWithFormat:@"\"%@\"", phrase];
    lblMatchesLandscape.text = [NSString stringWithFormat:@"\"%@\"", phrase];   
    
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
    
    [self setMenuControllers];    
    [self setGestureRecognizer:self];   
    [self updateLabels];

    [self doDocumentsSearch];

}

- (IBAction) btnFilterByCategoryPressed:(id)sender {
    
    int tag = [sender tag];
    
    for (int i=1; i<=7; i++){
        UIButton * button = (UIButton*)[self.view viewWithTag:i];
        NSString * imgName = [NSString stringWithFormat:@"btn-category%u-off.png", (i-1)];
        if(i==tag) {
            imgName = [NSString stringWithFormat:@"btn-category%u-on.png", (i-1)];
        }
        [button setBackgroundImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];    
    }
    
    int categoryId = tag - 1;
    category = [CategoryDAO getCategoryById:categoryId];
    
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

- (void)viewDidLoad
{
    [super viewDidLoad];    
    lastSort = kSortLastUpdate;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch 
{
    [self hideMenu];    
    return YES;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
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
