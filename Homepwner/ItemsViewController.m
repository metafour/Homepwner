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



































@end
