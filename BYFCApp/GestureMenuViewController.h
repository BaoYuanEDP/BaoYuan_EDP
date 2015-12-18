//
//  GestureMenuViewController.h
//  BYFCApp
//
//  Created by PengLee on 15/4/13.
//  Copyright (c) 2015年 PengLee. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol GestureMenuViewControllerDelegate<NSObject>
-(void)dismiss;
@end


@interface GestureMenuViewController : UIViewController
{
    NSArray * viewContrs ;
}
@property(weak,nonatomic) id<GestureMenuViewControllerDelegate>delegate;
@property(copy,nonatomic) void (^dicBlock)(NSMutableDictionary *);
-(void)getAStringByBlock:(void(^)(NSMutableDictionary *dic))block;
@property (nonatomic, strong) NSString *str12;
@property (nonatomic, strong) NSMutableDictionary *dic;
//楼栋号
@property (nonatomic,strong) NSString *louDongNum;
@property (nonatomic,strong) NSString *num1;
@property (nonatomic,strong) NSString *num2;
//房源类型
@property (nonatomic,strong) NSString *roomSourceType;
//是否有图
@property (nonatomic,strong) NSString *isHaveImage;

//委托状态
@property (strong,nonatomic)NSString *jiaoYiStyle;
//有效天数选择
@property (strong,nonatomic)NSString *statusLimitAcceptStr;
//自定义有效时间结束时间
@property (strong,nonatomic)NSString *effectiveDateToAcceptStr;
//自定义有效时间开始时间
@property (strong,nonatomic)NSString *effectiveDateFromAcceptStr;
//有效员工编号
@property (strong,nonatomic)NSString *userCodeAcceptStr;


//房源类型
@property (strong,nonatomic)NSString *tradeAcceptStr;
//房屋现状
@property (strong,nonatomic)NSString *propertyOccupyAcceptStr;
//物业归属
@property (strong,nonatomic)NSString *propertyOwn1AcceptStr;
//房屋类型几室几厅
@property (strong,nonatomic)NSString *countFTAcceptStr;
//房屋类型室
@property (strong,nonatomic)NSString *countFAcceptStr;
//房屋类型厅
@property (strong,nonatomic)NSString *countTAcceptStr;

//建筑面积100-200平米
@property (strong,nonatomic)NSString *squareFromToAcceptStr;
//建筑面积100平米
@property (strong,nonatomic)NSString *squareFromAcceptStr;
//建筑面积200平米
@property (strong,nonatomic)NSString *squareToAcceptStr;

//房屋朝向
@property (strong,nonatomic)NSString *propertyDirectionAcceptStr;
//签赔
@property (strong,nonatomic)NSString *propertyTrustAcceptStr;
//业主联系方式
@property (strong,nonatomic)NSString *custTelAcceptStr;


@property (strong,nonatomic)UITableView * customTableView;


@end
