//
//  PSWResetViewController.m
//  BYFCApp
//
//  Created by zzs on 14/12/9.
//  Copyright (c) 2014年 PengLee. All rights reserved.
//

#import "PSWResetViewController.h"
#import "PL_Header.h"

@interface PSWResetViewController ()

@end

@implementation PSWResetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"修改密码";
//    UIBarButtonItem *left=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back.png"] style:UIBarButtonItemStylePlain target:self action:@selector(backBtn)];
//    self.navigationController.navigationBar.tintColor=[UIColor colorWithRed:237.0/255.0 green:237.0/255.0 blue:237.0/255.0 alpha:1];
//     self.navigationItem.leftBarButtonItem=left;
    self.navigationController.navigationBarHidden=NO;
    UIButton * backItemBnt = [UIButton buttonWithType:UIButtonTypeCustom];
    backItemBnt.frame = CGRectMake(20, 10, 10, 20);
    [backItemBnt setBackgroundImage:[UIImage imageNamed:@"返回.png"] forState:UIControlStateNormal];
    [backItemBnt addTarget:self action:@selector(backBtn) forControlEvents:UIControlEventTouchUpInside];
    // [navView addSubview:backItemBnt];
    
    UIBarButtonItem * leftBtn = [[UIBarButtonItem alloc]initWithCustomView:backItemBnt];
    self.navigationItem.leftBarButtonItem = leftBtn;
    
    self.view.backgroundColor=[UIColor colorWithRed:237.0/255.0 green:237.0/255.0 blue:237.0/255.0 alpha:1];
    //675  * 375
    UIButton * btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn1 setBackgroundImage:[UIImage imageNamed:@"logo.png"] forState:UIControlStateNormal];
    btn1.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:btn1];
    CGFloat margin = 60;
    NSLayoutConstraint * layLefy = [NSLayoutConstraint constraintWithItem:btn1 attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:PL_WIDTH/2-30];
    [self.view addConstraint:layLefy];
    NSLayoutConstraint * layTop = [NSLayoutConstraint constraintWithItem:btn1 attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:PL_HEIGHT/10+50];
    [self.view addConstraint:layTop];
    NSLayoutConstraint * layHeight = [NSLayoutConstraint constraintWithItem:btn1 attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:margin+5];
    [btn1 addConstraint:layHeight];
    NSLayoutConstraint * layWidth = [NSLayoutConstraint constraintWithItem:btn1 attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:margin];
    [btn1 addConstraint:layWidth];
    //账号密码
    UIView *view=[[UIView alloc]init];
    view.backgroundColor=[UIColor whiteColor];
    view.translatesAutoresizingMaskIntoConstraints=NO;
    [self.view addSubview:view];
    NSLayoutConstraint * layLeftV = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
    [self.view addConstraint:layLeftV];
    NSLayoutConstraint * layTopV = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:PL_HEIGHT/5+30+20+30+10];
    [self.view addConstraint:layTopV];
    NSLayoutConstraint * layHeightV = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:88+44];
    [view addConstraint:layHeightV];
    NSLayoutConstraint * layWidthV = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:PL_WIDTH];
    [view addConstraint:layWidthV];
    
    UIImageView *lineImage1=[[UIImageView alloc]initWithFrame:CGRectMake(10, 43, PL_WIDTH-20, 1)];
    lineImage1.image=[UIImage imageNamed:@"heng.png"];
    [view addSubview:lineImage1];
    UIImageView *lineImage=[[UIImageView alloc]initWithFrame:CGRectMake(10, 43+44, PL_WIDTH-20, 1)];
    lineImage.image=[UIImage imageNamed:@"heng.png"];
    [view addSubview:lineImage];
    //密码输入框
    oldPsw=[[UITextField alloc]initWithFrame:CGRectMake(20, 0, PL_WIDTH, 44)];
    oldPsw.leftView=[[UIView alloc]initWithFrame:CGRectMake(0, 5, 80, 20)];
    UILabel *oldLab=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 70, 20)];
    oldLab.text=@"原始密码:";
    oldPsw.delegate=self;
    oldLab.font=[UIFont systemFontOfSize:14];
    oldLab.textColor=[UIColor grayColor];
    [oldPsw.leftView addSubview:oldLab];
    oldPsw.leftViewMode = UITextFieldViewModeAlways;
    [view addSubview:oldPsw];
    
    newPsw=[[UITextField alloc]initWithFrame:CGRectMake(20, 44, PL_WIDTH, 44)];
    newPsw.leftView=[[UIView alloc]initWithFrame:CGRectMake(0, 49, 80, 20)];
    UILabel *newLab=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 70, 20)];
    newLab.text=@" 新 密 码:";
    newPsw.delegate=self;
    newLab.font=[UIFont systemFontOfSize:14];
    newLab.textColor=[UIColor grayColor];
    [newPsw.leftView addSubview:newLab];
    newPsw.secureTextEntry=YES;
    [newPsw.leftView addSubview:newPsw];
    newPsw.leftViewMode=UITextFieldViewModeAlways;
    [view addSubview:newPsw];
    
    newPsw2=[[UITextField alloc]initWithFrame:CGRectMake(20, 44+44, PL_WIDTH, 44)];
    newPsw2.delegate=self;
    newPsw2.leftView=[[UIView alloc]initWithFrame:CGRectMake(0, 49+44, 80, 20)];
    
    UILabel *newLab2=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 70, 20)];
    newLab2.text=@"确认密码:";
    newLab2.font=[UIFont systemFontOfSize:14];
    newLab2.textColor=[UIColor grayColor];
    [newPsw2.leftView addSubview:newLab2];
    newPsw2.secureTextEntry=YES;
    [newPsw2.leftView addSubview:newPsw2];
    newPsw2.leftViewMode=UITextFieldViewModeAlways;
    [view addSubview:newPsw2];
    
    //sure
    UIButton * sure = [UIButton buttonWithType:UIButtonTypeCustom];
    [sure setBackgroundImage:[UIImage imageNamed:@"fanhui.png"] forState:UIControlStateNormal];
    sure.translatesAutoresizingMaskIntoConstraints = NO;
    [sure addTarget:self action:@selector(returnBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sure];
    NSLayoutConstraint * layLeftsure = [NSLayoutConstraint constraintWithItem:sure attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:20];
    [self.view addConstraint:layLeftsure];
    NSLayoutConstraint * layTopsure = [NSLayoutConstraint constraintWithItem:sure attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:PL_HEIGHT/5+30+20+30+10+40+88+10+50];
    [self.view addConstraint:layTopsure];
    NSLayoutConstraint * layHeightsure = [NSLayoutConstraint constraintWithItem:sure attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:40];
    [sure addConstraint:layHeightsure];
    NSLayoutConstraint * layWidthsure = [NSLayoutConstraint constraintWithItem:sure attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:PL_WIDTH/3];
    [sure addConstraint:layWidthsure];
    
    //cancle
    UIButton * returnBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [returnBtn setBackgroundImage:[UIImage imageNamed:@"queding.png"] forState:UIControlStateNormal];
    returnBtn.translatesAutoresizingMaskIntoConstraints = NO;
    [returnBtn addTarget:self action:@selector(sureButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:returnBtn];
    NSLayoutConstraint * layLeftreturnBtn = [NSLayoutConstraint constraintWithItem:returnBtn attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:PL_WIDTH-20-PL_WIDTH/3];
    [self.view addConstraint:layLeftreturnBtn];
    NSLayoutConstraint * layTopreturnBtn = [NSLayoutConstraint constraintWithItem:returnBtn attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:PL_HEIGHT/5+30+20+30+10+40+88+10+50];
    [self.view addConstraint:layTopreturnBtn];
    NSLayoutConstraint * layHeightreturnBtn = [NSLayoutConstraint constraintWithItem:returnBtn attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:40];
    [returnBtn addConstraint:layHeightreturnBtn];
    NSLayoutConstraint * layWidthreturnBtn = [NSLayoutConstraint constraintWithItem:returnBtn attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:PL_WIDTH/3];
    [returnBtn addConstraint:layWidthreturnBtn];
}
-(void)sureButton
{
    if (![oldPsw.text isEqualToString:[[NSUserDefaults standardUserDefaults]objectForKey:PL_USER_PASSWORD]]) {
        PL_ALERTVIEW_SHOW(@"原始密码错误");
    }
    else if (![newPsw2.text isEqualToString:newPsw.text]){
        PL_ALERTVIEW_SHOW(@"新密码与确认密码不一致");
    }
    if([oldPsw.text isEqualToString:[[NSUserDefaults standardUserDefaults]objectForKey:PL_USER_PASSWORD]]&&[newPsw2.text isEqualToString:newPsw.text]){
        [[MyRequest defaultsRequest]changePassWord:^(NSMutableString *string) {
            NSLog(@"%@",string);
        } userid:[[NSUserDefaults standardUserDefaults]objectForKey:PL_USER_NAME] userPass:[[NSUserDefaults standardUserDefaults]objectForKey:PL_USER_PASSWORD] token:[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"] NewPwd:newPsw.text];
    }
}
-(void)returnBtn
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)backBtn
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    //创建一个线程用来延迟视图上弹
    NSThread *thread = [[NSThread alloc]initWithTarget:self selector:@selector(change:) object:nil];
    [thread start];
}
- (void)change:(id)sender
{
    //线程睡眠0.2秒以实现视图延迟上弹
    [NSThread sleepForTimeInterval:0.2];
    //创建一个仿射变换，平移(0, -100)视图上移100像素
    CGAffineTransform pTransform = CGAffineTransformMakeTranslation(0, -100);
    //使视图使用这个变换
    self.view.transform = pTransform;
    
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
    NSThread *thread = [[NSThread alloc]initWithTarget:self selector:@selector(change2:) object:nil];
    [thread start];
}
- (void)change2:(id)sender
{
    //线程睡眠0.2秒以实现视图延迟上弹
    //[NSThread sleepForTimeInterval:0.2];
    //创建一个仿射变换，平移(0, -100)视图上移100像素
    CGAffineTransform pTransform = CGAffineTransformMakeTranslation(0, 0);
    //使视图使用这个变换
    self.view.transform = pTransform;
    
}

/*
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([string length]>0)
    {
        unichar single=[string characterAtIndex:0];//当前输入的字符
        if ((single >='0' && single<='9') || single==',')//数据格式正确
        {
            return YES;
        }else{
            return NO; 
        } 
    }else{ 
        return YES; 
    } 
}
*/

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
