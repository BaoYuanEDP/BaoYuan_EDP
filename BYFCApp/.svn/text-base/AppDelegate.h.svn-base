//
//  AppDelegate.h
//  BYFCApp
//
//  Created by PengLee on 14/12/2.
//  Copyright (c) 2014年 PengLee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXApi.h"
#import "PeopleInfoVC.h"
#import "JSON.h"
//warning NSLOG WILL SHOW

#if DEBUG
#define NSLog(...) NSLog(__VA_ARGS__)
#define debugMethod() NSLog(@"%s",__func__)

#else
#define NSLOG(...)
#define debugMethod()
#endif



@interface AppDelegate : UIResponder <UIApplicationDelegate,WXApiDelegate,UIAlertViewDelegate>
{
    NSString * trackUrl;
  
    
}
@property (strong, nonatomic) UIWindow *window;
@property (strong,nonatomic)UIViewController * viewController;

//判断略过当前路径防止备份到iCloud,发布时被拒，写在入口类
-(BOOL)addSkipBackupAttributeToItemAtURL:(NSURL *)URL;
-(BOOL)isEnableWIFI;
-(BOOL)isEnable3g;


@end

