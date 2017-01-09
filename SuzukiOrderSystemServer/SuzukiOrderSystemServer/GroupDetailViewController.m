//
//  GroupDetailViewController.m
//  AirOrder
//
//  Created by Suzuki Hideharu on 2016/05/10.
//  Copyright © 2016年 Suzuki.Works. All rights reserved.
//

#import "Define.h"
#import "GroupDetailViewController.h"
#import "GroupStore.h"
#import "Group.h"

@interface GroupDetailViewController ()

@end

@implementation GroupDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[self view] setBackgroundColor:BACKGROUND_COLOR_DEF_VIEWCONTROLLER];
    
    /* NavigationBar */
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,
                                                                    0,
                                                                    [[self view] frame].size.width * 0.5,
                                                                    [[[self navigationController] navigationBar] bounds].size.height)];
    [titleLabel setFont:[UIFont fontWithName:@"HiraKakuProN-W6" size:20]];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    [titleLabel setTextColor:[UIColor whiteColor]];
    [[self navigationItem] setTitleView:titleLabel];
    
    if([self flagIndex] == 1){
        
        //カテゴリリストに新規追加 初期設定
        [titleLabel setText:@"カテゴリリストに追加"];
        [self setGroupTypeIndex:1];
        [[self groupTypeButtonTANPIN] setBackgroundColor:[UIColor blueColor]];
        [[self groupTypeButtonTANPIN] setTintColor:[UIColor whiteColor]];
        [[self groupTypeButtonTANPIN] setUserInteractionEnabled:NO];

    }else{
        
        //カテゴリリストに上書き 設定
        [titleLabel setText:[[self group] groupName]];
        [[self groupNameTextField] setText:[[self group] groupName]];
        [self setGroupTypeIndex:[[[self group] groupTypeIndex] intValue]];
        if([self groupTypeIndex] == 1){
            [[self groupTypeButtonTANPIN] setBackgroundColor:[UIColor blueColor]];
            [[self groupTypeButtonTANPIN] setTintColor:[UIColor whiteColor]];
            [[self groupTypeButtonTANPIN] setUserInteractionEnabled:NO];
        }else if([self groupTypeIndex] == 2){
            [[self groupTypeButtonNOMIHO] setBackgroundColor:[UIColor blueColor]];
            [[self groupTypeButtonNOMIHO] setTintColor:[UIColor whiteColor]];
            [[self groupTypeButtonNOMIHO] setUserInteractionEnabled:NO];
        }else if([self groupTypeIndex] == 3){
            [[self groupTypeButtonTABENOMI] setBackgroundColor:[UIColor blueColor]];
            [[self groupTypeButtonTABENOMI] setTintColor:[UIColor whiteColor]];
            [[self groupTypeButtonTABENOMI] setUserInteractionEnabled:NO];
        }
        [[self saveGroupButton] setTitle:@"カテゴリを上書き保存" forState:UIControlStateNormal];
    }
}

- (IBAction)tappedGroupTypeButton:(id)sender {
    for (int i = 1; i < 4; i++) {
        UIButton *groupTypeButton = [[sender superview] viewWithTag:i];
        if (i == (int)[sender tag]) {
            [groupTypeButton setBackgroundColor:[UIColor blueColor]];
            [groupTypeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [groupTypeButton setUserInteractionEnabled:NO];
            [self setGroupTypeIndex:i];
        }else{
            [groupTypeButton setBackgroundColor:[UIColor lightGrayColor]];
            [groupTypeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [groupTypeButton setUserInteractionEnabled:YES];
        }
    }
}

- (IBAction)tappedSaveGroupButton:(id)sender
{
    [[self groupNameTextField] setText:[[[self groupNameTextField] text]
                                       stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
    if (![self validation]) {
        return;
    }
    
    if([self flagIndex] == 1){
        
        //カテゴリリストに新規追加
        [[GroupStore defaultGroupStore] addGroupName:[[self groupNameTextField] text] groupTypeIndex:[self groupTypeIndex]];
        [[GroupStore defaultGroupStore] saveContext];
        
    }else{
        
        //カテゴリリストに上書き
        [[GroupStore defaultGroupStore] overWriteGroup:[self group]
                                             groupName:[[self groupNameTextField] text]
                                        grouptypeIndex:[self groupTypeIndex]];
        [[GroupStore defaultGroupStore] saveContext];
    }
    
    [[self view] endEditing:YES];
    [[self navigationController] popViewControllerAnimated:YES];
}

-(BOOL)validation
{
    if ([[[self groupNameTextField] text] length] == 0 || [[[self groupNameTextField] text] length] > 50) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"カテゴリ名 Error"
                                                                                 message:@"カテゴリ名の文字数が適切ではありません。"
                                                                          preferredStyle:UIAlertControllerStyleAlert];
        //addAction指定で左からボタンを配置,タップ時の処理はブロックで指定
        [alertController addAction:[UIAlertAction actionWithTitle:@"OK"
                                                            style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction *action) {
                                                              [self dismissViewControllerAnimated:YES completion:nil];
                                                          }]];
        [self presentViewController:alertController animated:YES completion:nil];
        return NO;
    }
    return YES;
}



/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [[self view] endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
