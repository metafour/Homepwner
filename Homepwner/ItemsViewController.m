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

@implementation ItemsViewController

- (instancetype)init
{
  // Call the superclass's designated initializer
  self = [super initWithStyle:UITableViewStylePlain];

  if (self) {
    for (int i = 0; i < 5; i++) {
      [[ItemStore sharedStore] createItem];
    }
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
}


- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    BNRItem *item;
  
  if (indexPath.section == 0) {
    
    if (indexPath.row == [[[ItemStore sharedStore] itemsBelowValue:50] count]) {
      cell.textLabel.text = @"No more items!";
    }
    else {
      item = [[[ItemStore sharedStore] itemsBelowValue:50] objectAtIndex:indexPath.row];
      cell.textLabel.text = item.description;
      cell.textLabel.font = [UIFont systemFontOfSize:20.0];
    }
    
  }
  else {
   
    if (indexPath.row == [[[ItemStore sharedStore] itemsAboveValue:50] count]) {
      cell.textLabel.text = @"No more items!";
    }
    else {
      item = [[[ItemStore sharedStore] itemsAboveValue:50] objectAtIndex:indexPath.row];
      cell.textLabel.text = item.description;
      cell.textLabel.font = [UIFont systemFontOfSize:20.0];
    }
    
  }
    
//    NSArray *items = [[ItemStore sharedStore] allItems];
//    BNRItem *item = items[indexPath.row];
  
  
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//    NSArray *items = [[ItemStore sharedStore] allItems];
    
    if ([[ItemStore sharedStore] numberOfItemsAboveValue:50] > 0) {
        return 2;
    }
    
//    for (id item in items) {
//        if ([item valueInDollars] > 50) {
//            return 2;
//        }
//    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    if (section == 1) {
        return [[ItemStore sharedStore] numberOfItemsAboveValue:50] + 1;
    } else {
        return [[[ItemStore sharedStore] allItems] count] - [[ItemStore sharedStore] numberOfItemsAboveValue:50] + 1;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return @"Items < $50";
            break;
        case 1:
            return @"Items > $50";
            break;
            
        default:
            return @"Items";
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  id sharedStore = [ItemStore sharedStore];
  
  if (indexPath.section == 0) {
    if (indexPath.row == [[sharedStore itemsBelowValue:50] count]) {
      return 44;
    }
  }
  else {
    if (indexPath.section == 1) {
      if (indexPath.row == [[sharedStore itemsAboveValue:50] count]) {
        return 44;
      }
    }
  }
  
  return 60;
}



































@end
