//
//  MenuLanguageController.m
//  PDFLibrary
//
//  Created by Gonzalo Aizpun on 8/21/11.
//  Copyright 2011 TheAppMaster. All rights reserved.
//

#import "MenuLanguageController.h"


@implementation MenuLanguageController

#define kTableHeaderHeight 10
#define kTableFooterHeight 20
#define kTableCellHeight   38


#pragma mark - UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [itemList count] + 2; // header + footer
    
}


- (UITableViewCell *)createHeaderCell:(UITableView *)tableView {

    LanguageHeaderCell * cell = (LanguageHeaderCell *)
    [tableView dequeueReusableCellWithIdentifier:@"LanguageHeaderCell"];
    if(cell == nil){
        NSArray* nib = [[NSBundle mainBundle] loadNibNamed:@"LanguageHeaderCell" owner:self options:nil];
        for(id oneObject in nib) {
            if([oneObject isKindOfClass:[LanguageHeaderCell class]]) {
                cell = (LanguageHeaderCell *)oneObject;
            }
        }	
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;        
    
}


- (UITableViewCell *)createFooterCell:(UITableView *)tableView {
    
    LanguageFooterCell * cell = (LanguageFooterCell *)
    [tableView dequeueReusableCellWithIdentifier:@"LanguageFooterCell"];
    if(cell == nil){
        NSArray* nib = [[NSBundle mainBundle] loadNibNamed:@"LanguageFooterCell" owner:self options:nil];
        for(id oneObject in nib) {
            if([oneObject isKindOfClass:[LanguageFooterCell class]]) {
                cell = (LanguageFooterCell *)oneObject;
            }
        }	
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;    
    
}


- (UITableViewCell *)createContentCell:(UITableView *)tableView 
                              language:(Language *)language isLast:(BOOL)isLast {    
    
    NSString * identifier = isLast ? @"LanguageLastCell" : @"LanguageCell";
    LanguageCell * cell = (LanguageCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    if(cell == nil){
        NSArray* nib = [[NSBundle mainBundle] loadNibNamed:identifier owner:self options:nil];
        for(id oneObject in nib) {
            if([oneObject isKindOfClass:[LanguageCell class]]) {
                cell = (LanguageCell *)oneObject;
                cell.lblTitle.text = language.name;
            }
        }	
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}



- (UITableViewCell *)tableView:(UITableView *)tableView 
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if(indexPath.row == 0) {
        
        return [self createHeaderCell:tableView];
        
    } else if (indexPath.row == [itemList count] + 1) {
        
        return [self createFooterCell:tableView];
        
    } else {
        
        BOOL isLast = (indexPath.row == [itemList count]);
        Language * item = [itemList objectAtIndex:indexPath.row - 1];
        return [self createContentCell:tableView language:item isLast:isLast];
        
    }
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    float height = kTableCellHeight;
    
    if(indexPath.row == 0) {
        height = kTableHeaderHeight;
        
    } else if (indexPath.row == [itemList count] + 1) {
        height = kTableFooterHeight;
    }
    
    return height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"TAPPED %u", indexPath.row);
    
}



// ****************************************************


- (void)setListFromDatabase {
    
    itemList = [LanguageDAO getLanguages];
}


- (void)setSizeFromList {
    
    int height   = kTableHeaderHeight + kTableFooterHeight + ([itemList count] * kTableCellHeight);
    CGRect frame = CGRectMake(0.0, 0.0, 109.0, height);
    self.view.frame = frame;
    languageTableView.frame = frame;
}

// ****************************************************


#pragma mark - View lifecycle

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
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setListFromDatabase];
    [self setSizeFromList];
}

- (void)viewWillAppear:(BOOL)animated {
    [languageTableView reloadData];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

@end
