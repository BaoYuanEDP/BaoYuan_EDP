//
//  Custom_Popover3.h
//  BYFCApp
//
//  Created by 王鹏 on 15/12/4.
//  Copyright © 2015年 PengLee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PL_Header.h"
@interface Custom_Popover3 : UIView<UITextFieldDelegate>
+(Custom_Popover3*)initCustom_Popover3;
@property (weak, nonatomic) IBOutlet UIButton *selectImages;
@property (weak, nonatomic) IBOutlet UIButton *upXiuGaibtn2;
@property (weak, nonatomic) IBOutlet UIView *imageViews;

@property (weak, nonatomic) IBOutlet UITextField *qianPeiPrice;
@property (weak, nonatomic) IBOutlet UIButton *qianPeiData;
@property (weak, nonatomic) IBOutlet UITextField *qianPeiDataTextField;
@property (weak, nonatomic) IBOutlet UIView *qianPeiView;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@end
