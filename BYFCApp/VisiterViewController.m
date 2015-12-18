//
//  VisiterViewController.m
//  BYFCApp
//
//  Created by zzs on 14/12/3.
//  Copyright (c) 2014年 PengLee. All rights reserved.
//

#import "VisiterViewController.h"
#import "CustomPullDownVC.h"
#include "MyPhoneViewController.h"
#include "SubPhoneViewController.h"
#import "SubViewController.h"
#import "PL_Header.h"
#import "MoreMenuVC.h"
#import "MoreVisterViewController.h"

#define checkNull(__X__)        (__X__) == [NSNull null] || (__X__) == nil ? @"" : [NSString stringWithFormat:@"%@", (__X__)]

#define BUTTONSIZE 80

@interface VisiterViewController ()<UIGestureRecognizerDelegate,MoreMenuVCDelegate,RoomPersonDelegate,MoreVisterViewControllerDelegate>
{
    float cellHeight;
    BOOL _isOpenView;
    CustomPullDownVC *menuDropDown;
    int freshcount;
    
    //通话记录弹出视图
    UIView *_phoneView;
    //通话记录视图是否弹出
    BOOL phoneViewIsOut;
    //
    UIButton *phonebutton;
    //背景视图
    UIView *backgroundView;
    
    NSString *dutyString;
    
    UIView *genjinView;
    
    //CUSTID
    NSString *CustID;
    
    //上级编号
    NSString *supCode;
    
}
@property(nonatomic,strong)UITableView * tableView;
@property(strong,nonatomic)UIView      * jilianView;
@property(nonatomic, strong)VisiterData *custom;
@end

@implementation VisiterViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [bgView removeFromSuperview];
    [genjinView removeFromSuperview];
    self.navigationController.navigationBarHidden=NO;
    //    if (rightIsClick==YES) {
    //        [self post2];
    //    }
    //    else
    //    {
    //        [self postRequest];
    //    }
    //
    dutyString = [PL_USER_STORAGE objectForKey:PL_USER_DUTYCODE];
    NSLog(@"Duty code1234 == %@",dutyString);
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //    [self headerRereshing];
    [self setupRefresh];
    phoneViewIsOut = NO;
    
}


#pragma mark 获取上级编号
-(void)getSupCode
{
    [[MyRequest defaultsRequest]afGetSupFromUserCode:[PL_USER_STORAGE objectForKey:PL_USER_USERID] userToken:[PL_USER_STORAGE objectForKey:PL_USER_TOKEN] completeBack:^(NSString *str) {
        supCode = str;
    }];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(Action:) name:@"sunhaichen" object:Nil];
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"FOLLOWID"];
    //初始化电话号码
    telePhoneNumberString = @"";
    pubTypeString = @"";
    jiaoYiTypeString = @"";
    //获取上级编号
    
    _array=[[NSMutableArray alloc]initWithCapacity:0];
    self.title=@"我的客源";
    //自定义返回按钮
    UIButton * backItemBnt = [UIButton buttonWithType:UIButtonTypeCustom];
    backItemBnt.frame = CGRectMake(20, 10, 10, 20);
    [backItemBnt setBackgroundImage:[UIImage imageNamed:@"返回.png"] forState:UIControlStateNormal];
    [backItemBnt addTarget:self action:@selector(returnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftBtn = [[UIBarButtonItem alloc]initWithCustomView:backItemBnt];
    self.navigationItem.leftBarButtonItem = leftBtn;
    
    //定义导航栏右键
    UIView * rightView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 110, 30)];
    rightView.backgroundColor = [UIColor clearColor];
    sikeLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 5, 75, 25)];
    sikeLable.adjustsFontSizeToFitWidth=YES;
    sikeLable.textAlignment=NSTextAlignmentRight;
    sikeLable.font = [UIFont systemFontOfSize:10];
    [rightView addSubview:sikeLable];
    
    rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(CGRectGetMaxX(sikeLable.frame), 0, 30, 30);
    rightBtn.titleLabel.font=[UIFont systemFontOfSize:17];
    [rightBtn setImage:[UIImage imageNamed:@"私客图标.png"] forState:UIControlStateNormal];
    [rightBtn setImage:[UIImage imageNamed:@"公客图标.png"] forState:UIControlStateSelected];
    
    [rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightClick01:) forControlEvents:UIControlEventTouchUpInside];
    [rightView addSubview:rightBtn];
    
    UIBarButtonItem * right = [[UIBarButtonItem alloc]initWithCustomView:rightView];
    self.navigationItem.rightBarButtonItem = right;
    
    //主表格，展示客源信息
    table=[[UITableView alloc]initWithFrame:CGRectMake(0, 37+10, ([UIScreen mainScreen].bounds.size.width), ([UIScreen mainScreen].bounds.size.height)-50-30-20) style:UITableViewStylePlain];
    table.delegate=self;
    table.dataSource=self;
    table.tableFooterView=[UIView new];
    [self.view addSubview:table];
    
    //页面底部视图
    view=[[UIView alloc]initWithFrame:CGRectMake(0, PL_HEIGHT-50, PL_WIDTH, 50+10)];
    view.backgroundColor=[UIColor colorWithRed:237.0/255.0 green:237.0/255.0 blue:237.0/255.0 alpha:1];
    
    [self.view addSubview:view];
    
    //购房客
    gouBtn=[[UIButton alloc]initWithFrame:CGRectMake(PL_WIDTH-100, 10, 80, 30)];
    [gouBtn setImage:[UIImage imageNamed:@"租房客.png"] forState:UIControlStateNormal];
    [gouBtn addTarget:self action:@selector(zuClick) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:gouBtn];
    //租房客
    zuBtn=[[UIButton alloc]initWithFrame:CGRectMake(PL_WIDTH-100, 10, 80, 30)];
    [zuBtn setImage:[UIImage imageNamed:@"购房客.png"] forState:UIControlStateNormal];
    [zuBtn addTarget:self action:@selector(gouClick) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:zuBtn];
    
    UIView *view1=[[UIView alloc]initWithFrame:CGRectMake(PL_WIDTH-120, 0, 120, 50+10)];
    view1.tag = 1;
    [view addSubview:view1];
    
    UIImageView *bgImg=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 120, 50+10)];
    bgImg.image=[UIImage imageNamed:@"属性背景.png"];
    [view1 addSubview:bgImg];
    
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(15, 10, 60, 30)];
    label.text=@"新增客源";
    label.font=[UIFont systemFontOfSize:15];
    [view1 addSubview:label];
    
    addBtn=[[UIButton alloc]initWithFrame:CGRectMake(15, 10, 80, 30)];
    [addBtn addTarget:self action:@selector(addClick:) forControlEvents:UIControlEventTouchUpInside];
    [view1 addSubview:addBtn];
    
    
    UIButton *addbutton=[[UIButton alloc]initWithFrame:CGRectMake(80, 10, 20, 30)];
    [addbutton setImage:[UIImage imageNamed:@"plussign.png"] forState:UIControlStateNormal];
    [addbutton addTarget:self action:@selector(addClick:) forControlEvents:UIControlEventTouchUpInside];
    [view1 addSubview:addbutton];
    
    //通话记录按钮
    [self addPhoneButton:view1];
    
    //页面顶部筛选栏
    _array=[[NSMutableArray alloc]initWithCapacity:0];
    
    UIImageView *bgView1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 60, PL_WIDTH, 50)];
    bgView1.image = [UIImage imageNamed:@"属性背景.png"];
    //    [self.view addSubview:bgView1];
    NSArray *topTitle=[NSArray arrayWithObjects:@"意向度  ",@"    意向总价    ",@"   更  多  ", nil];
    for (int i=0; i<3; i++)
    {
        topButton=[[UIButton alloc]initWithFrame:CGRectMake(PL_WIDTH/3*i+2, 60, PL_WIDTH/3, 40+10)];
        topButton.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 20);
        [topButton setBackgroundImage:[UIImage imageNamed:@"第二个.png"] forState:UIControlStateNormal];
        [topButton addTarget:self action:@selector(topButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [topButton setTitle:[topTitle objectAtIndex:i] forState:UIControlStateNormal];
        topButton.titleLabel.textAlignment=NSTextAlignmentLeft;
        topButton.titleLabel.font=[UIFont systemFontOfSize:12];
        topButton.tag=30000+i;
        [topButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.view addSubview:topButton];
        
    }
    buttonArr=[[NSMutableArray alloc]initWithCapacity:0];
    for (int j=0; j<3; j++) {
        buttonImg=[[UIButton alloc]initWithFrame:CGRectMake(PL_WIDTH/3*(j+1)-20, 79, 15, 10)];
        [buttonImg setImage:[UIImage imageNamed:@"dropdown.png"] forState:UIControlStateNormal];
        [buttonImg setImage:[UIImage imageNamed:@"dropup.png"] forState:UIControlStateSelected];
        [buttonImg addTarget:self action:@selector(topButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        buttonImg.tag=30000+j;
        buttonImg.userInteractionEnabled = NO;
        [self.view addSubview:buttonImg];
        [buttonArr addObject:buttonImg];
        
    }
    //点击筛选项后弹出视图
    dropBgView=[[UIView alloc]initWithFrame:CGRectMake(0, 100+15, PL_WIDTH, PL_HEIGHT)];
    // dropBgView.backgroundColor=[UIColor colorWithRed:109.0/255.0 green:109.0/255.0 blue:109.0/255.0 alpha:0.9];
    dropBgView.backgroundColor=[[UIColor grayColor]colorWithAlphaComponent:0.5];
    dropBgView.hidden=YES;
    [self.view addSubview:dropBgView];
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick)];
    tap.numberOfTapsRequired=1;
    [dropBgView addGestureRecognizer:tap];
    //一级列表
    _tableView1=[[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(buttonImg.frame)+20, PL_WIDTH, PL_HEIGHT/2-30) style:UITableViewStylePlain];
    _tableView1.delegate=self;
    _tableView1.rowHeight = 44;
    _tableView1.dataSource=self;
    _tableView1.hidden=YES;
    _tableView1.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    [self.view addSubview:_tableView1];
    //二级列表
    _tableView2=[[UITableView alloc]initWithFrame:CGRectMake(PL_WIDTH/3+10,CGRectGetMaxY(buttonImg.frame)+20, PL_WIDTH*2/3-10, PL_HEIGHT/2-30) style:UITableViewStylePlain];
    _tableView2.delegate=self;
    _tableView2.dataSource=self;
    _tableView2.hidden=YES;
    _tableView2.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    [self.view addSubview:_tableView2];
    _tableView2.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    if (_tableView1.hidden==NO) {
        dropBgView.hidden=NO;
    }else
    {
        dropBgView.hidden=YES;
    }
    
    //增加监听，当键盘出现或改变时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    //键盘消失
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    //上拉下拉刷新
    [self setupRefresh];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(transformType:) name:@"type" object:nil];
    if (rightIsClick==YES) {
        [self post2];
    }
    else
    {
        [self postRequest];
    }
    
}

-(void)transformType:(NSNotification *)notice
{
    topStr3 = notice.userInfo[@"type"];
    if (rightIsClick==YES) {
        [self post2];
    }
    else
    {
        [self postRequest];
    }
    
    NSLog(@"++++++++%@",notice.userInfo[@"type"]);
}

#pragma mark 根据权限判断是否添加下属电话和下属客源
-(void)addPhoneButton:(UIView *)view1
{
    //view.frame = CGRectMake(0, PL_HEIGHT - 50, PL_WIDTH, 50);
    
    //    phonebutton.frame = CGRectMake(0, 0, PL_WIDTH - 121 , 50);
    //    [phonebutton setImage:[UIImage imageByScaleAndCropingForSize:CGSizeMake(30, 30) oldImage:[UIImage imageNamed:@"sanheng.png"]] forState:UIControlStateNormal];
    
    phonebutton=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, PL_WIDTH - 121, 50)];
    phonebutton.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"属性背景"]];
    [phonebutton setImage:[UIImage imageByScaleAndCropingForSize:CGSizeMake(30, 20) oldImage:[UIImage imageNamed:@"shangjiantou.png"]] forState:UIControlStateNormal];
    
    //    [phonebutton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [phonebutton addTarget:self action:@selector(phoneButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:phonebutton];
    
    
    
}



#pragma  mark ---弹出通话记录
-(void)phoneButtonClick:(UIButton *)sender
{
    NSLog(@"%s",__FUNCTION__);
    UIView *aview = [view viewWithTag:1];
    if (phoneViewIsOut == NO) {
        aview.hidden = YES;
        gouBtn.hidden = YES;
        zuBtn.hidden = YES;
        [UIView animateWithDuration:0.1 animations:^{
            [self.view.window addSubview:view];
            
            view.backgroundColor = [UIColor clearColor];
            
            view.frame = CGRectMake(0, 0, PL_WIDTH, PL_HEIGHT);
            
            UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, PL_HEIGHT - BUTTONSIZE - 160, PL_WIDTH, 200)];
            backView.backgroundColor = [UIColor whiteColor];
            [view addSubview:backView];
            //            [self.view bringSubviewToFront:view];
            //            view.backgroundColor = [UIColor grayColor];
            phonebutton.frame = CGRectMake(0, PL_HEIGHT - BUTTONSIZE - 160, PL_WIDTH, 30);
            [phonebutton setImage:[UIImage imageByScaleAndCropingForSize:CGSizeMake(30, 20) oldImage:[UIImage imageNamed:@"xiala"]] forState:UIControlStateNormal];
            [view bringSubviewToFront:phonebutton];
            
            
            //            view.frame = CGRectMake(0, PL_HEIGHT - 120, 320, 120);
            
        }
                         completion:^(BOOL finished)
         {
             UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickBackView:)];
             gesture.numberOfTapsRequired = 1;
             gesture.numberOfTouchesRequired = 1;
             [view addGestureRecognizer:gesture];
             
             if (![[[PL_USER_STORAGE objectForKey:PL_USER_DUTYCODE]substringWithRange:NSMakeRange([[PL_USER_STORAGE objectForKey:PL_USER_DUTYCODE] length] - 1, 1)] isEqualToString:@"E"])
             {
                 
                 
                 UIButton *subordinatePb = [[UIButton alloc]initWithFrame:CGRectMake((PL_WIDTH - BUTTONSIZE * 3) / 4, PL_HEIGHT - 100, BUTTONSIZE, BUTTONSIZE)];
                 [view addSubview:subordinatePb];
                 [subordinatePb setBackgroundImage:[UIImage imageNamed:@"下属通话"]forState:UIControlStateNormal];
                 [subordinatePb addTarget:self action:@selector(tosubphone:) forControlEvents:UIControlEventTouchUpInside];
                 
                 UIButton *subordinateB = [[UIButton alloc]initWithFrame:CGRectMake((PL_WIDTH-BUTTONSIZE * 3)/4*2+BUTTONSIZE, PL_HEIGHT - 100, BUTTONSIZE, BUTTONSIZE)];
                 [view addSubview:subordinateB];
                 [subordinateB setBackgroundImage:[UIImage imageNamed:@"下属客源"]forState:UIControlStateNormal];
                 [subordinateB addTarget:self action:@selector(tosub:) forControlEvents:UIControlEventTouchUpInside];
                 
                 
                 
                 UIButton *subordinateC = [[UIButton alloc]initWithFrame:CGRectMake((PL_WIDTH-BUTTONSIZE * 3)/4*3+BUTTONSIZE*2, PL_HEIGHT - 100, BUTTONSIZE, BUTTONSIZE)];
                 [view addSubview:subordinateC];
                 [subordinateC setBackgroundImage:[UIImage imageNamed:@"客源转移.jpg"] forState:UIControlStateNormal];
                 [subordinateC addTarget:self action:@selector(tosubC:) forControlEvents:UIControlEventTouchUpInside];
                 
                 
                 
                 
                 
                 
             }
             UIButton *myPhoneButton = [[UIButton alloc]initWithFrame:CGRectMake((PL_WIDTH - BUTTONSIZE * 3) / 4, PL_HEIGHT - 185, BUTTONSIZE, BUTTONSIZE)];
             [view addSubview:myPhoneButton];
             [myPhoneButton setBackgroundImage:[UIImage imageNamed:@"自己通话"]forState:UIControlStateNormal];
             [myPhoneButton addTarget:self action:@selector(tomyphone:) forControlEvents:UIControlEventTouchUpInside];
             
             
             UIButton *lookAboutButton = [[UIButton alloc]initWithFrame:CGRectMake((PL_WIDTH - BUTTONSIZE * 3) / 4 *3 + BUTTONSIZE * 2, PL_HEIGHT - 185, BUTTONSIZE, BUTTONSIZE)];
             [view addSubview:lookAboutButton];
             [lookAboutButton setBackgroundImage:[UIImage imageNamed:@"带看查询"]forState:UIControlStateNormal];
             [lookAboutButton addTarget:self action:@selector(lookAbout:) forControlEvents:UIControlEventTouchUpInside];
             
             
             UIButton *subordinateD = [[UIButton alloc]initWithFrame:CGRectMake((PL_WIDTH - BUTTONSIZE * 3) / 4 * 2+BUTTONSIZE , PL_HEIGHT - 185, BUTTONSIZE, BUTTONSIZE)];
             [view addSubview:subordinateD];
             [subordinateD setBackgroundImage:[UIImage imageNamed:@"查看跟进"] forState:UIControlStateNormal];
             [subordinateD addTarget:self action:@selector( followUp:) forControlEvents:UIControlEventTouchUpInside];
             
             
         }];
        
        
        
        phoneViewIsOut = YES;
        
        
    }
    else
    {
        //通话记录和下属客源信息视图收回
        [self phoneFramchang];
    }
    
    
}

#pragma mark ---查看下属跟进和自己跟进
-(void)followUp:(UIButton *)sender{
    
    //判断职级来跳转界面
    if ([[[PL_USER_STORAGE objectForKey:PL_USER_DUTYCODE]substringWithRange:NSMakeRange([[PL_USER_STORAGE objectForKey:PL_USER_DUTYCODE] length] - 1, 1)] isEqualToString:@"E"])
    {
        FollowUpListViewController *followUpListVc = [[FollowUpListViewController alloc]init];
        [self.navigationController pushViewController:followUpListVc animated:YES];
        [self phoneFramchang];
    }
    else
    {
        FollowUpViewController *followUpVc = [[FollowUpViewController alloc]init];
        followUpVc.fromString = @"客源";
        followUpVc.titleStr = @"跟进查询";
        [self.navigationController pushViewController:followUpVc animated:YES];
        
        [self phoneFramchang];
    }
}

#pragma mark ---约看查询
-(void)lookAbout:(UIButton *)sender{
    
    if ([[[PL_USER_STORAGE objectForKey:PL_USER_DUTYCODE]substringWithRange:NSMakeRange([[PL_USER_STORAGE objectForKey:PL_USER_DUTYCODE] length] - 1, 1)] isEqualToString:@"E"])
    {
        LookAboutViewController *laVC = [[LookAboutViewController alloc]init];
        laVC.fromType = ViewFrom_Vister;
        
        [self.navigationController pushViewController:laVC animated:YES];
        [self phoneFramchang];
    }
    else
    {
        FollowUpViewController *followUpVc = [[FollowUpViewController alloc]init];
        followUpVc.fromString = @"客源";
        followUpVc.toString   = @"带看";
        followUpVc.titleStr = @"带看查询";
        [self.navigationController pushViewController:followUpVc animated:YES];
        [self phoneFramchang];
    }
}
#pragma mark --- 下属客源转移
-(void)tosubC:(UIButton *)sender{
    
    TransformKYViewController *transformKYVc = [[TransformKYViewController alloc]initWithNibName:@"TransformKYViewController" bundle:nil];
    [self.navigationController pushViewController:transformKYVc animated:YES];
    [self phoneFramchang];
}
#pragma mark --- 跳转到自己通话记录
-(void)tomyphone:(UIButton *)sender
{
    //    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"该功能尚未开放" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
    //    [alert show];
    MyPhoneViewController *myphoneVC = [[MyPhoneViewController alloc]initWithNibName:@"MyPhoneViewController" bundle:nil];
    myphoneVC.type = Type_Vister;
    [self.navigationController pushViewController:myphoneVC animated:YES];
    [self phoneFramchang];
    
}
#pragma mark --- 跳转到下属通话记录
-(void)tosubphone:(UIButton *)sender
{
    SubPhoneViewController *subphoneVC = [[SubPhoneViewController alloc]initWithNibName:@"SubPhoneViewController" bundle:nil];
    //        [self.navigationController presentViewController:subphoneVC animated:YES completion:^{
    //            [self phoneFramchang];
    //        }];
    //    [self.navigationController pushViewController:subphoneVC animated:YES];
    //     [self phoneFramchang];
    subphoneVC.typeSub =  TypeSub_Vister;
    [self.navigationController pushViewController:subphoneVC animated:YES];
    //    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"该功能尚未开放" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
    //    [alert show];
    [self phoneFramchang];
    
}
#pragma mark --- 跳转到下属私客
-(void)tosub:(UIButton *)sender
{
    SubViewController *subVC = [[SubViewController alloc]initWithNibName:@"SubViewController" bundle:nil];
    [self.navigationController pushViewController:subVC animated:YES];
    [self phoneFramchang];
}

#pragma mark --- 背景视图下移手势
-(void)clickBackView:(UIGestureRecognizer *)gesture
{
    [self phoneFramchang];
}
#pragma mark ---- 通话记录视图复原
-(void)phoneFramchang
{
    //    for (UIView *item in self.view.window.subviews) {
    //        [item removeFromSuperview];
    //    }
    UIView *aview = [view viewWithTag:1];
    [view removeFromSuperview];
    [UIView animateWithDuration:0.1 animations:^{
        [self.view addSubview:view];
        view.frame = CGRectMake(0, PL_HEIGHT - 50, PL_WIDTH, 50);
        
        phonebutton.frame = CGRectMake(0, 0, PL_WIDTH - 121 , 50);
        [phonebutton setImage:[UIImage imageByScaleAndCropingForSize:CGSizeMake(30, 20) oldImage:[UIImage imageNamed:@"shangjiantou.png"]] forState:UIControlStateNormal];
    } completion:^(BOOL finished) {
        aview.hidden = NO;
        gouBtn.hidden = NO;
        zuBtn.hidden = NO;
        phoneViewIsOut = NO;
        
    }];
    
    
}


#pragma  mark ---下拉
- (void)topButtonClick:(UIButton *)sender
{
    if (sender.tag == 30002) {
        sender.selected = YES;
    }
    else
    {
        sender.selected=!sender.selected;
        _tableView1.hidden=YES;
        _tableView2.hidden=YES;
        _currentButton=sender;
    }
    
    
    if (sender.selected) {
        switch (sender.tag)
        {
            case 30000:{
                _currentBtn2=buttonArr[0];
                _currentBtn2.selected=YES;
                _currentBtn3=buttonArr[1];
                _currentBtn3.selected=NO;
                _currentBtn4=buttonArr[2];
                _currentBtn4.selected=NO;
                dropBgView.hidden=NO;
                _tableView2.hidden= YES;
                _tableView1.hidden=NO;
                _tableView1.frame =    CGRectMake(0, 100+15-5, PL_WIDTH, _tableView1.rowHeight*7);
                [_tableView1 reloadData];
            }
                break;
            case 30001:{
                _currentBtn2=buttonArr[1];
                _currentBtn2.selected=YES;
                
                _currentBtn3=buttonArr[0];
                _currentBtn3.selected=NO;
                _currentBtn4=buttonArr[2];
                _currentBtn4.selected=NO;
                image0.hidden=YES;
                dropBgView.hidden=NO;
                _tableView1.hidden=NO;
                _tableView1.frame =    CGRectMake(0, 100+15-5, PL_WIDTH, _tableView1.rowHeight*3);
                [_tableView1 reloadData];
            }
                break;
            case 30002:
            {
                MoreMenuVC * menu = [[MoreMenuVC alloc]initWithRootViewController:self];
                menu.moreDlegate = self;
                MoreVisterViewController *mVC = [[MoreVisterViewController alloc]init];
                if (rightIsClick==YES) {
                    mVC.isPrivate=@"0";
                }
                else
                {
                    mVC.isPrivate=@"1";
                }
                
                mVC.delegate = self;
                [menu showTelWindow:self.view.window andViewController:mVC];
                
                
            }
                
                //            {
                //                _currentBtn2=buttonArr[2];
                //                _currentBtn2.selected=YES;
                //                _currentBtn3=buttonArr[1];
                //                _currentBtn3.selected=NO;
                //                _currentBtn4=buttonArr[0];
                //                _currentBtn4.selected=NO;
                //                _tableView2.hidden = YES;
                //                dropBgView.hidden=NO;
                //                _tableView1.hidden=NO;
                //                 _tableView1.frame =    CGRectMake(0, 100+15-5, PL_WIDTH, _tableView1.rowHeight*4);
                //                [_tableView1 reloadData];
                //            }
                break;
            default:
                break;
        }
        
    }
    else
    {
        _tableView1.hidden = YES;
        _tableView2.hidden = YES;
        _currentBtn2=buttonArr[sender.tag-30000];
        _currentBtn2.selected=NO;
        dropBgView.hidden=YES;
    }
}
-(void)transformTel:(NSString *)teleNumber
{
    telePhoneNumberString = teleNumber;
    
    NSLog(@"teleNumber++++++++++%@",teleNumber);
}
-(void)transformPubType:(NSString *)pubTypeStr
{
    pubTypeString = pubTypeStr;
    
    NSLog(@"pubTypeStr-------%@",pubTypeStr);
}
-(void)transformtopStr3:(NSString *)topStr
{
    topStr3 = topStr;
    
    NSLog(@"topStr-------%@",topStr);
}
-(void)transformJiaoYiStr:(NSString *)jiaoyiStr
{
    jiaoYiTypeString = jiaoyiStr;
}
#pragma mark--请求客源列表
-(void)postRequest
{
    _strP = @"";
    NSString * name =[[NSUserDefaults standardUserDefaults]objectForKey:PL_USER_NAME];
    NSString * token = [PL_USER_STORAGE objectForKey:PL_USER_TOKEN];
    PL_PROGRESS_SHOW;
    _custom=[[VisiterData alloc]init];
    _custom.userid=name;
    _custom.flagSubs = @"0";
    _custom.subUserCode = @"";
    _custom.telephoneNumberString = telePhoneNumberString;
    _custom.pubTypeString = pubTypeString;
    _custom.jiaoYiString = jiaoYiTypeString;
    _custom.getAllString = @"1";
    _custom.directFlgString = @"0";
    NSLog(@"%@",telePhoneNumberString);
    if (topStr1.length) {
        _custom.CustLevel=topStr1;
    }
    else
    {
        _custom.CustLevel=@"";
    }
    if (XQStr.length) {
        _custom.DistrictName=XQStr;
    }
    else
    {
        _custom.DistrictName=@"";
    }
    if (PQStr.length) {
        _custom.AreaId=PQStr;
    }
    else
    {
        _custom.AreaId=@"";
    }
    if (currentTradeStr.length) {
        _custom.Trade=currentTradeStr;
    }
    else
    {
        _custom.Trade=@"";
    }
    if (currentPriceMin.length) {
        _custom.PriceMin=currentPriceMin;
    }
    else
    {
        _custom.PriceMin=@"";
    }
    if (currentPriceMax.length) {
        _custom.PriceMax=currentPriceMax;
    }
    else
    {
        _custom.PriceMax=@"";
    }
    if (rightIsClick==YES) {
        _custom.FlagPrivate=@"0";
    }
    else
    {
        _custom.FlagPrivate=@"1";
    }
    if (!topStr3.length) {
        _custom.FlagRecommand=@"";
        _custom.FlagNeed=@"";
        _custom.FlagSchool=@"";
    }
    if ([topStr3 isEqualToString:@"经理推荐"]) {
        _custom.FlagRecommand=@"1";
        _custom.FlagNeed=@"";
        _custom.FlagSchool=@"";
    }
    else if ([topStr3 isEqualToString:@"急需"]) {
        _custom.FlagRecommand=@"";
        _custom.FlagNeed=@"1";
        _custom.FlagSchool=@"";
    }
    else if ([topStr3 isEqualToString:@"学区房"]) {
        _custom.FlagRecommand=@"";
        _custom.FlagNeed=@"";
        _custom.FlagSchool=@"1";
    }
    _custom.StartIndex=@"";
    _custom.token=token;
    _strP = _custom.FlagPrivate;
    [[MyRequest defaultsRequest]getSubCustomList:_custom backInfoMessage:^(NSMutableString *string) {
        _resultString=string;
        PL_PROGRESS_DISMISS;
        if ([string isEqualToString:@"NOLOGIN"]) {
            ViewController *login=[[ViewController alloc]init];
            [self.navigationController pushViewController:login animated:YES];
        }
        if ([string isEqualToString:@"maintain"]) {
            PL_ALERT_SHOW(@"系统维护中");
        }
        if ([string isEqualToString:@"[]"] ) {
            if (telePhoneNumberString.length == 0) {
                PL_ALERT_SHOW(@"暂无私客数据");
                [_array removeAllObjects];
            }
            else
            {
                //                UILabel * label = [[UILabel alloc]init];
                //                label.text = @"暂无数据";
                //                label.textAlignment = NSTextAlignmentCenter;
                NSString *alertStr = [NSString stringWithFormat:@"暂无%@数据",telePhoneNumberString];
                PL_ALERT_SHOW(alertStr);
                [_array removeAllObjects];
            }
            
        }
        else  if ([string isEqualToString:@"exception"]) {
            PL_ALERT_SHOW(@"服务器异常");
            [_array removeAllObjects];
        }
        else
        {
            SBJSON *json=[[SBJSON alloc]init];
            _array=[json objectWithString:_resultString error:nil];
            
        }
        [table reloadData];
        NSDictionary *dic = _array.firstObject;
        sikeLable.text = [NSString stringWithFormat:@"共%@条私客",[dic[@"CountNum"]length] == 0 ? @"0":dic[@"CountNum"]];
        //
        //        [[MyRequest defaultsRequest] afGetPriviteCount:[PL_USER_STORAGE objectForKey:PL_USER_NAME] userToken:[PL_USER_STORAGE objectForKey:PL_USER_TOKEN] completeBack:^(id obj) {
        //            if ([obj isKindOfClass:[NSString class]])
        //            {
        //                NSString * str = obj;
        //                if ([str isEqualToString:@"[]"]) {
        //                    str=@"0";
        //                }
        //                else
        //                {
        //                    sikeLable.text = [NSString stringWithFormat:@"共%@条私客",str];
        //                    NSLog(@"%@",sikeLable.text);
        //                    privateCount = str;
        //
        //                }
        //
        //                PL_PROGRESS_DISMISS;
        //            }
        //        }];
        
        
        
    }];
    
    
}
#pragma mark --通过电话搜索后刷新列表
-(void)freshCustomeList
{
    if (rightIsClick==YES) {
        [self post2];
    }
    else
    {
        [self postRequest];
    }
    
}

#pragma mark--增加客源
-(void)addClick:(UIButton *)sender
{
    
    if ([privateCount integerValue]>=500)
    {
        PL_ALERT_SHOWNOT_OKAND_YES(@"您的私客数量已经达到上限");
        return;
    }
    else
    {
        sender.selected=!sender.selected;
        if (sender.selected) {
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:0.1];
            gouBtn.frame=CGRectMake(PL_WIDTH/3, 10, 80, 30);
            zuBtn.frame=CGRectMake(PL_WIDTH/3-90, 10, 80, 30);
            [view bringSubviewToFront:gouBtn];
            [view bringSubviewToFront:zuBtn];
            [UIView commitAnimations];
        }else{
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:0.1];
            gouBtn.frame=CGRectMake(PL_WIDTH-100, 10, 80, 30);
            zuBtn.frame=CGRectMake(PL_WIDTH-100, 10, 80, 30);
            [view sendSubviewToBack:gouBtn];
            [view sendSubviewToBack:zuBtn];
            [UIView commitAnimations];
        }
        
    }
    
}
#pragma mark 点击增加购房客按钮
-(void)gouClick
{
    ZuViewController *zu=[[ZuViewController alloc]init];
    zu.tradeStr=@"求购";
    [self.navigationController pushViewController:zu animated:YES];
    zuBtn.frame = CGRectMake(PL_WIDTH-100, 10, 80, 30);
    gouBtn.frame = CGRectMake(PL_WIDTH-100, 10, 80, 30);
    [view sendSubviewToBack:gouBtn];
    [view sendSubviewToBack:zuBtn];
}
#pragma mark 点击增加租房客按钮
-(void)zuClick
{
    ZuViewController *zu=[[ZuViewController alloc]init];
    zu.tradeStr=@"求租";
    [self.navigationController pushViewController:zu animated:YES];
    zuBtn.frame = CGRectMake(PL_WIDTH-100, 10, 80, 30);
    gouBtn.frame = CGRectMake(PL_WIDTH-100, 10, 80, 30);
    [view sendSubviewToBack:gouBtn];
    [view sendSubviewToBack:zuBtn];
}

#pragma mark  表
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==phoneTable) {
        //        return 44;
    }
    if (tableView==_tableView1||tableView==_tableView2 ) {
        return 44;
    }
    if (tableView.tag==15000) {
        return 30;
    }
    return 100;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==phoneTable) {
        //        return phoneArr.count;
    }
    
    if (tableView==_tableView1 )
    {
        switch (_currentButton.tag) {
            case 30000:
                return 7;
                break;
            case 30001:
                return 3;
                break;
            case 30002:
                return 4;
                break;
                
            default:
                break;
        }
    }
    else if (tableView==_tableView2)
    {
        return priceArray.count;
    }
    if (tableView.tag==15000) {
        return styleArray.count;
    }
    else if (tableView==_tableView1||tableView==_tableView2)
    {
        return 10;
    }
    else
    {
        return _array.count;
    }
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"\n\n\n\n\n\n\n%ld",(long)indexPath.row);
    if (tableView==phoneTable) {
        if (phoneArr.count>0)
        {
            
            
            NSLog(@"%@",[PL_USER_STORAGE objectForKey:PL_USER_PHONEnUM]);
            NSString * telNum =[PL_USER_STORAGE objectForKey:PL_USER_PHONEnUM];
            NSLog(@"%@",telNum);
            NSLog(@"%@",CustID);
            NSLog(@"%@",supCode);
            NSLog(@"%@",[PL_USER_STORAGE objectForKey:PL_USER_USERID]);
            NSLog(@"%@",[PL_USER_STORAGE objectForKey:PL_USER_TOKEN]);
            NSString *phoneString=[phoneArr objectAtIndex:indexPath.row];
            NSLog(@"%@-------->",phoneString);
            NSArray *phoneArr22=[phoneString componentsSeparatedByString:@"|"];
            NSString *phoneNum=[phoneArr22 objectAtIndex:1];
            
            if ([telNum isEqualToString:@""]||[phoneNum isEqualToString:@""]) {
                
            }
            else
            {   PL_ALERT_SHOW(@"系统正在拨打，请稍后");
                [phoneBG removeFromSuperview];
                PL_PROGRESS_SHOW;
                [[MyRequest defaultsRequest]afDialCustTelephone:telNum CustPhone:phoneNum ID:CustID Type:@"0" FromCode:[PL_USER_STORAGE objectForKey:PL_USER_SUPCODE] userid:[PL_USER_STORAGE objectForKey:PL_USER_USERID] userToken:[PL_USER_STORAGE objectForKey:PL_USER_TOKEN] completeBack:^(NSMutableString *str)
                 {
                     PL_PROGRESS_DISMISS;
                     NSLog(@"%@",str);
                     
                 }];
                
                [self genClick:cell.genjin];
                
            }
            
        }
        
    }
    
    if (tableView==_tableView1) {
        _currentButton.selected = NO;
        switch (_currentButton.tag) {
            case 30000:
            {
                _currentBtn2.selected=NO;
                if (indexPath.row==0) {
                    //                    _currentButton.titleLabel.text=@"全  部";
                    [_currentButton setTitle:@"全  部" forState:UIControlStateNormal];
                }
                else
                {
                    xxNum=indexPath.row-1;
                    //                    _currentButton.titleLabel.text=[NSString stringWithFormat:@"%ld   星",(long)xxNum];
                    [_currentButton setTitle:[NSString stringWithFormat:@"%ld   星",(long)xxNum]forState:UIControlStateNormal];
                    
                }
                dropBgView.hidden=YES;
                _tableView1.hidden=YES ;
                _array=nil;
                _custom=[[VisiterData alloc]init];
                _custom.userid=[[NSUserDefaults standardUserDefaults]objectForKey:PL_USER_NAME];
                _custom.flagSubs = @"0";
                _custom.subUserCode = @"";
                _custom.telephoneNumberString = telePhoneNumberString;
                _custom.pubTypeString = pubTypeString;
                _custom.jiaoYiString = jiaoYiTypeString;
                _custom.getAllString = @"1";
                _custom.directFlgString = @"0";
                NSLog(@"%@",telePhoneNumberString);
                if (indexPath.row==0) {
                    _custom.CustLevel=@"";
                }else{
                    _custom.CustLevel=[NSString stringWithFormat:@"%lu",(unsigned long)indexPath.row-1];
                }
                currentStr=_custom.CustLevel;
                topStr1=currentStr;
                if (XQStr.length) {
                    _custom.DistrictName=XQStr;
                }
                else
                {
                    _custom.DistrictName=@"";
                }
                if (PQStr.length) {
                    _custom.AreaId=PQStr;
                }
                else
                {
                    _custom.AreaId=@"";
                }
                
                if (!currentTradeStr.length) {
                    _custom.Trade=@"";
                }
                else
                {
                    _custom.Trade=currentTradeStr;
                }
                if (!currentPriceMin.length) {
                    _custom.PriceMin=@"";
                }
                else
                {
                    _custom.PriceMin=currentPriceMin;
                }
                if (!currentPriceMax.length) {
                    _custom.PriceMax=@"";
                }
                else
                {
                    _custom.PriceMax=currentPriceMax;
                }
                
                if (!topStr3.length) {
                    _custom.FlagRecommand=@"";
                    _custom.FlagNeed=@"";
                    _custom.FlagSchool=@"";
                }
                if ([topStr3 isEqualToString:@"经理推荐"]) {
                    _custom.FlagRecommand=@"1";
                    _custom.FlagNeed=@"";
                    _custom.FlagSchool=@"";
                }
                else if ([topStr3 isEqualToString:@"急需"]) {
                    _custom.FlagRecommand=@"";
                    _custom.FlagNeed=@"1";
                    _custom.FlagSchool=@"";
                }
                else if ([topStr3 isEqualToString:@"学区房"]) {
                    _custom.FlagRecommand=@"";
                    _custom.FlagNeed=@"";
                    _custom.FlagSchool=@"1";
                }
                else if([topStr3 isEqualToString:@"不限"])
                {
                    _custom.FlagRecommand=@"";
                    _custom.FlagNeed=@"";
                    _custom.FlagSchool=@"";
                    
                }
                if (!rightIsClick) {
                    _custom.FlagPrivate=@"1";
                }
                else
                {
                    _custom.FlagPrivate=@"0";
                }
                _custom.StartIndex=@"";
                _custom.token=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
                //********************************
                PL_PROGRESS_SHOW;
                [[MyRequest defaultsRequest]getCustomList:_custom backInfoMessage:^(NSMutableString *string) {
                    _resultString=string;
                    if ([string isEqualToString:@"NOLOGIN"]) {
                        ViewController *login=[[ViewController alloc]init];
                        [self.navigationController pushViewController:login animated:YES];
                    }
                    else if ([string isEqualToString:@"[]"]) {
                        PL_ALERT_SHOW(@"暂无数据");
                        [_array removeAllObjects];
                    }
                    else  if ([string isEqualToString:@"exception"]) {
                        PL_ALERT_SHOW(@"服务器异常");
                        [_array removeAllObjects];
                    }
                    else
                    {
                        NSLog(@"4xing %@",_resultString);
                        SBJSON *json=[[SBJSON alloc]init];
                        _array=[json objectWithString:_resultString error:nil];
                    }
                    
                    [table reloadData];
                    table.scrollsToTop=YES;
                    PL_PROGRESS_DISMISS;
                    
                }];
            }
                break;
            case 30001:
            {
                if (indexPath.row==0) {
                    //                    _currentButton.titleLabel.text=@"    不  限";
                    [_currentButton setTitle:@"不  限" forState:UIControlStateNormal];
                    _currentBtn2.selected=NO;
                }
                PriceRangeData *price=[[PriceRangeData alloc]init];
                price.PriceType = @"";
                price.priceUp = @"";
                price.priceDown = @"";
                price.priceUnit = @"";
                price.userid=[[NSUserDefaults standardUserDefaults]objectForKey:PL_USER_NAME];
                price.token=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
                if(indexPath.row==0)
                {
                    _array=nil;
                    VisiterData *custom=[[VisiterData alloc]init];
                    custom.userid=[[NSUserDefaults standardUserDefaults]objectForKey:PL_USER_NAME];
                    custom.flagSubs = @"0";
                    custom.subUserCode = @"";
                    custom.telephoneNumberString = telePhoneNumberString;
                    custom.pubTypeString = pubTypeString;
                    custom.jiaoYiString = jiaoYiTypeString;
                    custom.getAllString = @"1";
                    custom.directFlgString = @"0";
                    if (!currentStr.length) {
                        custom.CustLevel=@"";
                    }
                    else
                    {
                        custom.CustLevel=topStr1;
                    }
                    if (XQStr.length) {
                        custom.DistrictName=XQStr;
                    }
                    else
                    {
                        custom.DistrictName=@"";
                    }
                    if (PQStr.length) {
                        custom.AreaId=PQStr;
                    }
                    else
                    {
                        custom.AreaId=@"";
                    }
                    
                    custom.Trade=@"";
                    custom.PriceMin=@"";
                    custom.PriceMax=@"";
                    if (!rightIsClick) {
                        custom.FlagPrivate=@"1";
                    }
                    else
                    {
                        custom.FlagPrivate=@"0";
                    }
                    
                    custom.StartIndex=@"";
                    //*******************************
                    if (!topStr3.length) {
                        custom.FlagRecommand=@"";
                        custom.FlagNeed=@"";
                        custom.FlagSchool=@"";
                    }
                    if ([topStr3 isEqualToString:@"经理推荐"]) {
                        custom.FlagRecommand=@"1";
                        custom.FlagNeed=@"";
                        custom.FlagSchool=@"";
                    }
                    else if ([topStr3 isEqualToString:@"急需"]) {
                        custom.FlagRecommand=@"";
                        custom.FlagNeed=@"1";
                        custom.FlagSchool=@"";
                    }
                    else if ([topStr3 isEqualToString:@"学区房"]) {
                        custom.FlagRecommand=@"";
                        custom.FlagNeed=@"";
                        custom.FlagSchool=@"1";
                    }
                    
                    custom.token=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
                    PL_PROGRESS_SHOW;
                    [[VisitersRequest defaultsRequest]getCustomList:custom backInfoMessage:^(NSMutableString *string) {
                        _resultString=string;
                        if ([string isEqualToString:@"NOLOGIN"]) {
                            ViewController *login=[[ViewController alloc]init];
                            [self.navigationController pushViewController:login animated:YES];
                        }
                        else if ([string isEqualToString:@"[]"]) {
                            PL_ALERT_SHOW(@"暂无数据");
                            [_array removeAllObjects];
                        }
                        else  if ([string isEqualToString:@"exception"]) {
                            PL_ALERT_SHOW(@"服务器异常");
                            [_array removeAllObjects];
                        }
                        else
                        {
                            SBJSON *json=[[SBJSON alloc]init];
                            _array=[json objectWithString:_resultString error:nil];
                        }
                        
                        [table reloadData];
                        PL_PROGRESS_DISMISS;
                        
                    }];
                    
                }else if(indexPath.row==1){
                    price.PriceType=@"售价";
                    cell.tag=502;
                    _currentBtn2.selected=YES;
                    [self postPrice:price];
                }else{
                    price.PriceType=@"租价";
                    cell.tag=501;
                    _currentBtn2.selected=YES;
                    [self postPrice:price];
                }
                if (indexPath.row==0) {
                    _tableView2.hidden=YES;
                    dropBgView.hidden=YES;
                    _tableView1.hidden=YES;
                }
                else
                {
                    _tableView2.hidden=NO;
                }
            }
                break;
            case 30002:
            {
                _currentBtn2.selected=NO;
                MoreArr1=@[@"不  限",@"经理推荐",@"急  需",@"学区房"];
                _currentButton.titleLabel.text=[MoreArr1 objectAtIndex:indexPath.row];
                //[_currentButton setTitle:[MoreArr1 objectAtIndex:indexPath.row] forState:UIControlStateNormal];
                topStr3=_currentButton.titleLabel.text;
                dropBgView.hidden=YES;
                _tableView1.hidden=YES;
                VisiterData *custom=[[VisiterData alloc]init];
                custom.userid=[[NSUserDefaults standardUserDefaults]objectForKey:PL_USER_NAME];
                custom.flagSubs = @"0";
                custom.subUserCode = @"";
                custom.telephoneNumberString = telePhoneNumberString;
                custom.pubTypeString = pubTypeString;
                custom.jiaoYiString = jiaoYiTypeString;
                custom.getAllString = @"1";
                custom.directFlgString = @"0";
                if (!topStr1.length) {
                    custom.CustLevel=@"";
                }
                else
                {
                    custom.CustLevel=topStr1;
                }
                
                if (XQStr.length) {
                    custom.DistrictName=XQStr;
                }
                else
                {
                    custom.DistrictName=@"";
                }
                if (PQStr.length) {
                    custom.AreaId=PQStr;
                }
                else
                {
                    custom.AreaId=@"";
                }
                if (currentTradeStr==nil) {
                    custom.Trade=@"";
                }
                else
                {
                    custom.Trade=currentTradeStr;
                }
                if (currentPriceMin==nil) {
                    custom.PriceMin=@"";
                }
                else
                {
                    custom.PriceMin=currentPriceMin;
                }
                if (currentPriceMax==nil) {
                    custom.PriceMax=@"";
                }
                else
                {
                    custom.PriceMax=currentPriceMax;
                }
                if (indexPath.row==0) {
                    custom.FlagRecommand=@"";
                    custom.FlagNeed=@"";
                    custom.FlagSchool=@"";
                }
                else if (indexPath.row==1)
                {
                    custom.FlagRecommand=@"1";
                    custom.FlagNeed=@"";
                    custom.FlagSchool=@"";
                }
                else if(indexPath.row==2)
                {
                    custom.FlagRecommand=@"";
                    custom.FlagNeed=@"1";
                    custom.FlagSchool=@"";
                }
                else
                {
                    custom.FlagRecommand=@"";
                    custom.FlagNeed=@"";
                    custom.FlagSchool=@"1";
                }
                
                if (!rightIsClick) {
                    custom.FlagPrivate=@"1";
                }
                else
                {
                    custom.FlagPrivate=@"0";
                }
                
                custom.StartIndex=@"";
                custom.token=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
                PL_PROGRESS_SHOW;
                [[MyRequest defaultsRequest]getCustomList:custom backInfoMessage:^(NSMutableString *string) {
                    _resultString=string;
                    if ([string isEqualToString:@"NOLOGIN"]) {
                        ViewController *login=[[ViewController alloc]init];
                        [self.navigationController pushViewController:login animated:YES];
                    }
                    else if ([string isEqualToString:@"[]"]) {
                        PL_ALERT_SHOW(@"暂无数据");
                        [_array removeAllObjects];
                    }
                    else if ([string isEqualToString:@"exception"]) {
                        PL_ALERT_SHOW(@"服务器异常");
                        [_array removeAllObjects];
                    }
                    else
                    {
                        SBJSON *json=[[SBJSON alloc]init];
                        _array=[json objectWithString:_resultString error:nil];
                    }
                    
                    [table reloadData];
                    PL_PROGRESS_DISMISS;
                    
                }];
            }
                break;
                
            default:
                break;
        }
    }
    if (tableView==_tableView2) {
        //        _currentButton.selected=NO;
        
        NSDictionary *dic=[priceArray objectAtIndex:indexPath.row];
        
        if ([priceArray[0][@"PRICETYPE"]isEqualToString:@"租价"] ) {
            NSString *priceStr=[NSString stringWithFormat:@"%@-%@元/月",[dic  objectForKey:@"PRICEUP"],[dic objectForKey:@"PRICEDOWN"]];
            //            _currentButton.titleLabel.text=priceStr;
            [_currentButton setTitle:priceStr forState:UIControlStateNormal];
        }
        else if([priceArray[0][@"PRICETYPE"]isEqualToString:@"售价"] )
        {
            NSString *priceStr=[NSString stringWithFormat:@"%@-%@万元",[dic  objectForKey:@"PRICEUP"],[dic objectForKey:@"PRICEDOWN"]];
            //            _currentButton.titleLabel.text=priceStr;
            [_currentButton setTitle:priceStr forState:UIControlStateNormal];
            
        }
        
        _currentBtn2.selected=NO;
        dropBgView.hidden=YES;
        _tableView2.hidden=YES;
        _tableView1.hidden=YES;
        _array=nil;
        
        VisiterData *custom=[[VisiterData alloc]init];
        custom.userid=[[NSUserDefaults standardUserDefaults]objectForKey:PL_USER_NAME];
        custom.flagSubs = @"0";
        custom.subUserCode = @"";
        custom.telephoneNumberString = telePhoneNumberString;
        custom.pubTypeString = pubTypeString;
        custom.jiaoYiString = jiaoYiTypeString;
        custom.getAllString = @"1";
        custom.directFlgString = @"0";
        if (!currentStr.length) {
            custom.CustLevel=@"";
        }
        else
        {
            custom.CustLevel=topStr1;
        }
        if (XQStr.length) {
            custom.DistrictName=XQStr;
        }
        else
        {
            custom.DistrictName=@"";
        }
        if (PQStr.length) {
            custom.AreaId=PQStr;
        }
        else
        {
            custom.AreaId=@"";
        }
        
        if (cell.tag==501) {
            custom.Trade=@"求租";
        }
        else if(cell.tag==502)
        {
            custom.Trade=@"求购";
        }
        currentTradeStr=custom.Trade;
        NSDictionary *dict=[priceArray objectAtIndex:indexPath.row];
        NSLog(@"%@",[dict objectForKey:@"PRICEUP"]);
        custom.PriceMin=[dict objectForKey:@"PRICEUP"];
        
        custom.PriceMax=[dict objectForKey:@"PRICEDOWN"];
        currentPriceMin=custom.PriceMin;
        currentPriceMax=custom.PriceMax;
        
        if (!rightIsClick) {
            custom.FlagPrivate=@"1";
        }
        else
        {
            custom.FlagPrivate=@"0";
        }
        custom.StartIndex=@"";
        if (!topStr3.length) {
            custom.FlagRecommand=@"";
            custom.FlagNeed=@"";
            custom.FlagSchool=@"";
        }
        if ([topStr3 isEqualToString:@"经理推荐"]) {
            custom.FlagRecommand=@"1";
            custom.FlagNeed=@"";
            custom.FlagSchool=@"";
        }
        else if ([topStr3 isEqualToString:@"急需"]) {
            custom.FlagRecommand=@"";
            custom.FlagNeed=@"1";
            custom.FlagSchool=@"";
        }
        else if ([topStr3 isEqualToString:@"学区房"]) {
            custom.FlagRecommand=@"";
            custom.FlagNeed=@"";
            custom.FlagSchool=@"1";
        }
        
        
        NSLog(@"%@",currentPriceMin);
        PL_PROGRESS_SHOW;
        custom.token=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
        [[MyRequest defaultsRequest]getCustomList:custom backInfoMessage:^(NSMutableString *string) {
            NSLog(@"%@",string);
            if ([string isEqualToString:@"NOLOGIN"]) {
                ViewController *login=[[ViewController alloc]init];
                [self.navigationController pushViewController:login animated:YES];
            }
            else  if ([string isEqualToString:@"[]"]) {
                PL_ALERT_SHOW(@"暂无数据");
                [_array removeAllObjects];
            }
            else if ([string isEqualToString:@"exception"]) {
                PL_ALERT_SHOW(@"服务器异常");
                [_array removeAllObjects];
            }
            else
            {
                SBJSON *json=[[SBJSON alloc]init];
                _array=[json objectWithString:string error:nil];
            }
            
            [table reloadData];
            PL_PROGRESS_DISMISS;
            
        }];
    }
    if (tableView.tag==15000) {
        
        NSLog(@"%ld",(long)tableView.tag);
        NSDictionary *dict=[styleArray objectAtIndex:indexPath.row];
        style.text=[dict objectForKey:@"FollowType"];
        [sousuoViewstyle removeFromSuperview];
        styleBtn.selected=NO;
    }
    else if(tableView==table)
    {
        NSLog(@"%@",_strP);
        AVisiterDetailViewController *customer=[[AVisiterDetailViewController alloc]init];
        customer.AVisiterDetailPropertyID = _VisiterPropertyID;
        customer.dict=[_array objectAtIndex:indexPath.row];
        //客源详情请求
        AppointVisiterData *customDetail=[[AppointVisiterData alloc]init];
        customDetail.CustID=[customer.dict objectForKey:@"CustID"];
        customer.custId=customDetail.CustID;
        [[NSUserDefaults standardUserDefaults]setObject:customDetail.CustID forKey:@"CustID"];
        customDetail.userid=[[NSUserDefaults standardUserDefaults]objectForKey:@"userName"];
        customDetail.token=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
        [[NSUserDefaults standardUserDefaults]setObject:customDetail.CustID forKey:@"custID"];
        customer.customDetail = customDetail;
        customer.strP = _strP;
        [self.navigationController pushViewController:customer animated:YES];
        
        //        PL_PROGRESS_SHOW;
        //        [[MyRequest defaultsRequest]getCustomDetailInfoEasterList:customDetail backInfoMessage:^(NSMutableString *string) {
        //            if ([string isEqualToString:@"NOLOGIN"]) {
        //                ViewController *login=[[ViewController alloc]init];
        //                [self.navigationController pushViewController:login animated:YES];
        //            }
        //            else if ([string isEqualToString:@"exception"]) {
        //                PL_ALERT_SHOW(@"服务器异常");
        //            }
        //            else if ([string isEqualToString:@"[]"])
        //            {
        //                PL_ALERT_SHOW(@"暂无数据");
        //            }
        //            else
        //            {
        //                SBJSON *json=[[SBJSON alloc]init];
        //                NSArray *array=[json objectWithString:string error:nil];
        //                NSDictionary * dicti=[array objectAtIndex:0];
        //                NSLog(@"%@",[dicti objectForKey:@"CustLevel"]);
        //            }
        //            PL_PROGRESS_DISMISS;
        //            customer.detailString=string;
        //
        //            if (rightIsClick==NO) {
        //                customer.isHiden=NO;
        //            }
        //            else
        //            {
        //                customer.isHiden=YES;
        //            }
        //        }];
        //
    }
}
-(void)postPrice:(PriceRangeData *)price
{
    [[MyRequest defaultsRequest]getPriceRange:price backInfoMessage:^(NSMutableString *string) {
        if ([string isEqualToString:@"NOLOGIN"]) {
            ViewController *login=[[ViewController alloc]init];
            [self.navigationController pushViewController:login animated:YES];
        }
        else if ([string isEqualToString:@"exception"])
        {
            PL_ALERT_SHOW(@"服务器异常");
            priceArray=nil;
        }
        else if ([string isEqualToString:@"[]"]) {
            PL_ALERT_SHOW(@"暂无数据");
            priceArray=nil;
        }
        else
        {
            SBJSON *json=[[SBJSON alloc]init];
            priceArray=[json objectWithString:string error:nil];
        }
        
        [_tableView2 reloadData];
        PL_PROGRESS_DISMISS;
    }];
    
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==phoneTable) {
        //        static NSString *cellStr=@"cell";
        //        UITableViewCell *phonecell=[tableView dequeueReusableCellWithIdentifier:cellStr];
        //        if (!phonecell) {
        //            phonecell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellStr];
        //        }
        //        phonecell.backgroundColor=[UIColor whiteColor];
        //        if (phoneArr.count>0)
        //        {
        //            NSString *phoneString=[phoneArr objectAtIndex:indexPath.row];
        //            phoneArr2=[phoneString componentsSeparatedByString:@"|"];
        //            NSString *phoneStr=[phoneArr2 objectAtIndex:0];
        //
        //            if (phoneStr.length==11) {
        //                phonecell.textLabel.text=[NSString stringWithFormat:@"        %@",phoneStr];
        //                UIImage *image=[UIImage imageNamed:@"call_mobile.png"];
        //                CGSize itemSize = CGSizeMake(30, 30);
        //                UIGraphicsBeginImageContextWithOptions(itemSize, NO,0.0);
        //                CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
        //                [image drawInRect:imageRect];
        //
        //                phonecell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
        //                UIGraphicsEndImageContext();
        //
        //            }
        //            else
        //            {
        //                phonecell.textLabel.text=[NSString stringWithFormat:@"          %@",phoneStr];
        //                UIImage *image=[UIImage imageNamed:@"call_phone.png"];
        //                CGSize itemSize = CGSizeMake(30, 30);
        //                UIGraphicsBeginImageContextWithOptions(itemSize, NO,0.0);
        //                CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
        //                [image drawInRect:imageRect];
        //
        //                phonecell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
        //                UIGraphicsEndImageContext();
        //            }
        //
        //        }
        //               phonecell.selectionStyle=UITableViewCellSelectionStyleNone;
        //        return phonecell;
    }
    
    if (tableView == _tableView1)
    {
        static NSString *cellIdectifier = @"cellIdectifier";
        UITableViewCell *_tableView1cell = [tableView dequeueReusableCellWithIdentifier:cellIdectifier];
        if (!_tableView1cell) {
            _tableView1cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdectifier];
        }
        if (_currentButton.tag==30000)
        {
            _tableView1cell.textLabel.text=@"";
            for (int i=1; i<6; i++) {
                //                if (image0) {
                //                    <#statements#>
                //                }
                image0=[[UIImageView alloc]initWithFrame:CGRectMake(10+(i-1)*25, 10, 20, 20)];
                if (i<indexPath.row) {
                    image0.image=[UIImage imageNamed:@"小黄星星.png"];
                }else{
                    image0.image=[UIImage imageNamed:@"小灰星星.png"];
                }
                [_tableView1cell addSubview:image0];
            }
            if (indexPath.row==0) {
                _tableView1cell=nil;
                if (!_tableView1cell) {
                    _tableView1cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdectifier];
                }
                _tableView1cell.textLabel.text=@"全部";
            }
        }
        else if(_currentButton.tag==30001)
        {
            _tableView1cell=nil;
            if (!_tableView1cell) {
                _tableView1cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdectifier];
            }
            NSArray *textArr=@[@"不限",@"售价",@"租价"];
            _tableView1cell.textLabel.text=[textArr objectAtIndex:indexPath.row];
        }
        else if(_currentButton.tag==30002)
        {
            _tableView1cell=nil;
            if (!_tableView1cell) {
                _tableView1cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdectifier];
            }
            NSArray *MoreArr=@[@"不限",@"经理推荐",@"急需",@"学区房"];
            _tableView1cell.textLabel.text=[MoreArr objectAtIndex:indexPath.row];
        }
        
        _tableView1cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return _tableView1cell;
    }
    else if(tableView==_tableView2)
    {
        static NSString *cellIdectifier = @"cellIdectifier2";
        UITableViewCell *_tableView2cell = [tableView dequeueReusableCellWithIdentifier:cellIdectifier];
        if (!_tableView2cell) {
            _tableView2cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdectifier];
        }
        if (priceArray.count>0)
        {
            NSDictionary *dic=[priceArray objectAtIndex:indexPath.row];
            NSString *priceStr=[NSString stringWithFormat:@"%@-%@ %@",[dic  objectForKey:@"PRICEUP"],[dic objectForKey:@"PRICEDOWN"],[dic objectForKey:@"UNIT"]];
            _tableView2cell.textLabel.text=priceStr;
        }
        
        
        _tableView2cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return _tableView2cell;
    }
    
    
    if (tableView.tag==15000) {
        static NSString *str=@"cellStr";
        UITableViewCell *cell2=[tableView dequeueReusableCellWithIdentifier:str];
        if (!cell2) {
            cell2=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
        }
        if (styleArray.count>0)
        {
            NSDictionary *dic=[styleArray objectAtIndex:indexPath.row];
            cell2.textLabel.text=[dic objectForKey:@"FollowType"];
            cell2.textLabel.font=[UIFont systemFontOfSize:12];
            cell2.backgroundColor=[UIColor clearColor];
            cell2.textLabel.textColor=[UIColor whiteColor];
            cell2.selectionStyle=UITableViewCellSelectionStyleNone;
            
            
        }
        return cell2;
    }
    
    static NSString *str=@"cell";
    cell=[tableView dequeueReusableCellWithIdentifier:str];
    if (!cell) {
        cell=[[MyVisiterCustomCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    cell.tag=[indexPath row];
    
    if (_array.count>0)
    {
        dictionary=[_array objectAtIndex:indexPath.row];
        if (dictionary.count>0 && [dictionary isKindOfClass:[NSDictionary class]])
        {
            if ([[dictionary objectForKey:@"Age"]isEqualToString:@""]) {
                if ((NSNull *)[dictionary objectForKey:@"Sex"]==[NSNull null])
                {
                    cell.name.text=[NSString stringWithFormat:@"%@(%@)",[dictionary objectForKey:@"CustName"],[dictionary objectForKey:@"Source"]];
                }
                else
                {
                    cell.name.text=[NSString stringWithFormat:@"%@(%@)%@",[dictionary objectForKey:@"CustName"],[dictionary objectForKey:@"Source"],[dictionary objectForKey:@"Sex"]];
                }
                
            }else{
                if ((NSNull *)[dictionary objectForKey:@"Sex"]==[NSNull null])
                {
                    cell.name.text=[NSString stringWithFormat:@"%@(%@)%@",[dictionary objectForKey:@"CustName"],[dictionary objectForKey:@"Source"],[dictionary objectForKey:@"Age"]];
                }
                else
                {
                    cell.name.text=[NSString stringWithFormat:@"%@(%@)%@ %@",[dictionary objectForKey:@"CustName"],[dictionary objectForKey:@"Source"],[dictionary objectForKey:@"Sex"],[dictionary objectForKey:@"Age"]];
                }
                
                
            }
            if ((NSNull *)[dictionary objectForKey:@"DistrictName"]==[NSNull null])
            {
                [cell.xiaoqu setTitle:@"" forState:UIControlStateNormal];
            }
            else
            {
                [cell.xiaoqu setTitle:[NSString stringWithFormat:@"%@",[dictionary objectForKey:@"DistrictName"]] forState:UIControlStateNormal];
            }
            
            [cell.xiaoqu setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            cell.xiaoqu.titleLabel.text =[NSString stringWithFormat:@"%@",[dictionary objectForKey:@"DistrictName"]];
            
            [cell.xiaoqu addTarget:self action:@selector(xiaoquClick:) forControlEvents:UIControlEventTouchUpInside];
            cell.xiaoqu.titleLabel.textColor = [UIColor blackColor];
            if ((NSNull *)[dictionary objectForKey:@"AreaName"]==[NSNull null])
            {
                [cell.pianqu setTitle:@"" forState:UIControlStateNormal];
            }
            else
            {
                [cell.pianqu setTitle:[NSString stringWithFormat:@"%@",[dictionary objectForKey:@"AreaName"]] forState:UIControlStateNormal];
            }
            
            
            [cell.pianqu setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            cell.pianqu.tag=indexPath.row;
            [cell.pianqu addTarget:self action:@selector(pianquClick:) forControlEvents:UIControlEventTouchUpInside];
            
            if ([[dictionary objectForKey:@"CountF"]isEqualToString:@"房"]) {
                cell.roomInfo.text=[NSString stringWithFormat:@"%@%@",[dictionary objectForKey:@"CountT"],[dictionary objectForKey:@"Square"]];
            }else{
                cell.roomInfo.text=[NSString stringWithFormat:@"%@%@ %@",[dictionary objectForKey:@"CountF"],[dictionary objectForKey:@"CountT"],[dictionary objectForKey:@"Square"]];
            }
            if ([[dictionary objectForKey:@"Trade"]isEqualToString:@"求购"]) {
                cell.gou.image=[UIImage imageNamed:@"gou_hong"];
                cell.yixiangPrice.text=[NSString stringWithFormat:@"意向总价:%@万",[dictionary objectForKey:@"Price"]];
                NSMutableAttributedString * attri = [[NSMutableAttributedString alloc]initWithString:cell.yixiangPrice.text];
                [attri addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(5, attri.length-5)];
                cell.yixiangPrice.attributedText=attri;
            }else
            {
                cell.gou.image=[UIImage imageNamed:@"gou_hui.png"];
            }
            if ([[dictionary objectForKey:@"Trade"]isEqualToString:@"求租"]) {
                cell.zu.image=[UIImage imageNamed:@"zu_lv.png"];
                cell.yixiangPrice.text=[NSString stringWithFormat:@"意向总价:%@",[dictionary objectForKey:@"Price"]];
                NSMutableAttributedString * attri = [[NSMutableAttributedString alloc]initWithString:cell.yixiangPrice.text];
                [attri addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(4, attri.length-4)];
                cell.yixiangPrice.attributedText=attri;
            }
            else
            {
                cell.zu.image=[UIImage imageNamed:@"zu_hui.png"];
            }
            if ([[dictionary objectForKey:@"Trade"]isEqualToString:@""]) {
                cell.zu.image=[UIImage imageNamed:@"zu_lv.png"];
                cell.gou.image=[UIImage imageNamed:@"gou_hong"];
            }
            if ((NSNull *)[dictionary objectForKey:@"Trade"]==[NSNull null]) {
                cell.zu.image=[UIImage imageNamed:@"zu_lv.png"];
                cell.gou.image=[UIImage imageNamed:@"gou_hong"];
            }
            if ([[dictionary objectForKey:@"FlagRecommand"]isEqualToString:@"1"]) {
                cell.jinglituijian.image=[UIImage imageNamed:@"jinglituijian_lan"];
            }
            
            if ([[dictionary objectForKey:@"FlagNeed"]isEqualToString:@"1"]) {
                cell.jixu.image=[UIImage imageNamed:@"急需.png"];
            }
            
            if ([[dictionary objectForKey:@"FlagSchool"]isEqualToString:@"1"]) {
                cell.xuequfang.image=[UIImage imageNamed:@"xuequfang_fen.png"];
            }
            
            NSString *custlevelString = [NSString stringWithFormat:@"%@",[dictionary objectForKey:@"CustLevel"] ];
            //            if ([[dictionary objectForKey:@"CustLevel"]  isEqual: @(1)]) {
            //                cell.XX1.image=[UIImage imageNamed:@"小黄星星.png"];
            //            }
            
            if ([custlevelString isEqualToString:@"1"]) {
                
                cell.XX1.image=[UIImage imageNamed:@"小黄星星.png"];
                cell.XX2.image=[UIImage imageNamed:@"小灰星星.png"];
                cell.XX3.image=[UIImage imageNamed:@"小灰星星.png"];
                cell.XX4.image=[UIImage imageNamed:@"小灰星星.png"];
                cell.XX5.image=[UIImage imageNamed:@"小灰星星.png"];
            }
            else if ([custlevelString isEqualToString:@"2"]){
                cell.XX1.image=[UIImage imageNamed:@"小黄星星.png"];
                cell.XX2.image=[UIImage imageNamed:@"小黄星星.png"];
                cell.XX3.image=[UIImage imageNamed:@"小灰星星.png"];
                cell.XX4.image=[UIImage imageNamed:@"小灰星星.png"];
                cell.XX5.image=[UIImage imageNamed:@"小灰星星.png"];
            }
            else if ([custlevelString isEqualToString:@"3"]){
                cell.XX1.image=[UIImage imageNamed:@"小黄星星.png"];
                cell.XX2.image=[UIImage imageNamed:@"小黄星星.png"];
                cell.XX3.image=[UIImage imageNamed:@"小黄星星.png"];
                
                cell.XX4.image=[UIImage imageNamed:@"小灰星星.png"];
                cell.XX5.image=[UIImage imageNamed:@"小灰星星.png"];
            }else if ([custlevelString isEqualToString:@"4"]){
                cell.XX1.image=[UIImage imageNamed:@"小黄星星.png"];
                cell.XX2.image=[UIImage imageNamed:@"小黄星星.png"];
                cell.XX3.image=[UIImage imageNamed:@"小黄星星.png"];
                cell.XX4.image=[UIImage imageNamed:@"小黄星星.png"];
                
                cell.XX5.image=[UIImage imageNamed:@"小灰星星.png"];
            }else if ([custlevelString isEqualToString:@"5"]){
                cell.XX1.image=[UIImage imageNamed:@"小黄星星.png"];
                cell.XX2.image=[UIImage imageNamed:@"小黄星星.png"];
                cell.XX3.image=[UIImage imageNamed:@"小黄星星.png"];
                cell.XX4.image=[UIImage imageNamed:@"小黄星星.png"];
                cell.XX5.image=[UIImage imageNamed:@"小黄星星.png"];
            }
            else {
                cell.XX1.image=[UIImage imageNamed:@"小灰星星.png"];
                cell.XX2.image=[UIImage imageNamed:@"小灰星星.png"];
                cell.XX3.image=[UIImage imageNamed:@"小灰星星.png"];
                cell.XX4.image=[UIImage imageNamed:@"小灰星星.png"];
                cell.XX5.image=[UIImage imageNamed:@"小灰星星.png"];
            }
            
            
            [cell.genjin addTarget:self action:@selector(genClick:) forControlEvents:UIControlEventTouchUpInside];
            cell.genjin.tag=indexPath.row;
            
            [cell.phoneBtn addTarget:self action:@selector(phoneClick:) forControlEvents:UIControlEventTouchUpInside];
            cell.phoneBtn.tag=indexPath.row;
        }
        
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell2 forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell2 respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell2 setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell2 respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell2 setLayoutMargins:UIEdgeInsetsZero];
    }
}
#pragma mark 返回按钮方法
-(void)returnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)Action:(NSNotification *)notifi
{
    
    //背景
    bgView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, PL_WIDTH, PL_HEIGHT)];
    //bgView.backgroundColor=[UIColor colorWithRed:108.0/255.0 green:108.0/255.0 blue:108.0/255.0 alpha:0.9];
    bgView.backgroundColor=[[UIColor grayColor]colorWithAlphaComponent:0.5];
    [self.view addSubview:bgView];
    
    
    //小背景
    genjinView=[[UIView alloc]initWithFrame:CGRectMake(20, PL_HEIGHT/3-30, PL_WIDTH-40, 200+30)];
    genjinView.alpha=1;
    genjinView.backgroundColor=[UIColor whiteColor];
    [bgView addSubview:genjinView];
    
    UILabel *yi=[[UILabel alloc]initWithFrame:CGRectMake(40, 10, 60, 20)];
    yi.text=@"意向度:";
    [genjinView addSubview:yi];
    self.starRateView = [[CWStarRateView alloc] initWithFrame:CGRectMake(100, 5, 150, 30) numberOfStars:5];
    self.starRateView.scorePercent = starCount/5.0;
    self.starRateView.allowIncompleteStar = NO;
    self.starRateView.hasAnimation = YES;
    self.starRateView.delegate=self;
    [genjinView addSubview:self.starRateView];
    
    //标题
    UILabel *title=[[UILabel alloc]initWithFrame:CGRectMake(PL_WIDTH/2-80, 5+30, 200, 30)];
    title.text=@"录入跟进信息";
    [genjinView addSubview:title];
    //跟进方式、按钮
    UIButton *FSBtn=[[UIButton alloc]initWithFrame:CGRectMake(20+20, 30+30, 80, 30)];
    [FSBtn addTarget:self action:@selector(fangshiClick:) forControlEvents:UIControlEventTouchUpInside];
    [genjinView addSubview:FSBtn];
    
    fangshi=[[UILabel alloc]initWithFrame:CGRectMake(20+20, 35+30, 50, 20)];
    fangshi.text=@"跟进方式";
    fangshi.font=[UIFont systemFontOfSize:12];
    fangshi.textAlignment=NSTextAlignmentCenter;
    [genjinView addSubview:fangshi];
    fangshiBtn=[[UIButton alloc]initWithFrame:CGRectMake(71+20, 40+30, 10, 10)];
    [fangshiBtn setImage:[UIImage imageNamed:@"dropdown.png"] forState:UIControlStateNormal];
    [fangshiBtn setImage:[UIImage imageNamed:@"dropup.png"] forState:UIControlStateSelected];
    [fangshiBtn addTarget:self action:@selector(fangshiClick:) forControlEvents:UIControlEventTouchUpInside];
    [genjinView addSubview:fangshiBtn];
    //跟进方式
    NSMutableArray * arrTitle = [NSMutableArray arrayWithObjects:@"电话",@"手机",@"微信",@"QQ",@"其他", nil];
    sousuoView = [[UIView alloc]initWithFrame:CGRectMake(20+20, 55+30, 80, 30*arrTitle.count)];
    UIImageView * viewBg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"black.png"]];
    viewBg.frame = CGRectMake(0, 0, CGRectGetWidth(sousuoView.frame), CGRectGetHeight(sousuoView.frame));
    [sousuoView addSubview:viewBg];
    
    for (int i=0; i<arrTitle.count-1; i++)
    {
        UIImageView * sousuoImage = [[UIImageView alloc]initWithFrame:CGRectMake(0,i*28+26+10, 80, 0.6)];
        sousuoImage.image = [UIImage imageNamed:@"black_in_hengxian.png"];
        sousuoImage.backgroundColor = [UIColor clearColor];
        [sousuoView addSubview:sousuoImage];
    }
    
    for (int j=0; j<arrTitle.count; j++)
    {
        UIButton * buttonLable = [UIButton buttonWithType:UIButtonTypeCustom];
        buttonLable.frame = CGRectMake(0, j*28+13, 80, 20);
        buttonLable.backgroundColor = [UIColor clearColor];
        buttonLable.titleLabel.font=[UIFont systemFontOfSize:12];
        [buttonLable setTitle:[arrTitle objectAtIndex:j] forState:UIControlStateNormal];
        [buttonLable setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        buttonLable.tag =2500+j;
        [buttonLable addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [sousuoView addSubview:buttonLable];
    }
    
    sousuoView.backgroundColor = [UIColor clearColor];
    
    //跟进类型、按钮
    sousuoViewstyle = [[UIView alloc]initWithFrame:CGRectMake(120+40, 55+30, 80, 80+40)];
    UIImageView * leixingIMge = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"black.png"]];
    leixingIMge.frame = CGRectMake(0, 0, CGRectGetWidth(sousuoViewstyle.frame), CGRectGetHeight(sousuoViewstyle.frame));
    [sousuoViewstyle addSubview:leixingIMge];
    styleTable=[[UITableView alloc]initWithFrame:CGRectMake(0, 7, leixingIMge.frame.size.width, 80+40-7) style:UITableViewStylePlain];
    styleTable.delegate=self;
    styleTable.dataSource=self;
    styleTable.tag=15000;
    styleTable.separatorColor = [UIColor grayColor];
    styleTable.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    
    styleTable.separatorInset = UIEdgeInsetsZero;
    styleTable.backgroundColor=[UIColor clearColor];
    [sousuoViewstyle addSubview:styleTable];
    if ([styleTable respondsToSelector:@selector(setSeparatorInset:)])
    {
        [styleTable setSeparatorInset:UIEdgeInsetsZero];
        
    }
    if([styleTable respondsToSelector:@selector(setLayoutMargins:)])
    {
        [styleTable setLayoutMargins:UIEdgeInsetsZero];
        
    }
    
    //    UIButton *STBtn=[[UIButton alloc]initWithFrame:CGRectMake(120+40, 30+30, 80, 30)];
    //    [STBtn addTarget:self action:@selector(styleClick:) forControlEvents:UIControlEventTouchUpInside];
    //    [genjinView addSubview:STBtn];
    
    style=[[UILabel alloc]initWithFrame:CGRectMake(120+40, 35+30, 50, 20)];
    style.text=@"跟进类型";
    style.font=[UIFont systemFontOfSize:12];
    [genjinView addSubview:style];
    //跟进方式、按钮
    UIButton *TPBtn=[[UIButton alloc]initWithFrame:CGRectMake(120+40, 35+30, 60, 20)];
    [TPBtn addTarget:self action:@selector(styleClick:) forControlEvents:UIControlEventTouchUpInside];
    [genjinView addSubview:TPBtn];
    styleBtn=[[UIButton alloc]initWithFrame:CGRectMake(171+40, 40+30, 10, 10)];
    [styleBtn setImage:[UIImage imageNamed:@"dropdown.png"] forState:UIControlStateNormal];
    [styleBtn setImage:[UIImage imageNamed:@"dropup.png"] forState:UIControlStateSelected];
    [styleBtn addTarget:self action:@selector(styleClick:) forControlEvents:UIControlEventTouchUpInside];
    [genjinView addSubview:styleBtn];
    
    //输入框
    textView1=[[UITextView alloc]initWithFrame:CGRectMake(20, 55+30, PL_WIDTH-40-40, 100)];
    textView1.layer.borderWidth=1.5;
    textView1.layer.borderColor = [UIColor grayColor].CGColor;
    textView1.delegate=self;
    [genjinView addSubview:textView1];
    
    placeholder=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, PL_WIDTH-40, 30)];
    placeholder.text=@"请输入跟进内容";
    placeholder.textColor=[UIColor grayColor];
    placeholder.font=[UIFont systemFontOfSize:13];
    [textView1 addSubview:placeholder];
    
    //统计
    count=[[UILabel alloc]initWithFrame:CGRectMake(25, 157+30, 100, 20)];
    count.text=[NSString stringWithFormat:@"0/100"];
    [genjinView addSubview:count];
    //确认按钮
    UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake(PL_WIDTH-135, 150+40, 77, 30)];
    [button setImage:[UIImage imageNamed:@"提交按钮.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(sureClick) forControlEvents:UIControlEventTouchUpInside];
    [genjinView addSubview:button];
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapbgView)];
    gesture.delegate = self;
    gesture.numberOfTapsRequired = 1;
    gesture.numberOfTouchesRequired = 1;
    [bgView addGestureRecognizer:gesture];
    
}
#pragma  mark ---写跟进
-(void)genClick:(UIButton *)sender
{
    indexTag=sender.tag;
    [[NSUserDefaults standardUserDefaults]setObject: [NSString stringWithFormat:@"%ld",(long)indexTag] forKey:@"indexTag"];
    
    NSDictionary *starDic=[_array objectAtIndex:sender.tag];
    starCount=[[starDic objectForKey:@"CustLevel"] intValue];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"sunhaichen" object:nil];
}

//-(void)sureClick1
//{
//    NSLog(@"123");
//}

#pragma mark 防止手势拦截
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    NSLog(@"%s",__FUNCTION__);
    
    if ([NSStringFromClass([touch.view class])isEqualToString:@"UITableViewCellContentView"]) {
        return NO;
    }
    else
    {
        return YES;
    }
}

-(void)tapbgView
{
    NSLog(@"==================== %s",__FUNCTION__);
    
    //    [genjinView removeFromSuperview];
    //    [bgView removeFromSuperview];
}
- (void)starRateView:(CWStarRateView *)starRateView scroePercentDidChange:(CGFloat)newScorePercent
{
    score=newScorePercent*5;
    starCount=score;
}
-(void)buttonClick:(UIButton *)sender
{
    fangshiBtn.selected=NO;
    switch (sender.tag) {
        case 2500:
        {
            fangshi.text=@"电话";
            [sousuoView removeFromSuperview];
        }
            break;
        case 2501:
        {
            fangshi.text=@"手机";
            [sousuoView removeFromSuperview];
        }
            break;
        case 2502:
        {
            fangshi.text=@"微信";
            [sousuoView removeFromSuperview];
        }
            break;
        case 2503:
        {
            fangshi.text=@"QQ";
            [sousuoView removeFromSuperview];
        }
            break;
        case 2504:
        {
            fangshi.text=@"其他";
            [sousuoView removeFromSuperview];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark----跟进方式
-(void)fangshiClick:(UIButton *)sender
{
    NSLog(@"%d",sender.selected);
    sender.selected=!sender.selected;
    if (sender.selected) {
        [genjinView addSubview:sousuoView];
        fangshiBtn.selected=YES;
    }else{
        [sousuoView removeFromSuperview];
        fangshiBtn.selected=NO;
    }
}
#pragma mark---跟进类型---
-(void)styleClick:(UIButton *)sender
{
    NSLog(@"******");
    styleArray = [NSArray array];
    
    sender.selected=!sender.selected;
    if (sender.selected) {
        styleBtn.selected=YES;
        PL_PROGRESS_SHOW;
        [[MyRequest defaultsRequest]GetFollowTypeList:^(NSMutableString *string) {
            NSLog(@"%@",string);
            if ([string isEqualToString:@"NOLOGIN"]) {
                ViewController *login=[[ViewController alloc]init];
                [self.navigationController popToViewController:login animated:YES];
            }
            if ([string isEqualToString:@"[]"]) {
                PL_ALERT_SHOW(@"暂无数据");
            }
            SBJSON *json=[[SBJSON alloc]init];
            styleArray=[json objectWithString:string error:nil];
            [styleTable reloadData];
            [genjinView addSubview:sousuoViewstyle];
            PL_PROGRESS_DISMISS;
        } userid:[[NSUserDefaults standardUserDefaults]objectForKey:PL_USER_NAME] token:[[NSUserDefaults standardUserDefaults]objectForKey:PL_USER_TOKEN]];
        
    }else{
        styleBtn.selected=NO;
        [sousuoViewstyle removeFromSuperview];
    }
    
    //    styleArray = [NSArray array];
    //    sender.selected=!sender.selected;
    //        if (sender.selected) {
    //        styleBtn.selected=YES;
    //        PL_PROGRESS_SHOW;
    //        [[MyRequest defaultsRequest]GetFollowTypeList:^(NSMutableString *string) {
    //            PL_PROGRESS_DISMISS;
    //            if ([string isEqualToString:@"NOLOGIN"]) {
    //                ViewController *login=[[ViewController alloc]init];
    //                [self.navigationController pushViewController:login animated:YES];
    //            }
    //            else if ([string isEqualToString:@"[]"]) {
    //                PL_ALERT_SHOW(@"暂无数据");
    //            }
    //            else  if ([string isEqualToString:@"exception"]) {
    //                PL_ALERT_SHOW(@"服务器异常");
    //            }
    //            else
    //            {
    //                SBJSON *json=[[SBJSON alloc]init];
    //                styleArray=[json objectWithString:string error:nil];
    //                [styleTable reloadData];
    //            }
    //
    //
    //        } userid:[[NSUserDefaults standardUserDefaults]objectForKey:PL_USER_NAME] token:[[NSUserDefaults standardUserDefaults]objectForKey:PL_USER_TOKEN]];
    //
    //    }else{
    //        [sousuoViewstyle removeFromSuperview];
    //        styleBtn.selected=NO;
    //    }
}

#pragma mark---UITextView  Delegate
- (void)textViewDidChange:(UITextView *)textView
{
    if (textView.text.length >BOOKMARK_WORD_LIMIT)
    {
        textView.text =[textView.text substringToIndex:BOOKMARK_WORD_LIMIT];
    }
    else
    {
        count.text=[NSString stringWithFormat:@"%lu/100",(unsigned long)textView.text.length];
    }
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (![text isEqualToString:@""])
    {
        placeholder.hidden = YES;
    }
    if ([text isEqualToString:@""] && range.location == 0 && range.length == 1)
    {
        placeholder.hidden = NO;
    }
    NSString * str = [NSString stringWithFormat:@"%@%@",textView.text,text];
    if (str.length >BOOKMARK_WORD_LIMIT)
    {
        textView.text =[textView.text substringToIndex:BOOKMARK_WORD_LIMIT];
        return NO;
    }
    else
    {
        count.text=[NSString stringWithFormat:@"%lu/100",(unsigned long)str.length];
    }
    return YES;
}
#pragma mark ---确认按钮
-(void)sureClick
{
    if (starCount<4) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"意向度过低，是否修改意向度" delegate:self cancelButtonTitle:@"否" otherButtonTitles:@"是", nil];
        [alert show];
    }
    else
    {
        [self commitRequest];
    }
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0) {
        [self commitRequest];
    }
    else
    {
        //        [self commitRequest];
    }
}


#pragma mark - 判断跟进信息是否是电话号码
- (BOOL)validateNumber:(NSString *) textString
{
    NSString * number = @"(\\d+){8,}(\\w+|\\D+|\\w+\\D+|\\D+\\w|)";
    NSString * number2 = @"(\\w+|\\D|\\w+\\D|\\D+\\w+|\\w+\\D+\\w|\\D+\\w+\\D+)(\\d+){8,}";
    NSString * number3 = @"(\\w+|\\D|\\w+\\D+|\\D+\\w)(\\d+){8,}(\\w+|\\D+|\\D+\\w+|\\w+\\D+)";
    NSLog(@"%@",number);
    NSPredicate *numberPre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",number];
    NSPredicate *numberPre2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",number2];
    
    NSPredicate *numberPre3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",number3];
    
    return [numberPre evaluateWithObject:textString] || [numberPre2 evaluateWithObject:textString] || [numberPre3 evaluateWithObject:textString];
    
}

-(void)commitRequest
{
    [textView1 resignFirstResponder];
    
    if ([fangshi.text isEqualToString:@"跟进方式"]&&[style.text isEqualToString:@"跟进类型"]&&[textView1.text isEqualToString:@""])
    {
        PL_ALERT_SHOW(@"跟进方式、跟进类型、跟进内容不能为空");
    }else if([style.text isEqualToString:@"跟进类型"]&&[textView1.text isEqualToString:@""]){
        PL_ALERT_SHOW(@"跟进类型、跟进内容不能为空");
    }else if([fangshi.text isEqualToString:@"跟进方式"]&&[textView1.text isEqualToString:@""]){
        PL_ALERT_SHOW(@"跟进方式、跟进内容不能为空");
    }else if([fangshi.text isEqualToString:@"跟进方式"]&&[style.text isEqualToString:@"跟进类型"]){
        PL_ALERT_SHOW(@"跟进方式、跟进类型不能为空");
    }else if([fangshi.text isEqualToString:@"跟进方式"]){
        PL_ALERT_SHOW(@"跟进方式不能为空");
    }else if([style.text isEqualToString:@"跟进类型"]){
        PL_ALERT_SHOW(@"跟进类型不能为空");
    }else if([textView1.text isEqualToString:@""]){
        PL_ALERT_SHOW(@"跟进内容不能为空");
    }else if ([self validateNumber:textView1.text]){
        PL_ALERT_SHOW(@"输入的内容不能含有电话号码");
        
    }
    else
    {
        NSLog(@"+++++%s",__FUNCTION__);
        CustomersFollowData *follow=[[CustomersFollowData alloc]init];
        NSString *indexStr=[[NSUserDefaults standardUserDefaults]objectForKey:@"indexTag"];
        NSDictionary *d=[_array objectAtIndex:indexStr.integerValue];
        follow.CustID=[d objectForKey:@"CustID"];
        follow.FollowType=style.text;
        follow.Content=textView1.text;
        follow.FollowWay=fangshi.text;
        follow.FollowID = [[NSUserDefaults standardUserDefaults] objectForKey:@"FOLLOWID"];
        follow.CustLevel=[NSString stringWithFormat:@"%ld",(long)starCount];
        follow.userid=[[NSUserDefaults standardUserDefaults]objectForKey:PL_USER_NAME];
        follow.token=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
        NSLog(@"%@  %@  %@  %@  %@  %@",follow.CustID,follow.FollowType,follow.Content,follow.FollowWay,follow.userid,follow.token);
        PL_PROGRESS_SHOW;
        [[MyRequest defaultsRequest]getAddCustomersFollow:follow backInfoMessage:^(NSMutableString *string) {
            
            NSLog(@"%@",string);
            if ([string isEqualToString:@"NOLOGIN"]) {
                
                ViewController *login=[[ViewController alloc]init];
                [self.navigationController pushViewController:login animated:YES];
            }
            else  if ([string isEqualToString:@"exception"]) {
                PL_ALERT_SHOW(@"服务器异常");
            }
            else if ([string isEqualToString:@"[]"])
            {
                PL_ALERT_SHOW(@"暂无数据");
            }
            if ([string isEqualToString:@"OK"]) {
                NSLog(@"%@",follow.CustLevel);
                PL_ALERT_SHOW(@"提交成功");
                //                rightBtn.selected=NO;
                //                rightIsClick=NO;
                //                [self postRequest];
                //0[self post2];
            }
            else if ([string isEqualToString:@"2"])
            {
                PL_ALERT_SHOW(@"您的私客已经满了，请先移除部分客源");
            }
            else if ([string isEqualToString:@"3"])
            {
                PL_ALERT_SHOW(@"该客户已变成其他客户经理的私客，无法更新");
            }
            else if ([string isEqualToString:@"ERR"])
            {
                PL_ALERT_SHOW(@"提交失败");
            }else
            {
                PL_ALERT_SHOW(@"提交内容有敏感词汇!");
            }
            PL_PROGRESS_DISMISS;
            //            // [self setupRefresh];
            //            [table headerBeginRefreshing];
            //            [table headerBeginRefreshing];
            //            [self setupRefresh];
            [table reloadData];
            [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"FOLLOWID"];
        }];
        [bgView removeFromSuperview];
        
    }
}

#pragma mark 点击拨打电话
-(void)phoneClick:(UIButton *)sender
{
    //    [self getSupCode];
    NSDictionary *starDic=[_array objectAtIndex:sender.tag];
    starCount=[[starDic objectForKey:@"CustLevel"] intValue];
    CustID = _array[sender.tag][@"CustID"];
    NSLog(@"id  %@",CustID);
    indexTag=sender.tag;
    [[NSUserDefaults standardUserDefaults]setObject: [NSString stringWithFormat:@"%ld",(long)indexTag] forKey:@"indexTag"];
    NSDictionary *visterDic = _array[sender.tag];
    NSString *phoneStr=[visterDic objectForKey:@"CustTel"];
    phoneArr=[phoneStr componentsSeparatedByString:@","];
    TelViewAlert * alert = [[TelViewAlert alloc]initWithconnectWithArray:phoneArr Calltype:callType_Vister custId:visterDic[@"CustID"]];
    alert.stringTitle = [NSString stringWithFormat:@"%@",visterDic[@"CustName"]];
    [alert showTelWindow:self.view];
    NSLog(@"%f",self.view.frame.origin.y);
    //        phoneBG=[[UIView alloc]initWithFrame:CGRectMake(0, 0, PL_WIDTH, PL_HEIGHT)];
    //        //phoneBG.backgroundColor=[UIColor colorWithRed:108.0/255.0 green:108.0/255.0 blue:108.0/255.0 alpha:0.9];
    //        phoneBG.backgroundColor=[[UIColor grayColor]colorWithAlphaComponent:0.5];
    //        [self.view addSubview:phoneBG];
    //
    //        UIImageView *bgImg=[[UIImageView alloc]initWithFrame:CGRectMake(20, 80+30, PL_WIDTH-40, 49)];
    //        bgImg.backgroundColor=[UIColor whiteColor];
    //        [phoneBG addSubview:bgImg];
    //
    //        UIImageView *tellusImg=[[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 30, 30)];
    //        tellusImg.image=[UIImage imageNamed:@"联系客服.png"];
    //
    //        UILabel *tellus=[[UILabel alloc]initWithFrame:CGRectMake(50, 10, 200, 30)];
    //        NSDictionary *d=[_array objectAtIndex:sender.tag];
    //        tellus.text=[d objectForKey:@"CustName"];
    //        [bgImg addSubview:tellus];
    //
    //        UIButton *delete=[[UIButton alloc]initWithFrame:CGRectMake(bgImg.frame.size.width-40, 15, 20, 20)];
    //        [delete setImage:[UIImage imageNamed:@"close_call_phone_activity.png.png"] forState:UIControlStateNormal];
    //        [delete addTarget:self action:@selector(deleteClick) forControlEvents:UIControlEventTouchUpInside];
    //        [bgImg addSubview:delete];
    //
    //
    //
    //        phoneTable=[[UITableView alloc]initWithFrame:CGRectMake(20, 160, PL_WIDTH-40, phoneArr.count<6?phoneArr.count*44:PL_HEIGHT/2+50) style:UITableViewStylePlain];
    //        phoneTable.delegate=self;
    //        phoneTable.dataSource=self;
    //        phoneTable.separatorColor=[UIColor grayColor];
    //        [phoneBG addSubview:phoneTable];
    //
    //        if ([phoneTable respondsToSelector:@selector(setSeparatorInset:)])
    //        {
    //            [phoneTable setSeparatorInset:UIEdgeInsetsZero];
    //        }
    //        if([phoneTable respondsToSelector:@selector(setLayoutMargins:)])
    //        {
    //            [phoneTable setLayoutMargins:UIEdgeInsetsZero];
    //        }
}

-(void)deleteClick
{
    [phoneBG removeFromSuperview];
}

#pragma mark--小区 片区点击事件
-(void)xiaoquClick:(UIButton *)sender
{
    NSDictionary *dic=[_array objectAtIndex:sender.tag];
    _resultString=nil;
    _array=nil;
    VisiterData *custom=[[VisiterData alloc]init];
    custom.userid=[[NSUserDefaults standardUserDefaults]objectForKey:PL_USER_NAME];
    custom.flagSubs = @"0";
    custom.subUserCode = @"";
    custom.telephoneNumberString = telePhoneNumberString;
    custom.pubTypeString = pubTypeString;
    custom.jiaoYiString = jiaoYiTypeString;
    custom.getAllString = @"1";
    custom.directFlgString = @"0";
    if (topStr1.length) {
        custom.CustLevel=topStr1;
    }
    else
    {
        custom.CustLevel=@"";
    }
    custom.DistrictName=sender.titleLabel.text;
    XQStr=custom.DistrictName;
    custom.AreaId=[NSString stringWithFormat:@"%@",[dic objectForKey:@"AreaID"]];
    custom.AreaId = @"";
    if (currentTradeStr.length) {
        custom.Trade=currentTradeStr;
    }
    else
    {
        custom.Trade=@"";
    }
    if (currentPriceMin.length) {
        custom.PriceMin=currentPriceMin;
    }
    else
    {
        custom.PriceMin=@"";
    }
    if (currentPriceMax.length) {
        custom.PriceMax=currentPriceMax;
    }
    else
    {
        custom.PriceMax=@"";
    }
    if (!topStr3.length) {
        custom.FlagRecommand=@"";
        custom.FlagNeed=@"";
        custom.FlagSchool=@"";
    }
    if ([topStr3 isEqualToString:@"经理推荐"]) {
        custom.FlagRecommand=@"1";
        custom.FlagNeed=@"";
        custom.FlagSchool=@"";
    }
    else if ([topStr3 isEqualToString:@"急需"]) {
        custom.FlagRecommand=@"";
        custom.FlagNeed=@"1";
        custom.FlagSchool=@"";
    }
    else if ([topStr3 isEqualToString:@"学区房"]) {
        custom.FlagRecommand=@"";
        custom.FlagNeed=@"";
        custom.FlagSchool=@"1";
    }
    
    if (!rightIsClick) {
        custom.FlagPrivate=@"1";
    }
    else
    {
        custom.FlagPrivate=@"0";
    }
    custom.StartIndex=@"";
    custom.token=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
    PL_PROGRESS_SHOW;
    
    [[MyRequest defaultsRequest]getCustomList:custom backInfoMessage:^(NSMutableString *string) {
        _resultString=string;
        if ([string isEqualToString:@"NOLOGIN"]) {
            ViewController *login=[[ViewController alloc]init];
            [self.navigationController pushViewController:login animated:YES];
        }
        else if ([string isEqualToString:@"[]"])
        {
            PL_ALERT_SHOW(@"暂无数据");
            [_array removeAllObjects];
        }
        else  if ([string isEqualToString:@"exception"]) {
            PL_ALERT_SHOW(@"服务器异常");
            [_array removeAllObjects];
        }
        else
        {
            SBJSON *json=[[SBJSON alloc]init];
            _array=[json objectWithString:_resultString error:nil];
        }
        
        [table reloadData];
        table.scrollsToTop=YES;
        PL_PROGRESS_DISMISS;
    }];
    
}
-(void)pianquClick:(UIButton *)sender
{
    NSDictionary *dic=[_array objectAtIndex:sender.tag];
    _resultString=nil;
    _array=nil;
    VisiterData *custom=[[VisiterData alloc]init];
    custom.userid=[[NSUserDefaults standardUserDefaults]objectForKey:PL_USER_NAME];
    custom.flagSubs = @"0";
    custom.subUserCode = @"";
    custom.telephoneNumberString = telePhoneNumberString;
    custom.pubTypeString = pubTypeString;
    custom.jiaoYiString = jiaoYiTypeString;
    custom.getAllString = @"1";
    custom.directFlgString =@"0";
    if (topStr1.length) {
        custom.CustLevel=topStr1;
    }
    else
    {
        custom.CustLevel=@"";
    }
    XQStr=[NSString stringWithFormat:@"%@",[dic objectForKey:@"DistrictName"]];
    if (XQStr.length) {
        custom.DistrictName=XQStr;
    }
    else
    {
        custom.DistrictName=@"";
    }
    
    
    custom.AreaId=[NSString stringWithFormat:@"%@",[dic objectForKey:@"AreaID"]];
    custom.AreaId = @"";
    PQStr=custom.AreaId;
    if (currentTradeStr.length) {
        custom.Trade=currentTradeStr;
    }
    else
    {
        custom.Trade=@"";
    }
    if (currentPriceMin.length) {
        custom.PriceMin=currentPriceMin;
    }
    else
    {
        custom.PriceMin=@"";
    }
    if (currentPriceMax.length) {
        custom.PriceMax=currentPriceMax;
    }
    else
    {
        custom.PriceMax=@"";
    }
    if (!topStr3.length) {
        custom.FlagRecommand=@"";
        custom.FlagNeed=@"";
        custom.FlagSchool=@"";
    }
    if ([topStr3 isEqualToString:@"经理推荐"]) {
        custom.FlagRecommand=@"1";
        custom.FlagNeed=@"";
        custom.FlagSchool=@"";
    }
    else if ([topStr3 isEqualToString:@"急需"]) {
        custom.FlagRecommand=@"";
        custom.FlagNeed=@"1";
        custom.FlagSchool=@"";
    }
    else if ([topStr3 isEqualToString:@"学区房"]) {
        custom.FlagRecommand=@"";
        custom.FlagNeed=@"";
        custom.FlagSchool=@"1";
    }
    if (!rightIsClick) {
        custom.FlagPrivate=@"1";
    }
    else
    {
        custom.FlagPrivate=@"0";
    }
    custom.StartIndex=@"";
    custom.token=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
    PL_PROGRESS_SHOW;
    [[MyRequest defaultsRequest]getCustomList:custom backInfoMessage:^(NSMutableString *string) {
        _resultString=string;
        if ([string isEqualToString:@"NOLOGIN"]) {
            ViewController *login=[[ViewController alloc]init];
            [self.navigationController pushViewController:login animated:YES];
        }
        else if ([string isEqualToString:@"[]"])
        {
            PL_ALERT_SHOW(@"暂无数据");
            [_array removeAllObjects];
        }
        else  if ([string isEqualToString:@"exception"]) {
            PL_ALERT_SHOW(@"服务器异常");
            [_array removeAllObjects];
        }
        else
        {
            SBJSON *json=[[SBJSON alloc]init];
            _array=[json objectWithString:_resultString error:nil];
        }
        
        [table reloadData];
        PL_PROGRESS_DISMISS;
    }];
}

-(void)tapClick
{
    NSLog(@"%s",__FUNCTION__);
    dropBgView.hidden=YES ;
    _tableView1.hidden=YES;
    _tableView2.hidden=YES;
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [textView1 resignFirstResponder];
    
    NSLog(@"%s",__FUNCTION__);
    _currentBtn2.selected=NO;
    _currentBtn3.selected=NO;
    _currentBtn4.selected=NO;
    UITouch *touch=[touches anyObject];
    CGPoint point=[touch locationInView:bgView];
    if (CGRectContainsPoint(genjinView.frame, point)) {
        [genjinView endEditing:YES];
        CGAffineTransform pTransform = CGAffineTransformMakeTranslation(0, 0);
        //使视图使用这个变换
        bgView.transform = pTransform;
    }
    else
    {
        [bgView removeFromSuperview];
        [genjinView removeFromSuperview];
        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"FOLLOWID"];
        
    }
    
}
- (void)change2:(id)sender
{
    //线程睡眠0.2秒以实现视图延迟上弹
    //[NSThread sleepForTimeInterval:0.2];
    //创建一个仿射变换，平移(0, -100)视图上移100像素
    CGAffineTransform pTransform = CGAffineTransformMakeTranslation(0, 0);
    //使视图使用这个变换
    view.transform = pTransform;
    
}

//当键盘出现或改变时调用
- (void)keyboardWillShow:(NSNotification *)aNotification
{
    //创建一个仿射变换，平移(0, -100)视图上移100像素
    CGAffineTransform pTransform = CGAffineTransformMakeTranslation(0, -120);
    //使视图使用这个变换
    bgView.transform = pTransform;
    
    placeholder.text=@"";
    
    
}

//当键退出时调用
- (void)keyboardWillHide:(NSNotification *)aNotification
{
    //创建一个仿射变换，平移(0, -100)视图上移100像素
    CGAffineTransform pTransform = CGAffineTransformMakeTranslation(0, 0);
    //使视图使用这个变换
    genjinView.transform = pTransform;
    
    if ([textView1.text isEqualToString:@""]) {
        placeholder.text=@"请输入跟进内容";
    }
    
    
    
    
}
#pragma mark --上啦下拉刷新
- (void)setupRefresh
{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    //    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    // dateKey用于存储刷新时间，可以保证不同界面拥有不同的刷新时间
    // [table addHeaderWithTarget:self action:@selector(headerRereshing) dateKey:@"table"];
    [table addHeaderWithTarget:self action:@selector(headerRereshing)];
    //#warning 自动刷新(一进入程序就下拉刷新)
    //    [self.tableView headerBeginRefreshing];
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [table addFooterWithTarget:self action:@selector(footerRereshing)];
    
    // 设置文字(也可以不设置,默认的文字在MJRefreshConst中修改)
    table.headerPullToRefreshText = @"下拉刷新";
    table.headerReleaseToRefreshText = @"松开刷新";
    table.headerRefreshingText = @"客源正在刷新中";
    
    table.footerPullToRefreshText = @"上拉加载更多数据";
    table.footerReleaseToRefreshText = @"松开加载更多数据";
    table.footerRefreshingText = @"客源正在加载中";
}

#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    NSString * name =[[NSUserDefaults standardUserDefaults]objectForKey:PL_USER_NAME];
    NSString * token = [PL_USER_STORAGE objectForKey:PL_USER_TOKEN];
    VisiterData *custom=[[VisiterData alloc]init];
    custom.userid=name;
    custom.flagSubs = @"0";
    custom.subUserCode = @"";
    custom.pubTypeString = pubTypeString;
    custom.telephoneNumberString = telePhoneNumberString;
    custom.jiaoYiString = jiaoYiTypeString;
    custom.getAllString = @"1";
    custom.directFlgString = @"0";
    NSLog(@"topStr1%@",topStr1);
    NSLog(@"XQStr%@",XQStr);
    NSLog(@"PQStr%@",PQStr);
    if (topStr1.length) {
        custom.CustLevel=topStr1;
    }
    else
    {
        custom.CustLevel=@"";
    }
    if (XQStr.length) {
        custom.DistrictName=XQStr;
    }
    else
    {
        custom.DistrictName=@"";
    }
    if (PQStr.length) {
        custom.AreaId=PQStr;
    }
    else
    {
        custom.AreaId=@"";
    }
    if (currentTradeStr.length) {
        custom.Trade=currentTradeStr;
    }
    else
    {
        custom.Trade=@"";
    }
    if (currentPriceMin.length) {
        custom.PriceMin=currentPriceMin;
    }
    else
    {
        custom.PriceMin=@"";
    }
    if (currentPriceMax.length) {
        custom.PriceMax=currentPriceMax;
    }
    else
    {
        custom.PriceMax=@"";
    }
    if (!rightIsClick) {
        custom.FlagPrivate=@"1";
    }
    else
    {
        custom.FlagPrivate=@"0";
    }
    custom.StartIndex=@"";
    if (!topStr3.length) {
        custom.FlagRecommand=@"";
        custom.FlagNeed=@"";
        custom.FlagSchool=@"";
    }
    if ([topStr3 isEqualToString:@"经理推荐"]) {
        custom.FlagRecommand=@"1";
        custom.FlagNeed=@"";
        custom.FlagSchool=@"";
    }
    else if ([topStr3 isEqualToString:@"急需"]) {
        custom.FlagRecommand=@"";
        custom.FlagNeed=@"1";
        custom.FlagSchool=@"";
    }
    else if ([topStr3 isEqualToString:@"学区房"]) {
        custom.FlagRecommand=@"";
        custom.FlagNeed=@"";
        custom.FlagSchool=@"1";
    }
    custom.token=token;
    PL_PROGRESS_SHOW;
    [[MyRequest defaultsRequest]getCustomList:custom backInfoMessage:^(NSMutableString *string) {
        _resultString=string;
        if ([string isEqualToString:@"NOLOGIN"]) {
            ViewController *login=[[ViewController alloc]init];
            [self.navigationController pushViewController:login animated:YES];
        }
        if ([string isEqualToString:@"maintain"]) {
            PL_ALERT_SHOW(@"系统维护中");
        }
        else if ([string isEqualToString:@"[]"]) {
            
            //            UILabel * label = [[UILabel alloc]init];
            //            label.textAlignment = NSTextAlignmentCenter;
            //            label.text = @"暂无私客数据";
            // table.backgroundView = label;
            
            PL_ALERT_SHOW(@"暂无数据");
            [_array removeAllObjects];
            
            // [table removeFromSuperview];
        }
        else  if ([string isEqualToString:@"exception"]) {
            PL_ALERT_SHOW(@"服务器异常");
            [_array removeAllObjects];
        }
        else
        {
            SBJSON *json=[[SBJSON alloc]init];
            _array=[json objectWithString:_resultString error:nil];
        }
        PL_PROGRESS_DISMISS;
        
        NSDictionary *dic = _array.firstObject;
        sikeLable.text = [NSString stringWithFormat:@"共%@条私客",[dic[@"CountNum"]length] == 0 ? @"0":dic[@"CountNum"]];
        NSLog(@"%@",sikeLable.text);
        
        if (rightIsClick==NO)
        {
            PL_PROGRESS_SHOW;
            [[MyRequest defaultsRequest] afGetPriviteCount:[PL_USER_STORAGE objectForKey:PL_USER_NAME] userToken:[PL_USER_STORAGE objectForKey:PL_USER_TOKEN] completeBack:^(id obj) {
                if ([obj isKindOfClass:[NSString class]])
                {
                    NSString * str = obj;
                    //                    sikeLable.text = [NSString stringWithFormat:@"共%@条私客",str];
                    NSLog(@"%@",sikeLable.text);
                    privateCount  = str;
                    
                }
            }];
        }
        else
        {
            PL_PROGRESS_SHOW;
            [[MyRequest defaultsRequest]afGetPublicCount:[PL_USER_STORAGE objectForKey:PL_USER_NAME] userToken:[PL_USER_STORAGE objectForKey:PL_USER_TOKEN] completeBack:^(id obj) {
                if ([obj isKindOfClass:[NSString class]])
                {
                    NSString * str2 = obj;
                    if ([str2 isEqualToString:@"[]"]) {
                        str2=@"0";
                    }
                    sikeLable.text = [NSString stringWithFormat:@"共%@条公客",str2];
                    PL_PROGRESS_DISMISS;
                }
            }];
        }
        [table reloadData];
        [table headerEndRefreshing];
        
    }];
}

//上拉加载
- (void)footerRereshing
{
    freshcount++;
    NSString * name =[[NSUserDefaults standardUserDefaults]objectForKey:PL_USER_NAME];
    NSString * token = [PL_USER_STORAGE objectForKey:PL_USER_TOKEN];
    // PL_PROGRESS_SHOW;
    VisiterData *custom=[[VisiterData alloc]init];
    custom.userid=name;
    custom.flagSubs = @"0";
    custom.subUserCode = @"";
    custom.pubTypeString = pubTypeString;
    custom.telephoneNumberString = telePhoneNumberString;
    custom.jiaoYiString = jiaoYiTypeString;
    custom.getAllString = @"1";
    custom.directFlgString = @"0";
    if (topStr1.length) {
        
        custom.CustLevel=topStr1;
    }
    else
    {
        custom.CustLevel=@"";
    }
    if (XQStr.length) {
        custom.DistrictName=XQStr;
    }
    else
    {
        custom.DistrictName=@"";
    }
    if (PQStr.length) {
        custom.AreaId=PQStr;
    }
    else
    {
        custom.AreaId=@"";
    }
    if (currentTradeStr.length) {
        custom.Trade=currentTradeStr;
    }
    else
    {
        custom.Trade=@"";
    }
    if (currentPriceMin.length) {
        custom.PriceMin=currentPriceMin;
    }
    else
    {
        custom.PriceMin=@"";
    }
    if (currentPriceMax.length) {
        custom.PriceMax=currentPriceMax;
    }
    else
    {
        custom.PriceMax=@"";
    }
    if (!rightIsClick) {
        custom.FlagPrivate=@"1";
    }
    else
    {
        custom.FlagPrivate=@"0";
    }
    NSString *countStr=[NSString stringWithFormat:@"%d",freshcount+1];
    custom.StartIndex=countStr;
    if (!topStr3.length) {
        custom.FlagRecommand=@"";
        custom.FlagNeed=@"";
        custom.FlagSchool=@"";
    }
    if ([topStr3 isEqualToString:@"经理推荐"]) {
        custom.FlagRecommand=@"1";
        custom.FlagNeed=@"";
        custom.FlagSchool=@"";
    }
    else if ([topStr3 isEqualToString:@"急需"]) {
        custom.FlagRecommand=@"";
        custom.FlagNeed=@"1";
        custom.FlagSchool=@"";
    }
    else if ([topStr3 isEqualToString:@"学区房"]) {
        custom.FlagRecommand=@"";
        custom.FlagNeed=@"";
        custom.FlagSchool=@"1";
    }
    custom.token=token;
    PL_PROGRESS_SHOW;
    [[MyRequest defaultsRequest]getCustomList:custom backInfoMessage:^(NSMutableString *string) {
        _resultString=string;
        if ([string isEqualToString:@"NOLOGIN"]) {
            ViewController *login=[[ViewController alloc]init];
            [self.navigationController pushViewController:login animated:YES];
        }else if ([string isEqualToString:@"maintain"]) {
            PL_ALERT_SHOW(@"系统维护中");
        }
        else  if ([string isEqualToString:@"exception"]) {
            PL_ALERT_SHOW(@"服务器异常");
        }
        else
        {
            SBJSON *json=[[SBJSON alloc]init];
            NSArray*array=[json objectWithString:_resultString error:nil];
            if (array.count==0) {
                UILabel * label = [[UILabel alloc]init];
                label.text = @"暂无私客数据";
                label.textAlignment = NSTextAlignmentCenter;
                //table.backgroundView = label;
                PL_ALERT_SHOW(@"没有更多数据了");
                freshcount--;
            }
            [_array addObjectsFromArray:array];
        }
        PL_PROGRESS_DISMISS;
        if (rightIsClick==NO)
        {
            //sikeLable.text = [NSString stringWithFormat:@"共有%ld条私客",(long)_array.count];
            PL_PROGRESS_SHOW;
            [[MyRequest defaultsRequest] afGetPriviteCount:[PL_USER_STORAGE objectForKey:PL_USER_NAME] userToken:[PL_USER_STORAGE objectForKey:PL_USER_TOKEN] completeBack:^(id obj) {
                if ([obj isKindOfClass:[NSString class]])
                {
                    NSString * str = obj;
                    sikeLable.text = [NSString stringWithFormat:@"共%@条私客",str];
                    NSLog(@"%@",sikeLable.text);
                    privateCount = str;
                    PL_PROGRESS_DISMISS;
                }
            }];
        }
        else
        {
            PL_PROGRESS_SHOW;
            [[MyRequest defaultsRequest]afGetPublicCount:[PL_USER_STORAGE objectForKey:PL_USER_NAME] userToken:[PL_USER_STORAGE objectForKey:PL_USER_TOKEN] completeBack:^(id obj) {
                if ([obj isKindOfClass:[NSString class]])
                {
                    NSString * str2 = obj;
                    if ([str2 isEqualToString:@"[]"]) {
                        str2=@"0";
                    }
                    sikeLable.text = [NSString stringWithFormat:@"共%@条公客",str2];
                    NSLog(@"%@",sikeLable.text);
                    PL_PROGRESS_DISMISS;
                }
            }];
        }
        [table reloadData];
        [table footerEndRefreshing];
    }];
}
#pragma mark --公司客切换
-(void)rightClick01:(UIButton *)sender
{
    sender.selected=!sender.selected;
    if (!sender.selected) {
        self.title=@"我的客源";
        rightIsClick=NO;
        [self postRequest];
    }
    else
    {
        self.title=@"公司客源";
        rightIsClick=YES;
        sikeLable.hidden = NO;
        [self post2];
    }
}

-(void)post2
{
    _strP = @"";
    NSString * name =[[NSUserDefaults standardUserDefaults]objectForKey:PL_USER_NAME];
    NSString * token = [PL_USER_STORAGE objectForKey:PL_USER_TOKEN];
    VisiterData *custom=[[VisiterData alloc]init];
    custom.userid=name;
    custom.flagSubs = @"0";
    custom.subUserCode = @"";
    custom.pubTypeString = pubTypeString;
    custom.telephoneNumberString = telePhoneNumberString;
    custom.jiaoYiString = jiaoYiTypeString;
    custom.getAllString = @"1";
    custom.directFlgString = @"0";
    if (topStr1.length) {
        custom.CustLevel=topStr1;
    }
    else
    {
        custom.CustLevel=@"";
    }
    if (XQStr.length) {
        custom.DistrictName=XQStr;
    }
    else
    {
        custom.DistrictName=@"";
    }
    if (PQStr.length) {
        custom.AreaId=PQStr;
    }
    else
    {
        custom.AreaId=@"";
    }
    if (currentTradeStr.length) {
        custom.Trade=currentTradeStr;
    }
    else
    {
        custom.Trade=@"";
    }
    if (currentPriceMin.length) {
        custom.PriceMin=currentPriceMin;
    }
    else
    {
        custom.PriceMin=@"";
    }
    if (currentPriceMax.length) {
        custom.PriceMax=currentPriceMax;
    }
    else
    {
        custom.PriceMax=@"";
    }
    custom.FlagPrivate=@"0";
    custom.StartIndex=@"";
    if (!topStr3.length) {
        custom.FlagRecommand=@"";
        custom.FlagNeed=@"";
        custom.FlagSchool=@"";
    }
    if ([topStr3 isEqualToString:@"经理推荐"]) {
        custom.FlagRecommand=@"1";
        custom.FlagNeed=@"";
        custom.FlagSchool=@"";
    }
    else if ([topStr3 isEqualToString:@"急需"]) {
        custom.FlagRecommand=@"";
        custom.FlagNeed=@"1";
        custom.FlagSchool=@"";
    }
    else if ([topStr3 isEqualToString:@"学区房"]) {
        custom.FlagRecommand=@"";
        custom.FlagNeed=@"";
        custom.FlagSchool=@"1";
    }
    custom.token=token;
    _strP = custom.FlagPrivate;
    PL_PROGRESS_SHOW;
    [[MyRequest defaultsRequest]getCustomList:custom backInfoMessage:^(NSMutableString *string) {
        _resultString=string;
        if ([string isEqualToString:@"NOLOGIN"]) {
            ViewController *login=[[ViewController alloc]init];
            [self.navigationController pushViewController:login animated:YES];
        }
        else if ([string isEqualToString:@"[]"]) {
            PL_ALERT_SHOW(@"暂无数据");
            [_array removeAllObjects];
        }
        else  if ([string isEqualToString:@"exception"]) {
            PL_ALERT_SHOW(@"服务器异常");
            [_array removeAllObjects];
        }
        else
        {
            NSLog(@"gongkeshuju--%@",_resultString);
            SBJSON *json=[[SBJSON alloc]init];
            _array=[json objectWithString:_resultString error:nil];
        }
        [table reloadData];
        PL_PROGRESS_DISMISS;
        PL_PROGRESS_SHOW;
        [[MyRequest defaultsRequest]afGetPublicCount:[PL_USER_STORAGE objectForKey:PL_USER_NAME] userToken:[PL_USER_STORAGE objectForKey:PL_USER_TOKEN] completeBack:^(id obj) {
            if ([obj isKindOfClass:[NSString class]])
            {
                NSString * str2 = obj;
                if ([str2 isEqualToString:@"[]"]) {
                    str2=@"0";
                }else{
                    sikeLable.text = [NSString stringWithFormat:@"共%@条公客",str2];
                }
                
            }
            PL_PROGRESS_DISMISS;
        }];
    }];
    
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

@end
