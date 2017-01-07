//
//  GroupListTableViewCell.m
//  AirOrder
//
//  Created by Suzuki Hideharu on 2016/05/04.
//  Copyright © 2016年 Suzuki.Works. All rights reserved.
//

#import "GroupListCell.h"
#import "Group.h"

@implementation GroupListCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [[self contentView] setBackgroundColor:[UIColor whiteColor]];
        
        [self setCellImageView:[[UIImageView alloc] initWithFrame:CGRectZero]];
        [[self cellImageView] setContentMode:UIViewContentModeScaleAspectFit];
        [[self contentView] addSubview:[self cellImageView]];
        
        [self setCellName:[[UILabel alloc] initWithFrame:CGRectZero]];
        //[[self cellName] setBackgroundColor:[UIColor orangeColor]];
        [[self cellName] setFont:[UIFont fontWithName:@"HiraKakuProN-W6" size:16]];
        [[self contentView] addSubview:[self cellName]];
        
        [self setCellType:[[UILabel alloc] initWithFrame:CGRectZero]];
        [[self cellType] setTextAlignment:NSTextAlignmentCenter];
        [[self cellType] setNumberOfLines:2];
        [[self cellType] setFont:[UIFont fontWithName:@"HiraKakuProN-W3" size:14]];
        [[self cellType] setBackgroundColor:[UIColor redColor]];
        [[self contentView] addSubview:[self cellType]];
        
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    float marginVertical       = 5.0;
    float marginHorizontal     = 15.0;
    float contentViewHeight = [[self contentView] bounds].size.height;
    float contentViewWidth  = [[self contentView] bounds].size.width;
    float groupImageWidth       = 60;
    float groupImageHeight      = 45;

    
    //cellImage
    CGRect cellImageFrame = CGRectMake(marginHorizontal,
                                       (contentViewHeight - groupImageHeight) / 2.0,
                                       groupImageWidth,
                                       groupImageHeight);
    [[self cellImageView] setFrame:cellImageFrame];
    
    //cellType
    CGRect cellTypeFrame = CGRectMake(contentViewWidth - (marginHorizontal) - 50,
                                      (contentViewHeight - 50) / 2.0,
                                      50,
                                      50);
    [[self cellType] setFrame:cellTypeFrame];
    
    //nameLabel
    CGRect cellNameFrame = CGRectMake(CGRectGetMaxX(cellImageFrame) + marginHorizontal,
                                      marginVertical,
                                      (cellTypeFrame.origin.x - marginHorizontal) -
                                      CGRectGetMaxX(cellImageFrame) + marginHorizontal,
                                      contentViewHeight - marginVertical * 2.0);
    [[self cellName] setFrame:cellNameFrame];
}

-(void)setGroup:(Group *)group{
    
    [[self cellImageView] setImage:[UIImage imageNamed:@"icon_folder"]];
    [[self cellName] setText:[group groupName]];
    
    switch ([[group groupTypeIndex] intValue]) {
        case 1:{
            [[self cellType] setText:@"単品"];
            [[self cellType] setBackgroundColor:[UIColor blueColor]];
            [[self cellType] setTextColor:[UIColor whiteColor]];
        }break;
        case 2:{
            [[self cellType] setText:@"飲み\n放題"];
            [[self cellType] setBackgroundColor:[UIColor yellowColor]];
            [[self cellType] setTextColor:[UIColor blackColor]];
        }break;
        case 3:{
            [[self cellType] setText:@"食べ飲\nみ放題"];
            [[self cellType] setBackgroundColor:[UIColor cyanColor]];
            [[self cellType] setTextColor:[UIColor blackColor]];
        }break;
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
