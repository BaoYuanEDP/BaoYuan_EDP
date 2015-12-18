//
//  PackageViewController.m
//  BYFCApp
//
//  Created by zzs on 15/1/22.
//  Copyright (c) 2015年 PengLee. All rights reserved.
//

#import "PackageViewController.h"
#import "PL_Header.h"

@interface PackageViewController ()

@end

@implementation PackageViewController
/*
-(void)viewDidAppear:(BOOL)animated
{
    [self performSegueWithIdentifier:@"gopage" sender:self];
}
*/
- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    self.title=@"端口申请";
    self.navigationController.navigationBarHidden=NO;
    UIButton * backItemBnt = [UIButton buttonWithType:UIButtonTypeCustom];
    backItemBnt.frame = CGRectMake(20, 10, 10, 20);
    [backItemBnt setBackgroundImage:[UIImage imageNamed:@"返回.png"] forState:UIControlStateNormal];
    [backItemBnt addTarget:self action:@selector(returnClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem * leftBtn = [[UIBarButtonItem alloc]initWithCustomView:backItemBnt];
    self.navigationItem.leftBarButtonItem = leftBtn;
    
    [self initView];
     
}
-(void)initView
{
    NSLog(@"%@",_dict);
    UILabel *check=[[UILabel alloc]initWithFrame:CGRectMake(13, 77, PL_WIDTH*0.4, PL_HEIGHT/24)];
    check.text=@"您选择的是";
    //check.backgroundColor=[UIColor redColor];
    check.font=[UIFont systemFontOfSize:18];
    [self.view addSubview:check];
    UIImageView *image1=[[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(check.frame), 70, 1, 30)];
    image1.image=[UIImage imageNamed:@"heng_hui_duan.png"];
    [self.view addSubview:image1];
    UIImageView *image2=[[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMinX(image1.frame)+40, CGRectGetMinY(check.frame), PL_WIDTH*0.3, PL_HEIGHT/24)];
    image2.backgroundColor=[UIColor yellowColor];
    image2.image=[UIImage imageNamed:@"anjuke_SH33.png"];
    [self.view addSubview:image2];
    
    UIImageView *image33=[[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(image1.frame)+5, PL_WIDTH, 1)];
    image33.image=[UIImage imageNamed:@"heng_hui_duan.png"];
    [self.view addSubview:image33];
    
    UIView *smallView=[[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(image33.frame), PL_WIDTH, 216)];
    smallView.backgroundColor=[UIColor redColor];
    [self.view addSubview:smallView];
    
    UIImageView *image3=[[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(image33.frame)+20, PL_WIDTH, 1)];
    //UIImageView *image3=[[UIImageView alloc]initWithFrame:CGRectMake(0, 20, PL_WIDTH, 1)];
    image3.image=[UIImage imageNamed:@"heng_hui_duan.png"];
    [self.view addSubview:image3];
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(image3.frame), PL_WIDTH,30)];
    view.backgroundColor=[UIColor colorWithRed:170.0/255.0 green:170.0/255.0 blue:170.0/255.0 alpha:0.2];
    [self.view addSubview:view];
    
    
    
    UILabel *taocanbianhao=[[UILabel alloc]initWithFrame:CGRectMake(0, 5, check.frame.size.width, 20)];
    taocanbianhao.text=@"套餐编号";
    taocanbianhao.font=[UIFont systemFontOfSize:14];
    taocanbianhao.textAlignment=NSTextAlignmentRight;
    [view addSubview:taocanbianhao];
    UIImageView *shu2=[[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMinX(image1.frame), 0, 1, 30)];
    shu2.image=[UIImage imageNamed:@"heng_hui_duan.png"];
    [view addSubview:shu2];
    UILabel *jingjia=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(shu2.frame), 10, PL_WIDTH-taocanbianhao.frame.size.width-1, 20)];
    jingjia.text=[_dict objectForKey:@"PackageID"];
    jingjia.font=[UIFont systemFontOfSize:14];
    jingjia.textAlignment=NSTextAlignmentCenter;
    [view addSubview:jingjia];
    UIImageView *heng2=[[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(view.frame), PL_WIDTH, 1)];
    heng2.image=[UIImage imageNamed:@"heng_hui_duan.png"];
    [self.view addSubview:heng2];
    UIImageView *heng3=[[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(heng2.frame)+20, PL_WIDTH, 1)];
    heng3.image=[UIImage imageNamed:@"heng_hui_duan.png"];
    [self.view addSubview:heng3];
    
    UIImageView *zhuzhaiImg=[[UIImageView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(image33.frame)+10, 50, 53)];
    zhuzhaiImg.image=[UIImage imageNamed:@"端口申请方形白色背景.png"];
    [self.view addSubview:zhuzhaiImg];
    UILabel *zhuzhai=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 50, 53)];
    zhuzhai.text=@"住宅";
    zhuzhai.textAlignment=NSTextAlignmentCenter;
    zhuzhai.font=[UIFont systemFontOfSize:14];
    [zhuzhaiImg addSubview:zhuzhai];
    [self.view bringSubviewToFront:zhuzhaiImg];
    
    //***************************
    UILabel *kucun=[[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(heng3.frame), PL_WIDTH/4-1, 40)];
    kucun.backgroundColor=[UIColor colorWithRed:170.0/255.0 green:170.0/255.0 blue:170.0/255.0 alpha:0.2];
    kucun.font=[UIFont systemFontOfSize:14];
    kucun.textAlignment=NSTextAlignmentCenter;
    kucun.text=@"库存";
    [self.view addSubview:kucun];
    UIImageView *shu3=[[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(kucun.frame), CGRectGetMaxY(heng3.frame), 1, 80)];
    shu3.image=[UIImage imageNamed:@"heng_hui_duan.png"];
    [self.view addSubview:shu3];
    
    UILabel *dingjiaF=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(shu3.frame), CGRectGetMaxY(heng3.frame), PL_WIDTH/4-1, 40)];
    dingjiaF.backgroundColor=[UIColor colorWithRed:170.0/255.0 green:170.0/255.0 blue:170.0/255.0 alpha:0.2];
    dingjiaF.font=[UIFont systemFontOfSize:14];
    dingjiaF.textAlignment=NSTextAlignmentCenter;
    dingjiaF.text=@"定价房源";
    [self.view addSubview:dingjiaF];
    UIImageView *shu4=[[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(dingjiaF.frame), CGRectGetMaxY(heng3.frame), 1, 80)];
    shu4.image=[UIImage imageNamed:@"heng_hui_duan.png"];
    [self.view addSubview:shu4];
    UILabel *jingjiaF=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(shu4.frame), CGRectGetMaxY(heng3.frame), PL_WIDTH/4, 40)];
    jingjiaF.backgroundColor=[UIColor colorWithRed:170.0/255.0 green:170.0/255.0 blue:170.0/255.0 alpha:0.2];
    jingjiaF.font=[UIFont systemFontOfSize:14];
    jingjiaF.textAlignment=NSTextAlignmentCenter;
    jingjiaF.text=@"竞价房源";
    [self.view addSubview:jingjiaF];
    
    UIImageView *shu5=[[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(jingjiaF.frame), CGRectGetMaxY(heng3.frame), 1, 80)];
    shu5.image=[UIImage imageNamed:@"heng_hui_duan.png"];
    [self.view addSubview:shu5];
    UILabel *priceRequest=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(shu5.frame), CGRectGetMaxY(heng3.frame), PL_WIDTH/4, 40)];
    priceRequest.backgroundColor=[UIColor colorWithRed:170.0/255.0 green:170.0/255.0 blue:170.0/255.0 alpha:0.2];
    priceRequest.font=[UIFont systemFontOfSize:14];
    priceRequest.textAlignment=NSTextAlignmentCenter;
    priceRequest.text=@"充值要求";
    [self.view addSubview:priceRequest];
    
    UIImageView *heng4=[[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(heng3.frame)+40, PL_WIDTH, 1)];
    heng4.image=[UIImage imageNamed:@"heng_hui_duan.png"];
    [self.view addSubview:heng4];

     /*
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(tong:) name:@"tongzhi2222222222" object:nil];
     _tiyanban.titleLabel.text=[_dict objectForKey:@"PackageID"];
     _kucun.text=[_dict objectForKey:@"HRCount"];
     _dingjiaF.text=[_dict objectForKey:@"HRDingJiaCount"];
     _jingjiaF.text=[_dict objectForKey:@"HRJingJiaCount"];
     _priceRequest.text=[_dict objectForKey:@"PayDemand"];
     _packagePrice.text=[_dict objectForKey:@"PackagePrice"];
     */


    UILabel *kucunNum=[[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(heng4.frame), PL_WIDTH/4, 40)];
    kucunNum.font=[UIFont systemFontOfSize:14];
    kucunNum.textAlignment=NSTextAlignmentCenter;
    kucunNum.text=[NSString stringWithFormat:@"%@",[_dict objectForKey:@"HRCount"]];
    [self.view addSubview:kucunNum];
    
    UILabel *dingjiaNum=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(shu3.frame), CGRectGetMaxY(heng4.frame), PL_WIDTH/4, 40)];
    dingjiaNum.font=[UIFont systemFontOfSize:14];
    dingjiaNum.textAlignment=NSTextAlignmentCenter;
    dingjiaNum.text=[NSString stringWithFormat:@"%@",[_dict objectForKey:@"HRDingJiaCount"]];
    [self.view addSubview:dingjiaNum];
    
    UILabel *jingjiaNum=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(shu4.frame), CGRectGetMaxY(heng4.frame), PL_WIDTH/4, 40)];
    jingjiaNum.font=[UIFont systemFontOfSize:14];
    jingjiaNum.textAlignment=NSTextAlignmentCenter;
    jingjiaNum.text=[NSString stringWithFormat:@"%@",[_dict objectForKey:@"HRJingJiaCount"]];
    [self.view addSubview:jingjiaNum];
    UILabel *priceNum=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(shu5.frame), CGRectGetMaxY(heng4.frame), PL_WIDTH/4, 40)];
    priceNum.font=[UIFont systemFontOfSize:14];
    priceNum.textAlignment=NSTextAlignmentCenter;
    priceNum.text=[NSString stringWithFormat:@"%@",[_dict objectForKey:@"PayDemand"]];
    [self.view addSubview:priceNum];
    
    UIImageView *heng5=[[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(heng4.frame)+40, PL_WIDTH, 1)];
    heng5.image=[UIImage imageNamed:@"heng_hui_duan.png"];
    [self.view addSubview:heng5];
    
    UILabel *miaoshu=[[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(heng5.frame), PL_WIDTH, 30)];
    miaoshu.text=@"    套餐描述";
    miaoshu.font=[UIFont systemFontOfSize:14];
    miaoshu.textAlignment=NSTextAlignmentLeft;
    miaoshu.backgroundColor=[UIColor colorWithRed:170.0/255.0 green:170.0/255.0 blue:170.0/255.0 alpha:0.2];
    [self.view addSubview:miaoshu];
    
    UIImageView *heng6=[[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(miaoshu.frame), PL_WIDTH, 1)];
    heng6.image=[UIImage imageNamed:@"heng_hui_duan.png"];
    [self.view addSubview:heng6];
    
    UILabel *miaoshu2=[[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(heng6.frame), PL_WIDTH, 30)];
    miaoshu2.text=[NSString stringWithFormat:@"    %@",[_dict objectForKey:@"PackagePrice"]];
    miaoshu2.font=[UIFont systemFontOfSize:14];
    miaoshu2.textAlignment=NSTextAlignmentLeft;
    [self.view addSubview:miaoshu2];
    
    UIImageView *heng7=[[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(miaoshu2.frame), PL_WIDTH, 1)];
    heng7.image=[UIImage imageNamed:@"heng_hui_duan.png"];
    [self.view addSubview:heng7];
    
    gongfeiBtn=[[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMinX(miaoshu.frame)+40, CGRectGetMaxY(heng7.frame)+10, 20, 20)];
    [gongfeiBtn setImage:[UIImage imageNamed:@"radio-button_off33.png"] forState:UIControlStateNormal];
    [gongfeiBtn setImage:[UIImage imageNamed:@"radio-button_on33.png"] forState:UIControlStateSelected];
    [gongfeiBtn addTarget:self action:@selector(gongfeiBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:gongfeiBtn];
    
    UIButton *gongfeiBtn2=[[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(gongfeiBtn.frame)-15, CGRectGetMaxY(heng7.frame)+7, 90, 30)];
    //gongfeiBtn2.backgroundColor=[UIColor redColor];
    [gongfeiBtn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [gongfeiBtn2 setTitle:@"公费申请" forState:UIControlStateNormal];
    gongfeiBtn2.titleLabel.font=[UIFont systemFontOfSize:14];
    [gongfeiBtn2 addTarget:self action:@selector(gongfeiBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:gongfeiBtn2];
    
    zifeiBtn=[[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMinX(gongfeiBtn.frame), CGRectGetMaxY(gongfeiBtn.frame)+10, 20, 20)];
    [zifeiBtn setImage:[UIImage imageNamed:@"radio-button_off33.png"] forState:UIControlStateNormal];
    [zifeiBtn setImage:[UIImage imageNamed:@"radio-button_on33.png"] forState:UIControlStateSelected];
    zifeiBtn.selected=YES;
    [zifeiBtn addTarget:self action:@selector(zifeiBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:zifeiBtn];
    
    UIButton *zifeiBtn2=[[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(zifeiBtn.frame)-15, CGRectGetMaxY(gongfeiBtn2.frame), 90, 30)];
    [zifeiBtn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [zifeiBtn2 setTitle:@"自费申请" forState:UIControlStateNormal];
    zifeiBtn2.titleLabel.font=[UIFont systemFontOfSize:14];
    [zifeiBtn2 addTarget:self action:@selector(zifeiBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:zifeiBtn2];
    
    UIButton *shenqing=[[UIButton alloc]initWithFrame:CGRectMake(PL_WIDTH/2, CGRectGetMaxY(heng7.frame), PL_WIDTH/2, 70)];
    shenqing.backgroundColor=[UIColor colorWithRed:12.0/255.0 green:136.0/255.0 blue:255.0/255.0 alpha:1];
    [shenqing setTitle:@"申请" forState:UIControlStateNormal];
    [shenqing setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [shenqing addTarget:self action:@selector(shenqingBtnClick) forControlEvents:UIControlEventTouchUpInside];
    shenqing.titleLabel.font=[UIFont systemFontOfSize:21];
    [self.view addSubview:shenqing];
    
    UIImageView *heng8=[[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(zifeiBtn.frame)+10, PL_WIDTH, 1)];
    heng8.image=[UIImage imageNamed:@"heng_hui_duan.png"];
    [self.view addSubview:heng8];
    
    
    
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
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"确定要申请该套餐吗？" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.delegate=self;
    [alert show];
}



-(void)returnClick
{
    [self.navigationController popViewControllerAnimated:YES];
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

- (IBAction)gongfeiClick:(UIButton *)sender {
    gongfeiBtn.selected=YES;
   
        zifeiBtn.selected=NO;
    
}

- (IBAction)zifeiClick:(UIButton *)sender {
    zifeiBtn.selected=YES;
    gongfeiBtn.selected=NO;
}

- (IBAction)shenqingClick:(UIButton *)sender {
    NSLog(@"shenqing");
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"确定要申请该套餐吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    
    [alert show];
    
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
        web.PackageID=[_dict objectForKey:@"PackageID"];
        web.PackagePrice=[_dict objectForKey:@"PackagePrice"];
        
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
                PL_ALERT_SHOW(@"未申请过套餐(体验版/标准版)，不允许安申请币充值");
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
                PL_ALERT_SHOW(@"本月申请额超出片区限额");
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

@end
