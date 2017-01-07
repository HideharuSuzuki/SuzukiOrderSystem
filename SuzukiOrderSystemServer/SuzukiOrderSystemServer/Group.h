//
//  Group.h
//  AirOrder
//
//  Created by Suzuki Hideharu on 2016/05/16.
//  Copyright © 2016年 Suzuki.Works. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface Group : NSManagedObject

@property (nullable, nonatomic, retain) NSString *groupName;
@property (nullable, nonatomic, retain) NSNumber *groupOrderingValue;
@property (nullable, nonatomic, retain) NSNumber *groupTypeIndex;

// リレーションシップ
@property (nullable, nonatomic, retain) NSSet    *itemsOfGroup;

@end

NS_ASSUME_NONNULL_END

