//
//  Custom_Popover6.h
//  BYFCApp
//
//  Created by 王鹏 on 15/12/7.
//  Copyright © 2015年 PengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Custom_Popover6 : UIView

@property (weak, nonatomic) IBOutlet UIPickerView *ListPickerView;
@property (weak, nonatomic) IBOutlet UIPickerView *ListPickerView2;
@property (weak, nonatomic) IBOutlet UIView *BackgroundView;
@property (weak, nonatomic) IBOutlet UIButton *Sure;
+(Custom_Popover6*)initWithCustomView6;
@end
