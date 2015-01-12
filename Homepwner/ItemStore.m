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
      [self.privateItems addObject:@"No more items!"];
    }
    
    return self;
}

- (NSArray *)allItems {
    return self.privateItems;
}

- (BNRItem *)createItem {
    BNRItem *item = [BNRItem randomItem];
    
    [self.privateItems insertObject:item atIndex:[self.privateItems count] - 1];
    
    return item;
}

- (void)removeItem:(BNRItem *)item
{
  [self.privateItems removeObjectIdenticalTo:item];
}

- (void)moveItemAtIndex:(NSUInteger)fromIndex
                toIndex:(NSUInteger)toIndex;
{
  if (fromIndex == toIndex) {
    return;
  }
  
  BNRItem *item = self.privateItems[fromIndex];
  
  [self.privateItems removeObjectAtIndex:fromIndex];
  
  [self.privateItems insertObject:item atIndex:toIndex];
}









































@end
