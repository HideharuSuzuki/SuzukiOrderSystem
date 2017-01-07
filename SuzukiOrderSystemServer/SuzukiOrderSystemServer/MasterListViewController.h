//
//  MasterListViewController.h
//  @order.main
//
//  Created by Suzuki Hideharu on 2016/08/19.
//  Copyright © 2016年 Suzuki.Works. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MasterListViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic)          NSArray     *m_masterListArray; //マスターのリストの配列
@property (strong, nonatomic) IBOutlet UITableView *m_masterListTableView; //マスターのリストのテーブルビュー

@end
