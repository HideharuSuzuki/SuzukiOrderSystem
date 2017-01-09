//
//  Item.m
//  AirOrder
//
//  Created by Suzuki Hideharu on 2016/05/09.
//  Copyright © 2016年 Suzuki.Works. All rights reserved.
//

#import "Item.h"

@implementation Item

// Insert code here to add functionality to your managed object subclass
@dynamic itemCode;
@dynamic itemDateCreated;
@dynamic itemExplain;
@dynamic itemImage;
@dynamic itemImageData;
@dynamic itemName;
@dynamic itemOrderingRow;
@dynamic itemPrice;
@dynamic itemThumbnail;
@dynamic itemThumbnailData;
@dynamic itemTypeIndex;
@dynamic group;

+(CGSize)thumbnailSize
{
    return CGSizeMake(80, 60);
}

-(void)setThumbnailDataItemImageDataFromImage:(UIImage *)image
{
    if (!image) {
        [self setItemImage:nil];
        [self setItemImageData:nil];
        [self setItemThumbnail:nil];
        [self setItemThumbnailData:nil];
        return;
    }
    CGSize originalImageSize = [image size];
    
    /* アイテムイメージを生成 */
    [self setItemImage:image];
    NSData *data = UIImagePNGRepresentation([self itemImage]);
    [self setItemImageData:data];
    
    /* サムネイルイメージを生成 */
    CGRect newRect;
    newRect.origin = CGPointZero;
    newRect.size   = [[self class] thumbnailSize];
    newRect.size.width  = newRect.size.width  * 2.0;
    newRect.size.height = newRect.size.height * 2.0;
    
    float ratio = MAX(newRect.size.width / originalImageSize.width, newRect.size.height / originalImageSize.height);
    
    UIGraphicsBeginImageContext(newRect.size);
    
    CGRect projectRect;
    projectRect.size.width  = ratio * originalImageSize.width;
    projectRect.size.height = ratio * originalImageSize.height;
    projectRect.origin.x = (newRect.size.width  - projectRect.size.width) / 2.0;
    projectRect.origin.y = (newRect.size.height - projectRect.size.height) / 2.0;
    
    [image drawInRect:projectRect];
    
    UIImage *small = UIGraphicsGetImageFromCurrentImageContext();
    [self setItemThumbnail:small];
    
    NSData *data2 = UIImagePNGRepresentation(small);//PNGデータからNSData(バイナリデータ)へ変換
    [self setItemThumbnailData:data2];
    
    UIGraphicsEndImageContext();
}

//insert時実行
-(void)awakeFromInsert
{
    [super awakeFromInsert];
    [self setItemDateCreated:[NSDate date]];
}

//fetch時実行
- (void)awakeFromFetch
{
    [super awakeFromFetch];
    
    /* バイナリデータから画像を作成 & セット */
    if ([self itemImageData]) {
        UIImage *itemImage = [UIImage imageWithData:[self itemImageData]];
        [self setPrimitiveValue:itemImage forKey:@"itemImage"];
    }
    if ([self itemThumbnailData]) {
        UIImage *thumbnail = [UIImage imageWithData:[self itemThumbnailData]];
        [self setPrimitiveValue:thumbnail forKey:@"itemThumbnail"];
    }
}

@end





