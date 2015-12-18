//
//  JiaoYiTypeViewController.h
//  BYFCApp
//
//  Created by PengLee on 15/10/8.
//  Copyright (c) 2015年 PengLee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MoreVisterViewController.h"
@interface JiaoYiTypeViewController : UIViewController
{
    //    交易状态
    BOOL isSelected;
    BOOL isSelected1;
    BOOL isSelected2;
    BOOL isSelected3;
    BOOL isSelected4;
    BOOL isSelected5;
    BOOL isSelected6;
    BOOL isSelected7;
}
@property(nonatomic,strong)NSString *jiaoyiString;
@property(nonatomic,strong)MoreVisterViewController *moreVC;
@end
