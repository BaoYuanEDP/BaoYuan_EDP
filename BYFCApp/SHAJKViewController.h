//
//  SHAJKViewController.h
//  BYFCApp
//
//  Created by zzs on 15/3/2.
//  Copyright (c) 2015年 PengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SHAJKViewController : UIViewController<UIAlertViewDelegate,UIScrollViewDelegate>
{
    UIScrollView *scroll;
    UIImageView *image33;
    UILabel *check;
    UIImageView *image1;
    UIImageView *heng7;
    UIImageView *heng77;
    UIImageView *heng777;
    UIView *smallView;
    UIView *smallView2;
    UIView *smallView3;
    UIButton *gongfeiBtn;
    UIButton *zifeiBtn;
    BOOL hideV2;
     BOOL hideV3;
    UITextField *miaoshuTF2;
    UIImageView *heng8;
}
@property(nonatomic,strong)NSDictionary *dict;
@property(nonatomic,strong)NSDictionary *dict2;
@property(nonatomic,strong)NSDictionary *dict3;
@end
