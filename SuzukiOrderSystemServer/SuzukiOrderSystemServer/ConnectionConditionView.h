//
//  ConnectionConditionView.h
//  @order.main
//
//  Created by Suzuki Hideharu on 2016/08/19.
//  Copyright © 2016年 Suzuki.Works. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "ServerMainController.h"

@interface ConnectionConditionView : UIView//<ServerMainControllerDelegate>

//@property (strong,nonatomic) ServerMainController  *m_serverMainController;
@property (strong,nonatomic) UILabel               *m_conditionLabel; //通信状態を表すラベル

@end
