//
//  Item.h
//  AirOrder
//
//  Created by Suzuki Hideharu on 2016/05/09.
//  Copyright © 2016年 Suzuki.Works. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface Item : NSManagedObject

// Insert code here to declare functionality of your managed object subclass
@property (nullable, nonatomic, retain) NSString *itemCode;
@property (nullable, nonatomic, retain) NSDate   *itemDateCreated;
@property (nullable, nonatomic, retain) NSString *itemExplain;
@property (nullable, nonatomic, retain) UIImage  *itemImage;
@property (nullable, nonatomic, retain) NSData   *itemImageData;
@property (nullable, nonatomic, retain) NSString *itemName;
@property (nullable, nonatomic, retain) NSNumber *itemOrderingRow;
@property (nullable, nonatomic, retain) NSNumber *itemPrice;
@property (nullable, nonatomic, retain) UIImage  *itemThumbnail;
@property (nullable, nonatomic, retain) NSData   *itemThumbnailData;
@property (nullable, nonatomic, retain) NSNumber *itemTypeIndex;

// リレーションシップ
@property (nullable, nonatomic, retain) NSManagedObject *group;

+(CGSize)thumbnailSize;
-(void)setThumbnailDataItemImageDataFromImage:(UIImage *)image;

@end

NS_ASSUME_NONNULL_END
