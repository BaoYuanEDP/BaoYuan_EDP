//
//  PL_Header.h
//  BYFCApp
//
//  Created by PengLee on 14/12/2.
//  Copyright (c) 2014年 PengLee. All rights reserved.
//

#ifndef BYFCApp_PL_Header_h
#define BYFCApp_PL_Header_h

#if DEBUG
#define NSLog(...) NSLog(__VA_ARGS__)
#define debugMethod() NSLog(@"%s",__func__)

#else
//#define NSLog(...)
#define debugMethod()
#endif

#define USER_LOGIN_URL_ADDRESS @"http://10.55.253.21:9091/APPcommonInterface.asmx"
//个别控件颜色修改
#define PL_CUSTOM_COLOR(R,G,B,A)  [UIColor colorWithRed:R/255.0f green:G/255.0f blue:B/255.0f alpha:A]
//外网地址
#define URL_DDEFAULT @"ws.bypro.com.cn"
//个人信息界面接口
#define PersonalUrlInfoUrl @"http://ws.bypro.com.cn/AppPropertyInterface.asmx"
//适配代码
#define PL_LEFT_RIGHT_TOP UIViewAutoresizingFlexibleTopMargin| UIViewAutoresizingFlexibleRightMargin| UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth| UIViewAutoresizingFlexibleBottomMargin
//获取设备
#define PL_SYSTEM_VERSION_ISIOS7 ([[[UIDevice currentDevice] systemVersion]doubleValue]>7.0)
//获取屏幕的宽高


#define PL_WIDTH     [UIScreen mainScreen].bounds.size.width
#define PL_HEIGHT   [UIScreen mainScreen].bounds.size.height
//获取控制器的宽高
#define kPL_Width CGRectGetMaxX(self.view.frame)
#define kPL_Height CGRectGetMaxY(self.view.frame)

//xitong 存储

#define PL_USER_STORAGE [NSUserDefaults standardUserDefaults]
//
//----------------------------------------------------------
#define PL_ALERT_SHOW(MSG)  [UIAlertView showAlertViewWithMessage:MSG]
//打开代理的提示框
#define PL_ALERT_SELF_SHOW(msg1,msg2) [[[UIAlertView alloc]initWithTitle:msg1 message:msg2 delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"注销", nil]show];



//加载提示框
#define PL_PROGRESS_SHOW  [[ShowActivityLoad shareDefault]showStatusAndDeterminnaterProgress]
#define PL_PROGRESS_IMAGE [[ShowActivityLoad shareDefault]showImage]
#define PL_PROGRESS_RUN [[ShowActivityLoad shareDefault]showRun]
#define PL_PROGRESS_DISMISS  [KVNProgress dismiss]

//block  安全保护--self


#define PL_SAFE_BLOCK(weakSelf)  __weak typeof(self) weakSelf = self


//app版本升级获取对比
#define APP_VERSION_NUM [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

//cell内空间高度宏定义  房源列表内部空间
#define kPLAvaterImageWidth 80
#define kPLAvaterImageHeight kPLAvaterImageWidth
//距离俯视图左边间距
#define kPLTableViewCellLeftEdges 20
//距离空间纵向间距
#define kPLhorisionCelledgedSpace 3
//空间横向间距
#define kPLvterCellSpace 10
#define kPLzuLableWidth 20
#define kPLshaleLableHeight kPLzuLableWidth
//字体大小
#define kPLStatusSystemFontSize 11
#define kPLautoLableSize(string) [string sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:kPLStatusSystemFontSize]}]
#define kPLAutoSizeLable(str,mesWidth) [str boundingRectWithSize:CGSizeMake(mesWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:kPLStatusSystemFontSize]} context:nil].size

//学区房  经理推荐  急售标签大小





//客户资料
//用户名
#define PL_USER_NAME        @"userName"
#define PL_USER_TRUE_NAME         @"UserName"
#define PL_USER_USERID      @"UserId"
#define PL_USER_PASSWORD    @"passWord"
#define PL_NO_LOGIN_        @"NOLOGIN"
//#define PL_USER_PASSWORD    @""
#define PL_USER_TOKEN       @"Token"
#define PL_USER_DUTYCODE    @"DutyCode"
#define PL_USER_SORT        @"Sort"
#define PL_USER_SUPCODE         @"Supercode"
#define PL_USER_UNITFULLCODE    @"UnitFullCode"

#define PL_ALERTVIEW_SHOW(msg)  [[[UIAlertView alloc]initWithTitle:@"提醒" message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil , nil]show]
#define PL_USER_COOKIES     @"isRecord"
#import "MyRequest.h"
#import "VisitersRequest.h"
#import "BYPersonInfo.h"

#import "MainViewController.h"
#import "RoomSourceVC.h"

#import "RoomData.h"
#import "PeopleInfoVC.h"
#import "SBJSON.h"
#import "ViewController.h"
#import "MyVisiterCell.h"
#import "AVisiterDetailViewController.h"
#import "VisiterData.h"
#import "AppointVisiterData.h"
#import "ViewController.h"
#import "PSWResetViewController.h"
#import "GesturePasswordController.h"
#import "PriceRangeData.h"
#import "CustomersFollowData.h"
#import "ADDPropertyContactData.h"
#import "CustFollowListData.h"
#import "CheckVC.h"
#import "RoomDetailVC.h"
#import "ZuViewController.h"

#import "CountRequest.h"
#import "UIButton+PLButtonTtile.h"
#import "UIImage+ImageScaleSize.h"
#import "NSString+Extetion.h"
#import "UIAlertView+AlertCustom.h"
#import "UIButton+PLButtonTtile.h"
#import "ShowActivityLoad.h"


#import "UMSocial.h"
#import "MJRefresh.h"
#import "ApplyViewController.h"
#import "BMapKit.h"
#import "BMKMapView.h"
#import "BMKLocationComponent.h"
#import "PortViewController.h"
#import "WebViewController.h"
#import "PackageViewController.h"
#import "KunShanWebViewController.h"
#import "sinaViewController.h"
#import "TongChengViewController.h"
#import "GanJiViewController.h"
#import "Comon.h"
#import "CardViewController.h"
#import "CWStarRateView.h"
#import "SWTableViewCell.h"
#import "RoomCustomCell.h"
#import "AddData.h"
#import "SHViewController.h"
#import "SHAJKViewController.h"
#import "CardData.h"
#import "HolidayViewController.h"
#import "AllFollowViewController.h"
#import "MyVisiterCustomCell.h"
#import "XJViewController.h"
#import "SinaListViewController.h"
#import "SouFangListViewController.h"
#import "KSListViewController.h"
#import "TCListViewController.h"
#import "GJListViewController.h"
#import "phoneTableViewCell.h"
#import "VisiterViewController.h"
#import "VisterTypeViewController.h"
#import  "VisiterDetailSetViewController.h"
#import "TransformKYViewController.h"
#import "VisiterUpdate.h"
#import "FollowUpViewController.h"
#import "FollowUpListViewController.h"
#import "FollowUpListTableViewCell.h"
#import "RoomFollowUpListViewController.h"
#import "RoomGenjinTableViewCell.h"
#import "LookAboutAddView.h"
#import "LookAboutRoomTableViewCell.h"

#import "UIViewController+feedback.h"
#import "feed.h"
#import "TimeFilterView.h"
#import "MoreMenuVC.h"
#import "MoreVisterViewController.h"
#import "PhoneNumberTableViewCell.h"
#import "ReviseFYView.h"
#import "ReviseFYViewController.h"
#import "ChageTableViewCell.h"
#import "VisterInfo.h"
#import "SelectPersonAndZoneView.h"
#import "LookAboutTableViewCell.h"
#import "LookAboutViewController.h"
#import "DatePickerView.h"
#import "GosenResultView.h"
#import "GoseeResultTableViewCell.h"
#import "LookSeeView.h"
#import "PersonSearchCellTableViewCell.h"
#import "PersonSearchCellModel.h"
#import "PersonSearchListVC.h"
//#import "UpgradeVC.h"
#import "GoOutApplyListCellModel.h"
#import "GoOutApplyListCell.h"
#import "GoOutApplyListViewController.h"
#import "PortListTableViewCell.h"
#import "PortListViewCellModel.h"
#import "RHSignTimeData.h"
#import "CardLookViewController.h"
#import "CardLookViewCell.h"
#import "CardLookViewCellModel.h"
#import "XJViewModel.h"
#import "HolidayCustomCell.h"
#import "RoomLostViewController.h"
#import "JiuCuoCell.h"

#import "NewReviseFYViewController.h"
#import "NewHolidayViewController2.h"
#import "MoreVisterViewController.h"
#import "TwoMaViewController.h"
#import "AllFollowRoomViewController.h"
#import "JiaoYiTypeViewController.h"
#import "HolidayCell.h"
#import "HolidayListViewCell.h"
#import "HolidayListMode.h"
#import "HolidayListViewController.h"
#import "DailyrecordViewController.h"
#import "RoomCustomLable.h"
#import "RoomRquestModel.h"
#import "CalendarHomeViewController.h"
#import "CalendarViewController.h"
#endif
