//
//  GroupStore.h
//  AirOrder
//
//  Created by Suzuki Hideharu on 2016/05/17.
//  Copyright © 2016年 Suzuki.Works. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Group;

@interface GroupStore : NSObject

@property(nonatomic, strong)NSManagedObjectContext *managedObjectContext;
@property(nonatomic, strong)NSMutableArray         *allGroups;

+(GroupStore *)defaultGroupStore;

-(Group *)addGroupName:(NSString *)string groupTypeIndex:(int)typeIndex;
-(void)overWriteGroup:(Group *)group groupName:(NSString *)groupName grouptypeIndex:(int)typeIndex;
-(void)removeGroup:(NSIndexPath *)indexPath;
-(void)moveGroupAtIndex:(int)from toIndex:(int)to;
-(BOOL)saveContext;


@end
