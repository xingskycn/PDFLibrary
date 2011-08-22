//
//  MenuCategoriesController.m
//  PDFLibrary
//
//  Created by Gonzalo Aizpun on 8/20/11.
//  Copyright 2011 TheAppMaster. All rights reserved.
//

#import "MenuCategoriesController.h"


@implementation MenuCategoriesController

#define kTableHeaderHeight 10
#define kTableFooterHeight 20
#define kTableCellHeight   38



- (id)initWithDelegate:(id)del
{
	if ((self = [super init])) {
		delegate = del;
	}
	return self;
}

#pragma mark - UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [itemList count] + 2; // header + footer
    
}


- (UITableViewCell *)createHeaderCell:(UITableView *)tableView {
    
    CategoryHeaderCell * cell = (CategoryHeaderCell *)
    [tableView dequeueReusableCellWithIdentifier:@"CategoryHeaderCell"];
    if(cell == nil){
        NSArray* nib = [[NSBundle mainBundle] loadNibNamed:@"CategoryHeaderCell" owner:self options:nil];
        for(id oneObject in nib) {
            if([oneObject isKindOfClass:[CategoryHeaderCell class]]) {
                cell = (CategoryHeaderCell *)oneObject;
            }
        }	
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;        

}


- (UITableViewCell *)createFooterCell:(UITableView *)tableView {

    CategoryFooterCell * cell = (CategoryFooterCell *)
                                [tableView dequeueReusableCellWithIdentifier:@"CategoryFooterCell"];
    if(cell == nil){
        NSArray* nib = [[NSBundle mainBundle] loadNibNamed:@"CategoryFooterCell" owner:self options:nil];
        for(id oneObject in nib) {
            if([oneObject isKindOfClass:[CategoryFooterCell class]]) {
                cell = (CategoryFooterCell *)oneObject;
            }
        }	
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;    
    
}


- (UITableViewCell *)createContentCell:(UITableView *)tableView 
                     category:(Category *)category isLast:(BOOL)isLast {    
    
    
    NSString * identifier = isLast ? @"CategoryLastCell" : @"CategoryCell";
    CategoryCell * cell = (CategoryCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    if(cell == nil){
        NSArray* nib = [[NSBundle mainBundle] loadNibNamed:identifier owner:self options:nil];
        for(id oneObject in nib) {
            if([oneObject isKindOfClass:[CategoryCell class]]) {
                cell = (CategoryCell *)oneObject;
                cell.lblTitle.text = category.name;
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
        Category * category = [itemList objectAtIndex:indexPath.row - 1];
        return [self createContentCell:tableView category:category isLast:isLast];
        
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
    
    Category * category = [itemList objectAtIndex:(indexPath.row-1)];
    NSLog(@"enviando al delegate %u", category.id);
    [delegate menuCategoryTapped:category.id];
}



// ****************************************************


- (void)setListFromDatabase {
    
    itemList = [CategoryDAO getCategories];
}


- (void)setSizeFromList {
    
    int height   = kTableHeaderHeight + kTableFooterHeight + ([itemList count] * kTableCellHeight);
    CGRect frame = CGRectMake(0.0, 0.0, 171.0, height);
    self.view.frame = frame;
    categoriesTableView.frame = frame;
    
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
    [categoriesTableView reloadData];
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
