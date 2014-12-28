//
//  ItemStore.m
//  Homepwner
//
//  Created by Camron Schwoegler on 12/26/14.
//  Copyright (c) 2014 metafour.org. All rights reserved.
//

#import "ItemStore.h"
#import "BNRItem.h"

@interface ItemStore ()

@property (nonatomic) NSMutableArray *privateItems;

@end

@implementation ItemStore

+ (instancetype)sharedStore {
    static ItemStore *sharedStore = nil;
    
    //Do I need to create a sharedStore?
    if (!sharedStore) {
        sharedStore = [[self alloc] initPrivate];
    }
    
    return sharedStore;
}

- (instancetype)init
{
    @throw [NSException exceptionWithName:@"Singleton" reason:@"Use +[ItemStore sharedStore]" userInfo:nil];
    
    return nil;
}

- (instancetype)initPrivate {
    self = [super init];
    
    if (self) {
        _privateItems = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (NSArray *)allItems {
    return self.privateItems;
}

- (BNRItem *)createItem {
    BNRItem *item = [BNRItem randomItem];
    
    [self.privateItems addObject:item];
    
    return item;
}


- (int)numberOfItemsAboveValue:(int)value
{
    int count = 0;
    
    for (id item in self.privateItems) {
        if ([item valueInDollars] > value) {
            count++;
        }
    }
    
    return count;
}

- (int)numberOfItemsBelowValue:(int)value
{
    int count = 0;
    
    for (id item in self.privateItems) {
        if ([item valueInDollars] <= value) {
            count++;
        }
    }
    
    return count;
}

- (NSArray *)itemsAboveValue:(int)value
{
  NSMutableArray *items = [[NSMutableArray alloc] init];
  
  for (id item in [[ItemStore sharedStore] allItems]) {
    if ([item valueInDollars] > value) {
      [items addObject:item];
    }
  }
  
  return items;
}

- (NSArray *)itemsBelowValue:(int)value
{
  NSMutableArray *items = [[NSMutableArray alloc] init];
  
  for (id item in [[ItemStore sharedStore] allItems]) {
    if ([item valueInDollars] <= value) {
      [items addObject:item];
    }
  }
  
  return items;
}








































@end