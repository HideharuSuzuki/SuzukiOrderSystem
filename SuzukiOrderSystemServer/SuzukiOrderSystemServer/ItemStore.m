//
//  ItemStore.m
//  AirOrder
//
//  Created by Suzuki Hideharu on 2016/05/09.
//  Copyright © 2016年 Suzuki.Works. All rights reserved.
//

#import "AppDelegate.h"
#import "ItemStore.h"
#import "Item.h"
#import "GroupStore.h"
#import "Group.h"

static ItemStore *defaultItemStore = nil;

@implementation ItemStore

+(ItemStore *)defaultItemStore //シングルトン
{
    if (!defaultItemStore) {
        defaultItemStore = [[super allocWithZone:NULL] init];//初回のみallocation処理
    }
    return defaultItemStore;
}

-(id)init
{
    if (defaultItemStore) {
        return defaultItemStore;
    }
    self = [super init];
    if (self) {
        
        //managedObjectContext
        [self setManagedObjectContext:[(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext]];
        
        //allItemsセット
        if (![self allItems]) {
            NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
            NSManagedObjectModel *model = [NSManagedObjectModel mergedModelFromBundles:nil];
            NSEntityDescription *entity  = [[model entitiesByName] objectForKey:@"Item"];
            [fetchRequest setEntity:entity];
            
            NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"itemDateCreated"
                                                                             ascending:YES];
            
            [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
            
            NSError *error;
            NSArray *result = [[self managedObjectContext] executeFetchRequest:fetchRequest
                                                                         error:&error];
            if (!result) {
                [NSException raise:@"Item Fetch failed"
                            format:@"Reason: %@", [error localizedDescription]];
            }
            [self setAllItems:[result mutableCopy]];
        }
        
        //itemListセット
        if (![self itemList]) {
            [self setItemList:[[NSMutableArray alloc] init]];
            NSArray *groups = [[GroupStore defaultGroupStore] allGroups];
            for (Group *group in groups) {
                NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"itemOrderingRow" ascending:YES];
                NSMutableArray *itemsInSection = [[[[[group itemsOfGroup] allObjects] mutableCopy]
                                                   sortedArrayUsingDescriptors:[NSArray arrayWithObjects:sortDescriptor, nil]] mutableCopy];
                [[self itemList] addObject:itemsInSection];
            }
            
            NSMutableArray *itemsInLastSection = [[NSMutableArray alloc] init];
            for (Item *item in [self allItems]) {
                if (![item group]) {
                    [itemsInLastSection addObject:item];
                }
            }
            [[self itemList] addObject:itemsInLastSection];
        }
    }
    return self;
}

//アイテムの追加
-(void)addItemName:(NSString *)itemName itemCode:(NSString *)itemCode itemPrice:(int)itemPrice
   itemExplain:(NSString *)itemExplain itemImage:(UIImage *)itemImage itemTypeIndex:(int)itemTypeIndex{
    
    //CoreDataにアイテムをインサート
    Item *item = [NSEntityDescription insertNewObjectForEntityForName:@"Item"
                                               inManagedObjectContext:[self managedObjectContext]];
    // プロパティセット
    [item setItemName:itemName];
    [item setItemCode:itemCode];
    [item setItemExplain:itemExplain];
    [item setItemPrice:[NSNumber numberWithInt:itemPrice]];
    [item setThumbnailDataItemImageDataFromImage:itemImage];
    [item setItemTypeIndex:[NSNumber numberWithInt:itemTypeIndex]];
    
    // モデル変更(追加)
    [[self allItems] addObject:item];
    [[[self itemList] lastObject] addObject:item];
}

//アイテムの上書き
-(void)overWriteItem:(Item *)item itemName:(NSString *)itemName itemPrice:(int)itemPrice
       itemExplain:(NSString *)itemExplain itemImage:(UIImage *)itemImage itemTypeIndex:(int)itemTypeIndex{
    
    // プロパティセット
    [item setItemName:itemName];
    [item setItemExplain:itemExplain];
    [item setItemPrice:[NSNumber numberWithInt:itemPrice]];
    [item setThumbnailDataItemImageDataFromImage:itemImage];
    [item setItemTypeIndex:[NSNumber numberWithInt:itemTypeIndex]];
    
    // モデル変更(上書き)
    if ([[[GroupStore defaultGroupStore] allGroups] containsObject:[item group]]) {
        
        if ([[[item group] valueForKey:@"groupTypeIndex"] intValue] != [[item itemTypeIndex] intValue]) {
            
            [[[self itemList] objectAtIndex:[[[GroupStore defaultGroupStore] allGroups] indexOfObject:[item group]]] removeObjectIdenticalTo:item];
            
            //orderingRowの振り直し
            NSArray *itemsInSection = [[self itemList] objectAtIndex:[[[GroupStore defaultGroupStore] allGroups] indexOfObject:[item group]]];
            int i = 0;
            for (Item *itemInSection in itemsInSection) {
                [itemInSection setItemOrderingRow:[NSNumber numberWithInt:i]];
                i++;
            }
            
            [[[self itemList] lastObject] addObject:item];
            [item setItemOrderingRow:nil];
            [item setGroup:nil];
        }
    }
}

//アイテムの削除
-(void)removeItem:(NSIndexPath *)indexPath
{
    // モデル変更(削除)
    Item *item = [[[self itemList] objectAtIndex:[indexPath section]] objectAtIndex:[indexPath row]];
    [[self allItems] removeObjectIdenticalTo:item];
    [[[self itemList] objectAtIndex:[indexPath section]] removeObjectAtIndex:[indexPath row]];
    
    /* 削除マーク */
    [[self managedObjectContext] deleteObject:item];
}

//アイテムの移動 - return 0:エラーなし 1:同じ場所に移動(変更なし) 2:グループの種類が合っていない(エラー)
-(int)moveItemAtIndex:(NSIndexPath *)atIndexPath toIndex:(NSIndexPath *)toIndexPath
{
    if (atIndexPath == toIndexPath) {
        return 1;
    }
    
    //移動先のアイテムの種類とグループの種類が合っているか確認
    Item  *item  = [[[self itemList] objectAtIndex:[atIndexPath section]] objectAtIndex:[atIndexPath row]];
    if ([[[GroupStore defaultGroupStore] allGroups] count] != [toIndexPath section]) { //移動先がカテゴリなし以外
        Group *group = [[[GroupStore defaultGroupStore] allGroups] objectAtIndex:[toIndexPath section]];
        if ([[item itemTypeIndex] intValue] != [[group groupTypeIndex] intValue]) { //グループの種類が合っていない
            return 2;
        }
    }
    
    //モデル変更 - アイテムの移動元削除 & 移動先追加
    [[[self itemList] objectAtIndex:[atIndexPath section]] removeObjectAtIndex:[atIndexPath row]];
    [[[self itemList] objectAtIndex:[toIndexPath section]] insertObject:item atIndex:[toIndexPath row]];
    
    //CoreData変更
    //移動元セクションのOrderingRowの振り直し
    if ([[self itemList] lastObject] != [[self itemList] objectAtIndex:[atIndexPath section]]) {
        NSArray *itemsInSection = [[self itemList] objectAtIndex:[atIndexPath section]];
        int i = 0;
        for (Item *itemInSection in itemsInSection) {
            [itemInSection setItemOrderingRow:[NSNumber numberWithInt:i]];
            i++;
        }
    }
    
    //移動先セクションのOrderingRowの振り直し
    if ([[self itemList] lastObject] != [[self itemList] objectAtIndex:[toIndexPath section]]) {
        
        NSArray *itemsInSection = [[self itemList] objectAtIndex:[toIndexPath section]];
        int i = 0;
        for (Item *itemInSection in itemsInSection) {
            [itemInSection setItemOrderingRow:[NSNumber numberWithInt:i]];
            i++;
        }
        
        //移動したアイテムに移動先のグループをセット
        Group *group = [[[GroupStore defaultGroupStore] allGroups] objectAtIndex:[toIndexPath section]];
        [item setGroup:group];
        
    }else if([[self itemList] lastObject] == [[self itemList] objectAtIndex:[toIndexPath section]]){ //移動先が「カテゴリなし」
        [item setItemOrderingRow:nil];
        [item setGroup:nil];
    }
    return 0;
}

//アイテムの保存
-(BOOL)saveContext
{
    NSError *error;
    BOOL successful = [[self managedObjectContext] save:&error];
    if (!successful) {
        [NSException raise:@"Context save failed"
                    format:@"Reason: %@", [error localizedDescription]];
    }
    return successful;
}

@end
















