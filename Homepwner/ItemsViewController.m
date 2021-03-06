//
//  ItemsViewController.m
//  Homepwner
//
//  Created by Camron Schwoegler on 12/26/14.
//  Copyright (c) 2014 metafour.org. All rights reserved.
//

#import "ItemsViewController.h"
#import "ItemStore.h"
#import "BNRItem.h"
#import "BNRDetailViewController.h"

@interface ItemsViewController ()

@property (nonatomic, strong) IBOutlet UIView *headerView;

@end

@implementation ItemsViewController



- (instancetype)init
{
    // Call the superclass's designated initializer
    self = [super initWithStyle:UITableViewStylePlain];
    
    if (self) {
//      self.tableView.contentInset = UIEdgeInsetsMake(10, 0, 0, 0);
      self.navigationItem.title = @"Homepwner";
      self.navigationItem.leftBarButtonItem = self.editButtonItem;
      self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewItem:)];
    }
    return self;
}



- (instancetype) initWithStyle:(UITableViewStyle)style
{
    return [self init];
}



- (void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:YES];
  
  [self.tableView reloadData];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
  
//  UIView *header = self.headerView;
//  [self.tableView setTableHeaderView:header];
}



- (UIStatusBarStyle)preferredStatusBarStyle {
  return UIStatusBarStyleDefault;
}


#pragma mark - UITableView Data Source Methods


- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];

  NSArray *items = [[ItemStore sharedStore] allItems];
  
  BNRItem *item = items[indexPath.row];

  cell.textLabel.text = item.description;

  return cell;
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}



- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
  return [[[ItemStore sharedStore] allItems] count];
}



- (void)tableView:(UITableView *)tableView
commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath
{
  if (editingStyle == UITableViewCellEditingStyleDelete) {
    NSArray *items = [[ItemStore sharedStore] allItems];
    
    BNRItem *item = items[indexPath.row];
    
    [[ItemStore sharedStore] removeItem:item];
    
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
  }
}



- (void)tableView:(UITableView *)tableView
moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath
      toIndexPath:(NSIndexPath *)destinationIndexPath
{
  [[ItemStore sharedStore] moveItemAtIndex:sourceIndexPath.row toIndex:destinationIndexPath.row];
}



- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
  return indexPath.row == [[[ItemStore sharedStore] allItems] count] - 1 ? NO : YES;
}



//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//  return @"Items";
//    switch (section) {
//        case 0:
//            return @"Items < $50";
//            break;
//        case 1:
//            return @"Items > $50";
//            break;
//            
//        default:
//            return @"Items";
//            break;
//    }
//}


#pragma mark - UITableView Delegate Methods


- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
  return @"Remove";
}

- (NSIndexPath *)tableView:(UITableView *)tableView
targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath
       toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath
{
  if (proposedDestinationIndexPath.row == [self.tableView numberOfRowsInSection:proposedDestinationIndexPath.section] - 1) {
    return [NSIndexPath indexPathForRow:proposedDestinationIndexPath.row - 1 inSection:proposedDestinationIndexPath.section];
  } else {
    return proposedDestinationIndexPath;
  }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  BNRDetailViewController *detailViewController = [[BNRDetailViewController alloc] init];
  
  BNRItem *selectedItem = [[[ItemStore sharedStore] allItems] objectAtIndex:indexPath.row];
  
  detailViewController.item = selectedItem;
  
  [self.navigationController pushViewController:detailViewController animated:YES];
}


#pragma mark - Custom Methods


- (UIView *)headerView
{
  if (!_headerView) {
    [[NSBundle mainBundle] loadNibNamed:@"HeaderView" owner:self options:nil];
  }
  
  return _headerView;
}



- (IBAction)addNewItem:(id)sender
{
  BNRItem *newItem = [[ItemStore sharedStore] createItem];
  
  NSInteger lastRow = [[[ItemStore sharedStore] allItems] indexOfObject:newItem];
  
  NSIndexPath *indexPath = [NSIndexPath indexPathForRow:lastRow inSection:0];
  
  [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
}



- (IBAction)toggleEditingMode:(id)sender
{
  if ([self isEditing]) {
    
    [sender setTitle:@"Edit" forState:UIControlStateNormal];
    
    [self setEditing:NO animated:YES];
    
  } else {
    
    [sender setTitle:@"Done" forState:UIControlStateNormal];
    
    [self setEditing:YES animated:YES];
  }
}


































@end
