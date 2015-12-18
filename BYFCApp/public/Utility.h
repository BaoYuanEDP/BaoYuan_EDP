//
//  Utility.h
//  
//
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface Utility : NSObject
{
    float sizeCache;
}
@property (nonatomic) float sizeCache;

//检查是否ios6还是7
+ (void)checkIOS6AndIOS7:(UIViewController*)viewControl;

//获取网络类型
//+(NSString*)getNetWork;

//广告id
//+(NSString*)getIdfa;

//mac地址
//+(NSString *)getMacAddress;

/**
 *  获取唯一标识
 *
 *  @return  唯一值
 */
//+(NSString*)getDeviceid; 

/**
 *  获取数据库某表的版本号
 *
 *  @param key 表名
 *
 *  @return 版本号
 */
//+(NSString *)getValueBySetting:(NSString *)key;

/*----------------------比较两个时间差值－*/
/*-------------获取不同网络环境下过期时间－－－－－－－*/
//+(int)getExpriedTime;


//返回设备型号，如果是最新的设备型号，如果不在这个返回，就返回identifier，根据对照表去找
//+(NSString *)getCurrentDeviceModelName;

//判断设备是否在5S以上
//+(BOOL)higherThaniPhone5S;

/*
 *  根绝设定规则返回每日签到的URL,未登录或不符合规则，则返回nil
 */
//+(NSString *)generateMemberSignUrl;

/**
 *  显示0.8s的tips
 *
 *  @param _tips 文案
 *  @param _view 显示的view
 */
//+(void)showTips:(NSString *)_tips view:(UIView *)_view;

@end


