//
//  JiuCuoCell.h
//  BYFCApp
//
//  Created by PengLee on 15/8/12.
//  Copyright (c) 2015年 PengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JiuCuoCell : UITableViewCell <UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UITextViewDelegate>
{
    NSArray *arrayType;
}
//纠错类型
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
//下拉按钮
@property (weak, nonatomic) IBOutlet UIButton *dropBtn;
//下拉按钮点击事件
- (IBAction)dropAction:(id)sender;
//纠错内容
@property (weak, nonatomic) IBOutlet UITextField *jiuCuoText;
//纠错类型背景
@property (weak, nonatomic) IBOutlet UITextField *textField1;
//纠错描述
@property (weak, nonatomic) IBOutlet UITextView *jiuCuoDescription;
@property (weak, nonatomic) IBOutlet UIImageView *btnImage;

@end
