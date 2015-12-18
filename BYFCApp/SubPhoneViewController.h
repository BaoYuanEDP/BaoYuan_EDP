//
//  SubPhoneViewController.h
//  BYFCApp
//
//  Created by zzs on 15/4/20.
//  Copyright (c) 2015年 PengLee. All rights reserved.
//

#import <UIKit/UIKit.h>
enum
{
    TypeSub_Vister = 0,
    TypeSub_Room,
};
typedef NSInteger TypeSub;
@interface SubPhoneViewController : UIViewController
@property(nonatomic,assign) TypeSub typeSub;
@end
