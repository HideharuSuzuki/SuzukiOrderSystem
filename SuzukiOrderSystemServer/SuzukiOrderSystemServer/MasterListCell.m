//
//  MasterListCell.m
//  @order.main
//
//  Created by Suzuki Hideharu on 2016/08/21.
//  Copyright © 2016年 Suzuki.Works. All rights reserved.
//

#import "Define.h"
#import "MasterListCell.h"

@implementation MasterListCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        [self setSeparatorInset:UIEdgeInsetsZero];
        [self setLayoutMargins:UIEdgeInsetsZero];
        
        //各ビュー初期化
        self.m_masterListImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self.m_masterListImageView setContentMode:UIViewContentModeScaleAspectFit];
        [self.m_masterListImageView setBackgroundColor:[UIColor blackColor]];
        [self.m_masterListImageView setImage:[UIImage imageNamed:@"NoImageThumbnail"]]; //(仮)TODO 変更
        [[self contentView] addSubview:self.m_masterListImageView];
        
        self.m_masterListTitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        //[cellItemName setBackgroundColor:[UIColor purpleColor]];
        [self.m_masterListTitleLabel setFont:HIRAKAKU_NORMAL_17];
        [self.m_masterListTitleLabel setNumberOfLines:2];
        [self.m_masterListTitleLabel setTextAlignment:NSTextAlignmentCenter];
        [[self contentView] addSubview:self.m_masterListTitleLabel];
    }
    return self;
}

//タイトルのセット(デリゲート)
-(void)setMasterListTitle:(NSString *)a_string{
    
    [self.m_masterListTitleLabel setText:a_string];
}

//ビューを描画する時実行
-(void)layoutSubviews{
    [super layoutSubviews];
    
    // 各種幅、高さ初期化
    float marginVertical     = 5.0;
    float contentViewHeight  = [[self contentView] bounds].size.height;
    float contentViewWidth   = [[self contentView] bounds].size.width;
    float imageWidthHeight   = contentViewHeight - marginVertical*2;
    float marginHorizontal   = 10.0;
    
    //各ビューのセットフレーム
    [self.m_masterListImageView setFrame:CGRectMake(marginHorizontal,
                                                    marginVertical,
                                                    imageWidthHeight,
                                                    imageWidthHeight)];
    [self.m_masterListTitleLabel setFrame:CGRectMake(CGRectGetMaxX(self.m_masterListImageView.frame),
                                                     marginVertical,
                                                     contentViewWidth - self.m_masterListImageView.frame.size.width -
                                                     marginHorizontal * 2,
                                                     self.m_masterListImageView.frame.size.height)];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

//押した瞬間実行
-(void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    if(highlighted) { //ハイライト状態
        [self setBackgroundColor:BACKGROUND_COLOR_DEF_VIEWCONTROLLER];
        [self.m_masterListTitleLabel setFont:HIRAKAKU_BOLD_17];
    }else{ //非ハイライト状態
        [self setBackgroundColor:[UIColor whiteColor]];
    }
}

//選択時の状態設定
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    if (selected) { //選択状態
        [self setBackgroundColor:BACKGROUND_COLOR_DEF_VIEWCONTROLLER];
        [self.m_masterListTitleLabel setFont:HIRAKAKU_BOLD_17];
    }else{ //非選択状態
        [self setBackgroundColor:[UIColor whiteColor]];
        [self.m_masterListTitleLabel setTextColor:[UIColor blackColor]];
        [self.m_masterListTitleLabel setFont:HIRAKAKU_NORMAL_17];
    }
}

@end
