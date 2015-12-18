//
//  sinaViewController.h
//  BYFCApp
//
//  Created by zzs on 15/1/30.
//  Copyright (c) 2015年 PengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface sinaViewController : UIViewController<UIAlertViewDelegate>
{
    UIButton *gongfeiBtn;
    UIButton *zifeiBtn;
}

@property(nonatomic,strong)NSDictionary *dict;
@end
