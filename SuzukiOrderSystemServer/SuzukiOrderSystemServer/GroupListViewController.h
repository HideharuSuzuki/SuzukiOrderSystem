//
//  GroupListViewController.h
//  AirOrder
//
//  Created by Suzuki Hideharu on 2016/05/04.
//  Copyright © 2016年 Suzuki.Works. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GroupListViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UISplitViewControllerDelegate>

@property (strong, nonatomic) UIBarButtonItem *m_EditBarbuttonItem;
@property (strong, nonatomic) UITableView     *m_GroupListTableView;

@end

