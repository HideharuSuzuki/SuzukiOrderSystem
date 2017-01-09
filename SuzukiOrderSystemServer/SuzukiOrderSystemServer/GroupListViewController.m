//
//  GroupListViewController.m
//  AirOrder
//
//  Created by Suzuki Hideharu on 2016/05/04.
//  Copyright © 2016年 Suzuki.Works. All rights reserved.
//

#import "Define.h"
#import "GroupListViewController.h"
#import "GroupListCell.h"

#import "GroupDetailViewController.h"
#import "GroupStore.h"
#import "Group.h"

@interface GroupListViewController ()

@end

@implementation GroupListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[self view] setBackgroundColor:BACKGROUND_COLOR_DEF_VIEWCONTROLLER];
    
    //SplitViewVontroller設定
    if([self splitViewController]){
        //マスター・ディテールを表示
        [[self splitViewController] setPreferredDisplayMode:UISplitViewControllerDisplayModeAllVisible];
    }

    //ナビゲーションバー設定
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,
                                                                    0,
                                                                    [[self view] frame].size.width * 0.5,
                                                                    [[[self navigationController] navigationBar] bounds].size.height)];
    [titleLabel setFont:HIRAKAKU_NORMAL_20];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    [titleLabel setTextColor:[UIColor whiteColor]];
    [titleLabel setText:@"カテゴリリスト"];
    [[self navigationItem] setTitleView:titleLabel];
    
    UIBarButtonItem *addBarbuttonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                                      target:self
                                                                                      action:@selector(addNewGroup)];
    
    
    UIButton *editbutton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [editbutton setFrame:CGRectMake(0, 0, 70, 44)];
    //[editbutton setBackgroundColor:[UIColor orangeColor]];
    [editbutton setTintColor:[UIColor whiteColor]];
    [editbutton setTitle:@"編集" forState:UIControlStateNormal];
    [[editbutton titleLabel] setFont:[UIFont fontWithName:@"HiraKakuProN-W3" size:17]];
    [editbutton addTarget:self action:@selector(tappedEditButton:) forControlEvents:UIControlEventTouchUpInside];
    [self setM_EditBarbuttonItem:[[UIBarButtonItem alloc] initWithCustomView:editbutton]];
    
    [[self navigationItem] setRightBarButtonItems:@[addBarbuttonItem, [self m_EditBarbuttonItem]]];

    // テーブルビュー設定
    float navigationBarHeight = [[UIApplication sharedApplication] statusBarFrame].size.height +
    [[[self navigationController] navigationBar] bounds].size.height;
    float marginVerHori = 15;
    
    [self setM_GroupListTableView:[[UITableView alloc] initWithFrame:CGRectMake(marginVerHori,
                                                                              navigationBarHeight + marginVerHori,
                                                                              [[self view] frame].size.width -
                                                                              [[self splitViewController] primaryColumnWidth] -
                                                                              marginVerHori * 2,
                                                                              [[self view] frame].size.height -
                                                                              navigationBarHeight -
                                                                              marginVerHori * 2)
                                                             style:UITableViewStylePlain]];
    [[self m_GroupListTableView] setContentInset:UIEdgeInsetsMake(-navigationBarHeight, 0, 0, 0)]; //上の余白削除
    [[self m_GroupListTableView] setRowHeight:70];
    [[self m_GroupListTableView] setDelegate: self];
    [[self m_GroupListTableView] setDataSource: self];
    [[self m_GroupListTableView] setTableFooterView: [[UIView alloc] initWithFrame:CGRectZero]]; //空セル非表示
    [[self view] addSubview:[self m_GroupListTableView]];
    
    // カテゴリなしはアラート
    if([[[GroupStore defaultGroupStore] allGroups] count] <= 0){
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"現在カテゴリがありません"
                                                                                 message:@"カテゴリの追加は右上の「+」ボタンをタップして下さい。"
                                                                          preferredStyle:UIAlertControllerStyleAlert];
        //addAction指定で左からボタンを配置,タップ時の処理はブロックで指定
        [alertController addAction:[UIAlertAction actionWithTitle:@"OK"
                                                            style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction *action) {
                                                              [self dismissViewControllerAnimated:YES completion:nil];
                                                          }]];
        [self presentViewController:alertController animated:YES completion:nil];

    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[self m_GroupListTableView] reloadData];
}

//行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[[GroupStore defaultGroupStore] allGroups] count];
}

//cell設定
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GroupListCell *cell = (GroupListCell *)[tableView dequeueReusableCellWithIdentifier:@"GroupListCell"];
    if (!cell) {
        cell = [[GroupListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GroupListCell"];
    }
    
    NSArray *groups = [[GroupStore defaultGroupStore] allGroups];
    Group *group = [groups objectAtIndex:[indexPath row]];
    [cell setGroup:group];
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];

    return cell;
}

//+ボタンタップ時実行
-(void)addNewGroup{
    GroupDetailViewController *groupDetailViewController = [[GroupDetailViewController alloc] init];
    [groupDetailViewController setFlagIndex:1];
    [[self navigationController] pushViewController:groupDetailViewController animated:YES];
}

//行選択
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GroupDetailViewController *detailViewController = [[GroupDetailViewController alloc] init];
    NSArray *groups = [[GroupStore defaultGroupStore] allGroups];
    [detailViewController setGroup:[groups objectAtIndex:[indexPath row]]];
    [detailViewController setFlagIndex:2];
    [[self navigationController] pushViewController:detailViewController animated:YES];
}

//行の削除
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        [[GroupStore defaultGroupStore] removeGroup:indexPath];
        [[GroupStore defaultGroupStore] saveContext];
        
        //tableViewから削除
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:YES];
        
    }
}

// 行移動
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    [[GroupStore defaultGroupStore] moveGroupAtIndex:(int)[sourceIndexPath row] toIndex:(int)[destinationIndexPath row]];
    [[GroupStore defaultGroupStore] saveContext];
    [[self m_GroupListTableView] reloadData];
}

/* 編集ボタンタップ時実行 */
-(void)tappedEditButton:(id)sender{
    if([[sender currentTitle] isEqualToString:@"編集"]){
        [[self m_GroupListTableView] setEditing:YES animated:YES];
        [sender setTitle:@"完了" forState:UIControlStateNormal];
    }else{
        [[self m_GroupListTableView] setEditing:NO animated:YES];
        [sender setTitle:@"編集" forState:UIControlStateNormal];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
