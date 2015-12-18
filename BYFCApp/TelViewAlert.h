//
//  TelViewAlert.h
//  BYFCApp
//
//  Created by PengLee on 15/2/11.
//  Copyright (c) 2015年 PengLee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "PL_Header.h"
#import "CWStarRateView.h"
@protocol TelDialNumDelegate;
enum{
    callType_Vister = 0,    //房源
    callType_Room,          //客源
    
};
typedef NSInteger callType;
@interface TelViewAlert : UIView
{
    UITableView * _telTableView;
  
    UILabel *fangshi;
    UIButton *fangshiBtn;
    UIView *sousuoView;
    UILabel *style;
}
@property(nonatomic,strong) __block NSMutableArray * acceptArray;
@property NSString * stringTitle;
//接收任意类型的数据block
@property(nonatomic,copy) void (^backBlock)(id obj);
@property (strong, nonatomic) CWStarRateView *starRateView;



@property id<TelDialNumDelegate>delegate;
- (instancetype)initWithconnectWithArray:(NSArray *)array Calltype:(callType)type custId:(NSString *)ID;

- (void)showTelWindow:(UIView *)myview;


@end
@protocol TelDialNumDelegate <NSObject>
- (void)closeWindowTel;

@optional


@end