//
//  MainViewController.m
//  BYFCApp
//
//  Created by zzs on 14/12/3.
//  Copyright (c) 2014年 PengLee. All rights reserved.
//

#import "MainViewController.h"
#import "VisiterViewController.h"
#import "PersonSearchViewController.h"
#import "PL_Header.h"
#import "NoticeCell.h"
#import "LookAboutAddView.h"

#define ANGLE2RADIAN(angle) (angle*M_PI/180.0)
#define DURATION 0.8f

//判断iphone6
#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
//判断iphone6+
#define iPhone6Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)

typedef NS_ENUM(NSUInteger, AnimationType)
{
    AnimationTypeFade = 0,//淡入淡出
   AnimationTypePush ,//推挤
    AnimationTypeCube,//3d立方效果
    AnimationTypeReavle,//揭开
    
    
};
typedef NS_ENUM(NSUInteger  , SubTypeString) {
    SubTypeStringFromLeft ,//从左边进入
    SubTypeStringFromRight,
    SubTypeStringFromBottom,
    SubTypeStringFromTop,
    
};
@interface MainViewController ()<WXApiDelegate,MenuDelegate,UIAlertViewDelegate>
{
//    本地通知的实例
    UILocalNotification*Notification;
//    筛选出来的数据
    
    NSString *newBanBen;
    NSString *appNumStr;
  
   }
@property(nonatomic,strong)NSMutableArray*dataSourceArray ;
@end
@interface PLCustomButton:UIButton
@property(nonatomic,assign)int angle;

@end
@implementation PLCustomButton
@synthesize angle;


@end

@implementation MainViewController


@synthesize resultArray;
-(NSMutableArray *)dataSourceArray
{
    if (!_dataSourceArray) {
        _dataSourceArray = [[NSMutableArray alloc]init];
    }
    return _dataSourceArray;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    _scene = WXSceneTimeline;
    NSString * name = [PL_USER_STORAGE objectForKey:PL_USER_TRUE_NAME];
        nameLable.text = [NSString stringWithFormat:@"您好,%@",name];
    nameLable.textColor = [UIColor blackColor];
    nameLable.font = [UIFont boldSystemFontOfSize:22];

    newBanBen = [[NSUserDefaults standardUserDefaults]objectForKey:@"NEW"];
    
    if ([newBanBen isEqualToString:@"1"]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"警告" message:@"请更新版本否则应用无法正常使用" delegate:self cancelButtonTitle:@"更新" otherButtonTitles:nil,nil];
        [alert show];
    }

}
-(void)applicationFinishedRestoringState
{
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
//    /*********本地通知的方法***************/
   
  Notification.applicationIconBadgeNumber=0;
    
      

    //添加背景图片
    UIImageView * mainImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, PL_SYSTEM_VERSION_ISIOS7?20:0,PL_WIDTH , 60)];
    mainImage.image = [UIImage imageNamed:@"IndexTitle.png"];
    
   // [self.view addSubview:mainImage];
    self.view.backgroundColor = PL_CUSTOM_COLOR(237, 237, 237, 1);
    //设置按钮
    UIButton * setBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    setBtn.backgroundColor = [UIColor clearColor];
    setBtn.frame = CGRectMake(8, PL_SYSTEM_VERSION_ISIOS7?30.0:10.0f, 27, 27);
    [setBtn setBackgroundImage:[UIImage imageNamed:FIRST_VIEW_SETTING] forState:UIControlStateNormal];
    [setBtn addTarget:self action:@selector(setClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:setBtn];
   
    
    //更多按钮
    UIButton * moreBnt = [UIButton buttonWithType:UIButtonTypeCustom];
    moreBnt.frame = CGRectMake(PL_WIDTH-35, PL_SYSTEM_VERSION_ISIOS7?30:10,27, 27);
    moreBnt.backgroundColor = [UIColor clearColor];
    [moreBnt setBackgroundImage:[UIImage imageNamed:FIRST_VIEW_MOREBUTTON] forState:UIControlStateNormal];
    moreBnt.contentMode = UIViewContentModeScaleAspectFit;
    [moreBnt addTarget:self action:@selector(clickMore) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.view addSubview:moreBnt];
    nameLable = [[UILabel alloc]initWithFrame:CGRectMake((PL_WIDTH-100)/2, PL_SYSTEM_VERSION_ISIOS7?30:10, 100, 20)];
    NSString * name = [PL_USER_STORAGE objectForKey:PL_USER_TRUE_NAME];
    if(name == nil || [name isKindOfClass:[NSNull class]])
    {
        ViewController *vc = [[ViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    nameLable.text = [NSString stringWithFormat:@"你好,%@",name];
    nameLable.adjustsFontSizeToFitWidth =YES;
    nameLable.textColor = [UIColor lightGrayColor];
    nameLable.font = [UIFont boldSystemFontOfSize:20];
    nameLable.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:nameLable];
    
      float R  = 0;
    if (iPhone6Plus) {
      R  = 100;
    }else
    {
         R  = 88;
    }
    
    float screenWidth = [UIScreen mainScreen].bounds.size.width;
    float screenHeight =[UIScreen mainScreen].bounds.size.height;
                         
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    if (iPhone6Plus)
    {
        btn.bounds= CGRectMake(0, 0, 97, 110);
    }
    else
    {
        btn.bounds= CGRectMake(0, 0, 85, 98);
    }
    
    if (screenHeight<=480)
    {
         btn.center = CGPointMake(screenWidth/2, screenHeight/3+15);
    }
    else
    {
         btn.center = CGPointMake(screenWidth/2, screenHeight/3+12);
    }
   
    [btn setBackgroundImage:[UIImage imageNamed:BY_LOGO_IMAGE] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(personClick) forControlEvents:UIControlEventTouchUpInside];
    
    btn.backgroundColor = [UIColor clearColor];
    float btnCEnter = btn.center.x;
    float btnY = btn.center.y;
    
    
    [self.view addSubview:btn];
    NSArray * arraybg = [NSArray arrayWithObjects:BY_ROOM_SOURCE_IMAGE,BY_CUSTOM_SOURCE_IMAGE,BY_CHECK_SOURCE_IMAGE,BY_APPLY_SOURCE_IMAGE,BY_WARNING_SOURCE_IMAGE,BY_BACK_SOURCE_IMAGE, nil];
    
    for (int i=0; i<6; i++)
    {
        PLCustomButton * button = [[PLCustomButton alloc]init];
        if (iPhone6Plus)
        {
            button.bounds= CGRectMake(0, 0, 97, 110);
        }
        else
        {
            button.bounds= CGRectMake(0, 0, 85, 98);
        }
        [button setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",arraybg[i]]] forState:UIControlStateNormal];
        button.tag = 1000+i;
        [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        button.backgroundColor = [UIColor clearColor];
        
        button.angle = (i-1)*60;
       
        
        
        
        float x,y;
        float radian =ANGLE2RADIAN(button.angle);
        x = btnCEnter +R*cosf(radian);
        y = btnY +R*sinf(radian);
        if (i==0 || i==5 )
        {
            button.center  = CGPointMake(x, y);
            
            
        }
        else
        {
            
            if (i==2 || i==3)
            {
                button.center =CGPointMake(x, y);
            }
            else
            {
                button.center = CGPointMake(x, y);
            }
            
            
            
        }
        
        
        [self.view addSubview:button];
    }
    PL_SAFE_BLOCK(weak);
   
    
#pragma mark --添加公告活动列表
    transView = [[CATransView alloc]initWithFrame:CGRectMake(15, PL_SYSTEM_VERSION_ISIOS7?PL_HEIGHT- (PL_HEIGHT/3+30)+20:2*PL_HEIGHT/3-30, PL_WIDTH-15, PL_HEIGHT/3+30) setBackGroundImage:[UIImage imageNamed:redImageViewBG] loadWithButtonImage:[UIImage imageNamed:@"sanheng.png"] completeBack:^(id obj) {
        NSLog(@"1232");
        [weak transitionWithType:kCATransitionReveal WithSubtype:kCATransitionFromBottom ForView:transView];
        //[weak.view exchangeSubviewAtIndex:1 withSubviewAtIndex:2];
        [weak.view bringSubviewToFront:blackView];
        [UIView animateWithDuration:0.3 animations:^{
             blackView.frame = CGRectMake(0, PL_SYSTEM_VERSION_ISIOS7?PL_HEIGHT+20- PL_HEIGHT/3-20:PL_HEIGHT-PL_HEIGHT/3-20, PL_WIDTH, PL_HEIGHT/3+20);
            transView.frame =CGRectMake(15, PL_SYSTEM_VERSION_ISIOS7?PL_HEIGHT- (PL_HEIGHT/3+30)+20:2*PL_HEIGHT/3-30, PL_WIDTH-15, PL_HEIGHT/3+30) ;
            
            [blackView setNeedsDisplay];
            [transView setNeedsDisplay];
        }];
        
       
        
        
    }];
    transView.isChangeColor = NO;
    
    [self.view addSubview:transView];
     blackView = [[CATransViewBlack alloc]initWithFrame:CGRectMake(0, PL_SYSTEM_VERSION_ISIOS7?PL_HEIGHT+20- PL_HEIGHT/3-20:PL_HEIGHT-PL_HEIGHT/3-20, PL_WIDTH, PL_HEIGHT/3+20) setBackGroundImage:[UIImage imageNamed:grayImageView] loadWithButtonImage:[UIImage imageNamed:@"sanheng.png"] completeBack:^(id obj) {
        NSLog(@"54236");
         [weak transitionWithType:kCATransitionReveal WithSubtype:kCATransitionFromBottom ForView:blackView];
         [weak.view bringSubviewToFront:transView];
         //[weak.view exchangeSubviewAtIndex:2 withSubviewAtIndex:1];
         [UIView animateWithDuration:0.3 animations:^{
        transView.frame =CGRectMake(0, PL_SYSTEM_VERSION_ISIOS7?PL_HEIGHT+20- PL_HEIGHT/3-20:PL_HEIGHT-PL_HEIGHT/3-20, PL_WIDTH, PL_HEIGHT/3+20) ;
            blackView.frame =CGRectMake(15, PL_SYSTEM_VERSION_ISIOS7?PL_HEIGHT- (PL_HEIGHT/3+30)+20:2*PL_HEIGHT/3-30, PL_WIDTH-15, PL_HEIGHT/3+30) ;
             
             [transView setNeedsDisplay];
         }];
        
         
        
    }];
    blackView.isChangeColor = YES;
    
   
    
    
    [self.view addSubview:blackView];
    [[MyRequest defaultsRequest]getNoticeList:@"1" page:@"30" userName:[PL_USER_STORAGE objectForKey:PL_USER_NAME] passToken:[PL_USER_STORAGE objectForKey:PL_USER_TOKEN] call:^(NSArray *dict) {
        

        blackView.colloletionArray = [NSMutableArray arrayWithArray:dict];
        
        
        [blackView.catableView reloadData];
        
       
        
    }];

    
   
    

    
    
    
    
}
- (void)viewDidAppear:(BOOL)animated
{
    [[MyRequest defaultsRequest]getNoticeList:@"1" page:@"30" userName:[PL_USER_STORAGE objectForKey:PL_USER_NAME] passToken:[PL_USER_STORAGE objectForKey:PL_USER_TOKEN] call:^(NSArray *dict) {
        
     blackView.colloletionArray = [NSMutableArray arrayWithArray:dict];
     [blackView.catableView reloadData];
        
        //NSLog(@"%@",resultArray);
        
    }];

}
#pragma CATransition动画实现
- (void) transitionWithType:(NSString *) type WithSubtype:(NSString *) subtype ForView : (UIView *) view
{
    //创建CATransition对象
    CATransition *animation = [CATransition animation];
    
    //设置运动时间
    animation.duration = DURATION;
    
    //设置运动type
    animation.type = type;
    if (subtype != nil) {
        
        //设置子类
        animation.subtype = subtype;
    }
    
    //设置运动速度
    animation.timingFunction = UIViewAnimationOptionCurveEaseInOut;
    
    [view.layer addAnimation:animation forKey:@"animation"];
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 1000) {
        PeopleInfoVC* controller = [PeopleInfoVC new];
        
        
        [self presentViewController:controller animated:YES completion:nil];
        
    }
    else
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.pgyer.com/Svof"]];

    }
    
}

-(void)hongseBtn
{
    NSLog(@"hhh");
    
}
#pragma mark --点击我的提醒进入个人提醒
-(void)changePage
{
    NSLog(@"红色改变背景");
}
#pragma mark --点击右侧更多按钮
-(void)clickMore
{
    NSLog(@"点击更多");
   // PL_ALERT_SHOW(@"更多功能敬请期待");
//    NSString * appVersion = APP_VERSION_NUM;
//    NSArray * moreArray = @[@"帮助",@"介绍",appVersion];
    NSArray * moreArray = @[@"日志",@"点击扫描二维码"];
    
    MainMenuView * menuView = [[MainMenuView alloc]initWithTile:nil loadWithArray:moreArray isOpenWithDirection:tableAnimationRight];
    menuView.delegate = self;
    [menuView showAnimation:YES];
    
}
#pragma mark -- 设置按钮点击
-(void)setClick
{
    NSLog(@"设置");
    PL_ALERT_SHOW(@"设置功能敬请期待");
//    NSArray * setArray = @[@"注销账户"];
//    MainMenuView * menuView = [[MainMenuView alloc]initWithTile:nil loadWithArray:setArray isOpenWithDirection:tableAnimationLeft];
//    menuView.delegate = self;
//    [PL_USER_STORAGE removeObjectForKey:PL_USER_code];
//    [PL_USER_STORAGE removeObjectForKey:PL_USER_USERID];
//    [PL_USER_STORAGE removeObjectForKey:PL_USER_TOKEN];
//
//    
   // [menuView showAnimation:YES];
    
}
- (void)didselectRow:(NSInteger)row cellTile:(NSString *)title tableShowDeriction:(TableAnimation)showderiction
{
    if (showderiction ==tableAnimationLeft)
    {
         NSLog(@"%ld 左边 %@",(long)row,title);
        //[PL_USER_STORAGE removeObjectForKey:PL_USER_NAME];
        [PL_USER_STORAGE removeObjectForKey:PL_USER_TOKEN];
        [PL_USER_STORAGE removeObjectForKey:PL_USER_COOKIES];
        [PL_USER_STORAGE removeObjectForKey:PL_USER_PASSWORD];
        [PL_USER_STORAGE synchronize];
        
        KeychainItemWrapper * keychin = [[KeychainItemWrapper alloc]initWithIdentifier:@"Gesture" accessGroup:nil];
        [keychin resetKeychainItem];
        
        // [keychin objectForKey:(__bridge id)kSecValueData];
        //  NSArray * vc = self.navigationController.viewControllers;
        ViewController * view = [[ViewController alloc]init];
        
        [self.navigationController pushViewController:view animated:YES];
    }
    else
    {
        NSLog(@"右");
        if (row==0)
        {
            self.navigationController.navigationBarHidden = NO;
//            BOOL isEq = NO;
////            [self.navigationController pushViewController:[WarningViewController new] animated:YES];
//            PersonSearchListVC *personVC = [[PersonSearchListVC alloc] initWithNibName:@"PersonSearchListVC" bundle:nil];
//            personVC.isEqCell = isEq;
//            UpgradeVC *upVC = [[UpgradeVC alloc] initWithNibName:@"UpgradeVC" bundle:nil];
//             [self.navigationController pushViewController:upVC animated:YES];
//            VersionTableViewController*VersionTableView=[VersionTableViewController new];
//            [self.navigationController pushViewController:VersionTableView animated:YES];
            DailyrecordViewController *vc = [[DailyrecordViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            
        }
        else if(row == 1)
        {
            self.navigationController.navigationBarHidden = NO;
            TwoMaViewController * vc = [[TwoMaViewController alloc] initWithNibName:@"TwoMaViewController" bundle:nil];
            [self.navigationController pushViewController:vc animated:YES];
        }
        else
        {
            self.navigationController.navigationBarHidden = NO;
            
            [self.navigationController pushViewController:[BackVC new] animated:YES];
        }
        
    }
   
    
}

#pragma mark --点击logo
-(void)personClick
{
    NSLog(@"个人");
    PeopleInfoVC * people = [[PeopleInfoVC alloc]init];
    
    people.navigationController.navigationBarHidden = NO;
    people.title = @"个人信息";
    [self.navigationController pushViewController:people animated:YES];
    }
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)btnClick:(UIButton *)sender {
    switch (sender.tag) {
        case 1000:
            NSLog(@"房源");
            self.navigationController.navigationItem.hidesBackButton = YES;
            [self.navigationController pushViewController:[RoomSourceVC new] animated:YES];
            break;
        case 1001:
            NSLog(@"客源");
            self.navigationController.navigationItem.hidesBackButton = YES;
            [self.navigationController pushViewController:[VisiterViewController new] animated:YES];
            break;
        case 1002:
            NSLog(@"审核");
            [self.navigationController pushViewController:[CheckVC new] animated:YES];
            
            
            break;
        case 1003:
            NSLog(@"锁");
            //PL_ALERT_SHOW(@"该功能暂未开放");
            [self.navigationController pushViewController:[ApplyViewController new] animated:YES];
            // [self.navigationController pushViewController:[CardViewController new] animated:YES];
            
            break;
        case 1004:
            NSLog(@"叹号");
            //PL_ALERT_SHOW(@"该功能暂未开放");
            self.navigationController.navigationBarHidden = NO;
            
            //            [self.navigationController pushViewController:[WarningViewController new] animated:YES];
            [self.navigationController pushViewController:[PersonSearchViewController new] animated:YES];
            
            break;
        case 1005:
            NSLog(@"恢复");
            //PL_ALERT_SHOW(@"该功能暂未开放");
            self.navigationController.navigationBarHidden = NO;
            
            [self.navigationController pushViewController:[BackVC new] animated:YES];
            
            break;
            
        default:
            break;
            
    }
}

@end