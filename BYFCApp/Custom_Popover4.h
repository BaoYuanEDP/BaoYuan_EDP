//
//  Custom_Popover4.h
//  BYFCApp
//
//  Created by 王鹏 on 15/12/4.
//  Copyright © 2015年 PengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Custom_Popover4 : UIView<UITextFieldDelegate,UITextViewDelegate>
+(Custom_Popover4*)initCustom_Popover4;
@property (weak, nonatomic) IBOutlet UIButton *miMakeyBtn;
@property (weak, nonatomic) IBOutlet UIButton *lookKeyBtn;
@property (weak, nonatomic) IBOutlet UIButton *baoyuanBtn;
@property (weak, nonatomic) IBOutlet UIButton *hangjiaBtn;
@property (weak, nonatomic) IBOutlet UITextField *PhoneNumber;
@property (weak, nonatomic) IBOutlet UIButton *fenhangBtn;
@property (weak, nonatomic) IBOutlet UIButton *salesmanBtn;
@property (weak, nonatomic) IBOutlet UITextView *beizhuTextView;
@property (weak, nonatomic) IBOutlet UIButton *upXiuGaiBtn;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (weak, nonatomic) IBOutlet UIView *keyView;
@property (weak, nonatomic) IBOutlet UIView *LinkmanView;
@property (weak, nonatomic) IBOutlet UITextField *numKeyTextField;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *QianPeiViewLayout;
@end
