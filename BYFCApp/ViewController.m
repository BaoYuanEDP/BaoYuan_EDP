//
//  ViewController.m
//  BYFCApp
//
//  Created by PengLee on 14/12/2.
//  Copyright (c) 2014年 PengLee. All rights reserved.
//

#import "ViewController.h"
#import "PL_Header.h"
#import "UMessage.h"

@interface ViewController ()<UITextFieldDelegate,PersonDelegate>
{
    BOOL isClick;
    UITextField *nameTF;
    UITextField *pswTF;
    UIButton * REpsw;
}

@end

@implementation ViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    
    isClick=[[[NSUserDefaults standardUserDefaults]objectForKey:@"isRecord"] boolValue];
    if (isClick==1) {
        REpsw.selected=YES;
        nameTF.text=[[NSUserDefaults standardUserDefaults]objectForKey:@"userName"];
        pswTF.text=[[NSUserDefaults standardUserDefaults]objectForKey:@"passWord"];
    }
    else
    {
        REpsw.selected=NO;
        nameTF.text=[[NSUserDefaults standardUserDefaults]objectForKey:@"userName"];
        pswTF.text=@"";
    }
   // [MyRequest defaultsRequest].delegate = self;
    
}
- (void)viewAnimation:(NSNotification *)note
{
    UIView * fview = [self.view firstResponder];
    
    CGFloat fy = CGRectGetMaxY(fview.frame);
    NSDictionary * dict = note.userInfo;
    CGRect endFrame = [[dict objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat delta = endFrame.origin.y - fy-60;
    if (delta <0)
    {
        [UIView animateWithDuration:0.25 animations:^{
            self.view.center = CGPointMake(self.view.center.x, self.view.center.y+delta);
        }];
        
        
        
    }
    else
    {
        [UIView animateWithDuration:0.25 animations:^{
            self.view.center = CGPointMake(self.view.center.x, self.view.bounds.size.height/2);
            
        }];
        
        
    }

}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(viewAnimation:) name:UIKeyboardWillChangeFrameNotification object:nil];
    nameArray=[NSArray arrayWithObjects:@"baihh01",@"jiangdong01",@"chenming03",@"luob02",@"xiangyc01",@"mengqh",@"shenyan02",@"guifang01",@"liangyc01",@"liuyue",@"zhubin02",@"chenhy04",@"jianggp",@"janeshih",@"xuxiang05",@"wanghui03",@"chenxh010",@"liull03",@"chenhy04",@"yangrong01",@"xiaolin1",@"shangxy01",@"chenhj03",@"chenbin02",@"zhaoqq01",@"jianglw01",@"lijq03",@"sunfeng03",@"zhengjy03",@"hanwj03",@"fujun1",@"huanghui03",@"ligc03",@"chengj05",@"yejf05",@"gaofei07",@"wudd05",@"xujun08",@"lingyang08",@"zhuyu05",@"sunying05",@"sunsy01",@"zhaomy1",@"linhy2",@"shenjie1",@"luomin2", nil];
    self.view.backgroundColor=[UIColor colorWithRed:237.0/255.0 green:237.0/255.0 blue:237.0/255.0 alpha:1];
    //675  * 375
    float cenyerX=self.view.center.x;
    UIButton * btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn1 setBackgroundImage:[UIImage imageNamed:@"logo.png"] forState:UIControlStateNormal];
    btn1.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:btn1];
    CGFloat margin = 60;
    NSLayoutConstraint * layLefy = [NSLayoutConstraint constraintWithItem:btn1 attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:cenyerX-margin/2];
    [self.view addConstraint:layLefy];
    NSLayoutConstraint * layTop = [NSLayoutConstraint constraintWithItem:btn1 attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:PL_HEIGHT/10];
    [self.view addConstraint:layTop];
    NSLayoutConstraint * layHeight = [NSLayoutConstraint constraintWithItem:btn1 attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:margin+5];
    [btn1 addConstraint:layHeight];
    NSLayoutConstraint * layWidth = [NSLayoutConstraint constraintWithItem:btn1 attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:margin];
    [btn1 addConstraint:layWidth];
    //宝原智汇标签
    UILabel *label1=[[UILabel alloc]init];
    label1.text=@"EDP";
    label1.textAlignment=NSTextAlignmentCenter;
    label1.translatesAutoresizingMaskIntoConstraints=NO;
    label1.font=[UIFont systemFontOfSize:15];
    [self.view addSubview:label1];
    NSLayoutConstraint * layLeftL1 = [NSLayoutConstraint constraintWithItem:label1 attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:cenyerX-margin/2-20];
    [self.view addConstraint:layLeftL1];
    NSLayoutConstraint * layTopL1 = [NSLayoutConstraint constraintWithItem:label1 attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:PL_HEIGHT/5+30];
    [self.view addConstraint:layTopL1];
    NSLayoutConstraint * layHeightL1 = [NSLayoutConstraint constraintWithItem:label1 attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:30];
    [label1 addConstraint:layHeightL1];
    NSLayoutConstraint * layWidthL1 = [NSLayoutConstraint constraintWithItem:label1 attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:100];
    [label1 addConstraint:layWidthL1];
    //移动业务版
    UILabel *label2=[[UILabel alloc]init];
    label2.text=@"";
    label2.textColor=[UIColor grayColor];
    label2.textAlignment=NSTextAlignmentCenter;
    label2.translatesAutoresizingMaskIntoConstraints=NO;
    label2.font=[UIFont systemFontOfSize:12];
    [self.view addSubview:label2];
    NSLayoutConstraint * layLeftL2 = [NSLayoutConstraint constraintWithItem:label2 attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:cenyerX-margin/2-20];
    [self.view addConstraint:layLeftL2];
    NSLayoutConstraint * layTopL2 = [NSLayoutConstraint constraintWithItem:label2 attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:PL_HEIGHT/5+30+20];
    [self.view addConstraint:layTopL2];
    NSLayoutConstraint * layHeightL2 = [NSLayoutConstraint constraintWithItem:label2 attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:30];
    [label2 addConstraint:layHeightL2];
    NSLayoutConstraint * layWidthL2 = [NSLayoutConstraint constraintWithItem:label2 attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:100];
    [label2 addConstraint:layWidthL2];
    //账号密码
    view=[[UIView alloc]init];
    view.backgroundColor=[UIColor whiteColor];
    view.translatesAutoresizingMaskIntoConstraints=NO;
    [self.view addSubview:view];
    NSLayoutConstraint * layLeftV = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
    [self.view addConstraint:layLeftV];
    NSLayoutConstraint * layTopV = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:PL_HEIGHT/5+30+20+30+10];
    [self.view addConstraint:layTopV];
    NSLayoutConstraint * layHeightV = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:88];
    [view addConstraint:layHeightV];
    NSLayoutConstraint * layWidthV = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:PL_WIDTH];
    [view addConstraint:layWidthV];
    
    UIImageView *lineImage=[[UIImageView alloc]initWithFrame:CGRectMake(10, 43, PL_WIDTH-20, 1)];
    lineImage.image=[UIImage imageNamed:@"heng.png"];
    [view addSubview:lineImage];
    
    nameTF=[[UITextField alloc]initWithFrame:CGRectMake(20, 0, PL_WIDTH, 44)];
    nameTF.leftView=[[UIView alloc]initWithFrame:CGRectMake(0, 5, 40, 20)];
    UIImageView *imageView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"rentou.png"]];
    imageView.frame=CGRectMake(0, 0, 20, 20);
    nameTF.placeholder=@"请输入用户名";
    [nameTF.leftView addSubview:imageView];
    nameTF.leftViewMode = UITextFieldViewModeAlways;
    [view addSubview:nameTF];
    
        pswTF=[[UITextField alloc]initWithFrame:CGRectMake(20, 44, PL_WIDTH, 44)];
    pswTF.leftView=[[UIView alloc]initWithFrame:CGRectMake(0, 49, 40, 20)];
    UIImageView *pswImg=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"suo.png"]];
    pswImg.frame=CGRectMake(0, 0, 20, 20);
    pswTF.placeholder=@"请输入密码";
    pswTF.secureTextEntry=YES;
    [pswTF.leftView addSubview:pswImg];
    pswTF.leftViewMode=UITextFieldViewModeAlways;
    [view addSubview:pswTF];
    //记住密码
    REpsw = [UIButton buttonWithType:UIButtonTypeCustom];
    [REpsw setBackgroundImage:[UIImage imageNamed:@"booleFalse.png"] forState:UIControlStateNormal];
    [REpsw setBackgroundImage:[UIImage imageNamed:@"booleTrue.png"] forState:UIControlStateSelected];
    [REpsw addTarget:self action:@selector(rememberClick:) forControlEvents:UIControlEventTouchUpInside];
    REpsw.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:REpsw];
    NSLayoutConstraint * layLeftREpsw = [NSLayoutConstraint constraintWithItem:REpsw attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:PL_WIDTH-80-2];
    [self.view addConstraint:layLeftREpsw];
    NSLayoutConstraint * layTopREpsw = [NSLayoutConstraint constraintWithItem:REpsw attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:PL_HEIGHT/5+30+20+30+10+88+10+10-2-2];
    [self.view addConstraint:layTopREpsw];
    NSLayoutConstraint * layHeightREpsw = [NSLayoutConstraint constraintWithItem:REpsw attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:20];
    [REpsw addConstraint:layHeightREpsw];
    NSLayoutConstraint * layWidthREpsw = [NSLayoutConstraint constraintWithItem:REpsw attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:20];
    [REpsw addConstraint:layWidthREpsw];
    //记住密码标签
    UILabel * REpswL = [[UILabel alloc]init];
    REpswL.text=@"记住密码";
    REpswL.font=[UIFont systemFontOfSize:13];
    REpswL.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:REpswL];
    

    
    NSLayoutConstraint * layLeftREpswL = [NSLayoutConstraint constraintWithItem:REpswL attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:PL_WIDTH-80+20];
    [self.view addConstraint:layLeftREpswL];
    NSLayoutConstraint * layTopREpswL = [NSLayoutConstraint constraintWithItem:REpswL attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:PL_HEIGHT/5+30+20+30+10+88+10+10];
    [self.view addConstraint:layTopREpswL];
    NSLayoutConstraint * layHeightREpswL = [NSLayoutConstraint constraintWithItem:REpswL attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:13];
    [REpswL addConstraint:layHeightREpswL];
    NSLayoutConstraint * layWidthREpswL = [NSLayoutConstraint constraintWithItem:REpswL attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:100];
    [REpswL addConstraint:layWidthREpswL];
    
    
    
    //登陆按钮
    UIButton * login = [UIButton buttonWithType:UIButtonTypeCustom];
    [login setBackgroundImage:[UIImage imageNamed:@"login_button_1.png"] forState:UIControlStateNormal];
    [login setTitle:@"登录" forState:UIControlStateNormal];
    [login setTitle:@"正在登录..." forState:UIControlStateSelected];
    login.titleLabel.font=[UIFont systemFontOfSize:20];
    login.translatesAutoresizingMaskIntoConstraints = NO;
    [login addTarget:self action:@selector(loginButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:login];
    NSLayoutConstraint * layLeftLogin = [NSLayoutConstraint constraintWithItem:login attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:10];
    [self.view addConstraint:layLeftLogin];
    NSLayoutConstraint * layTopLogin = [NSLayoutConstraint constraintWithItem:login attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:PL_HEIGHT/5+30+20+30+10+40+88+10];
    [self.view addConstraint:layTopLogin];
    NSLayoutConstraint * layHeightLogin = [NSLayoutConstraint constraintWithItem:login attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:40];
    [login addConstraint:layHeightLogin];
    NSLayoutConstraint * layWidthLogin = [NSLayoutConstraint constraintWithItem:login attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:PL_WIDTH-20];
    [login addConstraint:layWidthLogin];
    //忘记密码
    UIButton * pswBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [pswBtn1 setTitle:@"忘记密码" forState:UIControlStateNormal];
    pswBtn1.tag=1000;
    [pswBtn1 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [pswBtn1 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    pswBtn1.titleLabel.font=[UIFont systemFontOfSize:13];
    pswBtn1.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:pswBtn1];
    NSLayoutConstraint * layLeftPB1 = [NSLayoutConstraint constraintWithItem:pswBtn1 attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:10];
    [self.view addConstraint:layLeftPB1];
    NSLayoutConstraint * layTopPB1 = [NSLayoutConstraint constraintWithItem:pswBtn1 attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:PL_HEIGHT/5+30+20+30+10+40+88+100+30];
    [self.view addConstraint:layTopPB1];
    NSLayoutConstraint * layHeightPB1 = [NSLayoutConstraint constraintWithItem:pswBtn1 attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:20];
    [pswBtn1 addConstraint:layHeightPB1];
    NSLayoutConstraint * layWidthPB1 = [NSLayoutConstraint constraintWithItem:pswBtn1 attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:60];
    [pswBtn1 addConstraint:layWidthPB1];
    //分割线
    
    UIImageView * shuImage=[[UIImageView alloc]init];
    shuImage.backgroundColor=[UIColor redColor];
    //shuImage.image=[UIImage imageNamed:@"hengxian.png"];
   // shuImage.backgroundColor=[UIColor blackColor];
    [self.view addSubview:shuImage];
    NSLayoutConstraint * layLeftImg = [NSLayoutConstraint constraintWithItem:shuImage attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:10+70];
    [self.view addConstraint:layLeftImg];
    NSLayoutConstraint * layTopImg = [NSLayoutConstraint constraintWithItem:shuImage attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:PL_HEIGHT/5+30+20+30+10+40+88+100+30];
    [self.view addConstraint:layTopImg];
    NSLayoutConstraint * layHeightImg = [NSLayoutConstraint constraintWithItem:shuImage attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:20];
    [shuImage addConstraint:layHeightImg];
    NSLayoutConstraint * layWidthImg = [NSLayoutConstraint constraintWithItem:shuImage attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:2];
    [shuImage addConstraint:layWidthImg];
    
    //修改密码
    UIButton * pswBtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [pswBtn2 setTitle:@"修改密码" forState:UIControlStateNormal];
    pswBtn2.tag=1001;
    [pswBtn2 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [pswBtn2 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    pswBtn2.titleLabel.font=[UIFont systemFontOfSize:13];
    pswBtn2.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:pswBtn2];
    NSLayoutConstraint * layLeftPB2 = [NSLayoutConstraint constraintWithItem:pswBtn2 attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:70];
    [self.view addConstraint:layLeftPB2];
    NSLayoutConstraint * layTopPB2 = [NSLayoutConstraint constraintWithItem:pswBtn2 attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:PL_HEIGHT/5+30+20+30+10+40+88+100+30];
    [self.view addConstraint:layTopPB2];
    NSLayoutConstraint * layHeightPB2 = [NSLayoutConstraint constraintWithItem:pswBtn2 attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:20];
    [pswBtn2 addConstraint:layHeightPB2];
    NSLayoutConstraint * layWidthPB2 = [NSLayoutConstraint constraintWithItem:pswBtn2 attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:60];
    [pswBtn2 addConstraint:layWidthPB2];
    //联系我们
    UIButton * tellUs = [UIButton buttonWithType:UIButtonTypeCustom];
    [tellUs setTitle:@"联系我们" forState:UIControlStateNormal];
    tellUs.tag=1002;
    [tellUs addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [tellUs setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    tellUs.titleLabel.font=[UIFont systemFontOfSize:13];
    tellUs.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:tellUs];
    NSLayoutConstraint * layLefttell = [NSLayoutConstraint constraintWithItem:tellUs attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:PL_WIDTH-120-10];
    [self.view addConstraint:layLefttell ];
    NSLayoutConstraint * layToptell  = [NSLayoutConstraint constraintWithItem:tellUs attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:PL_HEIGHT/5+30+20+30+10+40+88+100+30];
    [self.view addConstraint:layToptell ];
    NSLayoutConstraint * layHeighttell  = [NSLayoutConstraint constraintWithItem:tellUs attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:20];
    [tellUs addConstraint:layHeighttell ];
    NSLayoutConstraint * layWidthtell  = [NSLayoutConstraint constraintWithItem:tellUs attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:60];
    [tellUs addConstraint:layWidthtell ];
    //反馈意见
    UIButton * back = [UIButton buttonWithType:UIButtonTypeCustom];
    [back setTitle:@"反馈意见" forState:UIControlStateNormal];
    back.tag=1003;
    [back addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [back setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    back.titleLabel.font=[UIFont systemFontOfSize:13];
    back.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:back];
    NSLayoutConstraint * layLeftback = [NSLayoutConstraint constraintWithItem:back attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:PL_WIDTH-70];
    [self.view addConstraint:layLeftback ];
    NSLayoutConstraint * layTopback  = [NSLayoutConstraint constraintWithItem:back attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:PL_HEIGHT/5+30+20+30+10+40+88+100+30];
    [self.view addConstraint:layTopback ];
    NSLayoutConstraint * layHeightback  = [NSLayoutConstraint constraintWithItem:back attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:20];
    [back addConstraint:layHeightback ];
    NSLayoutConstraint * layWidthback = [NSLayoutConstraint constraintWithItem:back attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:60];
    [back addConstraint:layWidthback ];
    
   // MyRequest * del = [MyRequest defaultsRequest];
   // del.delegate = self;
    //self.view.backgroundColor = [UIColor whiteColor];
    
}
//记住密码
-(void)rememberClick:(UIButton *)sender
{
    sender.selected=!sender.selected;
    if (sender.selected) {
        isClick=YES;
        
    }else
    {
        isClick=NO;
    }
}
-(void)compareResults:(NSMutableString *)string  dict:(NSDictionary *)dictonry

{
    NSLog(@"%@  --- %@",string ,dictonry);
    
}

#pragma mark --LOGIN
- (void)loginButton:(UIButton *)sender
{
    
    //sender.selected=YES;
    //判断用户名不为空
    if (nameTF.text&& pswTF.text  &&  nameTF.text !=nil && pswTF.text !=nil && ![nameTF.text isEqualToString:@""] && ![pswTF.text isEqualToString:@""] && isClick==YES)
    {
        sender.selected=YES;
        [[MyRequest defaultsRequest]getWebServiceData:^(NSMutableString *string){
            currentStr=string;
            

              //[[ShowActivityLoad shareDefault]dismissProgress];
        SBJSON * json = [[SBJSON alloc]init];
        NSDictionary * dict = [json objectWithString:string error:nil  ];
               if (dict && dict != nil)
            {
               
                
                [PL_USER_STORAGE setObject:nameTF.text forKey:PL_USER_NAME];
               // [PL_USER_STORAGE setValue:dict[@"UserId"] forKey:PL_USER_USERID];
                [PL_USER_STORAGE setObject:pswTF.text forKey:PL_USER_PASSWORD];
                [PL_USER_STORAGE setObject:[NSString stringWithFormat:@"%d",isClick] forKey:PL_USER_COOKIES];
                [PL_USER_STORAGE setObject:[NSString stringWithFormat:@"%@",dict[@"UserCode"]] forKey:PL_USER_code];
                
                NSLog(@"+++++++++++++++++++++++++++++%@",dict);
                //获取请求下来的token
                NSString * string =[dict objectForKey:PL_USER_TOKEN];
                //NSLog(@"TOKEN==%@",string);
                [[NSUserDefaults standardUserDefaults]setValue:[dict objectForKey:@"DutyTypeName"] forKey:@"DutyTypeName"];
                [PL_USER_STORAGE setObject:string forKey:PL_USER_TOKEN];
                [PL_USER_STORAGE setObject:[NSDate date] forKey:@"date"];
                [PL_USER_STORAGE setObject:[dict objectForKey:@"UserName"] forKey:@"UserName"];
                [ PL_USER_STORAGE setObject:dict[@"User_Phone"] forKey:PL_USER_PHONEnUM];
                [PL_USER_STORAGE setObject:[dict objectForKey:@"EncodeUserCode"] forKey:@"encode"];
                [PL_USER_STORAGE setObject:dict[PL_USER_UNITFULLCODE] forKey:PL_USER_UNITFULLCODE];
                [PL_USER_STORAGE synchronize];
                // NSLog(@"  密码 已经记录 了  is  %d",isClick);
                NSLog(@"DENGLU 手势解锁界面");
                //PL_ALERTVIEW_SHOW(@"进入手势解锁界面");
                GesturePasswordController *gesture=[[GesturePasswordController alloc]init];
                //[self.navigationController pushViewController:gesture animated:YES];
                [self presentViewController:gesture animated:YES completion:nil];
                MainViewController *main=[[MainViewController alloc]init];
                [self.navigationController pushViewController:main animated:YES];
                
            }
            else if ([currentStr isEqualToString:@"NotLogin"])
            {
                PL_ALERTVIEW_SHOW(@"该账号不存在");
                sender.selected=NO;
            }
            else
            {
                NSLog(@"不能登录");
                PL_ALERTVIEW_SHOW(@"用户名或者密码错误");
                sender.selected=NO;
            }
            
        } userName:nameTF.text userPass:pswTF.text];
        
    }
       //  }
    else  if(nameTF.text&& pswTF.text  &&  nameTF.text !=nil && pswTF.text !=nil && ![nameTF.text isEqualToString:@""] && ![pswTF.text isEqualToString:@""] && isClick == NO)
    {
        sender.selected=YES;
        NSString *str = [PL_USER_STORAGE objectForKey:PL_USER_code];
        [UMessage removeTag:str
                   response:^(id responseObject, NSInteger remain, NSError *error) {
                       //add your codes
                   }];
        [[MyRequest defaultsRequest]getWebServiceData:^(NSMutableString *string) {


            SBJSON *json=[[SBJSON alloc]init];
            NSDictionary *dict=[json objectWithString:string error:nil];


            if (dict && dict != nil)
            {
                 NSLog(@"====================== %@==================",dict[@"UserCode"]);
                
                [PL_USER_STORAGE setObject:nameTF.text forKey:PL_USER_NAME];
                [PL_USER_STORAGE setObject:pswTF.text forKey:PL_USER_PASSWORD];
                [PL_USER_STORAGE setObject:[NSString stringWithFormat:@"%d",isClick] forKey:PL_USER_COOKIES];
                [PL_USER_STORAGE setObject:[dict objectForKey:@"DutyCodeIsE"] forKey:PL_USER_DutyCodeIsE];
                NSLog(@"********%@",dict[@"DutyCodeIsE"]);
                [PL_USER_STORAGE setObject:[dict objectForKey:@"UserName"] forKey:@"UserName"];
                [PL_USER_STORAGE setObject:[dict objectForKey:@"UserCode"] forKey:@"UserCode"];
               
                 [PL_USER_STORAGE setObject:[NSString stringWithFormat:@"%@",dict[@"UserCode"]] forKey:PL_USER_code];
                //获取请求下来的token
                NSString * string =[dict objectForKey:PL_USER_TOKEN];
                
                NSLog(@"dict=%@",dict[@"User_Phone"]);
               NSLog(@"TOKEN==%@",string);
                  [[NSUserDefaults standardUserDefaults]setValue:[dict objectForKey:@"DutyTypeName"] forKey:@"DutyTypeName"];
                [PL_USER_STORAGE setObject:string forKey:PL_USER_TOKEN];
                [PL_USER_STORAGE setObject:[dict objectForKey:PL_USER_USERID] forKey:PL_USER_USERID];
                  [ PL_USER_STORAGE setObject:dict[@"User_Phone"] forKey:PL_USER_PHONEnUM];
                [PL_USER_STORAGE setObject:dict[PL_USER_DUTYCODE] forKey:PL_USER_DUTYCODE];
                [PL_USER_STORAGE setObject:dict[PL_USER_UNITFULLCODE] forKey:PL_USER_UNITFULLCODE];
                NSLog(@"Duty code === %@",[PL_USER_STORAGE objectForKey:PL_USER_DUTYCODE]);
                [PL_USER_STORAGE synchronize];
                //    添加友盟标签
                NSString *str = [PL_USER_STORAGE objectForKey:PL_USER_code];
                [UMessage addTag:str
                        response:^(id responseObject, NSInteger remain, NSError *error) {
                        }];
                //  NSLog(@"  密码 已经记录 了  is  %d",isClick);
                //  NSLog(@"进入主界面");
                //  PL_ALERTVIEW_SHOW(@"进入主界面");
                [self getSupCode];
                MainViewController *main=[[MainViewController alloc]init];
                [self.navigationController pushViewController:main animated:YES];
            }
            else if ([currentStr isEqualToString:@"NotLogin"])
            {
                PL_ALERTVIEW_SHOW(@"该账号不存在");
                sender.selected=NO;
            }
            else
            {
                //NSLog(@"登录错误");
                PL_ALERTVIEW_SHOW(@"用户名或者密码错误");
                sender.selected=NO;
            }
            
        } userName:nameTF.text userPass:pswTF.text];
    }
    else
    {
        PL_ALERTVIEW_SHOW(@"用户名或者密码错误");
        
    }
}
-(void)getSupCode
{
    NSLog(@"%s",__FUNCTION__);
    PL_PROGRESS_SHOW;
    [[MyRequest defaultsRequest]afGetSupFromUserCode:[PL_USER_STORAGE objectForKey:PL_USER_USERID] userToken:[PL_USER_STORAGE objectForKey:PL_USER_TOKEN] completeBack:^(NSString *str) {
        [PL_USER_STORAGE setObject:str forKey:PL_USER_SUPCODE];
        [PL_USER_STORAGE synchronize];
        NSLog(@"supcode%@",[PL_USER_STORAGE objectForKey:PL_USER_SUPCODE]);
        PL_PROGRESS_DISMISS;
        
    }];
}
-(void)btnClick:(UIButton *)sender
{
    switch (sender.tag) {
        case 1000:
        {
        
            NSLog(@"忘记密码");
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"IT运营保修台" message:@"60177999" delegate:self cancelButtonTitle:@"确定拨打" otherButtonTitles:@"取消", nil];
            [alert show];
            
        }
            break;
        case 1001:
        {
            NSLog(@"修改密码");
            PSWResetViewController *pswreset=[[PSWResetViewController alloc]init];
            [self.navigationController pushViewController:pswreset animated:YES];
        }
            break;
        case 1002:
        {
    
            NSLog(@"联系我们");
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"IT运营保修台" message:@"02160177999" delegate:self cancelButtonTitle:@"确定拨打" otherButtonTitles:@"取消", nil];
            [alert show];
            
        }
            break;
        case 1003:
        {
            NSLog(@"反馈意见");
            PL_ALERT_SHOW(@"此功能敬请期待");
        }
            break;
            
        default:
            break;
    }
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0) {
        UIWebView*callWebview =[[UIWebView alloc] init];
        NSURL *telURL =[NSURL URLWithString:@"tel:60177999"];
        [callWebview loadRequest:[NSURLRequest requestWithURL:telURL]];
        //记得添加到view上
        [self.view addSubview:callWebview];
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [nameTF resignFirstResponder];
    [pswTF resignFirstResponder];
}


@end
