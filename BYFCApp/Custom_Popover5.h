//
//  Custom_Popover5.h
//  BYFCApp
//
//  Created by 王鹏 on 15/12/7.
//  Copyright © 2015年 PengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Custom_Popover5 : UIView<UIScrollViewDelegate>
//小视图
@property (weak, nonatomic) IBOutlet UIView *BackgroundView;
//选择文件
@property (weak, nonatomic) IBOutlet UIButton *SelectFile;
//提交图片
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ChestCardLayout;

@property (weak, nonatomic) IBOutlet UIButton *CommitImage
;
@property (weak, nonatomic) IBOutlet UIScrollView *ScrollView;
//mainview的背景
@property (weak, nonatomic) IBOutlet UIView *MainBackgroundView;
//滚动视图

@property (weak, nonatomic) IBOutlet UIButton *RmoveViewBut;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *KeyBookLayout;
@property (weak, nonatomic) IBOutlet UIView *Card;
@property (weak, nonatomic) IBOutlet UIView *KeyBook;
@property (weak, nonatomic) IBOutlet UIButton *KeyBtnBooke;
@property (weak, nonatomic) IBOutlet UIButton *ChestCardBtn;

//工厂方法创建
+(Custom_Popover5*)initWithLoadView5;
@end
