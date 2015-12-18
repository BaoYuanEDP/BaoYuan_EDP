//
//  GanJiViewController.m
//  BYFCApp
//
//  Created by zzs on 15/2/2.
//  Copyright (c) 2015年 PengLee. All rights reserved.
//

#import "GanJiViewController.h"
#import "PL_Header.h"

@interface GanJiViewController ()

@end

@implementation GanJiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    self.title=@"端口申请";
    self.navigationController.navigationBarHidden=NO;
    UIButton * backItemBnt = [UIButton buttonWithType:UIButtonTypeCustom];
    backItemBnt.frame = CGRectMake(20, 10, 10, 20);
    [backItemBnt setBackgroundImage:[UIImage imageNamed:@"返回.png"] forState:UIControlStateNormal];
    [backItemBnt addTarget:self action:@selector(returnClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem * leftBtn = [[UIBarButtonItem alloc]initWithCustomView:backItemBnt];
    self.navigationItem.leftBarButtonItem = leftBtn;
    //self.dict = [NSDictionary dictionary];
    self.edgesForExtendedLayout=UIRectEdgeNone;
    scroll=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, PL_WIDTH, PL_HEIGHT)];
    scroll.backgroundColor=[UIColor whiteColor];
    //scroll.delegate=self;
    //_scroll1.canCancelContentTouches=YES;
    scroll.contentSize=CGSizeMake(PL_WIDTH, PL_HEIGHT*1.5);
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
    image2.image=[UIImage imageNamed:@"GanJilogo33.png"];
    [scroll addSubview:image2];
    
    image33=[[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(image1.frame)+5, PL_WIDTH, 1)];
    image33.image=[UIImage imageNamed:@"heng_hui_duan.png"];
    [scroll addSubview:image33];
    if (self.dict!=nil) {
        [self initView1];
    }
    if (self.dict2!=nil) {
        [self initView2];
    }
    [self initView3];
    
}

-(void)initView1
{
    smallView=[[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(image33.frame), PL_WIDTH, 270)];
     //smallView.backgroundColor=[UIColor redColor];
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
    
    UILabel *shouF=[[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(heng3.frame), PL_WIDTH/3-1, 30)];
    shouF.backgroundColor=[UIColor colorWithRed:170.0/255.0 green:170.0/255.0 blue:170.0/255.0 alpha:0.2];
    shouF.font=[UIFont systemFontOfSize:14];
    shouF.textAlignment=NSTextAlignmentCenter;
    shouF.text=@"房源量";
    [smallView addSubview:shouF];
    UIImageView *shu3=[[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(shouF.frame), CGRectGetMaxY(heng3.frame), 1, 60)];
    shu3.image=[UIImage imageNamed:@"heng_hui_duan.png"];
    [smallView addSubview:shu3];
    
    UILabel *zuF=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(shu3.frame), CGRectGetMaxY(heng3.frame), PL_WIDTH/3, 30)];
    zuF.backgroundColor=[UIColor colorWithRed:170.0/255.0 green:170.0/255.0 blue:170.0/255.0 alpha:0.2];
    zuF.font=[UIFont systemFontOfSize:14];
    zuF.textAlignment=NSTextAlignmentCenter;
    zuF.text=@"赠送竞价币";
    [smallView addSubview:zuF];
    UIImageView *shu4=[[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(zuF.frame), CGRectGetMaxY(heng3.frame), 1, 60)];
    shu4.image=[UIImage imageNamed:@"heng_hui_duan.png"];
    [smallView addSubview:shu4];
    UILabel *price=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(shu4.frame), CGRectGetMaxY(heng3.frame), PL_WIDTH/3, 30)];
    price.backgroundColor=[UIColor colorWithRed:170.0/255.0 green:170.0/255.0 blue:170.0/255.0 alpha:0.2];
    price.font=[UIFont systemFontOfSize:14];
    price.textAlignment=NSTextAlignmentCenter;
    price.text=@"套餐价格(元/月)";
    [smallView addSubview:price];
    
    //**********
    UIImageView *heng4=[[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(heng3.frame)+30, PL_WIDTH, 1)];
    heng4.image=[UIImage imageNamed:@"heng_hui_duan.png"];
    [smallView addSubview:heng4];
    
    UILabel *shouFNum=[[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(heng4.frame), PL_WIDTH/3, 30)];
    shouFNum.font=[UIFont systemFontOfSize:14];
    shouFNum.textAlignment=NSTextAlignmentCenter;
    shouFNum.text=[NSString stringWithFormat:@"%@",[_dict objectForKey:@"HRCount"]];
    [smallView addSubview:shouFNum];
    
    UILabel *zuFNum=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(shu3.frame), CGRectGetMaxY(heng4.frame), PL_WIDTH/3, 30)];
    zuFNum.font=[UIFont systemFontOfSize:14];
    zuFNum.textAlignment=NSTextAlignmentCenter;
    zuFNum.text=[NSString stringWithFormat:@"%@",[_dict objectForKey:@"PackagePresent"]];
    [smallView addSubview:zuFNum];
    
    UILabel *priceNum=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(shu4.frame), CGRectGetMaxY(heng4.frame), PL_WIDTH/3, 30)];
    priceNum.font=[UIFont systemFontOfSize:14];
    priceNum.textAlignment=NSTextAlignmentCenter;
    priceNum.text=[NSString stringWithFormat:@"%@",[_dict objectForKey:@"PackagePrice"]];
    [smallView addSubview:priceNum];
    UIImageView *heng5=[[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(heng4.frame)+30, PL_WIDTH, 1)];
    heng5.image=[UIImage imageNamed:@"heng_hui_duan.png"];
    [smallView addSubview:heng5];
    
    UILabel *renzheng=[[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(heng5.frame), PL_WIDTH, 30)];
    renzheng.text=@"刷新次数(次/天)";
    renzheng.font=[UIFont systemFontOfSize:14];
    renzheng.textAlignment=NSTextAlignmentCenter;
    renzheng.backgroundColor=[UIColor colorWithRed:170.0/255.0 green:170.0/255.0 blue:170.0/255.0 alpha:0.2];
    [smallView addSubview:renzheng];
    
    UIImageView *heng6=[[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(renzheng.frame), PL_WIDTH, 1)];
    heng6.image=[UIImage imageNamed:@"heng_hui_duan.png"];
    [smallView addSubview:heng6];
    
    UILabel *renzheng2=[[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(heng6.frame), PL_WIDTH, 30)];
    renzheng2.text=[NSString stringWithFormat:@"%@",[_dict objectForKey:@"HRRefreshCount"]];
    renzheng2.font=[UIFont systemFontOfSize:14];
    renzheng2.textAlignment=NSTextAlignmentCenter;
    [smallView addSubview:renzheng2];
    
    UIImageView *heng7=[[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(renzheng2.frame), PL_WIDTH, 1)];
    heng7.image=[UIImage imageNamed:@"heng_hui_duan.png"];
    [smallView addSubview:heng7];
    
    UILabel *miaoshu=[[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(heng7.frame), PL_WIDTH, 30)];
    miaoshu.text=@"服务内容描述";
    miaoshu.font=[UIFont systemFontOfSize:14];
    miaoshu.textAlignment=NSTextAlignmentCenter;
    miaoshu.backgroundColor=[UIColor colorWithRed:170.0/255.0 green:170.0/255.0 blue:170.0/255.0 alpha:0.2];
    [smallView addSubview:miaoshu];
    
    UIImageView *heng8=[[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(miaoshu.frame), PL_WIDTH, 1)];
    heng8.image=[UIImage imageNamed:@"heng_hui_duan.png"];
    [smallView addSubview:heng8];
    
    UILabel *miaoshu2=[[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(heng8.frame), PL_WIDTH-20, 40)];
    miaoshu2.text=[NSString stringWithFormat:@"%@",[_dict objectForKey:@"PackageRemark"]];
    miaoshu2.font=[UIFont systemFontOfSize:14];
    miaoshu2.numberOfLines=0;
    miaoshu2.textAlignment=NSTextAlignmentLeft;
    [smallView addSubview:miaoshu2];
    
    heng9=[[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(miaoshu2.frame), PL_WIDTH, 1)];
    heng9.image=[UIImage imageNamed:@"heng_hui_duan.png"];
    [smallView addSubview:heng9];
}

-(void)initView2
{
    smallView2=[[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(heng9.frame)+40, PL_WIDTH, 270)];
    //smallView2.backgroundColor=[UIColor redColor];
    [scroll addSubview:smallView2];
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
    zhuzhai.text=[_dict2 objectForKey:@"PackageType"];
    zhuzhai.textAlignment=NSTextAlignmentCenter;
    zhuzhai.font=[UIFont systemFontOfSize:14];
    [zhuzhaiImg addSubview:zhuzhai];
    [smallView2 bringSubviewToFront:zhuzhaiImg];
    
    UILabel *shouF=[[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(heng3.frame), PL_WIDTH/3-1, 30)];
    shouF.backgroundColor=[UIColor colorWithRed:170.0/255.0 green:170.0/255.0 blue:170.0/255.0 alpha:0.2];
    shouF.font=[UIFont systemFontOfSize:14];
    shouF.textAlignment=NSTextAlignmentCenter;
    shouF.text=@"房源量";
    [smallView2 addSubview:shouF];
    UIImageView *shu3=[[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(shouF.frame), CGRectGetMaxY(heng3.frame), 1, 60)];
    shu3.image=[UIImage imageNamed:@"heng_hui_duan.png"];
    [smallView2 addSubview:shu3];
    
    UILabel *zuF=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(shu3.frame), CGRectGetMaxY(heng3.frame), PL_WIDTH/3, 30)];
    zuF.backgroundColor=[UIColor colorWithRed:170.0/255.0 green:170.0/255.0 blue:170.0/255.0 alpha:0.2];
    zuF.font=[UIFont systemFontOfSize:14];
    zuF.textAlignment=NSTextAlignmentCenter;
    zuF.text=@"赠送竞价币";
    [smallView2 addSubview:zuF];
    UIImageView *shu4=[[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(zuF.frame), CGRectGetMaxY(heng3.frame), 1, 60)];
    shu4.image=[UIImage imageNamed:@"heng_hui_duan.png"];
    [smallView2 addSubview:shu4];
    UILabel *price=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(shu4.frame), CGRectGetMaxY(heng3.frame), PL_WIDTH/3, 30)];
    price.backgroundColor=[UIColor colorWithRed:170.0/255.0 green:170.0/255.0 blue:170.0/255.0 alpha:0.2];
    price.font=[UIFont systemFontOfSize:14];
    price.textAlignment=NSTextAlignmentCenter;
    price.text=@"套餐价格(元/月)";
    [smallView2 addSubview:price];
    
    //**********
    UIImageView *heng4=[[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(heng3.frame)+30, PL_WIDTH, 1)];
    heng4.image=[UIImage imageNamed:@"heng_hui_duan.png"];
    [smallView2 addSubview:heng4];
    
    UILabel *shouFNum=[[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(heng4.frame), PL_WIDTH/3, 30)];
    shouFNum.font=[UIFont systemFontOfSize:14];
    shouFNum.textAlignment=NSTextAlignmentCenter;
    shouFNum.text=[NSString stringWithFormat:@"%@",[_dict2 objectForKey:@"HRCount"]];
    [smallView2 addSubview:shouFNum];
    
    UILabel *zuFNum=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(shu3.frame), CGRectGetMaxY(heng4.frame), PL_WIDTH/3, 30)];
    zuFNum.font=[UIFont systemFontOfSize:14];
    zuFNum.textAlignment=NSTextAlignmentCenter;
    zuFNum.text=[NSString stringWithFormat:@"%@",[_dict2 objectForKey:@"PackagePresent"]];
    [smallView2 addSubview:zuFNum];
    
    UILabel *priceNum=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(shu4.frame), CGRectGetMaxY(heng4.frame), PL_WIDTH/3, 30)];
    priceNum.font=[UIFont systemFontOfSize:14];
    priceNum.textAlignment=NSTextAlignmentCenter;
    priceNum.text=[NSString stringWithFormat:@"%@",[_dict2 objectForKey:@"PackagePrice"]];
    [smallView2 addSubview:priceNum];
    UIImageView *heng5=[[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(heng4.frame)+30, PL_WIDTH, 1)];
    heng5.image=[UIImage imageNamed:@"heng_hui_duan.png"];
    [smallView2 addSubview:heng5];
    
    UILabel *renzheng=[[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(heng5.frame), PL_WIDTH, 30)];
    renzheng.text=@"刷新次数(次/天)";
    renzheng.font=[UIFont systemFontOfSize:14];
    renzheng.textAlignment=NSTextAlignmentCenter;
    renzheng.backgroundColor=[UIColor colorWithRed:170.0/255.0 green:170.0/255.0 blue:170.0/255.0 alpha:0.2];
    [smallView2 addSubview:renzheng];
    
    UIImageView *heng6=[[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(renzheng.frame), PL_WIDTH, 1)];
    heng6.image=[UIImage imageNamed:@"heng_hui_duan.png"];
    [smallView2 addSubview:heng6];
    
    UILabel *renzheng2=[[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(heng6.frame), PL_WIDTH, 30)];
    renzheng2.text=[NSString stringWithFormat:@"%@",[_dict2 objectForKey:@"HRRefreshCount"]];
    renzheng2.font=[UIFont systemFontOfSize:14];
    renzheng2.textAlignment=NSTextAlignmentCenter;
    [smallView2 addSubview:renzheng2];
    
    UIImageView *heng7=[[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(renzheng2.frame), PL_WIDTH, 1)];
    heng7.image=[UIImage imageNamed:@"heng_hui_duan.png"];
    [smallView2 addSubview:heng7];
    
    UILabel *miaoshu=[[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(heng7.frame), PL_WIDTH, 30)];
    miaoshu.text=@"服务内容描述";
    miaoshu.font=[UIFont systemFontOfSize:14];
    miaoshu.textAlignment=NSTextAlignmentCenter;
    miaoshu.backgroundColor=[UIColor colorWithRed:170.0/255.0 green:170.0/255.0 blue:170.0/255.0 alpha:0.2];
    [smallView2 addSubview:miaoshu];
    
    UIImageView *heng8=[[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(miaoshu.frame), PL_WIDTH, 1)];
    heng8.image=[UIImage imageNamed:@"heng_hui_duan.png"];
    [smallView2 addSubview:heng8];
    
    UILabel *miaoshu2=[[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(heng8.frame), PL_WIDTH-20, 40)];
    miaoshu2.text=[NSString stringWithFormat:@"%@",[_dict2 objectForKey:@"PackageRemark"]];
    miaoshu2.font=[UIFont systemFontOfSize:14];
    miaoshu2.numberOfLines=0;
    miaoshu2.textAlignment=NSTextAlignmentLeft;
    [smallView2 addSubview:miaoshu2];
    
    heng99=[[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(miaoshu2.frame), PL_WIDTH, 1)];
    heng99.image=[UIImage imageNamed:@"heng_hui_duan.png"];
    [smallView2 addSubview:heng99];
    

}

-(void)initView3
{
    NSInteger height;
    if (_dict==nil||_dict2==nil) {
        height=0;
    }
    else
    {
        height=270;
    }
#pragma  mark ------
    gongfeiBtn=[[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMinX(heng99.frame)+40, CGRectGetMaxY(image33.frame)+10+270+height, 20, 20)];
    [gongfeiBtn setImage:[UIImage imageNamed:@"radio-button_off33.png"] forState:UIControlStateNormal];
    [gongfeiBtn setImage:[UIImage imageNamed:@"radio-button_on33.png"] forState:UIControlStateSelected];
    [gongfeiBtn addTarget:self action:@selector(gongfeiBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [scroll addSubview:gongfeiBtn];
    
    UIButton *gongfeiBtn2=[[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(gongfeiBtn.frame)-15, CGRectGetMaxY(image33.frame)+7+270+height, 90, 30)];
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
    
    UIButton *shenqing=[[UIButton alloc]initWithFrame:CGRectMake(PL_WIDTH/2, CGRectGetMaxY(image33.frame)+267+height, PL_WIDTH/2, 70)];
    shenqing.backgroundColor=[UIColor colorWithRed:12.0/255.0 green:136.0/255.0 blue:255.0/255.0 alpha:1];
    [shenqing setTitle:@"申请" forState:UIControlStateNormal];
    [shenqing setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [shenqing addTarget:self action:@selector(shenqingBtnClick) forControlEvents:UIControlEventTouchUpInside];
    shenqing.titleLabel.font=[UIFont systemFontOfSize:21];
    [scroll addSubview:shenqing];
    
    UIImageView *heng10=[[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(shenqing.frame), PL_WIDTH, 1)];
    heng10.image=[UIImage imageNamed:@"heng_hui_duan.png"];
    [scroll addSubview:heng10];
}

-(void)initView
{
    /*
    NSLog(@"%@",_dict);
    UILabel *check=[[UILabel alloc]initWithFrame:CGRectMake(13, 72, PL_WIDTH*0.4, PL_HEIGHT/24)];
    check.text=@"您选择的是";
    //check.backgroundColor=[UIColor redColor];
    check.font=[UIFont systemFontOfSize:18];
    [self.view addSubview:check];
    UIImageView *image1=[[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(check.frame), 70, 1, 30)];
    image1.image=[UIImage imageNamed:@"heng_hui_duan.png"];
    [self.view addSubview:image1];
    UIImageView *image2=[[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMinX(image1.frame)+40, CGRectGetMinY(check.frame)-5, PL_WIDTH*0.3, PL_HEIGHT/20+5)];
    image2.backgroundColor=[UIColor yellowColor];
    image2.image=[UIImage imageNamed:@"GanJilogo33.png"];
    [self.view addSubview:image2];
    UIImageView *image3=[[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(image1.frame)+5, PL_WIDTH, 1)];
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
    UIImageView *shu2=[[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMinX(image1.frame), 5, 1, 20)];
    shu2.image=[UIImage imageNamed:@"heng_hui_duan.png"];
    [view addSubview:shu2];
    UILabel *jingjia=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(shu2.frame), 5, PL_WIDTH-taocanbianhao.frame.size.width-1, 20)];
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
    
    UIImageView *zhuzhaiImg=[[UIImageView alloc]initWithFrame:CGRectMake(10, CGRectGetMinY(image3.frame)-10, 50, 53)];
    zhuzhaiImg.image=[UIImage imageNamed:@"端口申请方形白色背景.png"];
    [self.view addSubview:zhuzhaiImg];
    UILabel *zhuzhai=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 50, 53)];
    zhuzhai.text=[_dict objectForKey:@"PackageType"];
    zhuzhai.textAlignment=NSTextAlignmentCenter;
    zhuzhai.font=[UIFont systemFontOfSize:14];
    [zhuzhaiImg addSubview:zhuzhai];
    [self.view bringSubviewToFront:zhuzhaiImg];
    
    UILabel *shouF=[[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(heng3.frame), PL_WIDTH/3-1, 30)];
    shouF.backgroundColor=[UIColor colorWithRed:170.0/255.0 green:170.0/255.0 blue:170.0/255.0 alpha:0.2];
    shouF.font=[UIFont systemFontOfSize:14];
    shouF.textAlignment=NSTextAlignmentCenter;
    shouF.text=@"房源量";
    [self.view addSubview:shouF];
    UIImageView *shu3=[[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(shouF.frame), CGRectGetMaxY(heng3.frame), 1, 60)];
    shu3.image=[UIImage imageNamed:@"heng_hui_duan.png"];
    [self.view addSubview:shu3];
    
    UILabel *zuF=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(shu3.frame), CGRectGetMaxY(heng3.frame), PL_WIDTH/3, 30)];
    zuF.backgroundColor=[UIColor colorWithRed:170.0/255.0 green:170.0/255.0 blue:170.0/255.0 alpha:0.2];
    zuF.font=[UIFont systemFontOfSize:14];
    zuF.textAlignment=NSTextAlignmentCenter;
    zuF.text=@"赠送竞价币";
    [self.view addSubview:zuF];
    UIImageView *shu4=[[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(zuF.frame), CGRectGetMaxY(heng3.frame), 1, 60)];
    shu4.image=[UIImage imageNamed:@"heng_hui_duan.png"];
    [self.view addSubview:shu4];
    UILabel *price=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(shu4.frame), CGRectGetMaxY(heng3.frame), PL_WIDTH/3, 30)];
    price.backgroundColor=[UIColor colorWithRed:170.0/255.0 green:170.0/255.0 blue:170.0/255.0 alpha:0.2];
    price.font=[UIFont systemFontOfSize:14];
    price.textAlignment=NSTextAlignmentCenter;
    price.text=@"套餐价格(元/月)";
    [self.view addSubview:price];
    
    UIImageView *heng4=[[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(heng3.frame)+30, PL_WIDTH, 1)];
    heng4.image=[UIImage imageNamed:@"heng_hui_duan.png"];
    [self.view addSubview:heng4];
    
    UILabel *shouFNum=[[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(heng4.frame), PL_WIDTH/3, 30)];
    shouFNum.font=[UIFont systemFontOfSize:14];
    shouFNum.textAlignment=NSTextAlignmentCenter;
    shouFNum.text=[NSString stringWithFormat:@"%@",[_dict objectForKey:@"HRCount"]];
    [self.view addSubview:shouFNum];
    
    UILabel *zuFNum=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(shu3.frame), CGRectGetMaxY(heng4.frame), PL_WIDTH/3, 30)];
    zuFNum.font=[UIFont systemFontOfSize:14];
    zuFNum.textAlignment=NSTextAlignmentCenter;
    zuFNum.text=[NSString stringWithFormat:@"%@",[_dict objectForKey:@"PackagePresent"]];
    [self.view addSubview:zuFNum];
    
    UILabel *priceNum=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(shu4.frame), CGRectGetMaxY(heng4.frame), PL_WIDTH/3, 30)];
    priceNum.font=[UIFont systemFontOfSize:14];
    priceNum.textAlignment=NSTextAlignmentCenter;
    priceNum.text=[NSString stringWithFormat:@"%@",[_dict objectForKey:@"PackagePrice"]];
    [self.view addSubview:priceNum];
    UIImageView *heng5=[[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(heng4.frame)+30, PL_WIDTH, 1)];
    heng5.image=[UIImage imageNamed:@"heng_hui_duan.png"];
    [self.view addSubview:heng5];
    
    UILabel *renzheng=[[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(heng5.frame), PL_WIDTH, 30)];
    renzheng.text=@"刷新次数(次/天)";
    renzheng.font=[UIFont systemFontOfSize:14];
    renzheng.textAlignment=NSTextAlignmentCenter;
    renzheng.backgroundColor=[UIColor colorWithRed:170.0/255.0 green:170.0/255.0 blue:170.0/255.0 alpha:0.2];
    [self.view addSubview:renzheng];
    
    UIImageView *heng6=[[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(renzheng.frame), PL_WIDTH, 1)];
    heng6.image=[UIImage imageNamed:@"heng_hui_duan.png"];
    [self.view addSubview:heng6];
    
    UILabel *renzheng2=[[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(heng6.frame), PL_WIDTH, 30)];
    renzheng2.text=[NSString stringWithFormat:@"%@",[_dict objectForKey:@"HRRefreshCount"]];
    renzheng2.font=[UIFont systemFontOfSize:14];
    renzheng2.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:renzheng2];
    
    UIImageView *heng7=[[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(renzheng2.frame), PL_WIDTH, 1)];
    heng7.image=[UIImage imageNamed:@"heng_hui_duan.png"];
    [self.view addSubview:heng7];
    
    UILabel *miaoshu=[[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(heng7.frame), PL_WIDTH, 30)];
    miaoshu.text=@"服务内容描述";
    miaoshu.font=[UIFont systemFontOfSize:14];
    miaoshu.textAlignment=NSTextAlignmentCenter;
    miaoshu.backgroundColor=[UIColor colorWithRed:170.0/255.0 green:170.0/255.0 blue:170.0/255.0 alpha:0.2];
    [self.view addSubview:miaoshu];
    
    UIImageView *heng8=[[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(miaoshu.frame), PL_WIDTH, 1)];
    heng8.image=[UIImage imageNamed:@"heng_hui_duan.png"];
    [self.view addSubview:heng8];
    
    UILabel *miaoshu2=[[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(heng8.frame), PL_WIDTH-20, 60)];
    miaoshu2.text=[NSString stringWithFormat:@"%@",[_dict objectForKey:@"PackageRemark"]];
    miaoshu2.font=[UIFont systemFontOfSize:14];
    miaoshu2.numberOfLines=0;
    miaoshu2.textAlignment=NSTextAlignmentLeft;
    [self.view addSubview:miaoshu2];
    
   
    
    UIImageView *heng9=[[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(miaoshu2.frame), PL_WIDTH, 1)];
    heng9.image=[UIImage imageNamed:@"heng_hui_duan.png"];
    [self.view addSubview:heng9];
    
    gongfeiBtn=[[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMinX(miaoshu.frame)+40, CGRectGetMaxY(heng9.frame)+10, 20, 20)];
    [gongfeiBtn setImage:[UIImage imageNamed:@"radio-button_off33.png"] forState:UIControlStateNormal];
    [gongfeiBtn setImage:[UIImage imageNamed:@"radio-button_on33.png"] forState:UIControlStateSelected];
    [gongfeiBtn addTarget:self action:@selector(gongfeiBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:gongfeiBtn];
    
    UIButton *gongfeiBtn2=[[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(gongfeiBtn.frame)-15, CGRectGetMaxY(heng9.frame)+7, 90, 30)];
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
    
    UIButton *shenqing=[[UIButton alloc]initWithFrame:CGRectMake(PL_WIDTH/2, CGRectGetMaxY(heng9.frame), PL_WIDTH/2, 70)];
    shenqing.backgroundColor=[UIColor colorWithRed:12.0/255.0 green:136.0/255.0 blue:255.0/255.0 alpha:1];
    [shenqing setTitle:@"申请" forState:UIControlStateNormal];
    [shenqing setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [shenqing addTarget:self action:@selector(shenqingBtnClick) forControlEvents:UIControlEventTouchUpInside];
    shenqing.titleLabel.font=[UIFont systemFontOfSize:21];
    [self.view addSubview:shenqing];
    
    UIImageView *heng10=[[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(zifeiBtn.frame)+10, PL_WIDTH, 1)];
    heng10.image=[UIImage imageNamed:@"heng_hui_duan.png"];
    [self.view addSubview:heng10];
    
    */
    
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
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;
{
    if (buttonIndex==1) {
        WebData *web=[[WebData alloc]init];
        web.WebName=@"赶集网";
        if (gongfeiBtn.selected) {
            web.RegisterType=@"0";
        }
        if (zifeiBtn.selected) {
            web.RegisterType=@"1";
        }
        if (_dict==nil&&_dict2!=nil) {
            web.PackageID=[_dict2 objectForKey:@"PackageID"];
            web.PackagePrice=[_dict2 objectForKey:@"PackagePrice"];
            web.PackageType=[_dict2 objectForKey:@"PackageType"];
        }
        else if (_dict!=nil&&_dict2==nil)
        {
            web.PackageID=[_dict objectForKey:@"PackageID"];
            web.PackagePrice=[_dict objectForKey:@"PackagePrice"];
            web.PackageType=[_dict objectForKey:@"PackageType"];
        }
        else if (_dict!=nil&&_dict2!=nil)
        {
            web.PackageID=[NSString stringWithFormat:@"%@,%@",[_dict objectForKey:@"PackageID"],[_dict2 objectForKey:@"PackageID"]];
            web.PackagePrice=[NSString stringWithFormat:@"%@,%@",[_dict objectForKey:@"PackagePrice"],[_dict2 objectForKey:@"PackagePrice"]];
            web.PackageType=[NSString stringWithFormat:@"%@,%@",[_dict objectForKey:@"PackageType"],[_dict2 objectForKey:@"PackageType"]];
        }
        
        
        web.userid=[[NSUserDefaults standardUserDefaults]objectForKey:PL_USER_NAME];
        web.token=[[NSUserDefaults standardUserDefaults]objectForKey:PL_USER_TOKEN];
        NSLog(@"%@  %@  %@  %@  %@  %@",web.WebName,web.RegisterType,web.PackageID,web.PackagePrice,web.userid,web.token);
        PL_PROGRESS_SHOW;
        [[MyRequest defaultsRequest]setApplication:web backInfoMessage:^(NSMutableString *string) {
            NSLog(@"%@",string);
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
            PL_PROGRESS_DISMISS;
        }];
    }
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

@end
