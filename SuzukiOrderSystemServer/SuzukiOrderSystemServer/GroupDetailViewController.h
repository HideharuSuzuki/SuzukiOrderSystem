//
//  GroupDetailViewController.h
//  AirOrder
//
//  Created by Suzuki Hideharu on 2016/05/10.
//  Copyright © 2016年 Suzuki.Works. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Group;

@interface GroupDetailViewController : UIViewController<UITextFieldDelegate>

@property (nonatomic)int  flagIndex;      //1:新規追加 2:上書き
@property (nonatomic)int  groupTypeIndex; //1:単品 2:飲み放題 3:食べ飲み放題

@property (strong, nonatomic) IBOutlet UITextField *groupNameTextField;
@property (strong, nonatomic) IBOutlet UIButton *groupTypeButtonTANPIN;
@property (strong, nonatomic) IBOutlet UIButton *groupTypeButtonNOMIHO;
@property (strong, nonatomic) IBOutlet UIButton *groupTypeButtonTABENOMI;
@property (strong, nonatomic) IBOutlet UIButton *saveGroupButton;

@property(nonatomic, strong)Group *group;

- (IBAction)tappedGroupTypeButton:(id)sender;
- (IBAction)tappedSaveGroupButton:(id)sender;

@end
