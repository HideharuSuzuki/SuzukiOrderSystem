//
//  ItemStore.h
//  AirOrder
//
//  Created by Suzuki Hideharu on 2016/05/09.
//  Copyright © 2016年 Suzuki.Works. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Item;

@interface ItemStore : NSObject

@property(nonatomic, strong)NSManagedObjectContext *managedObjectContext;
@property(nonatomic, strong)NSMutableArray         *allItems;
@property(nonatomic, strong)NSMutableArray         *itemList;

+(ItemStore *)defaultItemStore;
-(void)addItemName:(NSString *)itemName itemCode:(NSString *)itemCode itemPrice:(int)itemPrice
       itemExplain:(NSString *)itemExplain itemImage:(UIImage *)itemImage itemTypeIndex:(int)itemTypeIndex;
-(void)overWriteItem:(Item *)item itemName:(NSString *)itemName itemPrice:(int)itemPrice
       itemExplain:(NSString *)itemExplain itemImage:(UIImage *)itemImage itemTypeIndex:(int)itemTypeIndex;
-(void)removeItem:(NSIndexPath *)indexPath;
-(int)moveItemAtIndex:(NSIndexPath *)atIndexPath toIndex:(NSIndexPath *)toIndexPath;
-(BOOL)saveContext;
@end
