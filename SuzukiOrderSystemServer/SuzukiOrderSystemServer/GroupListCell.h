//
//  GroupListTableViewCell.h
//  AirOrder
//
//  Created by Suzuki Hideharu on 2016/05/04.
//  Copyright © 2016年 Suzuki.Works. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Group;

@interface GroupListCell : UITableViewCell

@property (strong, nonatomic) UIImageView *cellImageView;
@property (strong, nonatomic) UILabel *cellName;
@property (strong, nonatomic) UILabel *cellType;

-(void)setGroup:(Group *)group;

@end
