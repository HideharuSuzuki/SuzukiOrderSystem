//
//  MasterListViewController.m
//  @order.main
//
//  Created by Suzuki Hideharu on 2016/08/19.
//  Copyright © 2016年 Suzuki.Works. All rights reserved.
//

#import "Define.h"
#import "MasterListViewController.h"
#import "MasterListCell.h"
#import "GroupListViewController.h"

@interface MasterListViewController ()

@end

@implementation MasterListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //マスターリストの配列
    self.m_masterListArray = @[@"トップ画面", @"投稿画像\nリスト", @"注文履歴\nリスト", @"商品リスト", @"カテゴリ\nリスト",
                               @"注文画面の\n確認", @"注文画面\nきせかえ", @"データ分析", @"基本設定"];
    
    //マスターリストのテーブルビュー設定
    float applicationFrameHeight = [[UIScreen mainScreen] bounds].size.height -
                                    [[UIApplication sharedApplication] statusBarFrame].size.height -
                                    [[[self navigationController] navigationBar] frame].size.height;
    [[self m_masterListTableView] setRowHeight:applicationFrameHeight / [self.m_masterListArray count]];
    [self.m_masterListTableView setSeparatorInset:UIEdgeInsetsZero]; //境界線設定
    [self.m_masterListTableView setSeparatorColor:BACKGROUND_COLOR_DEF_VIEWCONTROLLER];
    [self.m_masterListTableView setLayoutMargins:UIEdgeInsetsZero];  //境界線設定
    [self.m_masterListTableView setScrollEnabled:NO];
    [[self m_masterListTableView] setDelegate:self];
    [[self m_masterListTableView] setDataSource:self];
    [[self view] addSubview:self.m_masterListTableView];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    //起動時選択状態に設定
    [self.m_masterListTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:0];
}


#pragma mark UITableViewDataSource

//セクション内行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.m_masterListArray count];
}

//セル設定
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MasterListCell *masterListCell = [tableView dequeueReusableCellWithIdentifier:@"MasterListCell"];
    if (!masterListCell) {
        masterListCell = [[MasterListCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"MasterListCell"];
    }
    [masterListCell setMasterListTitle:[self.m_masterListArray objectAtIndex:[indexPath row]]]; //セルのタイトルセット
    
    return masterListCell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableViewDelegate

//行選択
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (![self splitViewController]) {
        return;
    }
    
    switch ([indexPath row]) {
        case 0:{ // トップ画面
            
        }break;
        case 1:{ // 投稿画像リスト
            
        }break;
        case 2:{ // 注文履歴リスト
            
        }break;
        case 3:{ // 商品リスト
            
        }break;
        case 4:{ // カテゴリリスト
            GroupListViewController *groupListViewController = [[GroupListViewController alloc] init];
            UINavigationController *detailNavigationController = [[UINavigationController alloc] initWithRootViewController:groupListViewController];
            [[self splitViewController] setViewControllers:@[[self navigationController], detailNavigationController]];
            [[self splitViewController] setDelegate:groupListViewController];
        }break;
        case 5:{ // 注文画面確認
            
        }break;
        case 6:{ // 注文画面着せ替え
            
        }break;
        case 7:{ // データ分析
            
        }break;
        case 8:{ // 基本設定
//            BasicSettingViewController *basicSettingViewController = [[BasicSettingViewController alloc] init];
//            UINavigationController *detailNavigationController = [[UINavigationController alloc] initWithRootViewController:basicSettingViewController];
//            [[self splitViewController] setViewControllers:@[[self navigationController], detailNavigationController]];
//            [[self splitViewController] setDelegate:basicSettingViewController];
            
        }break;
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
