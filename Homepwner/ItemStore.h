//
//  ItemStore.h
//  Homepwner
//
//  Created by Camron Schwoegler on 12/26/14.
//  Copyright (c) 2014 metafour.org. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BNRItem;

@interface ItemStore : NSObject

@property (nonatomic, readonly) NSArray *allItems;

+ (instancetype)sharedStore;

- (BNRItem *)createItem;
- (int)numberOfItemsAboveValue:(int)value;
- (int)numberOfItemsBelowValue:(int)value;
- (NSArray *)itemsAboveValue:(int)value;
- (NSArray *)itemsBelowValue:(int)value;


@end