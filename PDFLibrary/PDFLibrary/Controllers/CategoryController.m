//
//  CategoryController.m
//  PDFLibrary
//
//  Created by Gonzalo Aizpun on 7/18/11.
//  Copyright 2011 TheAppMaster. All rights reserved.
//

#import "CategoryController.h"
#import "DocumentController.h"
#import "DocumentDAO.h"
#import "ScrollViewController.h"

#define PAGE_WIDTH 950

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

    DocumentController * controller;
    if (document.isEbook) {
        controller = [[DocumentController alloc] initWithNibName:@"EbookController" bundle:nil];    
    } else {
        controller = [[DocumentController alloc] initWithNibName:@"VideoController" bundle:nil];
    }
    [self.navigationController pushViewController:controller animated:YES];
    [controller updateViewFromDocument:document];    
    [controller release];
    
}


// ****************************************************
- (ScrollViewController*)loadContentViewWithPage:(NSInteger)pageIndex: (NSArray*) docs
{
    if (pageIndex < 0 || pageIndex >= kNumberOfPages) 
        return nil;
	
	ScrollViewController *controller = [[ScrollViewController alloc] initWithNibName:@"ScrollViewLandscape" bundle:nil];
    [controller initWithDocuments:docs:pageIndex:YES];
    [controller view];
	CGRect frame = controller.view.frame;
	frame.origin.x = PAGE_WIDTH * pageIndex;
	frame.origin.y = 0;
	controller.view.frame = frame;
	[scrollViewLandscape addSubview:controller.view];
    
	return controller;
}

- (void) initScrollView: (NSArray*) docs
{
    for(UIView* view in [scrollViewLandscape subviews])
        [view removeFromSuperview];
    
    NSMutableArray *controllers = [[NSMutableArray alloc] init];
    kNumberOfPages = ceil([docs count] / 6.0); 
    for (unsigned i = 0; i < kNumberOfPages; i++) {
        ScrollViewController *controller = [self loadContentViewWithPage:i:docs];
        controller.nav = self.navigationController;
        [controllers addObject:controller];
        [controller release];
    }
    
    viewControllers = controllers;
    [controllers release];
    
    // a page is the width of the scroll view
    int width = (PAGE_WIDTH * kNumberOfPages) - ((([docs count]%6)>=3)?470:0);
    scrollViewLandscape.contentSize = CGSizeMake(width, scrollViewLandscape.frame.size.height);
    scrollViewLandscape.showsHorizontalScrollIndicator = NO;
    scrollViewLandscape.showsVerticalScrollIndicator = NO;
    scrollViewLandscape.pagingEnabled = NO;
    scrollViewLandscape.scrollsToTop = NO;
    scrollViewLandscape.delegate = self;
}

- (void)doDocumentsSearch {
    
    currentList = nil;
    [tablePortrait reloadData];
    
    [self.view addSubview:indicatorController.view];
    
    currentList = [DocumentDAO getDocumentsByCategory:category.id
                                             language:0 keyword:nil myLibrary:NO sort:lastSort];
    
    [self initScrollView:currentList];
    
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
    UIButton * btnLastUpdate = (UIButton*)[self.portrait viewWithTag:8];
    UIButton * btnAlphabetical = (UIButton*)[self.portrait viewWithTag:9];
    UIButton * btnLastUpdateLandscape = (UIButton*)[self.landscape viewWithTag:8];
    UIButton * btnAlphabeticalLandscape = (UIButton*)[self.landscape viewWithTag:9];
    
    if(tag==8) {
        [btnLastUpdate setBackgroundImage:[UIImage imageNamed:@"btn-sort1-on.png"] 
                                 forState:UIControlStateNormal];
        [btnAlphabetical setBackgroundImage:[UIImage imageNamed:@"btn-sort2-off.png"] 
                                   forState:UIControlStateNormal];
        [btnLastUpdateLandscape setBackgroundImage:[UIImage imageNamed:@"btn-sort1-on.png"] 
                                 forState:UIControlStateNormal];
        [btnAlphabeticalLandscape setBackgroundImage:[UIImage imageNamed:@"btn-sort2-off.png"] 
                                   forState:UIControlStateNormal];
    } else {
        [btnLastUpdate setBackgroundImage:[UIImage imageNamed:@"btn-sort1-off.png"] 
                                 forState:UIControlStateNormal];
        [btnAlphabetical setBackgroundImage:[UIImage imageNamed:@"btn-sort2-on.png"] 
                                   forState:UIControlStateNormal];
        [btnLastUpdateLandscape setBackgroundImage:[UIImage imageNamed:@"btn-sort1-off.png"] 
                                 forState:UIControlStateNormal];
        [btnAlphabeticalLandscape setBackgroundImage:[UIImage imageNamed:@"btn-sort2-on.png"] 
                                   forState:UIControlStateNormal];
    }
    
    lastSort  = (tag == 8 ? kSortLastUpdate : kSortAlphabetical);
    [self doDocumentsSearch];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)sender {
    
}

// At the begin of scroll dragging, reset the boolean used when scrolls originate from the UIPageControl
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
}

// At the end of scroll animation, reset the boolean used when scrolls originate from the UIPageControl
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
}


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
