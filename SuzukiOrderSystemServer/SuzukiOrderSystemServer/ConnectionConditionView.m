//
//  ConnectionConditionView.m
//  @order.main
//
//  Created by Suzuki Hideharu on 2016/08/19.
//  Copyright © 2016年 Suzuki.Works. All rights reserved.
//

#import "Define.h"
#import "AppDelegate.h"
#import "ConnectionConditionView.h"

@implementation ConnectionConditionView

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        
        [self setBackgroundColor:[UIColor lightGrayColor]];
        
        //余白設定
        float marginHorizontal = 5;
        
        //端末のタイプ
        UILabel *deviceTypeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0,
                                                                             self.bounds.size.width * 0.7,
                                                                             15)];
        [deviceTypeLabel setText:@"親機"];
        [deviceTypeLabel setTextColor:[UIColor whiteColor]];
        [deviceTypeLabel setFont:HIRAKAKU_NORMAL_13];
        [deviceTypeLabel setBackgroundColor:[UIColor darkGrayColor]];
        [deviceTypeLabel setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:deviceTypeLabel];

        //サーバー機能の状態のラベル
        CGRect conditionLabelRect = self.bounds;
        conditionLabelRect.origin.x = marginHorizontal;
        conditionLabelRect.origin.y = deviceTypeLabel.frame.size.height;
        conditionLabelRect.size.width  = self.bounds.size.width * 0.7 - marginHorizontal;
        conditionLabelRect.size.height = self.bounds.size.height - deviceTypeLabel.frame.size.height;
        
        self.m_conditionLabel = [[UILabel alloc] initWithFrame:conditionLabelRect];
        //[self.m_conditionLabel setBackgroundColor:[UIColor whiteColor]];
        [self.m_conditionLabel setText:@"サーバー機能停止"];
        [self.m_conditionLabel setFont:HIRAKAKU_NORMAL_14];
        [self.m_conditionLabel setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:self.m_conditionLabel];
        
        //サーバー機能起動・停止ボタン
        CGRect renewalPublishButtonRect = self.bounds;
        renewalPublishButtonRect.origin.x = CGRectGetMaxX(conditionLabelRect);
        renewalPublishButtonRect.size.width = self.bounds.size.width - deviceTypeLabel.frame.size.width;
        
        UIButton *renewalPublishButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [[renewalPublishButton titleLabel] setFont:HIRAKAKU_NORMAL_14];
        [renewalPublishButton setFrame:renewalPublishButtonRect];
        //[renewalPublishButton setBackgroundColor:[UIColor redColor]];
        [renewalPublishButton setTitle:@"起動" forState:UIControlStateNormal];
        [renewalPublishButton addTarget:self action:@selector(tappedStartServerFunctionBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:renewalPublishButton];
        
        //サーバーコントローラー初期化 & デリゲート設定
        //self.m_serverMainController = [ServerMainController defaultServerMainController];
        //[self.serverMainController setM_delegate:self];
    }
    return self;
}


- (void)drawRect:(CGRect)rect {
    
}

#pragma mark ActionMethod

//サーバー機能の起動ボタンタップ時実行
//-(void)tappedStartServerFunctionBtn:(id)sender{
//    
//    int soc;
//    soc = [self.m_serverMainController server_socket]; //サーバー機能を起動
//    [self.m_serverMainController accept_loop:soc];
//    
//    //ボタンタイトル変更 & ターゲットアクション削除 & 追加
//    [sender setTitle:@"停止" forState:UIControlStateNormal];
//    [sender removeTarget:self action:@selector(tappedStartServerFunctionBtn:) forControlEvents:UIControlEventTouchUpInside];
//    [sender addTarget:self action:@selector(tappedStopServerFunctionBtn:) forControlEvents:UIControlEventTouchUpInside];
//}

//サーバー機能の停止ボタンタップ時実行
//-(void)tappedStopServerFunctionBtn:(id)sender{
//    self.userInteractionEnabled = NO;
//    
//    UIViewController *splitViewController = [[(AppDelegate *)[[UIApplication sharedApplication] delegate] window] rootViewController];
//    
//    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"サーバー機能の停止"
//                                                                             message:@"子機と通信できなくなりますが\nよろしいですか？"
//                                                                      preferredStyle:UIAlertControllerStyleAlert];
//    //addAction指定で左からボタンを配置,タップ時の処理はブロックで指定
//    [alertController addAction:[UIAlertAction actionWithTitle:@"いいえ"
//                                                        style:UIAlertActionStyleDefault
//                                                      handler:^(UIAlertAction *action) {
//                                                          [splitViewController dismissViewControllerAnimated:YES completion:nil];
//                                                          self.userInteractionEnabled = YES;
//                                                      }]];
//    [alertController addAction:[UIAlertAction actionWithTitle:@"はい"
//                                                        style:UIAlertActionStyleDefault
//                                                      handler:^(UIAlertAction *action) {
//                                                          
//                                                          [self.serverMainController fncEndProcessing]; //サーバー機能の終了処理
//                                                          [self.m_conditionLabel setText:@"サーバー機能停止"];
//                                                          
//                                                          //ボタンタイトル変更 & ターゲットアクション削除 & 追加
//                                                          [[sender titleLabel] setText:@"起動"];
//                                                          [sender removeTarget:self
//                                                                        action:@selector(tappedStopServerFunctionBtn:)
//                                                              forControlEvents:UIControlEventTouchUpInside];
//                                                          [sender addTarget:self
//                                                                     action:@selector(tappedStartServerFunctionBtn:)
//                                                           forControlEvents:UIControlEventTouchUpInside];
//
//                                                          [splitViewController dismissViewControllerAnimated:YES completion:nil];
//                                                          self.userInteractionEnabled = YES;
//                                                      }]];
//    //スプリットビューコントローラにプレゼント
//    [splitViewController presentViewController:alertController animated:YES completion:nil];
//}

#pragma mark ServerMainControllerDelegate

//通信状態の書き換え
-(void)fncRewriteCondition:(NSString *)a_string{
    [self.m_conditionLabel setText:a_string];
}

@end



















