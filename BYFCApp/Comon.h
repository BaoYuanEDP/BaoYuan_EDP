//
//  Comon.h
//  BYFCApp
//
//  Created by PengLee on 15/2/2.
//  Copyright (c) 2015年 PengLee. All rights reserved.
//

#ifndef BYFCApp_Comon_h
#define BYFCApp_Comon_h
//****
 //请求类宏定义
#define PL_MYREQUEST_DEFAULT [MyRequest defaultsRequest]

//获取用户名和密码

#define PL_USER_COREDATA_NAME [PL_USER_STORAGE objectForKey:PL_USER_NAME]
#define PL_USER_COREDATA_TOKEN [PL_USER_STORAGE objectForKey:PL_USER_TOKEN]

#define PL_USER_ENTER @"background_card"
//用户code
#define PL_USER_code @"UserCode"
#define PL_USER_DutyCodeIsE @"DutyCodeIsE"
//登录用户电话
#define PL_USER_PHONE @"User_Phone"
#define PL_EN_CODE @"encode"
//上级编号
#define PL_SUP_CODE @""
//54b730dcfd98c5d5ed000a3b
//微信分享key
#define PL_SHARE @"55a5c4f667e58e903b007641";
/**
 @prama
 */
#define PL_ROOM_DETAIL_FOLLOWTYPE_LIST @"FollowType"
#define PL_ROOM_DETAIL_FOLLOWWAY_LIST @"FollowWay"
//
/*
 @prama

*/

#define PL_ALERT_SHOWNOT_OKAND_YES(MSG)  [UIAlertView showAlertViewWithMessage:MSG]
//判断外网和内网 正式版发布 test1 = 16,   测试版 test1 = 14
static  NSInteger test1=14,test2=15;
//内网URL
//@"http://61.129.51.211:9091/"   http://10.55.253.21:9091/
#define PL_content_url_tesg @"http://61.129.51.211:9091/"
//外网URL
#define PL_outWan_url_http @"http://ws.bypro.com.cn/"

//获取考勤url
//@"http://ws.bypro.com.cn/AppHRAttendanceInterface.asmx"
#define PL_USER_SIGN [NSString stringWithFormat:@"%@AppHRAttendanceInterface.asmx",test1<test2?PL_content_url_tesg:PL_outWan_url_http]
//获取考勤切换Url
//@"http://ws.bypro.com.cn/AppHRAttendanceInterface.asmx"
#define PL_USER_SIGNOR [NSString stringWithFormat:@"%@AppHRAttendanceInterface.asmx",test1<test2?PL_content_url_tesg:PL_outWan_url_http]
//请假上传图片
///@"http://10.55.253.21:9091/AppHRAttendanceInterface.asmx"
#define PL_USER_UPLOADLEAVEPIC [NSString stringWithFormat:@"%@AppHRAttendanceInterface.asmx",test1<test2?PL_content_url_tesg:PL_outWan_url_http]

//房源列表URL
///@"http://10.55.253.21:9091/AppPropertyInterface.asmx"
#define PL_USER_ROOMLIST [NSString stringWithFormat:@"%@AppPropertyInterface.asmx",test1<test2?PL_content_url_tesg:PL_outWan_url_http]
//房源纠错接口
#define PL_USER_ADDERRORPRO [NSString stringWithFormat:@"%@AppPropertyInterface.asmx",test1<test2?PL_content_url_tesg:PL_outWan_url_http]
//联系人URL
///@"http://10.55.253.21:9091/AppcommonInterface.asmx"
#define PL_USER_PERSION [NSString stringWithFormat:@"%@AppcommonInterface.asmx",test1<test2?PL_content_url_tesg:PL_outWan_url_http]
//外出申请查看
///@"http://10.55.253.21:9091/AppHRAttendanceInterface.asmx"
#define PL_USER_GOOUTAPPLY [NSString stringWithFormat:@"%@AppHRAttendanceInterface.asmx",test1<test2?PL_content_url_tesg:PL_outWan_url_http]
//名片申请查看
#define PL_USER_CARDLOOK [NSString stringWithFormat:@"%@AppBHMSInterface.asmx",test1<test2?PL_content_url_tesg:PL_outWan_url_http]
//网站端口申请
///
#define PL_USER_PORTLIST [NSString stringWithFormat:@"%@AppBHMSInterface.asmx",test1<test2?PL_content_url_tesg:PL_outWan_url_http]

//日志url
///@"http://10.55.253.21:9091/AppcommonInterface.asmx"
#define PL_USER_UPFRADE [NSString stringWithFormat:@"%@AppcommonInterface.asmx",test1<test2?PL_content_url_tesg:PL_outWan_url_http]

//更新电话号码url
/**
 *  http://10.55.253.21:9091/AppCustomerInterface.asmx
 */

#define PL_USER_UPDATETELEPHONE [NSString stringWithFormat:@"%@AppCustomerInterface.asmx",test1<test2?PL_content_url_tesg:PL_outWan_url_http]



//客源列表URl
//@"http://10.55.253.21:9091/AppCustomerInterface.asmx"
#define PL_USER_KEYUAN_LIST [NSString stringWithFormat:@"%@AppCustomerInterface.asmx",test1<test2?PL_content_url_tesg:PL_outWan_url_http]
//主页公告通用URL
//@"http://10.55.253.21:9091/AppCommonInterface.asmx"
#define PL_USER_NOTICE_LIST [NSString stringWithFormat:@"%@AppCommonInterface.asmx",test1<test2?PL_content_url_tesg:PL_outWan_url_http]
//单条数据请假
#define PL_USER_CHNECKLEVA_ONE  [NSString stringWithFormat:@"%@AppHRAttendanceInterface.asmx",test1<test2?PL_content_url_tesg:PL_outWan_url_http]

//多条请假列表
#define PL_USER_MUTIBARHOLIDAY_LIST  [NSString stringWithFormat:@"%@AppHRAttendanceInterface.asmx",test1<test2?PL_content_url_tesg:PL_outWan_url_http]


//销假列表
#define PL_USER_GETATTENDANCE_LIST  [NSString stringWithFormat:@"%@AppHRAttendanceInterface.asmx",test1<test2?PL_content_url_tesg:PL_outWan_url_http]
//申请界面网站接口
//@"http://ws.bypro.com.cn/AppBHMSInterface.asmx"
#define PL_USER_INTERNET_ROOT_URL [NSString stringWithFormat:@"%@AppBHMSInterface.asmx",test1<test2?PL_content_url_tesg:PL_outWan_url_http]

//申请提交
#define PL_USER_CARD_CUMMIT_URL [NSString stringWithFormat:@"%@AppBHMSInterface.asmx",test1<test2?PL_content_url_tesg:PL_outWan_url_http]

//修改意向度http://ws.bypro.com.cn/APPInterface.asmx
#define PL_USER_UPDATE_LEVEL_URL [NSString stringWithFormat:@"%@AppCustomerInterface.asmx",test1<test2?PL_content_url_tesg:PL_outWan_url_http]
//培训申请提交
#define PL_USER_leeav [NSString stringWithFormat:@"%@AppHRAttendanceInterface.asmx",test1<test2?PL_content_url_tesg:PL_outWan_url_http]
//培训申请数据请求http://10.55.253.21:9091/AppHRAttendanceInterface.asmx?op=GetLessonList
#define PL_USER_GETLIST [NSString stringWithFormat:@"%@AppHRAttendanceInterface.asmx",test1<test2?PL_content_url_tesg:PL_outWan_url_http]

//请假列表
#define PL_USER_LEAVE_LIST_URL [NSString stringWithFormat:@"%@AppHRAttendanceInterface.asmx",test1<test2?PL_content_url_tesg:PL_outWan_url_http]
//请假申请修改
#define PL_USER_UPDATELEAVE [NSString stringWithFormat:@"%@AppHRAttendanceInterface.asmx",test1<test2?PL_content_url_tesg:PL_outWan_url_http]
//房源登记缺失
#define PL_USER_LOST_URL [NSString stringWithFormat:@"%@AppPropertyInterface.asmx",test1<test2?PL_content_url_tesg:PL_outWan_url_http]
//外出申请
#define PL_USER_GOTO_URL [NSString stringWithFormat:@"%@AppHRAttendanceInterface.asmx",test1<test2?PL_content_url_tesg:PL_outWan_url_http]

//跟进全部
#define PL_USER_ALL_FOLLOW_URL [NSString stringWithFormat:@"%@AppCustomerInterface.asmx",test1<test2?PL_content_url_tesg:PL_outWan_url_http]

//客源请求筛选价格
//@""
#define PL_USER_PRICE_LOE_HEIGHT_URL [NSString stringWithFormat:@"%@APPInterface.asmx",test1<test2?PL_content_url_tesg:PL_outWan_url_http]
//审核界面URL

#define PL_USER_CHECK_URL [NSString stringWithFormat:@"%@APPAudit/MyExaminelist.aspx?userId=",test1<test2?PL_content_url_tesg:PL_outWan_url_http]



//获取添加推广房源接口
//@"http://10.55.253.21:9091/Housing/Anjuke.asmx"
#define PL_USER_ADD_HOUSER_SOURCE [NSString stringWithFormat:@"%@Housing/Anjuke.asmx",test1<test2?PL_content_url_tesg:PL_outWan_url_http]

//新增客源
//http://10.55.253.21:9091/AppCustomerInterface.asmx
#define PL_USER_ADD_CUSTOMER [NSString stringWithFormat:@"%@AppCustomerInterface.asmx",test1<test2?PL_content_url_tesg:PL_outWan_url_http]

//套餐模块接口
//@“http://10.55.253.21:9090/AppBHMSInterface.asmx”
#pragma mark --新闻URL 
#define BY_NEWS_URL @"http://61.129.51.211:9090/AppDetailPages/aboutcompany.html"
#define BY_INDRUCT_PRODUCT_URL @"http://61.129.51.211:9090/AppDetailPages/AppInstructions.html"
#define BY_SHARE_URL @"http://61.129.51.211:9090/AppDetailPages/PropertyDetail.aspx?"
//
//934d556ceab9ef56a3e48b7ef3954c15  宝原蒲公英发布平台appkey
#define Pg_sdk_id @"934d556ceab9ef56a3e48b7ef3954c15"

//判断设备
#define PL_SYSTEM_VERSION_COMPARE  [[[UIDevice currentDevice]systemVersion]doubleValue] 
//调整字体
#define PL_USER_fONT_SIZE 12
#define PL_ROOM_DETAIL_FONT_SIGN_SIZE 13
#define PL_DETAIL_BIG_FONT_SIZ 16
#define PL_SF_FONT_DETAIL 18
#define pl_alpha 0.3
#define BOOKMARK_WORD_LIMIT 100
//上海安居客 appkey   和sign

#define PL_USER_SH_ANJUKE_APP_KEY @"1315b1cd6dc140ab9c56921993d474be"
#define PL_USER_SH_ANJUKE_SIGN     @"c4442e6508bc46cfb9b16c8a9dd453e8"

//昆山安居客 appkey  he   sign

#define PL_USER_KS_ANJUKE_APPKEY @"8b341fc0535a459592ebdbd573b1585d"
#define PL_USER_KS_ANJUKE_SIGN   @"29a9dd8b2ff80b1fdb795157019a5382"
//后台控制器记录KEY
#define PL_USER_BACKGROUND_KEY @"ViewControllerBackground"
#pragma mark --记录程序是否是第一次启动
#define APP_FIRST_LAUNCH @"app_first_launch"
//已经启动过
#define APP_EVER_LAUNCH_AGAIN @"app_ever_launch"
#define APP_FIRST_LAUNCH_BOOL [MyRequest firstLunch]

//电话登录人电话
#define PL_USER_PHONEnUM @"User_Phone_numbewr"




#import "AFNetworking.h"
#import "GDataXMLNode.h"
#import "SignTimeData.h"
#import "Masonry.h"
#import "RoomCustomLable.h"
#import "UIButton+Externtions.h"
#import "RoomDetailCell.h"
#import "LouPanCell.h"
#import "WriteLoadCell.h"
#import "TelViewAlert.h"
#import "UIView+TextEX.h"
#import "TSPopoverController.h"
#import "RoomTableViewController.h"

#import "CATransView.h"
#import "CATransViewBlack.h"
#import "ConstHeaderFile.h"
#import "BackVC.h"
#import "WarningViewController.h"
#import "WebView.h"
#import "MainMenuView.h"
#import "AWActionSheet.h"
#import "GenjinView.h"
#import "CustomAddView.h"
#import "NSString+TestPhoneNum.h"
#import "WriteMessageCell.h"
#import "AutocompletionTableView.h"
#import <PgySDK/PgyManager.h>
#import "PMCalendar.h"
#import "MyAlertView.h"
#import "NSString+AutosizeLable.h"
#import "SinaVC.h"
#import "ChineseInclude.h"
#import "PinYinForObjc.h"
#import "GestureMenuViewController.h"
#import "MoreMenuVC.h"
#import "RoomStyleViewController.h"
#import "MoreMenuVC.h"
#endif
