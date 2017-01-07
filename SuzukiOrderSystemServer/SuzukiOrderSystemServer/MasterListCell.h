//
//  MasterListCell.h
//  @order.main
//
//  Created by Suzuki Hideharu on 2016/08/21.
//  Copyright © 2016年 Suzuki.Works. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MasterListCell : UITableViewCell

@property (strong, nonatomic) UIImageView *m_masterListImageView;
@property (strong, nonatomic) NSString    *m_masterListTitleString;
@property (strong, nonatomic) UILabel     *m_masterListTitleLabel;

-(void)setMasterListTitle:(NSString *)a_string;

@end
