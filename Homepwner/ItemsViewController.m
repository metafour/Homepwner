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

@interface ItemsViewController ()

@property (nonatomic, strong) IBOutlet UIView *headerView;

@end

@implementation ItemsViewController

- (instancetype)init
{
    // Call the superclass's designated initializer
    self = [super initWithStyle:UITableViewStylePlain];
    
    if (self) {
      self.tableView.contentInset = UIEdgeInsetsMake(10, 0, 0, 0);
    }
    return self;
}

- (instancetype) initWithStyle:(UITableViewStyle)style
{
    return [self init];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
  
  UIView *header = self.headerView;
  [self.tableView setTableHeaderView:header];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
  return UIStatusBarStyleDefault;
}

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
    
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationBottom];
  }
}

- (void)tableView:(UITableView *)tableView
moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath
      toIndexPath:(NSIndexPath *)destinationIndexPath
{
  [[ItemStore sharedStore] moveItemAtIndex:sourceIndexPath.row toIndex:destinationIndexPath.row];
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

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
  return @"Remove";
}































@end
