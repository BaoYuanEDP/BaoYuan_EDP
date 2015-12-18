//
//  LookAboutViewController.h
//  BYFCApp
//
//  Created by PengLee on 15/5/21.
//  Copyright (c) 2015年 PengLee. All rights reserved.
//

#import <UIKit/UIKit.h>
enum
{
    ViewFrom_Room = 0,
    ViewFrom_Vister,
};
typedef NSInteger ViewFrom;

@interface LookAboutViewController : UIViewController<UITableViewDataSource,UITabBarDelegate>
@property(nonatomic,assign) ViewFrom fromType;
@property(strong,nonatomic) NSString *subUserCode;
@end
