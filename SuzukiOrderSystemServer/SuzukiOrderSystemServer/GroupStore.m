//
//  GroupStore.m
//  AirOrder
//
//  Created by Suzuki Hideharu on 2016/05/17.
//  Copyright © 2016年 Suzuki.Works. All rights reserved.
//

#import "AppDelegate.h"
#import "GroupStore.h"
#import "Group.h"
//#import "ItemStore.h"
//#import "Item.h"

static GroupStore *defaultGroupStore = nil;

@implementation GroupStore

+(GroupStore *)defaultGroupStore //シングルトン
{
    if (!defaultGroupStore) {
        defaultGroupStore = [[super allocWithZone:NULL] init];//初回のみallocation処理
    }
    return defaultGroupStore;
}

-(id)init
{
    if (defaultGroupStore) {
        return defaultGroupStore;
    }
    self = [super init];
    if (self) {
        
        //managedObjectContext
        [self setManagedObjectContext:[(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext]];
        
        //allGroups
        if (![self allGroups]) {
            NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
            NSManagedObjectModel *model  = [NSManagedObjectModel mergedModelFromBundles:nil];
            NSEntityDescription *entity  = [[model entitiesByName] objectForKey:@"Group"];
            [fetchRequest setEntity:entity];
            
            NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"groupOrderingValue"
                                                                             ascending:YES];
            
            [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
            
            NSError *error;
            NSArray *result = [[self managedObjectContext] executeFetchRequest:fetchRequest
                                                                         error:&error];
            if (!result) {
                [NSException raise:@"Group Fetch failed"
                            format:@"Reason: %@", [error localizedDescription]];
            }
            [self setAllGroups:[result mutableCopy]];
        }
    }
    return self;
}

-(Group *)addGroupName:(NSString *)string groupTypeIndex:(int)typeIndex
{
    int order;
    if ([[self allGroups] count] == 0) {
        order = 0;
    }else{
        order = [[[[self allGroups] lastObject] groupOrderingValue] intValue] + 1;
    }
    
    Group *group = [NSEntityDescription insertNewObjectForEntityForName:@"Group"
                                                 inManagedObjectContext:[self managedObjectContext]];
    [group setGroupOrderingValue:[NSNumber numberWithInt:order]];
    [group setGroupName:string];
    [group setGroupTypeIndex:[NSNumber numberWithInt:typeIndex]];
    
    //モデル変更(グループ追加 & アイテムリストの最後に空配列追加)
    [[self allGroups] addObject:group];
    int i = (int)[[self allGroups] count] - 1;
    [[[ItemStore defaultItemStore] itemList] insertObject:[[NSMutableArray alloc] init] atIndex:i];
    
    return group;
}

-(void)overWriteGroup:(Group *)group groupName:(NSString *)groupName grouptypeIndex:(int)typeIndex{
    [group setGroupName:groupName];
    [group setGroupTypeIndex:[NSNumber numberWithInt:typeIndex]];

}

-(void)removeGroup:(NSIndexPath *)indexPath
{
    Group *removeGroup = [[self allGroups] objectAtIndex:[indexPath row]];
    
    [[self allGroups] removeObjectAtIndex:[indexPath row]];
    
    int i = 0;
    for (Group *group in [self allGroups]) {
        [group setGroupOrderingValue:[NSNumber numberWithInt:i]];
        i++;
    }
    
    //削除したグループ(カテゴリ)に属するアイテムを「カテゴリなし」に移動 & 追加
    NSMutableArray *itemsInSection = [[[ItemStore defaultItemStore] itemList] objectAtIndex:[indexPath row]];
    for (Item *item in itemsInSection) {
        [item setItemOrderingRow:nil];
        [[[[ItemStore defaultItemStore] itemList] lastObject] addObject:item];
    }
    
    [[[ItemStore defaultItemStore] itemList] removeObjectAtIndex:[indexPath row]];
    
    [[self managedObjectContext] deleteObject:removeGroup];
}

-(void)moveGroupAtIndex:(int)from toIndex:(int)to
{
    if (from == to) {
        return;
    }
    Group *group = [[self allGroups] objectAtIndex:from];
    [[self allGroups] removeObjectAtIndex:from];
    [[self allGroups] insertObject:group atIndex:to];
    
    int i = 0;
    for (Group *group in [self allGroups]) {
        [group setGroupOrderingValue:[NSNumber numberWithInt:i]];
        i++;
    }
    
    // モデル変更(アイテムの配列ごと移動)
    NSMutableArray *itemsInSection = [[[ItemStore defaultItemStore] itemList] objectAtIndex:from];
    [[[ItemStore defaultItemStore] itemList] removeObjectAtIndex:from];
    [[[ItemStore defaultItemStore] itemList] insertObject:itemsInSection atIndex:to];
}

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













