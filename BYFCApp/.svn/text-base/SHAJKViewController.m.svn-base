//
//  SHAJKViewController.m
//  BYFCApp
//
//  Created by zzs on 15/3/2.
//  Copyright (c) 2015年 PengLee. All rights reserved.
//

#import "SHAJKViewController.h"
#import "PL_Header.h"

@interface SHAJKViewController ()
@property (nonatomic, assign) BOOL isEq;
@end

@implementation SHAJKViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
//    _dict=[NSDictionary dictionary];
//    _dict2=[NSDictionary dictionary];
//    _dict3=[NSDictionary dictionary];
    self.title=@"端口申请";
    self.navigationController.navigationBarHidden=NO;
    UIButton * backItemBnt = [UIButton buttonWithType:UIButtonTypeCustom];
    backItemBnt.frame = CGRectMake(20, 10, 10, 20);
    [backItemBnt setBackgroundImage:[UIImage imageNamed:@"返回.png"] forState:UIControlStateNormal];
    [backItemBnt addTarget:self action:@selector(returnClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem * leftBtn = [[UIBarButtonItem alloc]initWithCustomView:backItemBnt];
    self.navigationItem.leftBarButtonItem = leftBtn;
    
    self.edgesForExtendedLayout=UIRectEdgeNone;
   scroll=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, PL_WIDTH, PL_HEIGHT)];
    scroll.backgroundColor=[UIColor whiteColor];
    scroll.delegate=self;
    scroll.userInteractionEnabled=YES;
    //_scroll1.canCancelContentTouches=YES;
    
    [self.view addSubview:scroll];
    
    check=[[UILabel alloc]initWithFrame:CGRectMake(13, 13, PL_WIDTH*0.4, PL_HEIGHT/24)];
    check.text=@"您选择的是";
    //check.backgroundColor=[UIColor redColor];
    check.font=[UIFont systemFontOfSize:18];
    [scroll addSubview:check];
    image1=[[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(check.frame), 6, 1, 30)];
    image1.image=[UIImage imageNamed:@"heng_hui_duan.png"];
    [scroll addSubview:image1];
    UIImageView *image2=[[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMinX(image1.frame)+40, CGRectGetMinY(check.frame), PL_WIDTH*0.3, PL_HEIGHT/24)];
    image2.backgroundColor=[UIColor yellowColor];
    image2.image=[UIImage imageNamed:@"anjuke_SH33.png"];
    [scroll addSubview:image2];
    
    image33=[[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(image1.frame)+5, PL_WIDTH, 1)];
    image33.image=[UIImage imageNamed:@"heng_hui_duan.png"];
    [scroll addSubview:image33];
   
    if (_dict!=nil) {
        [self initView];
        _isEq = YES;
    }
    if (_dict2!=nil) {
         [self initView2];
        _isEq = YES;
    }
    if (_dict3!=nil) {
        [self initView3];
    }
    [self initView4];
    
    
}
-(void)initView
{
    NSLog(@"%@",_dict);
    NSLog(@"%@",_dict3);
    smallView=[[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(image33.frame), PL_WIDTH, 216)];
   // smallView.backgroundColor=[UIColor redColor];
    [scroll addSubview:smallView];
    
    UIImageView *image3=[[UIImageView alloc]initWithFrame:CGRectMake(0, 20, PL_WIDTH, 1)];
    //UIImageView *image3=[[UIImageView alloc]initWithFrame:CGRectMake(0, 20, PL_WIDTH, 1)];
    image3.image=[UIImage imageNamed:@"heng_hui_duan.png"];
    [smallView addSubview:image3];
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(image3.frame), PL_WIDTH,30)];
    view.backgroundColor=[UIColor colorWithRed:170.0/255.0 green:170.0/255.0 blue:170.0/255.0 alpha:0.2];
    [smallView addSubview:view];
    
    
    
    UILabel *taocanbianhao=[[UILabel alloc]initWithFrame:CGRectMake(0, 5, check.frame.size.width, 20)];
    taocanbianhao.text=@"套餐编号";
    taocanbianhao.font=[UIFont systemFontOfSize:14];
    taocanbianhao.textAlignment=NSTextAlignmentRight;
    [view addSubview:taocanbianhao];
    
    UIImageView *shu2=[[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMinX(image1.frame), 0, 1, 30)];
    shu2.image=[UIImage imageNamed:@"heng_hui_duan.png"];
    [view addSubview:shu2];
    UILabel *jingjia=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(shu2.frame), 5, PL_WIDTH-taocanbianhao.frame.size.width-1, 20)];
    jingjia.text=[_dict objectForKey:@"PackageID"];
    jingjia.font=[UIFont systemFontOfSize:14];
    jingjia.textAlignment=NSTextAlignmentCenter;
    [view addSubview:jingjia];
    UIImageView *heng2=[[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(view.frame), PL_WIDTH, 1)];
    heng2.image=[UIImage imageNamed:@"heng_hui_duan.png"];
    [smallView addSubview:heng2];
    
    UIImageView *heng3=[[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(heng2.frame)+20, PL_WIDTH, 1)];
    heng3.image=[UIImage imageNamed:@"heng_hui_duan.png"];
    [smallView addSubview:heng3];
    
    UIImageView *zhuzhaiImg=[[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 50, 53)];
    zhuzhaiImg.image=[UIImage imageNamed:@"端口申请方形白色背景.png"];
    [smallView addSubview:zhuzhaiImg];
    UILabel *zhuzhai=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 50, 53)];
    zhuzhai.text=[_dict objectForKey:@"PackageType"];
    zhuzhai.textAlignment=NSTextAlignmentCenter;
    zhuzhai.font=[UIFont systemFontOfSize:14];
    [zhuzhaiImg addSubview:zhuzhai];
    [smallView bringSubviewToFront:zhuzhaiImg];
    
    //***************************
    UILabel *kucun=[[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(heng3.frame), PL_WIDTH/4-1, 40)];
    kucun.backgroundColor=[UIColor colorWithRed:170.0/255.0 green:170.0/255.0 blue:170.0/255.0 alpha:0.2];
    kucun.font=[UIFont systemFontOfSize:14];
    kucun.textAlignment=NSTextAlignmentCenter;
    kucun.text=@"库存";
    [smallView addSubview:kucun];
    UIImageView *shu3=[[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(kucun.frame), CGRectGetMaxY(heng3.frame), 1, 80)];
    shu3.image=[UIImage imageNamed:@"heng_hui_duan.png"];
    [smallView addSubview:shu3];
    
    UILabel *dingjiaF=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(shu3.frame), CGRectGetMaxY(heng3.frame), PL_WIDTH/4-1, 40)];
    dingjiaF.backgroundColor=[UIColor colorWithRed:170.0/255.0 green:170.0/255.0 blue:170.0/255.0 alpha:0.2];
    dingjiaF.font=[UIFont systemFontOfSize:14];
    dingjiaF.textAlignment=NSTextAlignmentCenter;
    dingjiaF.text=@"定价房源";
    [smallView addSubview:dingjiaF];
    UIImageView *shu4=[[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(dingjiaF.frame), CGRectGetMaxY(heng3.frame), 1, 80)];
    shu4.image=[UIImage imageNamed:@"heng_hui_duan.png"];
    [smallView addSubview:shu4];
    UILabel *jingjiaF=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(shu4.frame), CGRectGetMaxY(heng3.frame), PL_WIDTH/4, 40)];
    jingjiaF.backgroundColor=[UIColor colorWithRed:170.0/255.0 green:170.0/255.0 blue:170.0/255.0 alpha:0.2];
    jingjiaF.font=[UIFont systemFontOfSize:14];
    jingjiaF.textAlignment=NSTextAlignmentCenter;
    jingjiaF.text=@"竞价房源";
    [smallView addSubview:jingjiaF];
    
    UIImageView *shu5=[[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(jingjiaF.frame), CGRectGetMaxY(heng3.frame), 1, 80)];
    shu5.image=[UIImage imageNamed:@"heng_hui_duan.png"];
    [smallView addSubview:shu5];
    UILabel *priceRequest=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(shu5.frame), CGRectGetMaxY(heng3.frame), PL_WIDTH/4, 40)];
    priceRequest.backgroundColor=[UIColor colorWithRed:170.0/255.0 green:170.0/255.0 blue:170.0/255.0 alpha:0.2];
    priceRequest.font=[UIFont systemFontOfSize:14];
    priceRequest.textAlignment=NSTextAlignmentCenter;
    priceRequest.text=@"充值要求";
    [smallView addSubview:priceRequest];
    
    UIImageView *heng4=[[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(heng3.frame)+40, PL_WIDTH, 1)];
    heng4.image=[UIImage imageNamed:@"heng_hui_duan.png"];
    [smallView addSubview:heng4];
    
 
//     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(tong:) name:@"tongzhi2222222222" object:nil];
//     _tiyanban.titleLabel.text=[_dict objectForKey:@"PackageID"];
//     _kucun.text=[_dict objectForKey:@"HRCount"];
//     _dingjiaF.text=[_dict objectForKey:@"HRDingJiaCount"];
//     _jingjiaF.text=[_dict objectForKey:@"HRJingJiaCount"];
//     _priceRequest.text=[_dict objectForKey:@"PayDemand"];
//     _packagePrice.text=[_dict objectForKey:@"PackagePrice"];
    
    
    
    UILabel *kucunNum=[[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(heng4.frame), PL_WIDTH/4, 40)];
    kucunNum.font=[UIFont systemFontOfSize:14];
    kucunNum.textAlignment=NSTextAlignmentCenter;
    kucunNum.text=[NSString stringWithFormat:@"%@",[_dict objectForKey:@"HRCount"]];
    [smallView addSubview:kucunNum];
    
    UILabel *dingjiaNum=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(shu3.frame), CGRectGetMaxY(heng4.frame), PL_WIDTH/4, 40)];
    dingjiaNum.font=[UIFont systemFontOfSize:14];
    dingjiaNum.textAlignment=NSTextAlignmentCenter;
    dingjiaNum.text=[NSString stringWithFormat:@"%@",[_dict objectForKey:@"HRDingJiaCount"]];
    [smallView addSubview:dingjiaNum];
    
    UILabel *jingjiaNum=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(shu4.frame), CGRectGetMaxY(heng4.frame), PL_WIDTH/4, 40)];
    jingjiaNum.font=[UIFont systemFontOfSize:14];
    jingjiaNum.textAlignment=NSTextAlignmentCenter;
    jingjiaNum.text=[NSString stringWithFormat:@"%@",[_dict objectForKey:@"HRJingJiaCount"]];
    [smallView addSubview:jingjiaNum];
    UILabel *priceNum=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(shu5.frame), CGRectGetMaxY(heng4.frame), PL_WIDTH/4, 40)];
    priceNum.font=[UIFont systemFontOfSize:14];
    priceNum.textAlignment=NSTextAlignmentCenter;
    priceNum.text=[NSString stringWithFormat:@"%@",[_dict objectForKey:@"PayDemand"]];
    [smallView addSubview:priceNum];
    
    UIImageView *heng5=[[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(heng4.frame)+40, PL_WIDTH, 1)];
    heng5.image=[UIImage imageNamed:@"heng_hui_duan.png"];
    [smallView addSubview:heng5];
    
    UILabel *miaoshu=[[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(heng5.frame), PL_WIDTH, 30)];
    miaoshu.text=@"套餐价格（元/月）";
    miaoshu.font=[UIFont systemFontOfSize:14];
    miaoshu.textAlignment=NSTextAlignmentCenter;
    miaoshu.backgroundColor=[UIColor colorWithRed:170.0/255.0 green:170.0/255.0 blue:170.0/255.0 alpha:0.2];
    [smallView addSubview:miaoshu];
    
    UIImageView *heng6=[[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(miaoshu.frame), PL_WIDTH, 1)];
    heng6.image=[UIImage imageNamed:@"heng_hui_duan.png"];
    [smallView addSubview:heng6];
    
    UILabel *miaoshu2=[[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(heng6.frame), PL_WIDTH, 30)];
    miaoshu2.text=[NSString stringWithFormat:@"%@",[_dict objectForKey:@"PackagePrice"]];
    miaoshu2.font=[UIFont systemFontOfSize:14];
    miaoshu2.textAlignment=NSTextAlignmentCenter;
    [smallView addSubview:miaoshu2];
    heng7=[[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(miaoshu2.frame), PL_WIDTH, 1)];
    heng7.image=[UIImage imageNamed:@"heng_hui_duan.png"];
    [smallView addSubview:heng7];
}

-(void)initView2
{
    
    smallView2=[[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(heng7.frame)+40, PL_WIDTH, 216)];
     //smallView.backgroundColor=[UIColor redColor];
    [scroll addSubview:smallView2];
//    if (_dict2==nil) {
//        [smallView2 removeFromSuperview];
//        hideV2=YES;
//    }
    
    UIImageView *image3=[[UIImageView alloc]initWithFrame:CGRectMake(0, 20, PL_WIDTH, 1)];
    //UIImageView *image3=[[UIImageView alloc]initWithFrame:CGRectMake(0, 20, PL_WIDTH, 1)];
    image3.image=[UIImage imageNamed:@"heng_hui_duan.png"];
    [smallView2 addSubview:image3];
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(image3.frame), PL_WIDTH,30)];
    view.backgroundColor=[UIColor colorWithRed:170.0/255.0 green:170.0/255.0 blue:170.0/255.0 alpha:0.2];
    [smallView2 addSubview:view];
    
    
    
    UILabel *taocanbianhao=[[UILabel alloc]initWithFrame:CGRectMake(0, 5, check.frame.size.width, 20)];
    taocanbianhao.text=@"套餐编号";
    taocanbianhao.font=[UIFont systemFontOfSize:14];
    taocanbianhao.textAlignment=NSTextAlignmentRight;
    [view addSubview:taocanbianhao];
    
    UIImageView *shu2=[[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMinX(image1.frame), 0, 1, 30)];
    shu2.image=[UIImage imageNamed:@"heng_hui_duan.png"];
    [view addSubview:shu2];
    UILabel *jingjia=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(shu2.frame), 5, PL_WIDTH-taocanbianhao.frame.size.width-1, 20)];
    jingjia.text=[_dict2 objectForKey:@"PackageID"];
    jingjia.font=[UIFont systemFontOfSize:14];
    jingjia.textAlignment=NSTextAlignmentCenter;
    [view addSubview:jingjia];
    UIImageView *heng2=[[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(view.frame), PL_WIDTH, 1)];
    heng2.image=[UIImage imageNamed:@"heng_hui_duan.png"];
    [smallView2 addSubview:heng2];
    
    UIImageView *heng3=[[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(heng2.frame)+20, PL_WIDTH, 1)];
    heng3.image=[UIImage imageNamed:@"heng_hui_duan.png"];
    [smallView2 addSubview:heng3];
    
    UIImageView *zhuzhaiImg=[[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 50, 53)];
    zhuzhaiImg.image=[UIImage imageNamed:@"端口申请方形白色背景.png"];
    [smallView2 addSubview:zhuzhaiImg];
    UILabel *zhuzhai=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 50, 53)];
    zhuzhai.text=@"商铺";
    zhuzhai.textAlignment=NSTextAlignmentCenter;
    zhuzhai.font=[UIFont systemFontOfSize:14];
    [zhuzhaiImg addSubview:zhuzhai];
    [smallView2 bringSubviewToFront:zhuzhaiImg];
    
    //***************************
    UILabel *kucun=[[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(heng3.frame), PL_WIDTH/4-1, 40)];
    kucun.backgroundColor=[UIColor colorWithRed:170.0/255.0 green:170.0/255.0 blue:170.0/255.0 alpha:0.2];
    kucun.font=[UIFont systemFontOfSize:14];
    kucun.textAlignment=NSTextAlignmentCenter;
    kucun.text=@"库存";
    [smallView2 addSubview:kucun];
    UIImageView *shu3=[[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(kucun.frame), CGRectGetMaxY(heng3.frame), 1, 80)];
    shu3.image=[UIImage imageNamed:@"heng_hui_duan.png"];
    [smallView2 addSubview:shu3];
    
    UILabel *dingjiaF=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(shu3.frame), CGRectGetMaxY(heng3.frame), PL_WIDTH/4-1, 40)];
    dingjiaF.backgroundColor=[UIColor colorWithRed:170.0/255.0 green:170.0/255.0 blue:170.0/255.0 alpha:0.2];
    dingjiaF.font=[UIFont systemFontOfSize:14];
    dingjiaF.textAlignment=NSTextAlignmentCenter;
    dingjiaF.text=@"定价房源";
    [smallView2 addSubview:dingjiaF];
    UIImageView *shu4=[[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(dingjiaF.frame), CGRectGetMaxY(heng3.frame), 1, 80)];
    shu4.image=[UIImage imageNamed:@"heng_hui_duan.png"];
    [smallView2 addSubview:shu4];
    UILabel *jingjiaF=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(shu4.frame), CGRectGetMaxY(heng3.frame), PL_WIDTH/4, 40)];
    jingjiaF.backgroundColor=[UIColor colorWithRed:170.0/255.0 green:170.0/255.0 blue:170.0/255.0 alpha:0.2];
    jingjiaF.font=[UIFont systemFontOfSize:14];
    jingjiaF.textAlignment=NSTextAlignmentCenter;
    jingjiaF.text=@"竞价房源";
    [smallView2 addSubview:jingjiaF];
    
    UIImageView *shu5=[[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(jingjiaF.frame), CGRectGetMaxY(heng3.frame), 1, 80)];
    shu5.image=[UIImage imageNamed:@"heng_hui_duan.png"];
    [smallView2 addSubview:shu5];
    UILabel *priceRequest=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(shu5.frame), CGRectGetMaxY(heng3.frame), PL_WIDTH/4, 40)];
    priceRequest.backgroundColor=[UIColor colorWithRed:170.0/255.0 green:170.0/255.0 blue:170.0/255.0 alpha:0.2];
    priceRequest.font=[UIFont systemFontOfSize:14];
    priceRequest.textAlignment=NSTextAlignmentCenter;
    priceRequest.text=@"充值要求";
    [smallView2 addSubview:priceRequest];
    
    UIImageView *heng4=[[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(heng3.frame)+40, PL_WIDTH, 1)];
    heng4.image=[UIImage imageNamed:@"heng_hui_duan.png"];
    [smallView2 addSubview:heng4];
    
    
    //     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(tong:) name:@"tongzhi2222222222" object:nil];
    //     _tiyanban.titleLabel.text=[_dict objectForKey:@"PackageID"];
    //     _kucun.text=[_dict objectForKey:@"HRCount"];
    //     _dingjiaF.text=[_dict objectForKey:@"HRDingJiaCount"];
    //     _jingjiaF.text=[_dict objectForKey:@"HRJingJiaCount"];
    //     _priceRequest.text=[_dict objectForKey:@"PayDemand"];
    //     _packagePrice.text=[_dict objectForKey:@"PackagePrice"];
    
    
    
    UILabel *kucunNum=[[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(heng4.frame), PL_WIDTH/4, 40)];
    kucunNum.font=[UIFont systemFontOfSize:14];
    kucunNum.textAlignment=NSTextAlignmentCenter;
     kucunNum.text=[NSString stringWithFormat:@"%@",[_dict2 objectForKey:@"HRCount"]];
    [smallView2 addSubview:kucunNum];
    
    UILabel *dingjiaNum=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(shu3.frame), CGRectGetMaxY(heng4.frame), PL_WIDTH/4, 40)];
    dingjiaNum.font=[UIFont systemFontOfSize:14];
    dingjiaNum.textAlignment=NSTextAlignmentCenter;
    dingjiaNum.text=[NSString stringWithFormat:@"%@",[_dict2 objectForKey:@"HRDingJiaCount"]];
    [smallView2 addSubview:dingjiaNum];
    
    UILabel *jingjiaNum=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(shu4.frame), CGRectGetMaxY(heng4.frame), PL_WIDTH/4, 40)];
    jingjiaNum.font=[UIFont systemFontOfSize:14];
    jingjiaNum.textAlignment=NSTextAlignmentCenter;
    jingjiaNum.text=[NSString stringWithFormat:@"%@",[_dict2 objectForKey:@"HRJingJiaCount"]];
    [smallView2 addSubview:jingjiaNum];
    UILabel *priceNum=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(shu5.frame), CGRectGetMaxY(heng4.frame), PL_WIDTH/4, 40)];
    priceNum.font=[UIFont systemFontOfSize:14];
    priceNum.textAlignment=NSTextAlignmentCenter;
    priceNum.text=[NSString stringWithFormat:@"%@",[_dict2 objectForKey:@"PayDemand"]];
    [smallView2 addSubview:priceNum];
    
    UIImageView *heng5=[[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(heng4.frame)+40, PL_WIDTH, 1)];
    heng5.image=[UIImage imageNamed:@"heng_hui_duan.png"];
    [smallView2 addSubview:heng5];
    
    UILabel *miaoshu=[[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(heng5.frame), PL_WIDTH, 30)];
    miaoshu.text=@"套餐价格（元/月）";
    miaoshu.font=[UIFont systemFontOfSize:14];
    miaoshu.textAlignment=NSTextAlignmentCenter;
    miaoshu.backgroundColor=[UIColor colorWithRed:170.0/255.0 green:170.0/255.0 blue:170.0/255.0 alpha:0.2];
    [smallView2 addSubview:miaoshu];
    
    UIImageView *heng6=[[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(miaoshu.frame), PL_WIDTH, 1)];
    heng6.image=[UIImage imageNamed:@"heng_hui_duan.png"];
    [smallView2 addSubview:heng6];
    
    UILabel *miaoshu2=[[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(heng6.frame), PL_WIDTH, 30)];
    miaoshu2.text=[NSString stringWithFormat:@"%@",[_dict2 objectForKey:@"PackagePrice"]];
    miaoshu2.font=[UIFont systemFontOfSize:14];
    miaoshu2.textAlignment=NSTextAlignmentCenter;
    [smallView2 addSubview:miaoshu2];
    heng77=[[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(miaoshu2.frame), PL_WIDTH, 1)];
    heng77.image=[UIImage imageNamed:@"heng_hui_duan.png"];
    [smallView2 addSubview:heng77];
}

-(void)initView3
{
    NSInteger height;
    if (hideV2==YES) {
        height=0;
    }
    else
    {
        height=216;
    }
     NSInteger height3;
    if (_dict==nil||_dict2==nil) {
        if (_isEq == YES) {
            height3=216;
        }else{
            height3 = 0;
        }
    }
    else
    {
        height3=216*2;
    }
    
    smallView3=[[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(image33.frame)+height3, PL_WIDTH, 216)];
    // smallView.backgroundColor=[UIColor redColor];
    [scroll addSubview:smallView3];
    if (_dict3==nil) {
        [smallView3 removeFromSuperview];
        hideV3=YES;
    }
   
    
    UIImageView *image3=[[UIImageView alloc]initWithFrame:CGRectMake(0, 20, PL_WIDTH, 1)];
    //UIImageView *image3=[[UIImageView alloc]initWithFrame:CGRectMake(0, 20, PL_WIDTH, 1)];
    image3.image=[UIImage imageNamed:@"heng_hui_duan.png"];
    [smallView3 addSubview:image3];
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(image3.frame), PL_WIDTH,30)];
    view.backgroundColor=[UIColor colorWithRed:170.0/255.0 green:170.0/255.0 blue:170.0/255.0 alpha:0.2];
    [smallView3 addSubview:view];
    
    
    
    UILabel *taocanbianhao=[[UILabel alloc]initWithFrame:CGRectMake(0, 5, check.frame.size.width, 20)];
    taocanbianhao.text=@"套餐编号";
    taocanbianhao.font=[UIFont systemFontOfSize:14];
    taocanbianhao.textAlignment=NSTextAlignmentRight;
    [view addSubview:taocanbianhao];
    
    UIImageView *shu2=[[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMinX(image1.frame), 0, 1, 30)];
    shu2.image=[UIImage imageNamed:@"heng_hui_duan.png"];
    [view addSubview:shu2];
    UILabel *jingjia=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(shu2.frame), 5, PL_WIDTH-taocanbianhao.frame.size.width-1, 20)];
    jingjia.text=[_dict3 objectForKey:@"PackageID"];
    jingjia.font=[UIFont systemFontOfSize:14];
    jingjia.textAlignment=NSTextAlignmentCenter;
    [view addSubview:jingjia];
    UIImageView *heng2=[[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(view.frame), PL_WIDTH, 1)];
    heng2.image=[UIImage imageNamed:@"heng_hui_duan.png"];
    [smallView3 addSubview:heng2];
    
    UIImageView *heng3=[[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(heng2.frame)+20, PL_WIDTH, 1)];
    heng3.image=[UIImage imageNamed:@"heng_hui_duan.png"];
    [smallView3 addSubview:heng3];
    
    UIImageView *zhuzhaiImg=[[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 50, 53)];
    zhuzhaiImg.image=[UIImage imageNamed:@"端口申请方形白色背景.png"];
    [smallView3 addSubview:zhuzhaiImg];
    UILabel *zhuzhai=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 50, 53)];
    zhuzhai.text=@"充值";
    zhuzhai.textAlignment=NSTextAlignmentCenter;
    zhuzhai.font=[UIFont systemFontOfSize:14];
    [zhuzhaiImg addSubview:zhuzhai];
    [smallView3 bringSubviewToFront:zhuzhaiImg];
    
    //***************************
    UILabel *kucun=[[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(heng3.frame), PL_WIDTH/4-1, 40)];
    kucun.backgroundColor=[UIColor colorWithRed:170.0/255.0 green:170.0/255.0 blue:170.0/255.0 alpha:0.2];
    kucun.font=[UIFont systemFontOfSize:14];
    kucun.textAlignment=NSTextAlignmentCenter;
    kucun.text=@"库存";
    [smallView3 addSubview:kucun];
    UIImageView *shu3=[[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(kucun.frame), CGRectGetMaxY(heng3.frame), 1, 80)];
    shu3.image=[UIImage imageNamed:@"heng_hui_duan.png"];
    [smallView3 addSubview:shu3];
    
    UILabel *dingjiaF=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(shu3.frame), CGRectGetMaxY(heng3.frame), PL_WIDTH/4-1, 40)];
    dingjiaF.backgroundColor=[UIColor colorWithRed:170.0/255.0 green:170.0/255.0 blue:170.0/255.0 alpha:0.2];
    dingjiaF.font=[UIFont systemFontOfSize:14];
    dingjiaF.textAlignment=NSTextAlignmentCenter;
    dingjiaF.text=@"定价房源";
    [smallView3 addSubview:dingjiaF];
    UIImageView *shu4=[[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(dingjiaF.frame), CGRectGetMaxY(heng3.frame), 1, 80)];
    shu4.image=[UIImage imageNamed:@"heng_hui_duan.png"];
    [smallView3 addSubview:shu4];
    UILabel *jingjiaF=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(shu4.frame), CGRectGetMaxY(heng3.frame), PL_WIDTH/4, 40)];
    jingjiaF.backgroundColor=[UIColor colorWithRed:170.0/255.0 green:170.0/255.0 blue:170.0/255.0 alpha:0.2];
    jingjiaF.font=[UIFont systemFontOfSize:14];
    jingjiaF.textAlignment=NSTextAlignmentCenter;
    jingjiaF.text=@"竞价房源";
    [smallView3 addSubview:jingjiaF];
    
    UIImageView *shu5=[[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(jingjiaF.frame), CGRectGetMaxY(heng3.frame), 1, 80)];
    shu5.image=[UIImage imageNamed:@"heng_hui_duan.png"];
    [smallView3 addSubview:shu5];
    UILabel *priceRequest=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(shu5.frame), CGRectGetMaxY(heng3.frame), PL_WIDTH/4, 40)];
    priceRequest.backgroundColor=[UIColor colorWithRed:170.0/255.0 green:170.0/255.0 blue:170.0/255.0 alpha:0.2];
    priceRequest.font=[UIFont systemFontOfSize:14];
    priceRequest.textAlignment=NSTextAlignmentCenter;
    priceRequest.text=@"充值要求";
    [smallView3 addSubview:priceRequest];
    
    UIImageView *heng4=[[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(heng3.frame)+40, PL_WIDTH, 1)];
    heng4.image=[UIImage imageNamed:@"heng_hui_duan.png"];
    [smallView3 addSubview:heng4];
    
    
    //     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(tong:) name:@"tongzhi2222222222" object:nil];
    //     _tiyanban.titleLabel.text=[_dict objectForKey:@"PackageID"];
    //     _kucun.text=[_dict objectForKey:@"HRCount"];
    //     _dingjiaF.text=[_dict objectForKey:@"HRDingJiaCount"];
    //     _jingjiaF.text=[_dict objectForKey:@"HRJingJiaCount"];
    //     _priceRequest.text=[_dict objectForKey:@"PayDemand"];
    //     _packagePrice.text=[_dict objectForKey:@"PackagePrice"];
    
    
    
    UILabel *kucunNum=[[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(heng4.frame), PL_WIDTH/4, 40)];
    kucunNum.font=[UIFont systemFontOfSize:14];
    kucunNum.textAlignment=NSTextAlignmentCenter;
     kucunNum.text=[NSString stringWithFormat:@"%@",[_dict3 objectForKey:@"HRCount"]];
    [smallView3 addSubview:kucunNum];
    
    UILabel *dingjiaNum=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(shu3.frame), CGRectGetMaxY(heng4.frame), PL_WIDTH/4, 40)];
    dingjiaNum.font=[UIFont systemFontOfSize:14];
    dingjiaNum.textAlignment=NSTextAlignmentCenter;
    dingjiaNum.text=[NSString stringWithFormat:@"%@",[_dict3 objectForKey:@"HRDingJiaCount"]];
    [smallView3 addSubview:dingjiaNum];
    
    UILabel *jingjiaNum=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(shu4.frame), CGRectGetMaxY(heng4.frame), PL_WIDTH/4, 40)];
    jingjiaNum.font=[UIFont systemFontOfSize:14];
    jingjiaNum.textAlignment=NSTextAlignmentCenter;
    jingjiaNum.text=[NSString stringWithFormat:@"%@",[_dict3 objectForKey:@"HRJingJiaCount"]];
    [smallView3 addSubview:jingjiaNum];
    UILabel *priceNum=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(shu5.frame), CGRectGetMaxY(heng4.frame), PL_WIDTH/4, 40)];
    priceNum.font=[UIFont systemFontOfSize:14];
    priceNum.textAlignment=NSTextAlignmentCenter;
    priceNum.text=[NSString stringWithFormat:@"%@",[_dict3 objectForKey:@"PayDemand"]];
    [smallView3 addSubview:priceNum];
    
    UIImageView *heng5=[[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(heng4.frame)+40, PL_WIDTH, 1)];
    heng5.image=[UIImage imageNamed:@"heng_hui_duan.png"];
    [smallView3 addSubview:heng5];
    
    UILabel *miaoshu=[[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(heng5.frame), PL_WIDTH, 30)];
    miaoshu.text=@" 套餐价格（元/月）";
    miaoshu.font=[UIFont systemFontOfSize:14];
    miaoshu.textAlignment=NSTextAlignmentCenter;
    miaoshu.backgroundColor=[UIColor colorWithRed:170.0/255.0 green:170.0/255.0 blue:170.0/255.0 alpha:0.2];
    [smallView3 addSubview:miaoshu];
    
    UIImageView *heng6=[[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(miaoshu.frame), PL_WIDTH, 1)];
    heng6.image=[UIImage imageNamed:@"heng_hui_duan.png"];
    [smallView3 addSubview:heng6];
    
    miaoshuTF2=[[UITextField alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(heng6.frame), PL_WIDTH, 30)];
    miaoshuTF2.placeholder=[NSString stringWithFormat:@"%@",[_dict3 objectForKey:@"PackagePrice"]];
    miaoshuTF2.font=[UIFont systemFontOfSize:14];
    miaoshuTF2.textAlignment=NSTextAlignmentCenter;
    [smallView3 addSubview:miaoshuTF2];
    heng777=[[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(miaoshuTF2.frame), PL_WIDTH, 1)];
    heng777.image=[UIImage imageNamed:@"heng_hui_duan.png"];
    [smallView3 addSubview:heng777];
    
#pragma mark---公费自费
//    NSInteger height2;
//    if (hideV3==YES) {
//        height2=0;
//    }
//    else
//    {
//        height2=216;
//    }
    

}

-(void)initView4
{
    NSInteger height;
    if (_dict==nil||_dict2==nil) {
        if (_dict3==nil) {
            height=0;
        }
        else
        {
            height=216;
        }
        
    }
    else
    {
        if (_dict3==nil) {
            height=216;
        }
        else
        {
            height=216*2;
        }
    }
    //NSInteger Y=CGRectGetMaxY(heng77.frame)+40+216+216+10;
    gongfeiBtn=[[UIButton alloc]initWithFrame:CGRectMake(40, CGRectGetMaxY(image33.frame)+216+height+10, 20, 20)];
    [gongfeiBtn setImage:[UIImage imageNamed:@"radio-button_off33.png"] forState:UIControlStateNormal];
    [gongfeiBtn setImage:[UIImage imageNamed:@"radio-button_on33.png"] forState:UIControlStateSelected];
    [gongfeiBtn addTarget:self action:@selector(gongfeiBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [scroll addSubview:gongfeiBtn];
    
    UIButton *gongfeiBtn2=[[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(gongfeiBtn.frame)-15, CGRectGetMaxY(image33.frame)+216+height-3+10, 90, 30)];
    //gongfeiBtn2.backgroundColor=[UIColor redColor];
    [gongfeiBtn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [gongfeiBtn2 setTitle:@"公费申请" forState:UIControlStateNormal];
    gongfeiBtn2.titleLabel.font=[UIFont systemFontOfSize:14];
    [gongfeiBtn2 addTarget:self action:@selector(gongfeiBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [scroll addSubview:gongfeiBtn2];
    
    zifeiBtn=[[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMinX(gongfeiBtn.frame), CGRectGetMaxY(gongfeiBtn.frame)+10, 20, 20)];
    [zifeiBtn setImage:[UIImage imageNamed:@"radio-button_off33.png"] forState:UIControlStateNormal];
    [zifeiBtn setImage:[UIImage imageNamed:@"radio-button_on33.png"] forState:UIControlStateSelected];
    zifeiBtn.selected=YES;
    [zifeiBtn addTarget:self action:@selector(zifeiBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [scroll addSubview:zifeiBtn];
    
    UIButton *zifeiBtn2=[[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(zifeiBtn.frame)-15, CGRectGetMaxY(gongfeiBtn2.frame), 90, 30)];
    [zifeiBtn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [zifeiBtn2 setTitle:@"自费申请" forState:UIControlStateNormal];
    zifeiBtn2.titleLabel.font=[UIFont systemFontOfSize:14];
    [zifeiBtn2 addTarget:self action:@selector(zifeiBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [scroll addSubview:zifeiBtn2];
    
    UIButton *shenqing=[[UIButton alloc]initWithFrame:CGRectMake(PL_WIDTH/2, CGRectGetMaxY(image33.frame)+height+216, PL_WIDTH/2, 70)];
    shenqing.backgroundColor=[UIColor colorWithRed:12.0/255.0 green:136.0/255.0 blue:255.0/255.0 alpha:1];
    [shenqing setTitle:@"申请" forState:UIControlStateNormal];
    [shenqing setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [shenqing addTarget:self action:@selector(shenqingBtnClick) forControlEvents:UIControlEventTouchUpInside];
    shenqing.titleLabel.font=[UIFont systemFontOfSize:21];
    [scroll addSubview:shenqing];
    
    heng8=[[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(zifeiBtn.frame)+10, PL_WIDTH, 1)];
    heng8.image=[UIImage imageNamed:@"heng_hui_duan.png"];
    [scroll addSubview:heng8];
    scroll.contentSize=CGSizeMake(PL_WIDTH, CGRectGetMaxY(heng8.frame)+100);
}

-(void)gongfeiBtnClick
{
    gongfeiBtn.selected=YES;
    zifeiBtn.selected=NO;
}

-(void)zifeiBtnClick
{
    gongfeiBtn.selected=NO;
    zifeiBtn.selected=YES;
}

-(void)shenqingBtnClick
{
    if (_dict3!=nil) {
        if (miaoshuTF2.text.length) {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"确定要申请该套餐吗？" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            alert.delegate=self;
            [alert show];
        }
        else
        {
            PL_ALERT_SHOW(@"请输入充值金额");
        }
    }
    else
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"确定要申请该套餐吗？" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alert.delegate=self;
        [alert show];
    }
    
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;
{
    if (buttonIndex==1) {
        PL_PROGRESS_SHOW;
        WebData *web=[[WebData alloc]init];
        web.WebName=@"上海安居客";
        if (gongfeiBtn.selected) {
            web.RegisterType=@"0";
        }
        if (zifeiBtn.selected) {
            web.RegisterType=@"1";
        }
        if (_dict==nil&&_dict2!=nil&&_dict3==nil) {
            web.PackageID=[_dict2 objectForKey:@"PackageID"];
            web.PackagePrice=[_dict2 objectForKey:@"PackagePrice"];
            web.PackageType=[_dict2 objectForKey:@"PackageType"];
        }
        else if(_dict!=nil&&_dict2==nil&&_dict3==nil)
        {
            web.PackageID=[_dict objectForKey:@"PackageID"];
            web.PackagePrice=[_dict objectForKey:@"PackagePrice"];
            web.PackageType=[_dict objectForKey:@"PackageType"];
        }
        else if(_dict==nil&&_dict2!=nil&&_dict3!=nil)
        {
            web.PackageID=[NSString stringWithFormat:@"%@,%@",[_dict2 objectForKey:@"PackageID"],[_dict3 objectForKey:@"PackageID"]];
            web.PackagePrice=[NSString stringWithFormat:@"%@,%@",[_dict2 objectForKey:@"PackagePrice"],miaoshuTF2.text];
            if ([[_dict3 objectForKey:@"PackageType"] isEqualToString:@""]) {
                NSString *strP = [_dict3 objectForKey:@"PackageType"];
                strP = @"";
                web.PackageType=[NSString stringWithFormat:@"%@,%@",[_dict2 objectForKey:@"PackageType"],strP];
            }
        }
        else if(_dict!=nil&&_dict2==nil&&_dict3!=nil)
        {
            web.PackageID=[NSString stringWithFormat:@"%@,%@",[_dict objectForKey:@"PackageID"],[_dict3 objectForKey:@"PackageID"]];
            web.PackagePrice=[NSString stringWithFormat:@"%@,%@",[_dict objectForKey:@"PackagePrice"],miaoshuTF2.text];
            if ([[_dict3 objectForKey:@"PackageType"] isEqualToString:@""]) {
                NSString *strP = [_dict3 objectForKey:@"PackageType"];
                strP = @"";
                web.PackageType=[NSString stringWithFormat:@"%@,%@",[_dict objectForKey:@"PackageType"],strP];
            }
        }
        else if(_dict!=nil&&_dict2!=nil&&_dict3==nil)
        {
            web.PackageID=[NSString stringWithFormat:@"%@,%@",[_dict objectForKey:@"PackageID"],[_dict2 objectForKey:@"PackageID"]];
            web.PackagePrice=[NSString stringWithFormat:@"%@,%@",[_dict objectForKey:@"PackagePrice"],[_dict2 objectForKey:@"PackagePrice"]];
            web.PackageType=[NSString stringWithFormat:@"%@,%@",[_dict objectForKey:@"PackageType"],[_dict2 objectForKey:@"PackageType"]];
        }
        else if(_dict!=nil&&_dict2!=nil&&_dict3!=nil)
        {
            web.PackageID=[NSString stringWithFormat:@"%@,%@,%@",[_dict objectForKey:@"PackageID"],[_dict2 objectForKey:@"PackageID"],[_dict3 objectForKey:@"PackageID"]];
            web.PackagePrice=[NSString stringWithFormat:@"%@,%@,%@",[_dict objectForKey:@"PackagePrice"],[_dict2 objectForKey:@"PackagePrice"],miaoshuTF2.text];
            if ([[_dict3 objectForKey:@"PackageType"] isEqualToString:@""]) {
                web.PackageType=[NSString stringWithFormat:@"%@,%@, ",[_dict objectForKey:@"PackageType"],[_dict2 objectForKey:@"PackageType"]];
            }
            else
            {
                web.PackageType=[NSString stringWithFormat:@"%@,%@,%@",[_dict objectForKey:@"PackageType"],[_dict2 objectForKey:@"PackageType"],[_dict3 objectForKey:@"PackageType"]];
            }
            
        }else if (_dict==nil&&_dict2==nil&&_dict3!=nil){
            web.PackageID = [NSString stringWithFormat:@"%@",[_dict3 objectForKey:@"PackageID"]];
            web.PackagePrice = [NSString stringWithFormat:@"%@",miaoshuTF2.text];
            web.PackageType=[NSString stringWithFormat:@"%@",[_dict3 objectForKey:@"PackageType"]];
        }
        web.userid=[[NSUserDefaults standardUserDefaults]objectForKey:PL_USER_NAME];
        web.token=[[NSUserDefaults standardUserDefaults]objectForKey:PL_USER_TOKEN];
        NSLog(@"%@  %@  %@  %@  %@  %@",web.WebName,web.RegisterType,web.PackageID,web.PackagePrice,web.userid,web.token);
        [[MyRequest defaultsRequest]setApplication:web backInfoMessage:^(NSMutableString *string) {
            NSLog(@"%@",string);
            PL_PROGRESS_DISMISS;
            if ([string isEqualToString:@"1"]) {
                PL_ALERT_SHOW(@"参数有空值");
            }
            else if([string isEqualToString:@"2"])
            {
                PL_ALERT_SHOW(@"未绑定网站账号");
            }
            else if ([string isEqualToString:@"3"])
            {
                PL_ALERT_SHOW(@"安币充值申请公费不能大于500");
            }
            else if ([string isEqualToString:@"4"])
            {
                PL_ALERT_SHOW(@"本月已申请该网站套餐,不能重复申请");
            }
            else if ([string isEqualToString:@"5"])
            {
                PL_ALERT_SHOW(@"未申请过套餐，不允许申请安币充值");
            }
            else if ([string isEqualToString:@"6"])
            {
                PL_ALERT_SHOW(@"安币充值只能输入数字");
            }
            else if ([string isEqualToString:@"7"])
            {
                PL_ALERT_SHOW(@"安币充值申请金额为0");
            }
            else if ([string isEqualToString:@"8"])
            {
                PL_ALERT_SHOW(@"安币充值申请金额必须为100的倍数");
            }
            else if ([string isEqualToString:@"9"])
            {
                PL_ALERT_SHOW(@"本月安币充值累计申请大于500");
            }
            else if ([string isEqualToString:@"10"])
            {
                PL_ALERT_SHOW(@"本月已申请该网站套餐,不能重复申请");
            }
            else if ([string isEqualToString:@"11"])
            {
                PL_ALERT_SHOW(@"同一种套餐类型只能申请一个套餐");
            }
            else if ([string isEqualToString:@"12"])
            {
                PL_ALERT_SHOW(@"没有申请商铺类套餐的权限");
            }
            else if ([string isEqualToString:@"13"])
            {
                PL_ALERT_SHOW(@"只有营业部才允许申请");
            }
            else if ([string isEqualToString:@"14"])
            {
                PL_ALERT_SHOW(@"本月申请额超出大区限额，请联系大区经理");
            }
            else if ([string isEqualToString:@"15"])
            {
                PL_ALERT_SHOW(@"上月业绩未导入，不能申请");
            }
            else if ([string isEqualToString:@"exception"])
            {
                PL_ALERT_SHOW(@"服务器异常");
            }
            else if ([string isEqualToString:@"OK"])
            {
                PL_ALERT_SHOW(@"申请成功");
            }
            else
            {
                PL_ALERT_SHOW(@"申请失败");
            }
        }];
    }
}


-(void)returnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

//当键盘出现或改变时调用
- (void)keyboardWillShow:(NSNotification *)aNotification
{
    //创建一个仿射变换，平移(0, -100)视图上移100像素
    CGAffineTransform pTransform = CGAffineTransformMakeTranslation(0, -200);
    //使视图使用这个变换
    scroll.transform = pTransform;
    //_scroll1.contentSize=CGSizeMake(PL_WIDTH, PL_HEIGHT*1.2);
}
//当键退出时调用
- (void)keyboardWillHide:(NSNotification *)aNotification
{
    // 创建一个仿射变换，平移(0, -100)视图上移100像素
    CGAffineTransform pTransform = CGAffineTransformMakeTranslation(0, 0);
    //使视图使用这个变换
    scroll.transform = pTransform;
   scroll.contentSize=CGSizeMake(PL_WIDTH, CGRectGetMaxY(heng8.frame)+100);
    
    
    
}

- (void)ksyWillAnimation:(NSNotification *)note
{
    UIView * fview = [scroll firstResponder];
    
    
    CGFloat fy = CGRectGetMaxY(fview.frame);
    NSDictionary * dict = note.userInfo;
    CGRect endFrame = [[dict objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    CGFloat delta = endFrame.origin.y - fy-40;
    
    if (delta <0)
    {
        CGAffineTransform pTransform = CGAffineTransformMakeTranslation(0, delta);
        [UIView animateWithDuration:0.25 animations:^{
            //            self.view.center = CGPointMake(self.view.center.x, self.view.center.y+delta);
            scroll.transform = pTransform;
            
            
        }];
        
        
        
    }
    else
    {
        CGAffineTransform pTransform = CGAffineTransformMakeTranslation(0, 0);
        [UIView animateWithDuration:0.25 animations:^{
            //            self.view.center = CGPointMake(self.view.center.x, self.view.bounds.size.height/2);
            scroll.transform = pTransform;
            
        }];
        
        
    }
    
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [scroll endEditing:YES];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [scroll endEditing:YES];
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
