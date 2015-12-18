//
//  Utility.m
//
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Utility.h"
//#import "TCGlobal.h"
//#import "GTMBase64.h"
//#import "DBhelper.h"
#import "AppDelegate.h"
#import <Foundation/Foundation.h>
//#import "HotelOrderModel.h"
#import <arpa/inet.h> // For AF_INET, etc.
#import <ifaddrs.h> // For getifaddrs()
#import <net/if.h> // For IFF_LOOPBACK
#include <sys/socket.h> // Per msqr
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>
//#import "OpenUDID.h"
#import "sys/utsname.h"
//#import "TCSourceVersionModel.h"
//#import "TCDateFormatter.h"
//#import "TCKeychain.h"
//#import "Reachability.h"
//#import "MBProgressHUD.h"
//#import "OpenUDID.h"

#define SYSTEM_VERSION                              ([[[UIDevice currentDevice] systemVersion] floatValue])

@implementation Utility
@synthesize sizeCache;

+ (void)checkIOS6AndIOS7:(UIViewController*)viewControl{
    if ([viewControl respondsToSelector:@selector(edgesForExtendedLayout)])
    {
        viewControl.edgesForExtendedLayout = UIRectEdgeNone;
        viewControl.extendedLayoutIncludesOpaqueBars = NO;
        viewControl.modalPresentationCapturesStatusBarAppearance = NO;
    }
}

+(NSString *)getValueBySetting:(NSString *)key{
    NSString *value;
//    NSPredicate *condition = [NSPredicate predicateWithFormat:@"key = %@",key];
//    NSMutableArray *array = [DBhelper searchWithPredicateByEntity:def_ModelName_Source_Version withKeys:condition];
//    if (array.count == 0) {
//        TCSourceVersionModel *setting = [DBhelper insertWithEntity:def_ModelName_Source_Version];
//        setting.key = key;
//        setting.value = @"0";
//        value = @"0";
//    }else {
//        TCSourceVersionModel *setting = (TCSourceVersionModel *)[array objectAtIndex:0];
//        value = setting.value;
//    }
//    [[AppDelegateEntity managedObjectContext] save:nil];
    return value;
}

//+(int)getExpriedTime
//{
//    int cacheexpireTime;
//    Reachability * hostReach=[Reachability reachabilityWithHostName:@"0.0.0.0"];
//    switch ([hostReach currentReachabilityStatus]) {
//        case ReachableViaWiFi:
//            cacheexpireTime=5;
//            break;
//        case ReachableVia3G:
//        case ReachableVia4G:
//            cacheexpireTime=10;
//            break;
//        case ReachableVia2G:
//            cacheexpireTime=30;
//            break;
//        default:
//            cacheexpireTime=5;
//        break;
//    }
//    return  cacheexpireTime;
//}

//获取网络类型
//+(NSString*)getNetWork{
//    
//    Reachability *hostReach = [Reachability reachabilityWithHostName:@"www.ly.com"]  ;
//    [hostReach startNotifier];
//    NetworkStatus status= [hostReach currentReachabilityStatus];
//    //未知，Wifi，2G，3G，4G，
//    
//    if (status == ReachableVia2G)
//    {
//        return @"2G";
//    }else if (status == ReachableVia3G){
//        return @"3G";
//    }else if (status == ReachableViaWiFi){
//        return @"Wifi";
//    }else if (status == NotReachable){
//        return @"NotNetwork";
//    }
//    return @"NotNetwork";
//}

//广告id
+(NSString*)getIdfa{
//    if (SYSTEM_VERSION >=6.0) {
//        return [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
//    }
    return @"";
}

/**
 *  获取唯一标识
 *
 *  @return  唯一值
 */
//+(NSString*)getDeviceid{
//    
//    NSString * deviceId = [TCKeychain getObjectForKey:KEY_DEVICEID];
//    
//    if (deviceId.length<=0) {
//        deviceId = [[NSUserDefaults standardUserDefaults] valueForKey:deviceIdKey];
//    }
//    if ( deviceId.length<=0) {
//        
//        NSString *openUDID = [[OpenUDID value] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//        if (openUDID.length>0) {
//            deviceId = openUDID;
//        }else if ([Utility getIdfa].length>0){
//            deviceId = [Utility getIdfa];
////        }else if ( AppDelegateEntity.devicePushToken.length>0){
////            deviceId = AppDelegateEntity.devicePushToken;
//        }else{
//            //idfv
//            if (SYSTEM_VERSION >=6.0) {
//                deviceId = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
//            }
//        }
//        
//        [TCKeychain setObject:deviceId forKey:KEY_DEVICEID];
//        
//        [[NSUserDefaults standardUserDefaults] setValue:deviceId forKey:deviceIdKey];
//        [[NSUserDefaults standardUserDefaults] synchronize];
//    }
//    return deviceId;
//}

+(NSString *)getMacAddress
{
//    if (SYSTEM_VERSION >=7.0) {
//        return @"";
//    }
	int                    mib[6];
	size_t                len;
	char                *buf;
	unsigned char        *ptr;
	struct if_msghdr    *ifm;
	struct sockaddr_dl    *sdl;
	
	mib[0] = CTL_NET;
	mib[1] = AF_ROUTE;
	mib[2] = 0;
	mib[3] = AF_LINK;
	mib[4] = NET_RT_IFLIST;
	
	if ((mib[5] = if_nametoindex("en0")) == 0) {
		printf("Error: if_nametoindex error/n");
		return NULL;
	}
	
	if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
		printf("Error: sysctl, take 1/n");
		return NULL;
	}
	
	if ((buf = malloc(len)) == NULL) {
		printf("Could not allocate memory. error!/n");
		return NULL;
	}
	
	if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
		printf("Error: sysctl, take 2");
		return NULL;
	}
	
	ifm = (struct if_msghdr *)buf;
	sdl = (struct sockaddr_dl *)(ifm + 1);
	ptr = (unsigned char *)LLADDR(sdl);
	// NSString *outstring = [NSString stringWithFormat:@"%02x:%02x:%02x:%02x:%02x:%02x", *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
	NSString *outstring = [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x", *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
	free(buf);
	return [outstring uppercaseString];
	
}

//返回设备型号，如果是最新的设备型号，如果不在这个返回，就返回identifier，根据对照表去找
//http://theiphonewiki.com/wiki/Models
+(NSString *)getCurrentDeviceModelName
{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    NSArray *modelArray = @[
                            @"i386", @"x86_64",
                            
                            @"iPhone1,1",
                            @"iPhone1,2",
                            @"iPhone2,1",
                            @"iPhone3,1",
                            @"iPhone3,2",
                            @"iPhone3,3",
                            @"iPhone4,1",
                            @"iPhone5,1",
                            @"iPhone5,2",
                            @"iPhone5,3",
                            @"iPhone5,4",
                            @"iPhone6,1",
                            @"iPhone6,2",
                            @"iPhone7,1",
                            @"iPhone7,2",
                            
                            @"iPod1,1",
                            @"iPod2,1",
                            @"iPod3,1",
                            @"iPod4,1",
                            @"iPod5,1",
                            
                            @"iPad1,1",
                            @"iPad2,1",
                            @"iPad2,2",
                            @"iPad2,3",
                            @"iPad2,4",
                            @"iPad3,1",
                            @"iPad3,2",
                            @"iPad3,3",
                            @"iPad3,4",
                            @"iPad3,5",
                            @"iPad3,6",
                            
                            @"iPad2,5",
                            @"iPad2,6",
                            @"iPad2,7",
                            ];
    NSArray *modelNameArray = @[
                                
                                @"iPhone Simulator", @"iPhone Simulator",
                                
                                @"iPhone 2G",
                                @"iPhone 3G",
                                @"iPhone 3GS",
                                @"iPhone 4(GSM)",
                                @"iPhone 4(GSM Rev A)",
                                @"iPhone 4(CDMA)",
                                @"iPhone 4S",
                                @"iPhone 5(GSM)",
                                @"iPhone 5(GSM+CDMA)",
                                @"iPhone 5c(GSM)",
                                @"iPhone 5c(Global)",
                                @"iphone 5s(GSM)",
                                @"iphone 5s(Global)",
                                @"iPhone 6 Plus",
                                @"iPhone 6",
                                
                                @"iPod Touch 1G",
                                @"iPod Touch 2G",
                                @"iPod Touch 3G",
                                @"iPod Touch 4G",
                                @"iPod Touch 5G",
                                
                                @"iPad",
                                @"iPad 2(WiFi)",
                                @"iPad 2(GSM)",
                                @"iPad 2(CDMA)",
                                @"iPad 2(WiFi + New Chip)",
                                @"iPad 3(WiFi)",
                                @"iPad 3(GSM+CDMA)",
                                @"iPad 3(GSM)",
                                @"iPad 4(WiFi)",
                                @"iPad 4(GSM)",
                                @"iPad 4(GSM+CDMA)",
                                
                                @"iPad mini (WiFi)",
                                @"iPad mini (GSM)",
                                @"ipad mini (GSM+CDMA)"
                                ];
    NSInteger modelIndex = - 1;
    NSString *modelNameString = nil;
    modelIndex = [modelArray indexOfObject:deviceString];
    if (modelIndex >= 0 && modelIndex < [modelNameArray count]) {
        modelNameString = [modelNameArray objectAtIndex:modelIndex];
    }else{
        modelNameString =[deviceString stringByAppendingString:@"(machine值，需要对照表)"];
        
    }
    return modelNameString;
//    NSLog(@"----设备类型---%@",modelNameString);
//    return [NSString stringWithFormat:@"Identifier:%@,Generation:%@",]
}

//判断设备是否在5S以上
+ (BOOL)higherThaniPhone5S
{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    if ([deviceString hasPrefix:@"iPhone"])
    {
        NSRange range = [deviceString rangeOfString:@","];
        deviceString = [deviceString substringToIndex:range.location];
        deviceString = [deviceString substringFromIndex:6];
        
        if (deviceString.integerValue >= 6)
        {
            return YES;
        }
        else
        {
            return NO;
        }
    }
    else
    {
        return NO;
    }
}

/*
 *  根绝设定规则返回每日签到的URL
 */
+(NSString *)generateMemberSignUrl
{
    
    //————————————modify by  yangyong	Start—————————————
    //格式http://172.16.8.132/deal/membersign.html?mid=123&pwd=fjlsdfljf&ts=4444444&sign=frewlj
    //mid:memberid;pwd,用户密码md5加密后全部字母小写，ts时间戳整数；
    //sign: string Md5Str = MD5Help.GetMD5(mid + pwd.ToLower() + ts + key, "utf-8");
    //key :        wl865@#$(!dd76dfg82
    
    /*
     1.原来正常的登录，添加一个stype=0
     stype = 0时，mid，pwd有效 md5:MD5Help.GetMD5(mid + stype + pwd.ToLower() + ts + key, "utf-8");
     url格式：http://172.16.8.132/deal/membersign.html?mid=xxx&stype=0&pwd=yyyyyy&ts=1234&sign=fdsfl
     2.
     第三方登录的自动登录后走这个逻辑
     stype：1 ：QQ 2 ：新浪微博 3 ：支付宝 是第三方的socialType
     stype != 0时，mid,stype, uid,有效 md5:MD5Help.GetMD5(mid + stype + uid + ts + key, "utf-8");
     url格式：http://172.16.8.132/deal/membersign.html?mid=xxx&stype=(1,2,3任意一种)&uid=xxxxxx&ts
     */
    
//    if (![[TCMember sharedMember] isLogin]) {
//        return nil;
//    }
//    
//    NSString *userId=TCUserDefaultEntity.userId;
//    NSString *socialType=TCUserDefaultEntity.socialType;
//    NSString *memberid  =[[[TCMember sharedMember] responseLogin] memberId];
//    
////    NSString *pwd=[ProtocolEngine aesDecryptAndBase64Decode:TCUserDefaultEntity.accountPassWord];
////    NSString *pwdmd5       =[pwd MD5EncodedString];
//    NSString *pwdmd5lower=@"";//[pwdmd5 lowercaseString];
//    
//    int ts=(int)[[NSDate date] timeIntervalSince1970];
//    
//    NSString *key=@"wl865@#$(!dd76dfg82";
//    
//    NSString *sign=nil;
//    NSString *url=nil;
//    
//    NSInteger type=[socialType integerValue];
//    if (type==0) {
//        const char *s=[[[NSString stringWithFormat:@"%@%d%@%d%@",memberid,type,pwdmd5lower,ts,key] MD5EncodedString] UTF8String];
//        sign=[NSString stringWithUTF8String:s];
//        url=[NSString stringWithFormat:@"stype=0&mid=%@&pwd=%@&ts=%d&sign=%@",memberid,pwdmd5lower,ts,sign];
//    }else{
//        const char *s=[[[NSString stringWithFormat:@"%@%d%@%d%@",memberid,type,userId,ts,key] MD5EncodedString] UTF8String];
//        sign=[NSString stringWithUTF8String:s];
//        
//        url=[NSString stringWithFormat:@"stype=%d&mid=%@&uid=%@&ts=%d&sign=%@",type,memberid,userId,ts,sign];
//    }
//    
//    if (url.length==0) {
//        return nil;
//    }
//    
//    NSString *baseUrl = AppDelegateEntity.getHomeIndex.writeList.signIn.url;
//    //如果接口没返用以下写死的连接
//    if (baseUrl.length<=0) {
//        baseUrl = @"http://app.ly.com/deal/membersign.html?wvc2=1&wvc3=1&";
//    }
//    NSString *returnUrl=[NSString stringWithFormat:@"%@%@",baseUrl,url];
//#ifdef TC_HTTP_DEBUG_REQUEST
//    NSLog(@"会员签到链接=%@",returnUrl);
//#endif
//    return returnUrl;
    //————————————modify by  yangyong 	 End—————————————
    
    return nil;
    
}

//+(void)showTips:(NSString *)_tips view:(UIView *)_view
//{
//    MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:_view animated:YES];
//    hud.mode=MBProgressHUDModeText;
//    hud.labelText=_tips;
//    hud.removeFromSuperViewOnHide=YES;
//    [hud show:YES];
//    [hud hide:YES afterDelay:0.8];
//}
@end


@interface UIFont (MethodExchange)
+(void)exchangeMethod:(SEL)origSel withNewMethod:(SEL)newSel;
@end

#import <objc/runtime.h>

@implementation UIFont (MethodExchange)

+(void)exchangeMethod:(SEL)origSel withNewMethod:(SEL)newSel{
    Class class = [self class];
    
    Method origMethod = class_getInstanceMethod(class, origSel);
    if (!origMethod){
        origMethod = class_getClassMethod(class, origSel);
    }
    if (!origMethod)
        @throw [NSException exceptionWithName:@"Original method not found" reason:nil userInfo:nil];
    Method newMethod = class_getInstanceMethod(class, newSel);
    if (!newMethod){
        newMethod = class_getClassMethod(class, newSel);
    }
    if (!newMethod)
        @throw [NSException exceptionWithName:@"New method not found" reason:nil userInfo:nil];
    if (origMethod==newMethod)
        @throw [NSException exceptionWithName:@"Methods are the same" reason:nil userInfo:nil];
    method_exchangeImplementations(origMethod, newMethod);
}

@end

