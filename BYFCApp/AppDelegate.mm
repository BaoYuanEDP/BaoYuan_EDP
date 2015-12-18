//
//  AppDelegate.m
//  BYFCApp
//
//  Created by PengLee on 14/12/2.
//  Copyright (c) 2014年 PengLee. All rights reserved.
//
#import "AppDelegate.h"
#import "GesturePasswordController.h"
#import "ViewController.h"
#import "PL_Header.h"
#import "Reachability.h"
#import "UMSocialWechatHandler.h"
#import "ShakeFeed.h"
#import "UMessage.h"
#import "GesturePasswordView.h"
#import <AVFoundation/AVFoundation.h>
#define UMSYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
@interface AppDelegate ()<BMKGeneralDelegate>
{
    Reachability *hostReach;
      BMKMapManager * _manager;
  
      NSTimer* timer3;
    NSTimer*timer4;
    NSTimer*timer5;
    NSTimer*timer6;
    NSString*comstr2;
    NSString*comstr;
    NSString *appNumStr;

    
}
 @property (nonatomic, strong) Reachability *conn;
@property(nonatomic,strong)NSMutableArray*dataSourceArray ;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self UmengMessage:launchOptions];
    
   

    /****************************本地通知的配置****************************/
    
    if ([[UIApplication sharedApplication] respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge|UIUserNotificationTypeSound|UIUserNotificationTypeAlert categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        
        NSLog(@"执行到里面了");
    }
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(LooSeeViewNotification) name:@"LookSeeView" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(SiginNotification) name:@"SginNotification" object:nil];
    [application scheduledLocalNotifications];
    application.applicationIconBadgeNumber = 0;
        @try {
        self.window = [[ShakeFeed alloc]initWithFrame:[UIScreen mainScreen].bounds
                       ];
        application.applicationSupportsShakeToEdit = YES;
        [self becomeFirstResponder];
        self.window.backgroundColor = [UIColor whiteColor];
        //判断是否是第一次启动
        if (APP_FIRST_LAUNCH_BOOL)
        {
            NSLog(@"first  launch");
            KeychainItemWrapper * keychin = [[KeychainItemWrapper alloc]initWithIdentifier:@"Gesture" accessGroup:nil];
            [keychin resetKeychainItem];
             UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:[ViewController new]];
            self.window.rootViewController = nav;
        }
        else
        {
            NSLog(@"second launch");
            if (![PL_USER_STORAGE objectForKey:PL_USER_NAME] || ![PL_USER_STORAGE objectForKey:PL_USER_PASSWORD] || APP_FIRST_LAUNCH_BOOL)
            {
                UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:[ViewController new]];
                self.window.rootViewController = nav;
            }
            else
            {
                
                
               [self loginMyCard];
                //设置首页
               MainViewController * main = [[MainViewController alloc]init];
               UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:main];
               self.window.rootViewController = nav;
                //图案解锁
               GesturePasswordController *gesture=[[GesturePasswordController alloc]init];
               //将图案解锁放到主线程
              dispatch_async(dispatch_get_main_queue(), ^{
                    [nav  presentViewController:gesture animated:YES completion:nil];
                });
            }
        }
        //监测网络
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
        hostReach = [Reachability reachabilityWithHostName:@"www.baidu.com"];
        [hostReach startNotifier];
        
        [UMSocialData setAppKey:um_appkey];
        
        [UMSocialConfig setSupportedInterfaceOrientations:UIInterfaceOrientationMaskAll];
        [UMSocialWechatHandler setWXAppId:um_weixinappkey appSecret:um_weixinsecert url:um_url];
        
        [UMSocialData openLog:YES];
       
       
        
        [[PgyManager sharedPgyManager]setEnableFeedback:NO];
        
        [[PgyManager sharedPgyManager]startManagerWithAppId:Pg_sdk_id];
//        [[PgyManager sharedPgyManager]checkUpdate];
//        [[MyRequest defaultsRequest] GetUpgradeLogNew:@"1" userid:[PL_USER_STORAGE objectForKey:PL_USER_USERID] token:[PL_USER_STORAGE objectForKey:PL_USER_TOKEN] backInfoMessage:^(NSString *str) {
//            appNumStr = [NSString stringWithFormat:@"%@",str];
//        }];
//
#warning 强制版本更新
        appNumStr = @"1.3.7";
        NSDictionary* dict = [[NSBundle mainBundle] infoDictionary];
        NSString *app_build = [dict objectForKey:@"CFBundleShortVersionString"];
        if (![app_build isEqualToString:appNumStr]) {
            [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"NEW"];
        }
        else
        {
            [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"NEW"];
   
        }
        NSLog(@"沙盒路径：%@",NSHomeDirectory());
      
        _manager = [[BMKMapManager alloc]init];
        BOOL ret = [_manager start:map_appkey generalDelegate:self];
        if (!ret)
        {
            NSLog(@"认证失败");
            
        }
        
         [self.window makeKeyAndVisible];
        
    }
    @catch (NSException *exception) {
        NSLog(@"expect==%@",exception);
        
    }
    @finally {
        
        
    }
    return YES;
}
/**
 *  带看通知的Timer的定义
 */
-(void)LooSeeViewNotification
{
    NSError*error=nil;
    NSError*error2=nil;
    
    [[AVAudioSession sharedInstance]setCategory:AVAudioSessionCategoryPlayback error:&error];
    [[AVAudioSession sharedInstance]setActive:YES error:&error2];
    timer4=[NSTimer scheduledTimerWithTimeInterval:30 target:self selector:@selector(collocateLocaNotification) userInfo:nil repeats:YES];
    [timer4 setFireDate:[NSDate distantPast]];
    NSRunLoop*run=[NSRunLoop mainRunLoop];
    [run addTimer:timer4 forMode:NSRunLoopCommonModes];
    /****通知配置完成*///////

    NSLog(@"%s",__func__);
}
/**
 *  打卡的通知Timer的定义
 */
-(void)SiginNotification
{
    timer5=[NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(SigninNotifation) userInfo:nil repeats:YES];
    [timer5 setFireDate:[NSDate distantPast]];
    NSRunLoop*run2=[NSRunLoop mainRunLoop];
    [run2 addTimer:timer5 forMode:NSRunLoopCommonModes];
}
- (void)UmengMessage:(NSDictionary *)launchOptions
{
    //set AppKey and AppSecret
    [UMessage startWithAppkey:@"55a5c4f667e58e903b007641" launchOptions:launchOptions];
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= _IPHONE80_
    if(UMSYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0"))
    {
        
        
        
        
        
        
        //register remoteNotification types （iOS 8.0及其以上版本）
        UIMutableUserNotificationAction *action1 = [[UIMutableUserNotificationAction alloc] init];
        action1.identifier = @"action1_identifier";
        action1.title=@"Accept";
        action1.activationMode = UIUserNotificationActivationModeForeground;//当点击的时候启动程序
        
        UIMutableUserNotificationAction *action2 = [[UIMutableUserNotificationAction alloc] init];  //第二按钮
        action2.identifier = @"action2_identifier";
        action2.title=@"Reject";
        action2.activationMode = UIUserNotificationActivationModeBackground;//当点击的时候不启动程序，在后台处理
        action2.authenticationRequired = YES;//需要解锁才能处理，如果action.activationMode = UIUserNotificationActivationModeForeground;则这个属性被忽略；
        action2.destructive = YES;
        UIMutableUserNotificationCategory *categorys = [[UIMutableUserNotificationCategory alloc] init];
        categorys.identifier = @"category1";//这组动作的唯一标示
        [categorys setActions:@[action1,action2] forContext:(UIUserNotificationActionContextDefault)];
        
        UIUserNotificationSettings *userSettings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge|UIUserNotificationTypeSound|UIUserNotificationTypeAlert
                                                                                     categories:[NSSet setWithObject:categorys]];
        [UMessage registerRemoteNotificationAndUserNotificationSettings:userSettings];
        
    } else{
        //register remoteNotification types (iOS 8.0以下)
        [UMessage registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge
         |UIRemoteNotificationTypeSound
         |UIRemoteNotificationTypeAlert];
    }
#else
    
    //register remoteNotification types (iOS 8.0以下)
    [UMessage registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge
     |UIRemoteNotificationTypeSound
     |UIRemoteNotificationTypeAlert];
    
#endif
    //for log
    [UMessage setLogEnabled:YES];
    
}
#pragma mark --检测网络状态和key值是否授权成功
- (void)onGetNetworkState:(int)iError
{
    if (0 == iError) {
        NSLog(@"联网成功");
    }
    else{
        NSLog(@"onGetNetworkState %d",iError);
    }
    
}

- (void)onGetPermissionState:(int)iError
{
    if (0 == iError) {
        NSLog(@"授权成功");
    }
    else {
        NSLog(@"onGetPermissionState %d",iError);
    }
}

#pragma mark --增加忽略备份的文件的地址
-(BOOL)addSkipBackupAttributeToItemAtURL:(NSURL *)URL
{
    assert(![[NSFileManager defaultManager]fileExistsAtPath:[URL path]]);
    NSError * error = nil;
    BOOL success = [URL setResourceValue:[NSNumber numberWithBool:YES] forKey:NSURLIsExcludedFromBackupKey error:&error];
    if (success)
    {
        NSLog(@"ERRor excluding %@ from back %@",[URL lastPathComponent],error);
        
    }
    return success;
    
}


-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return [UMSocialSnsService handleOpenURL:url wxApiDelegate:nil];
}
-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [UMSocialSnsService handleOpenURL:url];
    
}
//第二次启动登录，已经存在用户名和密码
- (void)loginMyCard
{
    if ([MyRequest checkNetWorking] == NETWORK_TYPE_TEST_WIFI)
    {
        PL_ALERT_SHOWNOT_OKAND_YES(@"您当前使用的是WIFI网络");
        
    }
    else
    {
        PL_ALERT_SHOWNOT_OKAND_YES(@"您当前使用的是本地网络");
        
    }
    [[MyRequest defaultsRequest]getWebServiceData:^(NSMutableString *string) {
        NSLog(@"123++%@",string);
        SBJSON * json = [[SBJSON alloc]init];
        NSDictionary * dict = [json objectWithString:string error:nil  ];
        
        
        [PL_USER_STORAGE setValue:dict[@"UserId"] forKey:PL_USER_USERID];
        
        [PL_USER_STORAGE setObject:[NSString stringWithFormat:@"%@",dict[@"UserCode"]] forKey:PL_USER_code];
        
        NSString * string1 =[dict objectForKey:PL_USER_TOKEN];
        NSLog(@"TOKEN==%@",string1);
        [PL_USER_STORAGE setObject:string1 forKey:PL_USER_TOKEN];
        [PL_USER_STORAGE setObject:dict[PL_USER_DUTYCODE] forKey:PL_USER_DUTYCODE];
        NSLog(@"Duty code ==== %@",[PL_USER_STORAGE objectForKey:PL_USER_DUTYCODE]);
        [ PL_USER_STORAGE setObject:dict[@"User_Phone"] forKey:PL_USER_PHONEnUM];
        [PL_USER_STORAGE setObject:[dict objectForKey:@"UserName"] forKey:@"UserName"];
        [PL_USER_STORAGE setObject:[dict objectForKey:@"EncodeUserCode"] forKey:@"encode"];
        [PL_USER_STORAGE synchronize];
        
    } userName:[PL_USER_STORAGE objectForKey:PL_USER_NAME] userPass:[PL_USER_STORAGE objectForKey:PL_USER_PASSWORD]];
}
-(NSString *) compareCurrentTime:(NSDate*) compareDate
//
{
    NSTimeInterval  timeInterval = [compareDate timeIntervalSinceNow];
    timeInterval = -timeInterval;
    long temp = 0;
    NSString *result;
    if((temp = timeInterval/60) <60){
        result = [NSString stringWithFormat:@"%ld分前",temp];
        NSLog(@"=====%@",result);
        if (temp<60) {
            GesturePasswordController *gesture=[[GesturePasswordController alloc]init];
            UINavigationController *nav=[[UINavigationController alloc]initWithRootViewController:gesture];
            nav.navigationBarHidden=YES;
           // self.window.rootViewController=nav;
        }else
        {
            ViewController *view=[[ViewController alloc]init];
            UINavigationController *nav=[[UINavigationController alloc]initWithRootViewController:view];
            nav.navigationBarHidden=YES;
            self.window.rootViewController=nav;
        }
    }
    return result;
}
-(void)applicationDidFinishLaunching:(UIApplication *)application
{
    
    //检测网络状态
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
    hostReach = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    [hostReach startNotifier];
    
   }

-(void)reachabilityChanged:(NSNotification *)note
{
    
    Reachability * curReach = [note object];
    NSParameterAssert([curReach isKindOfClass:[Reachability class]]);
    NetworkStatus state = [curReach currentReachabilityStatus];
    if (state==NotReachable)
    {
        PL_ALERT_SHOWNOT_OKAND_YES(@"网络连接失败，请重新检查设置您的网络");
    }
    else
    {
        [self loginMyCard];
    }
   
}
//是否是WiFi信号
-(BOOL)isEnableWIFI
{
    return ([[Reachability reachabilityForLocalWiFi]currentReachabilityStatus]!=NotReachable);
    
}
-(BOOL)isEnable3g{
    return ([[Reachability reachabilityForInternetConnection]currentReachabilityStatus]!=NotReachable);
}

- (void)applicationWillResignActive:(UIApplication *)application {
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
    [BMKMapView willBackGround ];
   
    
}



- (void)applicationWillEnterForeground:(UIApplication *)application {
    
    if ([PL_USER_STORAGE boolForKey:APP_FIRST_LAUNCH] && ![PL_USER_STORAGE objectForKey:PL_USER_NAME] && ![PL_USER_STORAGE objectForKey:PL_USER_PASSWORD])
    {
        PL_ALERT_SHOWNOT_OKAND_YES(@"请登录");
    }
    else if([PL_USER_STORAGE objectForKey:PL_USER_NAME] && [PL_USER_STORAGE objectForKey:PL_USER_PASSWORD]  )
    {
        
        GesturePasswordController *gesture=[[GesturePasswordController alloc]init];
        NSUserDefaults*userdis= [NSUserDefaults standardUserDefaults];
//        第二次进入提示重新设置密码
        NSString*strdis  = [userdis objectForKey:@"IsDis"];
        if ([strdis isEqualToString:@"0"]) {
            
            PL_ALERT_SHOW(@"请重新设置密码");
            
        }
        [userdis setObject:@"1" forKey:@"IsDis"];
        [userdis synchronize];
        
        [self.window.rootViewController presentViewController:gesture animated:YES completion:nil];
        
    }
    
   
    
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
   
    if (![PL_USER_STORAGE objectForKey:PL_USER_NAME] || ![PL_USER_STORAGE objectForKey:PL_USER_PASSWORD])
    {
        UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:[ViewController new]];
        self.window.rootViewController = nav;
    }
    else
    {
       // [self loginMyCard];
    }
    
  
   
    [UMSocialSnsService  applicationDidBecomeActive];
    [BMKMapView didForeGround];
   }

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
//    [application registerForRemoteNotifications];

    
    [UMessage registerDeviceToken:deviceToken];
}
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{

    
    [UMessage didReceiveRemoteNotification:userInfo];
}
- (void)applicationWillTerminate:(UIApplication *)application {
   
}
- (BOOL)canBecomeFirstResponder
{
    return YES;
    
}
- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event

{
    
    
    
}
- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    
    
    
}
-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
 

    NSLog(@"前台接收到通知%@",notification.alertBody);
    
    
    
 }

-(void)applicationDidEnterBackground:(UIApplication *)application

{
    
    UIApplication*app=[UIApplication sharedApplication];
    __block UIBackgroundTaskIdentifier bgTask;
    bgTask =[app beginBackgroundTaskWithExpirationHandler:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            if (bgTask !=UIBackgroundTaskInvalid) {
                bgTask =UIBackgroundTaskInvalid;
            }
            
        });
        
    }];
    
    NSLog(@"进入后台");
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(LooSeeViewNotification) name:@"LookSeeView" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(SiginNotification) name:@"SginNotification" object:nil];
    
   }


-(void)collocateLocaNotification
{
    NSLog(@"约看时间提醒LocaNotification正在检测通知,,,,,,,");
  
    /*************客源的通知推送************/
    NSUserDefaults*USER2=[NSUserDefaults standardUserDefaults];
//    NSMutableArray*mDIc=[USER2 objectForKey:@"MainDatas"];
       NSArray*arrayV =[USER2 objectForKey:@"flowdirectionData"];
    NSMutableArray*mDIc=[NSMutableArray arrayWithArray:arrayV];
    for (int i = 0; i <mDIc.count; i++) {
        NSDictionary * dicFor =mDIc[i];
        NSString*str8=dicFor[@"Time"];
        NSDateFormatter * dateFormatter = [[NSDateFormatter alloc]init];
        dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm";
        
        NSDate*DATE=[[NSDate alloc]init];
        
        NSString*  Locastr=[dateFormatter stringFromDate:DATE];
        if ([self compareTime1:Locastr Time:str8]) {
            //    创建一个本地通知对象
            UILocalNotification*    Notification2=[[UILocalNotification alloc]init];
            Notification2.timeZone=[NSTimeZone defaultTimeZone];
            NSDate *currentDate   = [NSDate date];
            Notification2.timeZone = [NSTimeZone defaultTimeZone]; // 使用本地时区
            Notification2.fireDate = [currentDate dateByAddingTimeInterval:2];
            Notification2.alertBody=[NSString stringWithFormat:@"您好！您预约的“%@”带看即将到达，请按时抵达勿让客户久等！",dicFor[@"Content"]];
            Notification2.soundName=@"msg2.wav";
            
            Notification2.applicationIconBadgeNumber++;
            [[UIApplication sharedApplication]scheduleLocalNotification:Notification2];
            NSLog(@"客源时间判断正确发送通知");
            
           [mDIc removeObjectAtIndex:i];
                          }else
        {
            NSLog(@"客源时间比对不正确");
                    }
      
        NSUserDefaults*user5=[NSUserDefaults standardUserDefaults];
        NSArray*ArrayR=mDIc;
        [user5 setObject:ArrayR forKey:@"flowdirectionData"];
        [user5 synchronize];


    }
      /****************MainDatas5*********/

    NSUserDefaults*userDefaults=[NSUserDefaults standardUserDefaults];
    NSArray * array = [userDefaults objectForKey:@"RoomData"];

    NSMutableArray*mdic=  [NSMutableArray arrayWithArray:array];
    if ( mdic == nil  || mdic.count == 0 ) {
        return;
    }
    for (NSDictionary * dic  in mdic) {
           NSString*STR3=[[dic[@"time"] stringByReplacingOccurrencesOfString:@"T" withString:@" "]substringToIndex:16];
                /*****************结束请求********************/
        NSDateFormatter * dateFormatter = [[NSDateFormatter alloc]init];
        dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm";
        
        NSDate*DATE=[[NSDate alloc]init];
        
        NSString*  Locastr=[dateFormatter stringFromDate:DATE];
        
//        NSString*test=@"2015-08-20 16:20:00";
//        NSString*test2=@"2015-09-24 16:39:00";
        if ([self compareTime1:Locastr Time:STR3 ]) {
            
            //    创建一个本地通知对象
            UILocalNotification*    Notification=[[UILocalNotification alloc]init];
            Notification.timeZone=[NSTimeZone defaultTimeZone];
            NSDate *currentDate   = [NSDate date];
            Notification.timeZone = [NSTimeZone defaultTimeZone]; // 使用本地时区
            Notification.fireDate = [currentDate dateByAddingTimeInterval:2];
            
            Notification.alertBody=[NSString stringWithFormat:@"您好！您预约的“%@”带看即将到达，请按时抵达勿让客户久等！",dic[@"content"]];
            Notification.soundName=@"msg2.wav";
            Notification.applicationIconBadgeNumber++;
            [[UIApplication sharedApplication]scheduleLocalNotification:Notification];
            NSLog(@"房源时间判断正确发送通知");
            [mdic removeObject:dic];

                 }else
        {
            NSLog(@"房源时间比对不正确");
          }
    }
    
    NSUserDefaults*user6=[NSUserDefaults standardUserDefaults];
    NSArray * array2 = mdic;
    [user6 setObject:array2 forKey:@"RoomData"];
    [user6 synchronize];
    
       NSLog(@"后台程序还在继续");
   
}


- (BOOL) compareTime1:(NSString*)str Time:(NSString*)str3
{
    
    NSDateFormatter * dateFormatter2= [[NSDateFormatter alloc]init];
    dateFormatter2.dateFormat = @"yyyy-MM-dd HH:mm";
    
    NSDate*date3=[[NSDate alloc]init];
    
    date3 = [dateFormatter2 dateFromString:str3];
    NSDate * date = [[NSDate alloc]init];
    date = [dateFormatter2 dateFromString:str];
    //    判断30分钟以内的
    NSTimeInterval ti = [date3 timeIntervalSinceDate:date];
    if (ti <1800) {
        return YES;
    }
    return NO;
    
}
/**********打卡通知提醒********/
-(void)SigninNotifation
{
    //    获取是否是营业非营业
    NSString*DutyTypeName=[[NSUserDefaults standardUserDefaults]objectForKey:@"DutyTypeName"];
    //    获取打卡的时间
    NSString*SiginTimeduty=[[NSUserDefaults standardUserDefaults]objectForKey:@"DutySignTime2"];
    NSDateFormatter * dateFormatter2= [[NSDateFormatter alloc]init];
    dateFormatter2.dateFormat = @"yyyy-MM-dd HH:mm";
    
    
    comstr=[dateFormatter2 stringFromDate:[NSDate date]];
    
    if ([DutyTypeName isEqualToString:@"营业"]) {
        NSDateFormatter * dateFormatter3= [[NSDateFormatter alloc]init];
        dateFormatter3.dateFormat = @"yyyy-MM-dd HH:mm";
        NSDate*date5=[dateFormatter3 dateFromString:SiginTimeduty];
        NSDate*date2=[NSDate dateWithTimeInterval:9*60*60 sinceDate:date5];
        comstr2=[dateFormatter3 stringFromDate:date2];
        //        NSString*str=@"2015-10-13 11:10";
        //        判断正确之后发送通知营业的
        if ([self compareStr:comstr2 Str3:comstr]) {
            
            NSLog(@"时间正确提醒下班通知");
            [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"DutySignTime2"];
            
        }
    }else
    {
        //        非营业的发送通知
    if (SiginTimeduty.length>0) {
        NSString*comstrNew=[SiginTimeduty stringByReplacingCharactersInRange:NSMakeRange(11, 5) withString:@"18:00"];
        
        //            判断时间非营业的
        if ([self compareStr:comstr Str3:comstrNew]) {
            
            
            NSLog(@"非营业发送通知");
            [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"DutySignTime2"];
            
        }
        
    }
    
}
    
    
    NSLog(@"考勤打卡时间提醒LocaNotification正在检测,,,,,,,");
    
                }

//判断两个字符串是否相等
-(BOOL)compareStr:(NSString*)str Str3:(NSString*)str3
{
    
    if ([str isEqualToString:str3]) {
        
        UILocalNotification*LocaNotification=[[UILocalNotification alloc ]init];
        LocaNotification.timeZone=[NSTimeZone defaultTimeZone];
        NSDate *currentDate   = [NSDate date];
        LocaNotification.timeZone = [NSTimeZone defaultTimeZone]; // 使用本地时区
        LocaNotification.fireDate = [currentDate dateByAddingTimeInterval:2];
        LocaNotification.alertBody=@"您好！打卡时间快到了哦,请务必按时打卡!";
        LocaNotification.soundName=@"SiginTime.wav";
        LocaNotification.applicationIconBadgeNumber++;
        [[UIApplication sharedApplication]scheduleLocalNotification:LocaNotification];
        return YES;

    }
    
    
    return NO;

    
    
}
@end
