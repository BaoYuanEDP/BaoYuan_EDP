//
//  AVisiterDetailViewController.m
//  BYFCApp
//
//  Created by zzs on 14/12/4.
//  Copyright (c) 2014年 PengLee. All rights reserved.
//

#import "AVisiterDetailViewController.h"
//#import "AppointVisiterRequest.h"
#import "MyRequest.h"
#import "AppointVisiterData.h"
#import "PL_Header.h"
#import "CWStarRateView.h"
@interface AVisiterDetailViewController ()<UIGestureRecognizerDelegate>
{
    UIImageView * viewBg;
    UIButton * buttonLable;
    UIView *bgView;
    UIView *genjinView;
    UILabel *fangshi1;
    UIView *sousuoView1;
    UIButton *fangshiBtn1;
    UIView *sousuoViewstyle1;
    UITableView *styleTable1;
    UILabel *style1;
    UIButton *styleBtn1;
    UITextView *textView2;
    UILabel *placeholder1;
    UILabel *count1;
    NSArray *styleArray1;
    
    
}
@property (strong, nonatomic) CWStarRateView *starRateView1;

@end

@implementation AVisiterDetailViewController


-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self posetDetail];
    
    
}

#pragma mark 获取上级编号
-(void)getSupCode
{
    [[MyRequest defaultsRequest]afGetSupFromUserCode:[PL_USER_STORAGE objectForKey:PL_USER_USERID] userToken:[PL_USER_STORAGE objectForKey:PL_USER_TOKEN] completeBack:^(NSString *str) {
        self.supcode = str;
    }];
}

-(void)viewWillAppear:(BOOL)animated{
    
    self.navigationController.navigationBarHidden = NO;
    [bgView removeFromSuperview];
    [genjinView removeFromSuperview];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // NSLog(@"%d",_listArr.count);
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"FOLLOWID"];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(Action1:) name:@"sunhaichen" object:Nil];
    
    self.navigationController.navigationBarHidden = NO;
    self.edgesForExtendedLayout=UIRectEdgeNone;
    _scroll1=[[UIScrollView alloc]initWithFrame:CGRectMake(0,0, PL_WIDTH, PL_HEIGHT)];
    
    _scroll1.backgroundColor=[UIColor whiteColor];
    _scroll1.delegate=self;
    //_scroll1.canCancelContentTouches=YES;
    if (PL_HEIGHT<=481) {
        _scroll1.contentSize=CGSizeMake(PL_WIDTH, PL_HEIGHT*1.4);
    }
    else
    {
        _scroll1.contentSize=CGSizeMake(PL_WIDTH, PL_HEIGHT*1.2);
    }
    
    [self.view addSubview:_scroll1];
    //[self.view bringSubviewToFront:_scroll1];
    
    [self initContent];
    
    
    
    followTable=[[UITableView alloc]initWithFrame:CGRectMake(-3, CGRectGetMaxY(genjinBG.frame)+5+30, PL_WIDTH, 30) style:UITableViewStylePlain];
    
    followTable.delegate=self;
    followTable.dataSource=self;
    followTable.separatorStyle=UITableViewCellSeparatorStyleNone;
    [_scroll1 addSubview:followTable];
    
    
    [self initV];
    
    self.navigationController.navigationBarHidden=NO;
    //self.view.backgroundColor=[UIColor whiteColor];
    self.title=@"客源详情";
    UIButton * backItemBnt = [UIButton buttonWithType:UIButtonTypeCustom];
    backItemBnt.frame = CGRectMake(10, 10, 10, 20);
    [backItemBnt setBackgroundImage:[UIImage imageNamed:@"返回.png"] forState:UIControlStateNormal];
    [backItemBnt addTarget:self action:@selector(returnClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIBarButtonItem * leftBtn = [[UIBarButtonItem alloc]initWithCustomView:backItemBnt];
    self.navigationItem.leftBarButtonItem = leftBtn;
    
    if ([_strP isEqualToString:@"0"]) {
        //        _isHiden = YES;
        _isHiden = NO;
    }
    else
    {
        UIBarButtonItem *right=[[UIBarButtonItem alloc]initWithTitle:@"放公" style:UIBarButtonItemStylePlain target:self action:@selector(rightClick)];
        right.tintColor=[UIColor redColor];
        self.navigationItem.rightBarButtonItem=right;
    }
    
    //详情
    
    [[NSUserDefaults standardUserDefaults]setObject:[dic objectForKey:@"CustID"] forKey:@"CustID"];
    
    
    //    _name.text=[dic objectForKey:@"CustName"];
    //    _area.text=[NSString stringWithFormat:@"上海 %@ %@",[self changNullToNil:[dic objectForKey:@"DistrictName"]],[self changNullToNil:[dic objectForKey:@"AreaName"]]];
    //    _request.text=[NSString stringWithFormat:@"%@ %@ %@ %@",[self changNullToNil:[dic objectForKey:@"Trade"]],[self changNullToNil:[dic objectForKey:@"CountF"]],[self changNullToNil:[dic objectForKey:@"CountT"]],[self changNullToNil:[dic objectForKey:@"CountW"]]];
    //    _room.text=[NSString stringWithFormat:@"住宅面积: %@ m²",[self changNullToNil:[dic objectForKey:@"Square"]]];
    //    if ([[dic objectForKey:@"Remark"] length]) {
    //        _beizhu.text=[NSString stringWithFormat:@"%@",[dic objectForKey:@"Remark"]];
    //    }
    //    else
    //    {
    //        _beizhu.text=@"暂无备注信息";
    //    }
    //
    //    NSLog(@"%@",[dic objectForKey:@"CountW"]);
    //    NSLog(@"%@",[dic objectForKey:@"Remark"]);
    //    _price.text=[NSString stringWithFormat:@"价格区间:%@",[self changNullToNil:[dic objectForKey:@"Price"]]];
    
    
    
    /*
     UIImageView *logoImg=[[UIImageView alloc]initWithFrame:CGRectMake(PL_WIDTH/4, PL_HEIGHT<=480?PL_HEIGHT/2+180:PL_HEIGHT/2+150, PL_WIDTH/2, PL_HEIGHT/4)];
     logoImg.image=[UIImage imageNamed:@"detail_home_logo.png"];
     [_scroll1 addSubview:logoImg];
     logoImg.contentMode=UIViewContentModeScaleAspectFit;
     _scroll1.contentSize=CGSizeMake(PL_WIDTH, CGRectGetMaxY(logoImg.frame)+5);
     */
    
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
    
    /*
     for (UIView * v  in _scroll1.subviews)
     {
     
     if ([v isKindOfClass:[UILabel class]])
     {
     UILabel * fondLable = (UILabel *)v;
     // fondLable.font = [UIFont systemFontOfSize:12];
     fondLable.attributedText = [fondLable.text changeDigitialColor:fondLable.text];
     
     NSLog(@"hahah");
     
     }
     }
     */
    
}



- (void)Action1:(NSNotification *)notifi
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
    self.starRateView1 = [[CWStarRateView alloc] initWithFrame:CGRectMake(100, 5, 150, 30) numberOfStars:5];
    self.starRateView1.scorePercent = starCount/5.0;
    self.starRateView1.allowIncompleteStar = NO;
    self.starRateView1.hasAnimation = YES;
    self.starRateView1.delegate=self;
    [genjinView addSubview:self.starRateView1];
    
    //标题
    UILabel *title=[[UILabel alloc]initWithFrame:CGRectMake(PL_WIDTH/2-80, 5+30, 200, 30)];
    title.text=@"录入跟进信息";
    [genjinView addSubview:title];
    //跟进方式、按钮
    UIButton *FSBtn=[[UIButton alloc]initWithFrame:CGRectMake(20+20, 30+30, 80, 30)];
    [FSBtn addTarget:self action:@selector(fangshiClick1:) forControlEvents:UIControlEventTouchUpInside];
    [genjinView addSubview:FSBtn];
    
    fangshi1=[[UILabel alloc]initWithFrame:CGRectMake(20+20, 35+30, 50, 20)];
    fangshi1.text=@"跟进方式";
    fangshi1.font=[UIFont systemFontOfSize:12];
    fangshi1.textAlignment=NSTextAlignmentCenter;
    [genjinView addSubview:fangshi1];
    fangshiBtn1=[[UIButton alloc]initWithFrame:CGRectMake(71+20, 40+30, 10, 10)];
    [fangshiBtn1 setImage:[UIImage imageNamed:@"dropdown.png"] forState:UIControlStateNormal];
    [fangshiBtn1 setImage:[UIImage imageNamed:@"dropup.png"] forState:UIControlStateSelected];
    [fangshiBtn1 addTarget:self action:@selector(fangshiClick1:) forControlEvents:UIControlEventTouchUpInside];
    [genjinView addSubview:fangshiBtn1];
    //跟进方式
    NSMutableArray * arrTitle = [NSMutableArray arrayWithObjects:@"电话",@"手机",@"微信",@"QQ",@"其他", nil];
    sousuoView1 = [[UIView alloc]initWithFrame:CGRectMake(20+20, 55+30, 80, 30*arrTitle.count)];
    UIImageView * viewBg1 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"black.png"]];
    viewBg1.frame = CGRectMake(0, 0, CGRectGetWidth(sousuoView1.frame), CGRectGetHeight(sousuoView1.frame));
    [sousuoView1 addSubview:viewBg1];
    
    for (int i=0; i<arrTitle.count-1; i++)
    {
        UIImageView * sousuoImage = [[UIImageView alloc]initWithFrame:CGRectMake(0,i*28+26+10, 80, 0.6)];
        sousuoImage.image = [UIImage imageNamed:@"black_in_hengxian.png"];
        sousuoImage.backgroundColor = [UIColor clearColor];
        [sousuoView1 addSubview:sousuoImage];
    }
    
    for (int j=0; j<arrTitle.count; j++)
    {
        UIButton * buttonLable1 = [UIButton buttonWithType:UIButtonTypeCustom];
        buttonLable1.frame = CGRectMake(0, j*28+13, 80, 20);
        buttonLable1.backgroundColor = [UIColor clearColor];
        buttonLable1.titleLabel.font=[UIFont systemFontOfSize:12];
        [buttonLable1 setTitle:[arrTitle objectAtIndex:j] forState:UIControlStateNormal];
        [buttonLable1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        buttonLable1.tag =2500+j;
        [buttonLable1 addTarget:self action:@selector(buttonClick1:) forControlEvents:UIControlEventTouchUpInside];
        [sousuoView1 addSubview:buttonLable1];
    }
    
    sousuoView1.backgroundColor = [UIColor clearColor];
    
    //跟进类型、按钮
    sousuoViewstyle1 = [[UIView alloc]initWithFrame:CGRectMake(120+40, 55+30, 80, 80+40)];
    UIImageView * leixingIMge = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"black.png"]];
    leixingIMge.frame = CGRectMake(0, 0, CGRectGetWidth(sousuoViewstyle1.frame), CGRectGetHeight(sousuoViewstyle1.frame));
    [sousuoViewstyle1 addSubview:leixingIMge];
    styleTable1=[[UITableView alloc]initWithFrame:CGRectMake(0, 7, leixingIMge.frame.size.width, 80+40-7) style:UITableViewStylePlain];
    styleTable1.delegate=self;
    styleTable1.dataSource=self;
    styleTable1.tag=15000;
    styleTable1.separatorColor = [UIColor grayColor];
    styleTable1.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    
    styleTable1.separatorInset = UIEdgeInsetsZero;
    styleTable1.backgroundColor=[UIColor clearColor];
    [sousuoViewstyle1 addSubview:styleTable1];
    if ([styleTable1 respondsToSelector:@selector(setSeparatorInset:)])
    {
        [styleTable1 setSeparatorInset:UIEdgeInsetsZero];
        
    }
    if([styleTable1 respondsToSelector:@selector(setLayoutMargins:)])
    {
        [styleTable1 setLayoutMargins:UIEdgeInsetsZero];
        
    }
    
    //    UIButton *STBtn=[[UIButton alloc]initWithFrame:CGRectMake(120+40, 30+30, 80, 30)];
    //    [STBtn addTarget:self action:@selector(styleClick:) forControlEvents:UIControlEventTouchUpInside];
    //    [genjinView addSubview:STBtn];
    
    style1=[[UILabel alloc]initWithFrame:CGRectMake(120+40, 35+30, 50, 20)];
    style1.text=@"跟进类型";
    style1.font=[UIFont systemFontOfSize:12];
    [genjinView addSubview:style1];
    //跟进方式、按钮
    UIButton *typeBtn=[[UIButton alloc]initWithFrame:CGRectMake(120+40, 35+30, 60, 20)];
    [typeBtn addTarget:self action:@selector(styleClick1:) forControlEvents:UIControlEventTouchUpInside];
    [genjinView addSubview:typeBtn];
    
    styleBtn1=[[UIButton alloc]initWithFrame:CGRectMake(171+40, 40+30, 10, 10)];
    [styleBtn1 setImage:[UIImage imageNamed:@"dropdown.png"] forState:UIControlStateNormal];
    [styleBtn1 setImage:[UIImage imageNamed:@"dropup.png"] forState:UIControlStateSelected];
    [styleBtn1 addTarget:self action:@selector(styleClick1:) forControlEvents:UIControlEventTouchUpInside];
    [genjinView addSubview:styleBtn1];
    
    //输入框
    textView2=[[UITextView alloc]initWithFrame:CGRectMake(20, 55+30, PL_WIDTH-40-40, 100)];
    textView2.layer.borderWidth=1.5;
    textView2.layer.borderColor = [UIColor grayColor].CGColor;
    textView2.delegate=self;
    [genjinView addSubview:textView2];
    
    placeholder1=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, PL_WIDTH-40, 30)];
    placeholder1.text=@"请输入跟进内容";
    placeholder1.textColor=[UIColor grayColor];
    placeholder1.font=[UIFont systemFontOfSize:13];
    [textView2 addSubview:placeholder1];
    
    //统计
    count1=[[UILabel alloc]initWithFrame:CGRectMake(25, 157+30, 100, 20)];
    count1.text=[NSString stringWithFormat:@"0/100"];
    [genjinView addSubview:count1];
    //确认按钮
    UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake(PL_WIDTH-135, 150+40, 77, 30)];
    [button setImage:[UIImage imageNamed:@"提交按钮.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(sureClick1) forControlEvents:UIControlEventTouchUpInside];
    [genjinView addSubview:button];
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapbgView)];
    gesture.delegate = self;
    gesture.numberOfTapsRequired = 1;
    gesture.numberOfTouchesRequired = 1;
    [bgView addGestureRecognizer:gesture];
    
}
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
#pragma mark ---确认按钮
-(void)sureClick1
{
    if (starCount<4) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"意向度过低，是否修改意向度" delegate:self cancelButtonTitle:@"否" otherButtonTitles:@"是", nil];
        alert.tag = 200000;
        [alert show];
    }
    else
    {
        [self commitRequest1];
    }
}

-(void)buttonClick1:(UIButton *)sender
{
    fangshiBtn1.selected=NO;
    switch (sender.tag) {
        case 2500:
        {
            fangshi1.text=@"电话";
            [sousuoView1 removeFromSuperview];
        }
            break;
        case 2501:
        {
            fangshi1.text=@"手机";
            [sousuoView1 removeFromSuperview];
        }
            break;
        case 2502:
        {
            fangshi1.text=@"微信";
            [sousuoView1 removeFromSuperview];
        }
            break;
        case 2503:
        {
            fangshi1.text=@"QQ";
            [sousuoView1 removeFromSuperview];
        }
            break;
        case 2504:
        {
            fangshi1.text=@"其他";
            [sousuoView1 removeFromSuperview];
        }
            break;
            
        default:
            break;
    }
}


#pragma mark----跟进方式
-(void)fangshiClick1:(UIButton *)sender
{
    NSLog(@"%d",sender.selected);
    sender.selected=!sender.selected;
    if (sender.selected) {
        [genjinView addSubview:sousuoView1];
        fangshiBtn1.selected=YES;
    }else{
        [sousuoView1 removeFromSuperview];
        fangshiBtn1.selected=NO;
    }
}
#pragma mark---跟进类型---
-(void)styleClick1:(UIButton *)sender
{
    NSLog(@"******");
    styleArray = [NSArray array];
    
    sender.selected=!sender.selected;
    if (sender.selected) {
        styleBtn1.selected=YES;
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
            [styleTable1 reloadData];
            [genjinView addSubview:sousuoViewstyle1];
            PL_PROGRESS_DISMISS;
        } userid:[[NSUserDefaults standardUserDefaults]objectForKey:PL_USER_NAME] token:[[NSUserDefaults standardUserDefaults]objectForKey:PL_USER_TOKEN]];
        
    }else{
        styleBtn1.selected=NO;
        [sousuoViewstyle1 removeFromSuperview];
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

#pragma mark 刷新数据
-(void)posetDetail
{
    PL_PROGRESS_SHOW;
    [[MyRequest defaultsRequest]getCustomDetailInfoEasterList:self.customDetail backInfoMessage:^(NSMutableString *string) {
        if ([string isEqualToString:@"NOLOGIN"]) {
            ViewController *login=[[ViewController alloc]init];
            [self.navigationController pushViewController:login animated:YES];
        }
        else if ([string isEqualToString:@"exception"]) {
            PL_ALERT_SHOW(@"服务器异常");
        }
        else if ([string isEqualToString:@"[]"])
        {
            PL_ALERT_SHOW(@"暂无数据");
        }
        else
        {
            //            SBJSON *json=[[SBJSON alloc]init];
            //            NSArray *array=[json objectWithString:string error:nil];
            //
            //            NSDictionary * dicti=[array objectAtIndex:0];
            //            NSLog(@"%@",[dicti objectForKey:@"CustLevel"]);
            NSLog(@"string=>>>>>>>>>>>>>>>>>>>>%@",string);
            self.detailString = string;
            SBJSON *json=[[SBJSON alloc]init];
            _arr=[json objectWithString:_detailString error:nil];
            [self refreshDetail];
            
        }
        PL_PROGRESS_DISMISS;
        
    }];
    
    
    
}
-(void)refreshDetail
{
    //    SBJSON *json=[[SBJSON alloc]init];
    //    NSArray *array=[json objectWithString:_detailString error:nil];
    dic=[_arr objectAtIndex:0];
    _name.text=[NSString stringWithFormat:@"%@ %@",[dic objectForKey:@"CustName"],[dic objectForKey:@"Sex"]];
    //    _sex.text = [dic objectForKey:@"Sex"];
    _area.text=[NSString stringWithFormat:@"上海 %@ %@",[self changNullToNil:[dic objectForKey:@"DistrictName"]],[self changNullToNil:[dic objectForKey:@"AreaName"]]];
    _request.text=[NSString stringWithFormat:@"%@ %@ %@ %@",[self changNullToNil:[dic objectForKey:@"Trade"]],[self changNullToNil:[dic objectForKey:@"CountF"]],[self changNullToNil:[dic objectForKey:@"CountT"]],[self changNullToNil:[dic objectForKey:@"CountW"]]];
    _room.text=[NSString stringWithFormat:@"住宅面积: %@ m²",[self changNullToNil:[dic objectForKey:@"Square"]]];
    if ([[dic objectForKey:@"Remark"] length]&&![[dic objectForKey:@"Remark"] isEqualToString:@"--"]) {
        _beizhu.text=[NSString stringWithFormat:@"%@",[dic objectForKey:@"Remark"]];
    }
    else
    {
        _beizhu.text=@"暂无备注信息";
    }
    
    NSLog(@"%@",[dic objectForKey:@"CountW"]);
    NSLog(@"%@",[dic objectForKey:@"Remark"]);
    if([[dic objectForKey:@"DistrictName"] isEqualToString:@"求购"])
    {
        _price.text=[NSString stringWithFormat:@"价格区间:%@万元",[self changNullToNil:[dic objectForKey:@"Price"]]];
    }
    else if([[dic objectForKey:@"DistrictName"] isEqualToString:@"求租"])
    {
        _price.text=[NSString stringWithFormat:@"价格区间:%@万元",[self changNullToNil:[dic objectForKey:@"Rental"]]];
    }
    else
    {
        _price.text=[NSString stringWithFormat:@"价格区间:%@万元",[self changNullToNil:[dic objectForKey:@"Price"]]];
    }
    NSLog(@">>>>>>>>>>>%@",[dic objectForKey:@"Price"]);
    starCount=[[dic objectForKey:@"CustLevel"] intValue];
    self.starRateView.scorePercent = starCount/5.0;
    self.starRateView.allowIncompleteStar = NO;
    self.starRateView.delegate=self;
    self.starRateView.hasAnimation = YES;
    if ([_strP isEqualToString:@"0"]) {
        //        self.starRateView.userInteractionEnabled=NO;
        self.starRateView.userInteractionEnabled = YES;
        //        _isHiden = YES;
        _isHiden = NO;
    }
    else
    {
        _isHiden = NO;
        
        self.starRateView.userInteractionEnabled=YES;
    }
    
    [self genJinRequest];
}

#pragma mark 如果字为null返回nil
-(NSString *)changNullToNil:(NSString *)str
{
    
    if ([str isEqual:[NSNull null]]) {
        return @"";
    }
    else
    {
        return str;
    }
}

-(void)initContent
{
    if (PL_HEIGHT<=480) {
        height=0;
    }
    else
    {
        height=0;
    }
    _name=[[UILabel alloc]initWithFrame:CGRectMake(20, PL_HEIGHT<=480?10:10, 200, 15)];
    //_name.text=@"公开课 阿姨";
    _name.font=[UIFont systemFontOfSize:13];
    [_scroll1 addSubview:_name];
    
    //    _sex=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_name.frame), PL_HEIGHT<=480?10:10, 80, 15)];
    //    _sex.font=[UIFont systemFontOfSize:13];
    //    [_scroll1 addSubview:_sex];
    
    _area=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(_name.frame), CGRectGetMaxY(_name.frame)+8, 250, CGRectGetHeight(_name.frame))];
    // _area.text=@"上海  松南片区";
    _area.font=[UIFont systemFontOfSize:13];
    [_scroll1 addSubview:_area];
    
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(_area.frame), CGRectGetMaxY(_area.frame)+8, 60, CGRectGetHeight(_area.frame))];
    label1.text = @"客源类型:";
    label1.font=[UIFont systemFontOfSize:13];
    
    [_scroll1 addSubview:label1];
    _request=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(label1.frame), CGRectGetMaxY(_area.frame)+8, 250, CGRectGetHeight(label1.frame))];
    //    _request.text=@"求购 --------------------------";
    _request.font=[UIFont systemFontOfSize:13];
    [_scroll1 addSubview:_request];
    
    _room=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(label1.frame), CGRectGetMaxY(label1.frame)+8, 250, CGRectGetHeight(label1.frame))];
    _room.font=[UIFont systemFontOfSize:13];
    [_scroll1 addSubview:_room];
    
    /*
     _beizhu=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(_room.frame), CGRectGetMaxY(_room.frame)+5, CGRectGetWidth(_room.frame)+200, CGRectGetHeight(_room.frame))];
     _beizhu.font=[UIFont systemFontOfSize:13];
     [_scroll1 addSubview:_beizhu];
     */
    _price=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(_room.frame), CGRectGetMaxY(_room.frame)+8, CGRectGetWidth(_room.frame), CGRectGetHeight(_room.frame))];
    _price.font=[UIFont systemFontOfSize:13];
    [_scroll1 addSubview:_price];
    
    yixiang=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(_price.frame), CGRectGetMaxY(_price.frame)+8, 60, CGRectGetHeight(_price.frame))];
    yixiang.text=@"意向度：";
    yixiang.font=[UIFont systemFontOfSize:13];
    [_scroll1 addSubview:yixiang];
    
    self.starRateView = [[CWStarRateView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(yixiang.frame)-13, CGRectGetMaxY(_price.frame), 120, 30) numberOfStars:5];
    
    //    starCount=[[dic objectForKey:@"CustLevel"] intValue];
    //    NSLog(@"%ld",starCount/5);
    //    self.starRateView.scorePercent = starCount/5.0;
    
    //    self.starRateView.allowIncompleteStar = NO;
    //    self.starRateView.delegate=self;
    //    self.starRateView.hasAnimation = YES;
    //    if (_isHiden==YES) {
    //        self.starRateView.userInteractionEnabled=NO;
    //    }
    //    else
    //    {
    //        self.starRateView.userInteractionEnabled=YES;
    //    }
    
    [_scroll1 addSubview:self.starRateView];
    
    UIImageView *beizhuBG=[[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(yixiang.frame)+5, PL_WIDTH, 30)];
    beizhuBG.image=[UIImage imageNamed:@"hengtiaobeijing.png"];
    
    [_scroll1 addSubview:beizhuBG];
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(_price.frame), 0, PL_WIDTH, 30)];
    label.text=@"备注：";
    label.font=[UIFont systemFontOfSize:13];
    [beizhuBG addSubview:label];
    
    
    _beizhu=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(_price.frame)+10, CGRectGetMaxY(beizhuBG.frame), PL_WIDTH, 30)];
    _beizhu.font=[UIFont systemFontOfSize:13];
    [_scroll1 addSubview:_beizhu];
    
    genjinBG=[[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_beizhu.frame), PL_WIDTH, 30)];
    genjinBG.image=[UIImage imageNamed:@"hengtiaobeijing.png"];
    genjinBG.userInteractionEnabled=YES;
    [_scroll1 addSubview:genjinBG];
    genjinLab=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(_price.frame), 0, 80, 30)];
    
    genjinLab.text=@"跟进信息：";
    genjinLab.font=[UIFont systemFontOfSize:13];
    [genjinBG addSubview:genjinLab];
    
    UIButton *allBtn=[[UIButton alloc]initWithFrame:CGRectMake(PL_WIDTH-60, 0, 60, 30)];
    [allBtn setTitle:@"全部" forState:UIControlStateNormal];
    
    [allBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    allBtn.titleLabel.font=[UIFont systemFontOfSize:13];
    [allBtn addTarget:self action:@selector(allBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [genjinBG addSubview:allBtn];
    
    NSInteger X;
    if (PL_WIDTH==320) {
        X=(CGRectGetMinX(genjinLab.frame)-10)/320.0*PL_WIDTH;
    }
    else
    {
        X=(CGRectGetMinX(genjinLab.frame)-10)/320.0*PL_WIDTH+8;
    }
    genR=[[UILabel alloc]initWithFrame:CGRectMake(X, CGRectGetMaxY(genjinBG.frame), 0.17*PL_WIDTH, 30)];
    genR.textColor=[UIColor redColor];
    genR.font=[UIFont systemFontOfSize:13];
    //genR.backgroundColor=[UIColor redColor];
    genR.text=@"跟进人";
    [_scroll1 addSubview:genR];
    UILabel *genF=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(genR.frame)-5, CGRectGetMaxY(genjinBG.frame), 0.17*PL_WIDTH, 30)];
    genF.textColor=[UIColor redColor];
    genF.text=@"跟进方式";
    genF.font=[UIFont systemFontOfSize:13];
    [_scroll1 addSubview:genF];
    UILabel *genS=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(genF.frame)+10, CGRectGetMaxY(genjinBG.frame), 0.17*PL_WIDTH, 30)];
    genS.textColor=[UIColor redColor];
    genS.text=@"跟进类型";
    genS.font=[UIFont systemFontOfSize:13];
    [_scroll1 addSubview:genS];
    UILabel *genT=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(genS.frame)+10, CGRectGetMaxY(genjinBG.frame), 0.17*PL_WIDTH, 30)];
    genT.textColor=[UIColor redColor];
    genT.text=@"客户反馈";
    genT.font=[UIFont systemFontOfSize:13];
    [_scroll1 addSubview:genT];
    UILabel *genD=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(genT.frame)+10, CGRectGetMaxY(genjinBG.frame), 0.17*PL_WIDTH, 30)];
    genD.textColor=[UIColor redColor];
    genD.text=@"跟进时间";
    genD.font=[UIFont systemFontOfSize:13];
    [_scroll1 addSubview:genD];
    
    //    followTable=[[UITableView alloc]initWithFrame:CGRectMake(CGRectGetMinX(genjinLab.frame), CGRectGetMaxY(genjinBG.frame)+5, PL_WIDTH, 150)];
    //    followTable.delegate=self;
    //    followTable.dataSource=self;
    //    followTable.separatorStyle=UITableViewCellSeparatorStyleNone;
    // [_scroll1 addSubview:followTable];
    
    
    phoneButton=[[UIButton alloc]initWithFrame:CGRectMake(PL_WIDTH-45, PL_HEIGHT<=480?2:2, 40, 40)];
    [phoneButton setImage:[UIImage imageNamed:@"redPhone_1@2x.png"] forState:UIControlStateNormal];
    [phoneButton addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_scroll1 addSubview:phoneButton];
    
    //设置按钮
    UIButton * setButton = [[UIButton alloc]initWithFrame:CGRectMake(PL_WIDTH-45, PL_HEIGHT<=480?50:50,40,40)];
    //setButton.backgroundColor = [UIColor blackColor];
    // [setButton setTitle:@"jjjj" forState:UIControlStateNormal];
    [setButton setImage:[UIImage imageNamed:@"reviseFY"] attributeTitle:nil];
    [setButton addTarget:self action:@selector(clickSetButton:) forControlEvents:UIControlEventTouchUpInside];
    [_scroll1 addSubview: setButton];
    
    //约看按钮
    UIButton *lookAboutButton = [[UIButton alloc]initWithFrame:CGRectMake(PL_WIDTH-45, PL_HEIGHT<=480?100:100, 40, 40)];
    // lookAboutButton.backgroundColor = [UIColor grayColor];
    
    [lookAboutButton setBackgroundImage :[UIImage imageNamed:@"lookabout1"] forState:UIControlStateNormal];
    [lookAboutButton addTarget:self action:@selector(clickLookAboutButton:) forControlEvents:UIControlEventTouchUpInside];
    [_scroll1 addSubview:lookAboutButton];
    
    
}

//约看方法
-(void)clickLookAboutButton:(UIButton*)sender{
    
    
    NSLog(@"%@",[UIImage imageNamed:@"日历"]);
    NSLog(@"%@",[UIImage imageNamed:@"lookabout"]);
    
    LookAboutAddView *lookaddView = [[LookAboutAddView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    lookaddView.CustID =[_dict objectForKey:@"CustID"];
    
    [lookaddView addSelfInAView:self.view];
    
    //
    //    LookSeeView *lookSeeView = [[LookSeeView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    //    [lookSeeView addSelfInAView:self.view];
    
    //
    //    if (_AVisiterDetailPropertyID==nil) {
    //
    //        RoomSourceVC *roomsourceVc = [[RoomSourceVC alloc]init];
    //        //传客源ID到房源
    //        roomsourceVc.RoonSourceCustID = [_dict objectForKey:@"CustID"];
    //        [self.navigationController pushViewController:roomsourceVc animated:YES];
    //    }else
    //    {
    //        [[MyRequest defaultsRequest]afSetGoSee:_AVisiterDetailPropertyID CustID:[_dict objectForKey:@"CustID"] Source:@"ios" userID:[PL_USER_STORAGE objectForKey:PL_USER_USERID] userToken:[PL_USER_STORAGE objectForKey:PL_USER_TOKEN] completeBack:^(NSString *str) {
    //
    //            NSLog(@"str:%@",str);
    //
    //            if ([str isEqualToString:@"OK"])
    //            {
    //                PL_ALERT_SHOW(@"添加约看成功");
    //            }else if ([str isEqualToString:@"ERR"])
    //            {
    //
    //                PL_ALERTVIEW_SHOW(@"添加约看失败");
    //            }else{
    //
    //                PL_ALERTVIEW_SHOW(@"房源ID或客源ID不存在");
    //            }
    //
    //        }];
    //
    //    }
    //
    
    
    
}
//客源详情设置按钮
-(void)clickSetButton:(UIButton *)sender
{
    
    VisiterDetailSetViewController *visiterDetailSetVc = [[VisiterDetailSetViewController alloc]initWithNibName:@"VisiterDetailSetViewController" bundle:nil] ;
    //住宅面积
    visiterDetailSetVc. smallStr= [dic objectForKey:@"Square"];
    //房
    visiterDetailSetVc.roomStr = [dic objectForKey:@"CountF"];
    //厅
    visiterDetailSetVc.hallStr = [self changNullToNil:[dic objectForKey:@"CountT"]];
    //客源ID
    visiterDetailSetVc.CustID = [_dict objectForKey:@"CustID"];
    //意向区域
    visiterDetailSetVc.DistricName = [NSString stringWithFormat:@"%@",[dic objectForKey:@"DistrictName"]];
    visiterDetailSetVc.AreaName = [NSString stringWithFormat:@"%@",[dic objectForKey:@"AreaName"]];
    //片区ID
    visiterDetailSetVc.AreaID = [dic objectForKey:@"AreaID"];
    //购价
    visiterDetailSetVc.Price = [_dict objectForKey:@"Price"];
    //租价
    visiterDetailSetVc.Rental = [_dict objectForKey:@"Rental"];
    [self.navigationController pushViewController:visiterDetailSetVc animated:YES];
    
}

-(void)allBtnClick
{
    AllFollowViewController *all=[[AllFollowViewController alloc]init];
    [self.navigationController pushViewController:all animated:YES];
}
- (void)starRateView:(CWStarRateView *)starRateView scroePercentDidChange:(CGFloat)newScorePercent
{
    
    //NSLog(@"%d",score);
    if (_isHiden==NO) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"是否修改意向度" delegate:self cancelButtonTitle:@"是" otherButtonTitles:@"否", nil];
        [alert show];
        alert.tag=100;
        score=newScorePercent*5;
        starCount=score;
    }
    else
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"是否提交跟进和意向度" delegate:self cancelButtonTitle:@"是" otherButtonTitles:@"否", nil];
        [alert show];
        alert.tag=400;
        //        alert.tag=100;
        score=newScorePercent*5;
        starCount=score;
    }
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==100) {
        if (buttonIndex==0) {
            NSLog(@"yes=====%ld",(long)score);
            //score=score2;
            PL_PROGRESS_SHOW;
            [[MyRequest defaultsRequest]afUpdateCustLevelCustID:self.custId CustLevel:[NSString stringWithFormat:@"%ld",(long)score] userid:[PL_USER_STORAGE objectForKey:PL_USER_NAME] userToken:[PL_USER_STORAGE objectForKey:PL_USER_TOKEN] completBack:^(id obj) {
                NSLog(@"obj==========%@",obj);
                if ([obj isKindOfClass:[NSString class]]&&obj) {
                    if ([obj isEqualToString:@"OK"]) {
                        NSLog(@"%@",[NSString stringWithFormat:@"%ld",(long)score]);
                        PL_ALERT_SHOW(@"意向度修改成功");
                    }
                    else if ([obj isEqualToString:@"2"])
                    {
                        PL_ALERT_SHOW(@"您的私客已经满了，请先移除部分客源");
                    }
                    else if ([obj isEqualToString:@"3"])
                    {
                        PL_ALERT_SHOW(@"该客户已变成其他客户经理的私客，无法更新");
                    }
                    else
                    {
                        PL_ALERT_SHOW(@"意向度修改失败");
                        //self.starRateView.scorePercent = starCount/5.0;
                    }
                }
                PL_PROGRESS_DISMISS;
            }];
        }
        else
        {
            NSLog(@"no");
            //self.starRateView.scorePercent = starCount/5.0;
        }
    }
    else if(alertView.tag==200)
    {
        if (buttonIndex==0) {
            PL_PROGRESS_SHOW;
            [[MyRequest defaultsRequest]afCancelPrivateCustID:self.custId userid:[PL_USER_STORAGE objectForKey:PL_USER_NAME] userToken:[PL_USER_STORAGE objectForKey:PL_USER_TOKEN] completBack:^(id obj) {
                PL_PROGRESS_DISMISS;
                if ([obj isEqualToString:@"OK"]) {
                    PL_ALERT_SHOW(@"更改成功");
                    [self.navigationController popViewControllerAnimated:YES];
                }
            }];
        }
        else
        {
            NSLog(@"cancle");
        }
    }
    else if(alertView.tag==300)
    {
        if (buttonIndex==0) {
            [self commitRequest];
        }
        else
        {
            self.starRateView.userInteractionEnabled=YES;
            //[self commitRequest];
        }
    }
    else if(alertView.tag==200000)
    {
        if (buttonIndex==0) {
            [self commitRequest1];
        }
        else
        {
            
        }
    }
    else
    {
        if (buttonIndex==0) {
            [self commitRequest];
        }
        else
        {
            
        }
    }
    
}

-(void)genJinRequest
{
    //跟进列表
    CustFollowListData *followList=[[CustFollowListData alloc]init];
    followList.CustID=[_dict objectForKey:@"CustID"];
    followList.userid=[[NSUserDefaults standardUserDefaults]objectForKey:@"userName"];
    followList.token=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
    PL_PROGRESS_SHOW;
    NSLog(@"%@ %@ %@",[_dict objectForKey:@"CustID"],[[NSUserDefaults standardUserDefaults]objectForKey:@"userName"],[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"]);
    [[MyRequest defaultsRequest]GetCustFollow:followList backInfoMessage:^(NSMutableString *string) {
        
        if ([string isEqualToString:@"NOLOGIN"]) {
            ViewController *login=[[ViewController alloc]init];
            [self.navigationController pushViewController:login animated:YES];
        }
        SBJSON *json=[[SBJSON alloc]init];
        followArray=[json objectWithString:string error:nil];
        // followTable.frame=CGRectMake(CGRectGetMinX(genjinBG.frame), CGRectGetMaxY(genjinBG.frame)+5, PL_WIDTH, followArray.count*followTable.rowHeight);
        
        
        
        if (followArray.count==0) {
            followHeight=30;
        }
        else
        {
            followHeight=followArray.count*30;
        }
        followTable.frame =CGRectMake(-3, CGRectGetMaxY(genjinBG.frame)+5+30, PL_WIDTH, followHeight);
        //        followTable.delegate=self;
        //        followTable.dataSource=self;
        //        followTable.separatorStyle=UITableViewCellSeparatorStyleNone;
        //        [_scroll1 addSubview:followTable];
        [followTable reloadData];
        //        [self initV];
        [self changeFram];
        PL_PROGRESS_DISMISS;
        
    }];
}
-(void)changeFram
{
    view.frame = CGRectMake(0, CGRectGetMaxY(followTable.frame)+5, PL_WIDTH, 200);
}
-(void)initV
{
    
    
    //写跟进
    //小背景
    //    view=[[UIView alloc]initWithFrame:CGRectMake(0, PL_HEIGHT/2+10, PL_WIDTH, 200)];
    view=[[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(followTable.frame)+5, PL_WIDTH, 200)];
    view.alpha=1;
    
    [_scroll1 addSubview:view];
    
    UIImageView *smallView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, PL_WIDTH, 30)];
    smallView.image=[UIImage imageNamed:@"hengtiaobeijing.png"];
    [view addSubview:smallView];
    UILabel *luruLab=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(_price.frame), 0, 100, 30)];
    luruLab.text=@"录入跟进信息：";
    luruLab.font=[UIFont systemFontOfSize:13];
    [smallView addSubview:luruLab];
    fangshi=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(luruLab.frame), 35-30, 50, 20)];
    fangshi.text=@"跟进方式";
    fangshi.textAlignment=NSTextAlignmentCenter;
    fangshi.font=[UIFont systemFontOfSize:12];
    
    [smallView addSubview:fangshi];
    UIButton *fangshBtn=[[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(luruLab.frame), 35-30, 50, 20)];
    [fangshBtn addTarget:self action:@selector(fangshiClick2:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:fangshBtn];
    
    TAP=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(TapTounch:)];
    
    [view addGestureRecognizer:TAP];
    
    fangshiBtn=[[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(fangshi.frame), 40-30, 10, 10)];
    [fangshiBtn setImage:[UIImage imageNamed:@"dropdown.png"] forState:UIControlStateNormal];
    [fangshiBtn setImage:[UIImage imageNamed:@"dropup.png"] forState:UIControlStateSelected];
    [fangshiBtn addTarget:self action:@selector(fangshiClick2:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:fangshiBtn];
    //跟进方式
    NSMutableArray * arrTitle = [NSMutableArray arrayWithObjects:@"电话",@"手机",@"微信",@"QQ",@"其他", nil];
    popView = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMinX(fangshi.frame), 55-30, 80, 30*arrTitle.count)];
    popView.layer.cornerRadius=8;
    popView.layer.masksToBounds=YES;
    popView.backgroundColor=[UIColor clearColor];
    viewBg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"black.png"]];
    viewBg.frame = CGRectMake(0, 0, CGRectGetWidth(popView.frame), CGRectGetHeight(popView.frame));
    [popView addSubview:viewBg];
    for (int i=0; i<3; i++)
    {
        UIImageView * sousuoImage = [[UIImageView alloc]initWithFrame:CGRectMake(0,i*28+26+10, 80, 0.6)];
        sousuoImage.image = [UIImage imageNamed:@"black_in_hengxian.png"];
        sousuoImage.backgroundColor = [UIColor clearColor];
        [popView addSubview:sousuoImage];
    }
    
    for (int j=0; j<arrTitle.count; j++)
    {
        buttonLable = [UIButton buttonWithType:UIButtonTypeCustom];
        buttonLable.frame = CGRectMake(0, j*28+8+8, 80, 20);
        buttonLable.backgroundColor = [UIColor clearColor];
        buttonLable.titleLabel.font=[UIFont systemFontOfSize:15];
        [buttonLable setTitle:[arrTitle objectAtIndex:j] forState:UIControlStateNormal];
        [buttonLable setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        buttonLable.tag =2500+j;
        [buttonLable addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [popView addSubview:buttonLable];
    }
    
    
    //跟进类型、按钮
    
    UIButton *STBtn=[[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(fangshiBtn.frame)+20, 0, 80, 30)];
    [STBtn addTarget:self action:@selector(styleClick:) forControlEvents:UIControlEventTouchUpInside];
    //STBtn.backgroundColor=[UIColor redColor];
    [view addSubview:STBtn];
    
    style=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(fangshiBtn.frame)+20, 35-30, 50, 20)];
    style.text=@"跟进类型";
    style.font=[UIFont systemFontOfSize:12];
    [smallView addSubview:style];
    styleBtn=[[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(style.frame), 40-30, 10, 10)];
    [styleBtn setImage:[UIImage imageNamed:@"dropdown.png"] forState:UIControlStateNormal];
    [styleBtn setImage:[UIImage imageNamed:@"dropup.png"] forState:UIControlStateSelected];
    [styleBtn addTarget:self action:@selector(styleClick:) forControlEvents:UIControlEventTouchUpInside];
    [smallView addSubview:styleBtn];
    //输入框
    textView=[[UITextView alloc]initWithFrame:CGRectMake(20, 35, PL_WIDTH-40, 100)];
    
    textView.layer.borderWidth=1.5;
    textView.layer.borderColor = [UIColor grayColor].CGColor;
    textView.delegate=self;
    [view addSubview:textView];
    placeholder=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, PL_WIDTH-40, 30)];
    placeholder.text=@"请输入内容";
    placeholder.textColor=[UIColor grayColor];
    placeholder.font=[UIFont systemFontOfSize:13];
    [textView addSubview:placeholder];
    //统计
    count=[[UILabel alloc]initWithFrame:CGRectMake(25, CGRectGetMaxY(textView.frame)+5, 100, 20)];
    count.text=[NSString stringWithFormat:@"0/100"];
    [view addSubview:count];
    //确认按钮
    UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake(PL_WIDTH-120+26, CGRectGetMaxY(textView.frame)+5, 77, 30)];
    [button setImage:[UIImage imageNamed:@"提交按钮.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(sureClick02) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
}


-(void)buttonClick:(UIButton *)sender
{
    fangshiBtn.selected=NO;
    switch (sender.tag) {
        case 2500:
        {
            fangshi.text=@"电话";
            [popView removeFromSuperview];
        }
            break;
        case 2501:
        {
            fangshi.text=@"手机";
            [popView removeFromSuperview];
        }
            break;
        case 2502:
        {
            fangshi.text=@"微信";
            [popView removeFromSuperview];
        }
            break;
        case 2503:
        {
            fangshi.text=@"QQ";
            [popView removeFromSuperview];
        }
            break;
        case 2504:
        {
            fangshi.text=@"其他";
            [popView removeFromSuperview];
        }
            break;
        default:
            break;
    }
}

#pragma mark----跟进方式
-(void)fangshiClick2:(UIButton *)sender
{
    sender.selected=!sender.selected;
    if (sender.selected) {
        [view addSubview:popView];
        
    }else{
        fangshiBtn.selected=NO;
        [popView removeFromSuperview];
    }
}
#pragma mark---跟进类型---
-(void)styleClick:(UIButton *)sender
{
    
    
    if (sender.selected) {
        
        TAP.enabled=YES;
        textView.editable=YES;
    }else
    {
        TAP.enabled=NO;
        textView.editable=NO;
        
        
    }
    
    sender.selected=!sender.selected;
    if (sender.selected) {
        styleBtn.selected=YES;
        _scroll1.scrollEnabled=YES;
        PL_PROGRESS_SHOW;
        [[MyRequest defaultsRequest]GetFollowTypeList:^(NSMutableString *string) {
            if ([string isEqualToString:@"NOLOGIN"]) {
                ViewController *login=[[ViewController alloc]init];
                [self.navigationController pushViewController:login animated:YES];
            }
            if ([string isEqualToString:@"[]"]) {
                PL_ALERT_SHOW(@"暂无数据");
            }
            SBJSON *json=[[SBJSON alloc]init];
            styleArray=[json objectWithString:string error:nil];
            viewBg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"black.png"]];
            viewBg.frame = CGRectMake(style.frame.origin.x+3, 25, 100,180);
            viewBg.layer.cornerRadius=10;
            viewBg.layer.masksToBounds=YES;
            viewBg.userInteractionEnabled=YES;
            [view addSubview:viewBg];
            styleTable=[[UITableView alloc]initWithFrame:CGRectMake(0, 16, 80+20, 80+40-7+50) style:UITableViewStylePlain];
            styleTable.delegate=self;
            styleTable.dataSource=self;
            styleTable.pagingEnabled=YES;
            styleTable.backgroundColor=[UIColor clearColor];
            [viewBg addSubview:styleTable];
            
            if ([styleTable respondsToSelector:@selector(setSeparatorInset:)])
            {
                [styleTable setSeparatorInset:UIEdgeInsetsZero];
                
            }
            if([styleTable respondsToSelector:@selector(setLayoutMargins:)])
            {
                [styleTable setLayoutMargins:UIEdgeInsetsZero];
                
            }
            PL_PROGRESS_DISMISS;
        } userid:[[NSUserDefaults standardUserDefaults]objectForKey:PL_USER_NAME] token:[[NSUserDefaults standardUserDefaults]objectForKey:PL_USER_TOKEN]];
        
    }else{
        styleBtn.selected=NO;
        _scroll1.scrollEnabled=NO;
        [viewBg removeFromSuperview];
    }
}
#pragma mark--表---
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==phoneTable) {
        return phoneArr.count;
    }
    else if (tableView==followTable)
    {
        if (followArray.count==0) {
            return 1;
        }
        else
        {
            return followArray.count;
        }
        
    }
    else
    {
        return styleArray.count;
    }
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str=@"cellStr";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:str];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
        
    }
    if (tableView==phoneTable)
    {
        //cell.backgroundView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"拨打电话背景.png"]];
        cell.backgroundColor=[UIColor whiteColor];
        NSString *phoneString=[phoneArr objectAtIndex:indexPath.row];
        phoneArr2=[phoneString componentsSeparatedByString:@"|"];
        //cell.textLabel.text=[NSString stringWithFormat:@"            %@",[phoneArr2 objectAtIndex:0]];
        NSString *phoneStr=[phoneArr2 objectAtIndex:0];
        
        NSLog(@"=====%@",phoneStr);
        if (phoneStr.length==11) {
            cell.textLabel.text=[NSString stringWithFormat:@"        %@",phoneStr];
            UIImage *image=[UIImage imageNamed:@"call_mobile.png"];
            CGSize itemSize = CGSizeMake(30, 30);
            UIGraphicsBeginImageContextWithOptions(itemSize, NO,0.0);
            CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
            [image drawInRect:imageRect];
            
            cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            
        }
        else
        {
            cell.textLabel.text=[NSString stringWithFormat:@"          %@",phoneStr];
            UIImage *image=[UIImage imageNamed:@"call_phone.png"];
            CGSize itemSize = CGSizeMake(30, 30);
            UIGraphicsBeginImageContextWithOptions(itemSize, NO,0.0);
            CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
            [image drawInRect:imageRect];
            
            cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
        }
    }
    else if (tableView==followTable)
    {
        cell.textLabel.font=[UIFont systemFontOfSize:12];
        if (followArray.count==0) {
            cell.textLabel.text=@"";
        }
        else
        {
            for (UIView *subView in cell.contentView.subviews) {
                [subView removeFromSuperview];
            }
            cell.textLabel.text=@"";
            NSDictionary *dictionary1=[followArray objectAtIndex:indexPath.row];
            UILabel *lab1=[[UILabel alloc]initWithFrame:CGRectMake(7/320.00*PL_WIDTH, 0, 0.17*PL_WIDTH, 20)];
            lab1.textAlignment=NSTextAlignmentCenter;
            lab1.text=[NSString stringWithFormat:@"%@",[dictionary1 objectForKey:@"EmpName"]];
            //lab1.backgroundColor=[UIColor redColor];
            lab1.font=[UIFont systemFontOfSize:12];
            [cell.contentView addSubview:lab1];
            UILabel *lab2=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(lab1.frame), 0, 0.17*PL_WIDTH, 20)];
            lab2.text=[dictionary1 objectForKey:@"FollowWay"];
            lab2.textAlignment=NSTextAlignmentCenter;
            lab2.font=[UIFont systemFontOfSize:12];
            //lab2.backgroundColor=[UIColor redColor];
            [cell.contentView addSubview:lab2];
            UILabel *lab3=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(lab2.frame)+10, 0, 0.17*PL_WIDTH, 20)];
            lab3.text=[dictionary1 objectForKey:@"FollowType"];
            lab3.font=[UIFont systemFontOfSize:12];
            lab3.textAlignment=NSTextAlignmentCenter;
            // lab3.backgroundColor=[UIColor redColor];
            [cell.contentView addSubview:lab3];
            UILabel *lab4=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(lab3.frame)+13, 0, 0.17*PL_WIDTH, 20)];
            lab4.text=[dictionary1 objectForKey:@"Content"];
            lab4.font=[UIFont systemFontOfSize:12];
            lab4.textAlignment=NSTextAlignmentLeft;
            //lab4.backgroundColor=[UIColor redColor];
            [cell.contentView addSubview:lab4];
            UILabel *lab5=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(lab4.frame)+5, 0, 0.17*PL_WIDTH+13, 20)];
            
            NSString *str5=[dictionary1 objectForKey:@"FollowDate"];
            NSString *newStr5=[str5 substringToIndex:10];
            NSLog(@"%@",newStr5);
            lab5.text=newStr5;
            lab5.font=[UIFont systemFontOfSize:12];
            lab5.textAlignment=NSTextAlignmentLeft;
            //lab4.backgroundColor=[UIColor redColor];
            [cell.contentView addSubview:lab5];
            cell.selectionStyle=UITableViewCellSelectionStyleGray;
        }
        
    }
    else if(tableView == styleTable )
    {
        NSDictionary *dict=[styleArray objectAtIndex:indexPath.row];
        cell.textLabel.text=[dict objectForKey:@"FollowType"];
        cell.textLabel.font=[UIFont systemFontOfSize:14];
        cell.textLabel.textColor=[UIColor whiteColor];
        cell.backgroundColor=[UIColor clearColor];
    }
    
    else if (tableView.tag==15000) {
        static NSString *str=@"cellStr";
        UITableViewCell *cell2=[tableView dequeueReusableCellWithIdentifier:str];
        if (!cell2) {
            cell2=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
        }
        if (styleArray.count>0)
        {
            NSDictionary *dic1=[styleArray objectAtIndex:indexPath.row];
            cell2.textLabel.text=[dic1 objectForKey:@"FollowType"];
            cell2.textLabel.font=[UIFont systemFontOfSize:12];
            cell2.backgroundColor=[UIColor clearColor];
            cell2.textLabel.textColor=[UIColor whiteColor];
            cell2.selectionStyle=UITableViewCellSelectionStyleNone;
            
            
        }
        return cell2;
    }
    
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==phoneTable) {
        return 44;
    }
    else if (tableView==followTable)
    {
        return 30;
    }
    else
    {
        return 30;
    }
    
}

#pragma mark---UITextView  Delegate
- (void)textViewDidChange:(UITextView *)textView3
{
    if (textView3 == textView) {
        if (textView.text.length >BOOKMARK_WORD_LIMIT)
        {
            textView.text =[textView.text substringToIndex:BOOKMARK_WORD_LIMIT];
            
            
        }
        else
        {
            count.text=[NSString stringWithFormat:@"%ld/100",(unsigned long)textView.text.length];
            
            
        }
    }
    else if(textView3 == textView2)
    {
        if (textView2.text.length >BOOKMARK_WORD_LIMIT)
        {
            textView2.text =[textView2.text substringToIndex:BOOKMARK_WORD_LIMIT];
            
            
        }
        else
        {
            count1.text=[NSString stringWithFormat:@"%ld/100",(unsigned long)textView2.text.length];
            
            
        }
    }
    
    
}

-(BOOL)textView:(UITextView *)textView1 shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if(textView1 == textView)
    {
        NSLog(@"length=====%ld",(unsigned long)textView1.text.length);
        if (![text isEqualToString:@""]) {
            placeholder.hidden=YES;
            
        }
        if ([text isEqualToString:@""] && range.location == 0 && range.length == 1) {
            placeholder.hidden=NO;
        }
        NSString * str = [NSString stringWithFormat:@"%@%@",textView.text,text];
        if (str.length >BOOKMARK_WORD_LIMIT)
        {
            textView.text =[textView.text substringToIndex:BOOKMARK_WORD_LIMIT];
            return NO;
        }
        else
        {
            count.text=[NSString stringWithFormat:@"%ld/100",(unsigned long)str.length];
            
        }
        
        return YES;
    }
    else if(textView1 == textView2)
    {
        NSLog(@"length=====%ld",(unsigned long)textView1.text.length);
        if (![text isEqualToString:@""]) {
            placeholder1.hidden=YES;
            
        }
        if ([text isEqualToString:@""] && range.location == 0 && range.length == 1) {
            placeholder1.hidden=NO;
        }
        NSString * str = [NSString stringWithFormat:@"%@%@",textView2.text,text];
        if (str.length >BOOKMARK_WORD_LIMIT)
        {
            textView2.text =[textView2.text substringToIndex:BOOKMARK_WORD_LIMIT];
            return NO;
        }
        else
        {
            count1.text=[NSString stringWithFormat:@"%ld/100",(unsigned long)str.length];
            
        }
        
        return YES;
    }
    return YES;
    
}
#pragma mark ---确认按钮
-(void)sureClick02
{
    [view endEditing:YES];
    if (_isHiden==NO) {
        [self commitRequest];
    }
    else
    {
        NSLog(@"sta====%ld",(long)starCount);
        if (starCount<4) {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"意向度过低，是否修改意向度" delegate:self cancelButtonTitle:@"否" otherButtonTitles:@"是", nil];
            alert.delegate=self;
            alert.tag=300;
            [alert show];
        }
        else
        {
            [self commitRequest];
        }
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
    [textView resignFirstResponder];
    if ([fangshi.text isEqualToString:@"跟进方式"]&&[style.text isEqualToString:@"跟进类型"]&&[textView.text isEqualToString:@""]) {
        PL_ALERT_SHOW(@"跟进方式、跟进类型、跟进内容不能为空");
    }else if([style.text isEqualToString:@"跟进类型"]&&[textView.text isEqualToString:@""]){
        PL_ALERT_SHOW(@"跟进类型、跟进内容不能为空");
    }else if([fangshi.text isEqualToString:@"跟进方式"]&&[textView.text isEqualToString:@""]){
        PL_ALERT_SHOW(@"跟进方式、跟进内容不能为空");
    }else if([fangshi.text isEqualToString:@"跟进方式"]&&[style.text isEqualToString:@"跟进类型"]){
        PL_ALERT_SHOW(@"跟进方式、跟进类型不能为空");
    }else if([fangshi.text isEqualToString:@"跟进方式"]){
        PL_ALERT_SHOW(@"跟进方式不能为空");
    }else if([style.text isEqualToString:@"跟进类型"]){
        PL_ALERT_SHOW(@"跟进类型不能为空");
    }else if([textView.text isEqualToString:@""]){
        PL_ALERT_SHOW(@"跟进内容不能为空");
        
    }else if ([self validateNumber:textView.text]){
        PL_ALERT_SHOW(@"输入的内容不能含有电话号码");
        
    }else
    {
        CustomersFollowData *follow=[[CustomersFollowData alloc]init];
        follow.CustID=[[NSUserDefaults standardUserDefaults]objectForKey:@"custID"];
        follow.FollowType=style.text;
        follow.Content=textView.text;
        follow.FollowWay=fangshi.text;
        follow.FollowID = [[NSUserDefaults standardUserDefaults]objectForKey:@"FOLLOWID"];
        follow.CustLevel=[NSString stringWithFormat:@"%ld",(long)starCount];
        follow.userid=[[NSUserDefaults standardUserDefaults]objectForKey:PL_USER_NAME];
        follow.token=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
        NSLog(@"%@  %@  %@  %@  %@  %@",follow.CustID,follow.FollowType,follow.Content,follow.FollowWay,follow.userid,follow.token);
        PL_PROGRESS_SHOW;
        [[MyRequest defaultsRequest]getAddCustomersFollow:follow backInfoMessage:^(NSMutableString *string) {
            if ([string isEqualToString:PL_NO_LOGIN_]) {
                ViewController *login=[[ViewController alloc]init];
                [self.navigationController pushViewController:login animated:YES];
            }
            if ([string isEqualToString:@"OK"]) {
                _isOK = string;
                self.starRateView.userInteractionEnabled=YES;
                PL_ALERT_SHOW(@"提交成功");
                textView.text = @"";
                count.text=[NSString stringWithFormat:@"0/100"];
                style.text = @"跟进类型";
                fangshi.text=@"跟进方式";
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
            NSLog(@"string==%@",string);
            //            [view removeFromSuperview];
            [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"FOLLOWID"];
            [self genJinRequest];
        }];
    }
}
-(void)commitRequest1
{
    [textView2 resignFirstResponder];
    if ([fangshi1.text isEqualToString:@"跟进方式"]&&[style1.text isEqualToString:@"跟进类型"]&&[textView2.text isEqualToString:@""]) {
        PL_ALERT_SHOW(@"跟进方式、跟进类型、跟进内容不能为空");
    }else if([style1.text isEqualToString:@"跟进类型"]&&[textView2.text isEqualToString:@""]){
        PL_ALERT_SHOW(@"跟进类型、跟进内容不能为空");
    }else if([fangshi1.text isEqualToString:@"跟进方式"]&&[textView2.text isEqualToString:@""]){
        PL_ALERT_SHOW(@"跟进方式、跟进内容不能为空");
    }else if([fangshi1.text isEqualToString:@"跟进方式"]&&[style1.text isEqualToString:@"跟进类型"]){
        PL_ALERT_SHOW(@"跟进方式、跟进类型不能为空");
    }else if([fangshi1.text isEqualToString:@"跟进方式"]){
        PL_ALERT_SHOW(@"跟进方式不能为空");
    }else if([style1.text isEqualToString:@"跟进类型"]){
        PL_ALERT_SHOW(@"跟进类型不能为空");
    }else if([textView2.text isEqualToString:@""]){
        PL_ALERT_SHOW(@"跟进内容不能为空");
        
    }else if ([self validateNumber:textView2.text]){
        PL_ALERT_SHOW(@"输入的内容不能含有电话号码");
        
    }else
    {
        CustomersFollowData *follow=[[CustomersFollowData alloc]init];
        follow.CustID=[[NSUserDefaults standardUserDefaults]objectForKey:@"custID"];
        follow.FollowType=style1.text;
        follow.Content=textView2.text;
        follow.FollowWay=fangshi1.text;
        follow.FollowID = [[NSUserDefaults standardUserDefaults]objectForKey:@"FOLLOWID"];
        follow.CustLevel=[NSString stringWithFormat:@"%ld",(long)starCount];
        follow.userid=[[NSUserDefaults standardUserDefaults]objectForKey:PL_USER_NAME];
        follow.token=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
        NSLog(@"%@  %@  %@  %@  %@  %@",follow.CustID,follow.FollowType,follow.Content,follow.FollowWay,follow.userid,follow.token);
        PL_PROGRESS_SHOW;
        [[MyRequest defaultsRequest]getAddCustomersFollow:follow backInfoMessage:^(NSMutableString *string) {
            if ([string isEqualToString:PL_NO_LOGIN_]) {
                ViewController *login=[[ViewController alloc]init];
                [self.navigationController pushViewController:login animated:YES];
            }
            if ([string isEqualToString:@"OK"]) {
                _isOK = string;
                self.starRateView1.userInteractionEnabled=YES;
                PL_ALERT_SHOW(@"提交成功");
                textView2.text = @"";
                count1.text=[NSString stringWithFormat:@"0/100"];
                style1.text = @"跟进类型";
                fangshi1.text=@"跟进方式";
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
            NSLog(@"string==%@",string);
            //            [view removeFromSuperview];
            [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"FOLLOWID"];
            [bgView removeFromSuperview];
            [self genJinRequest];
            
        }];
    }
}

-(void)refreshList
{
    
    //跟进列表
    CustFollowListData *followList=[[CustFollowListData alloc]init];
    followList.CustID=[_dict objectForKey:@"CustID"];
    followList.userid=[[NSUserDefaults standardUserDefaults]objectForKey:PL_USER_NAME];
    followList.token=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
    PL_PROGRESS_SHOW;
    [[VisitersRequest defaultsRequest]GetCustFollow:followList backInfoMessage:^(NSMutableString *string) {
        NSLog(@"%@",string);
        
        if ([string isEqualToString:@"NOLOGIN"]) {
            ViewController *login=[[ViewController alloc]init];
            [self.navigationController pushViewController:login animated:YES];
        }
        PL_PROGRESS_DISMISS;
        
        //        SBJSON *json=[[SBJSON alloc]init];
        //        NSArray *array=[json objectWithString:string error:nil];
    }];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==phoneTable)
    {
        
        
        NSString * telNum =[PL_USER_STORAGE objectForKey:PL_USER_PHONEnUM];
        NSString *phoneString=[phoneArr objectAtIndex:indexPath.row];
        NSArray *phoneArr22=[phoneString componentsSeparatedByString:@"|"];
        NSString *phoneNum=[phoneArr22 objectAtIndex:1];
        NSLog(@"1%@",telNum);
        NSLog(@"2%@",phoneNum);
        NSLog(@"3%@",[_dict objectForKey:@"CustID"]);
        NSLog(@"4%@",self.supcode);
        if([telNum isEqualToString:@""]||[phoneNum isEqualToString:@""])
        {
            
        }
        else
        {
            PL_ALERT_SHOW(@"系统正在拨打，请稍后");
            [phoneBG removeFromSuperview];
            [[MyRequest defaultsRequest]afDialCustTelephone:telNum CustPhone:phoneNum ID:[_dict objectForKey:@"CustID"] Type:@"0" FromCode:self.supcode userid:[PL_USER_STORAGE objectForKey:PL_USER_USERID] userToken:[PL_USER_STORAGE objectForKey:PL_USER_TOKEN] completeBack:^(NSMutableString *str)
             {
                 
                 NSLog(@"%@",str);
                 
             }];
            
        }
        
        
        
    }
    else if (tableView==followTable)
    {
        if (followArray.count>0) {
            NSDictionary *dictionary1=[followArray objectAtIndex:indexPath.row];
            GenjinView * genjin = [[GenjinView alloc]initWithUser_Name:[dictionary1 objectForKey:@"EmpName"] writeFs:[dictionary1 objectForKey:@"FollowWay"] writeLX:[dictionary1 objectForKey:@"FollowType"] contentString:[dictionary1 objectForKey:@"Content"] writeDate:[dictionary1 objectForKey:@"FollowDate"]];
            
            [genjin showInView:self.view.window animation:YES];
        }
        else
        {
            
        }
        
    }else if(tableView==styleTable)
    {
        NSDictionary *dict=[styleArray objectAtIndex:indexPath.row];
        style.text=[dict objectForKey:@"FollowType"];
        styleBtn.selected=NO;
        textView.editable=YES;
        [viewBg removeFromSuperview];
        
    }
    if (tableView.tag==15000) {
        
        NSLog(@"%ld",(long)tableView.tag);
        NSDictionary *dict=[styleArray objectAtIndex:indexPath.row];
        style1.text=[dict objectForKey:@"FollowType"];
        [sousuoViewstyle1 removeFromSuperview];
        styleBtn1.selected=NO;
    }
    
    
    
    
}

-(void)textViewDidBeginEditing:(UITextView *)textView1
{
    
    if (styleBtn.selected ) {
        TAP.enabled=YES;
        
        NSLog(@"HHHH");
    }
    
    //创建一个线程用来延迟视图上弹
    //    NSThread *thread = [[NSThread alloc]initWithTarget:self selector:@selector(change:) object:nil];
    //    [thread start];
    _scroll1.contentSize=CGSizeMake(0, PL_HEIGHT*1.3);
}
/*
 - (void)change:(id)sender
 {
 //线程睡眠0.2秒以实现视图延迟上弹
 [NSThread sleepForTimeInterval:0.2];
 //创建一个仿射变换，平移(0, -100)视图上移100像素
 CGAffineTransform pTransform = CGAffineTransformMakeTranslation(0, -210);
 //使视图使用这个变换
 self.view.transform = pTransform;
 
 }
 */
- (void)change2:(id)sender
{
    //线程睡眠0.2秒以实现视图延迟上弹
    //[NSThread sleepForTimeInterval:0.2];
    //创建一个仿射变换，平移(0, -100)视图上移100像素
    CGAffineTransform pTransform = CGAffineTransformMakeTranslation(0, 0);
    //使视图使用这个变换
    self.view.transform = pTransform;
    
}

//Tounch调用不到添加手势
-(void)TapTounch:(NSSet*)touches
{
    [textView resignFirstResponder];
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"FOLLOWID"];
    [textView2 resignFirstResponder];
    
    UITouch *touch=[touches anyObject];
    CGPoint point=[touch locationInView:self.view];
    CGPoint point1 = [touch locationInView:bgView];
    if (CGRectContainsPoint(phoneBG.frame, point)) {
        [phoneBG removeFromSuperview];
    }
    
    
    if (CGRectContainsPoint(genjinView.frame, point1)) {
        [genjinView endEditing:YES];
        CGAffineTransform pTransform = CGAffineTransformMakeTranslation(0, 0);
        //使视图使用这个变换
        bgView.transform = pTransform;
    }
    else
    {
        [bgView removeFromSuperview];
        [genjinView removeFromSuperview];
    }
    
    
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [view endEditing:YES];
}

-(void)returnClick
{
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"FOLLOWID"];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)btnClick:(UIButton *)sender {
    
    //    [self  getSupCode];
    //    //NSLog(@"%s",__FUNCTION__);
    //    //phoneBG=[[UIView alloc]initWithFrame:CGRectMake(20,77, PL_WIDTH-100-10, PL_HEIGHT/2-50)];
    //    phoneBG=[[UIView alloc]initWithFrame:CGRectMake(0, 0, PL_WIDTH, PL_HEIGHT)];
    //   // phoneBG.backgroundColor=[UIColor colorWithRed:108.0/255.0 green:108.0/255.0 blue:108.0/255.0 alpha:0.6];
    //    phoneBG.backgroundColor=[[UIColor grayColor]colorWithAlphaComponent:0.5];
    //  //  phoneBG.alpha=0.5;
    //   // phoneBG.backgroundColor=[UIColor blackColor];
    //    [self.view addSubview:phoneBG];
    //
    //    //UIImageView *bgImg=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, phoneBG.frame.size.width, 49)];
    //    UIImageView *bgImg=[[UIImageView alloc]initWithFrame:CGRectMake(20, 80+30, PL_WIDTH-40, 49)];
    //   // bgImg.image=[UIImage imageNamed:@"拨打电话背景.png"];
    //    bgImg.backgroundColor=[UIColor whiteColor];
    //    [phoneBG addSubview:bgImg];
    //
    //    UIImageView *tellusImg=[[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 30, 30)];
    //    tellusImg.image=[UIImage imageNamed:@"联系客服.png"];
    //   // [bgImg addSubview:tellusImg];
    //
    //    UILabel *tellus=[[UILabel alloc]initWithFrame:CGRectMake(50, 10, 200, 30)];
    //    tellus.text=[dic objectForKey:@"CustName"];
    //    [bgImg addSubview:tellus];
    //
    //    UIButton *delete=[[UIButton alloc]initWithFrame:CGRectMake(bgImg.frame.size.width-40, 15, 20, 20)];
    //    [delete setImage:[UIImage imageNamed:@"close_call_phone_activity.png.png"] forState:UIControlStateNormal];
    //    [delete addTarget:self action:@selector(deleteClick) forControlEvents:UIControlEventTouchUpInside];
    //    [bgImg addSubview:delete];
    //
    //    SBJSON *json=[[SBJSON alloc]init];
    //    NSArray *array=[json objectWithString:_detailString error:nil];
    //    NSDictionary * phoneDic=[array objectAtIndex:0];
    //    NSString *phoneStr=[phoneDic objectForKey:@"CustTel"];
    //    phoneArr=[phoneStr componentsSeparatedByString:@","];
    //
    //    NSLog(@"%ld",phoneArr.count);
    //
    //    NSLog(@"%ld=====",phoneArr.count);
    //    phoneTable=[[UITableView alloc]initWithFrame:CGRectMake(20, 80+50+30, PL_WIDTH-40, phoneArr.count<6?phoneArr.count*44:PL_HEIGHT/2+50) style:UITableViewStylePlain];
    //    phoneTable.delegate=self;
    //    phoneTable.dataSource=self;
    //    //phoneTable.backgroundColor=[UIColor grayColor];
    //    //phoneTable.backgroundView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"拨打电话背景.png"]];
    //    phoneTable.separatorColor=[UIColor grayColor];
    //    [phoneBG addSubview:phoneTable];
    //
    //    if ([phoneTable respondsToSelector:@selector(setSeparatorInset:)])
    //    {
    //        [phoneTable setSeparatorInset:UIEdgeInsetsZero];
    //
    //    }
    //    if([phoneTable respondsToSelector:@selector(setLayoutMargins:)])
    //    {
    //        [phoneTable setLayoutMargins:UIEdgeInsetsZero];
    //
    //    }
    //
    /*
     [[MyRequest defaultsRequest]DialCustTelephone:^(NSMutableString *string) {
     NSLog(@"%@",string);
     if ([string isEqualToString:@"True"])
     {
     PL_ALERT_SHOW(@"拨打成功");
     
     }
     } CameraNumber:[[NSUserDefaults standardUserDefaults]objectForKey:@"User_Phone"] CustPhone:@"60176765" userid:[PL_USER_STORAGE objectForKey:PL_USER_NAME] token:[ PL_USER_STORAGE objectForKey:PL_USER_TOKEN]];
     */
    // NSLog(@"打电话");
    
    
    //        SBJSON *json=[[SBJSON alloc]init];
    //        NSArray *array=[json objectWithString:_detailString error:nil];
    //            NSDictionary * phoneDic=[array objectAtIndex:0];
    //            NSString *phoneStr=[phoneDic objectForKey:@"CustTel"];
    //            phoneArr=[phoneStr componentsSeparatedByString:@","];
    //    NSDictionary *starDic=[_array objectAtIndex:sender.tag];
    //    starCount=[[starDic objectForKey:@"CustLevel"] intValue];
    //    CustID = [dic objectForKey:@"CustID"];
    //    NSDictionary *visterDic = _array[sender.tag];
    //    NSString *phoneStr=[visterDic objectForKey:@"CustTel"];
    //    phoneArr=[phoneStr componentsSeparatedByString:@","];
    //    TelViewAlert * alert = [[TelViewAlert alloc]initWithconnectWithArray:phoneArr Calltype:callType_Vister custId:[dic objectForKey:@"CustID"]];
    //    alert.stringTitle = [NSString stringWithFormat:@"%@",[dic objectForKey:@"CustName"]];
    //    [alert showTelWindow:self.view];
    NSLog(@"打电话");
    
    NSDictionary * phoneDic=[_arr objectAtIndex:0];
    NSString *phoneStr=[phoneDic objectForKey:@"CustTel"];
    phoneArr=[phoneStr componentsSeparatedByString:@","];
    TelViewAlert * alert = [[TelViewAlert alloc]initWithconnectWithArray:phoneArr Calltype:callType_Vister custId:[_dict objectForKey:@"CustID"]];
    [alert showTelWindow:self.view];
    alert.stringTitle = [NSString stringWithFormat:@"%@",[_dict objectForKey:@"CustName"]];
    
    
    
    
    
    //    NSDictionary *phoneDic=[_detailArray objectAtIndex:0];
    //    NSString *phoneStr=[phoneDic objectForKey:@"OwnerTel"];
    //
    //    phoneArr=[phoneStr componentsSeparatedByString:@","];
    //    TelViewAlert * alert = [[TelViewAlert alloc]initWithconnectWithArray:phoneArr Calltype:callType_Room custId:self.propertyID];
    //    [alert showTelWindow:self.view];
    //    alert.stringTitle = [NSString stringWithFormat:@"%@",[detailDic objectForKey:@"OwnerName"]];
    
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
        
    }
    
    
}

-(void)deleteClick
{
    NSLog(@"haha");
    [phoneBG removeFromSuperview];
}
//当键盘出现或改变时调用
- (void)keyboardWillShow:(NSNotification *)aNotification
{
    //创建一个仿射变换，平移(0, -100)视图上移100像素
    CGAffineTransform pTransform = CGAffineTransformMakeTranslation(0, -200);
    //使视图使用这个变换
    _scroll1.transform = pTransform;
    //_scroll1.contentSize=CGSizeMake(PL_WIDTH, PL_HEIGHT*1.2);
    bgView.transform = pTransform;
    
    TAP.enabled=YES;
    placeholder.text=@"";
    placeholder1.text = @"";
}

//当键退出时调用
- (void)keyboardWillHide:(NSNotification *)aNotification
{
    // 创建一个仿射变换，平移(0, -100)视图上移100像素
    CGAffineTransform pTransform = CGAffineTransformMakeTranslation(0, 0);
    //使视图使用这个变换
    _scroll1.transform = pTransform;
    //    bgView.transform = pTransform;
    
    if (PL_HEIGHT<=481) {
        _scroll1.contentSize=CGSizeMake(PL_WIDTH, PL_HEIGHT*1.4);
    }
    else
    {
        _scroll1.contentSize=CGSizeMake(PL_WIDTH, PL_HEIGHT*1.2);
    }
    
    if (styleBtn.selected) {
        TAP.enabled=NO;
    }
    
    if ([textView.text isEqualToString:@""]) {
        placeholder.text=@"请输入内容";
    }
    if ([textView2.text isEqualToString:@""]) {
        placeholder1.text=@"请输入内容";
    }
}

-(void)rightClick
{
    NSLog(@"right");
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"确定要推成公客吗？" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
    alert.tag=200;
    [alert show];
}


@end
