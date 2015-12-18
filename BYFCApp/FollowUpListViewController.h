//
//  FollowUpListViewController.h
//  BYFCApp
//
//  Created by zzs on 15/5/21.
//  Copyright (c) 2015年 PengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FollowUpListViewController : UIViewController
{

    NSArray *genjinfangshiArray;
    NSArray *jiaoyileixingArray;
    //genjin类型nssstring
    NSString *genjinleixingStr;
    //跟进方式nssstring
    NSString *genjinfangshiStr;
    //交易类型
    NSString *jiaoyileixingStr;
    //跟进日期第一个
    NSString *firstdateTimeStr;
    //跟进日期第二个
    NSString *lastdateTimeStr;

    
}
@property(nonatomic,strong)NSString *dutyCode;
@end
