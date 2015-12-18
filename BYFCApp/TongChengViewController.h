//
//  TongChengViewController.h
//  BYFCApp
//
//  Created by zzs on 15/2/2.
//  Copyright (c) 2015年 PengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TongChengViewController : UIViewController<UIAlertViewDelegate>
{
    UIButton *gongfeiBtn;
    UIButton *zifeiBtn;
}
@property(nonatomic,strong)NSDictionary *dict;
@end
