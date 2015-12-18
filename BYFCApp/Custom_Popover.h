//
//  Custom_Popover.h
//  BYFCApp
//
//  Created by Wangpu_IOS on 15/12/3.
//  Copyright © 2015年 PengLee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PL_Header.h"
@interface Custom_Popover : UIView
@property (weak, nonatomic) IBOutlet UIButton *TestBut;
@property (weak, nonatomic) IBOutlet UIButton *upImageBtn;
@property (weak, nonatomic) IBOutlet UIButton *selectImage;
@property (weak, nonatomic) IBOutlet CycleScrollView *imageScrollView;
@property (weak, nonatomic) IBOutlet UIView *yellowView;

//实例化xib view
+(Custom_Popover*)initCustomView;
@end
