//
//  GesturePasswordController.m
//  GesturePassword
//
//  Created by hb on 14-8-23.
//  Copyright (c) 2014年 黑と白の印记. All rights reserved.
//

#import <Security/Security.h>
#import <CoreFoundation/CoreFoundation.h>
#import "MainViewController.h"

#import "GesturePasswordController.h"


#import "KeychainItemWrapper/KeychainItemWrapper.h"

@interface GesturePasswordController ()

@property (nonatomic,strong) GesturePasswordView * gesturePasswordView;

@end

@implementation GesturePasswordController {
    NSString * previousString;
    NSString * password;
    int Quantity;
    int Quantity_;
    NSString* isDisRest;

}

@synthesize gesturePasswordView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    Quantity_=4;
    // Do any additional setup after loading the view.
    previousString = [NSString string];
    
    KeychainItemWrapper * keychin = [[KeychainItemWrapper alloc]initWithIdentifier:@"Gesture" accessGroup:nil];
    password = [keychin objectForKey:(__bridge id)kSecValueData];
//    if ([password isEqualToString:@""]) {
//
//        [self reset];
//    }
//    else {
//        [self verify];
//    }
    if (password.length<4) {
        
        [self reset];
      
 
    }
    else {
          [self verify];
        
           }
   

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma -mark 验证手势密码
- (void)verify{
    gesturePasswordView = [[GesturePasswordView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [gesturePasswordView.tentacleView setRerificationDelegate:self];
    [gesturePasswordView.tentacleView setStyle:1];
    [gesturePasswordView setGesturePasswordDelegate:self];
    [self.view addSubview:gesturePasswordView];
}

#pragma -mark 重置手势密码
- (void)reset{
    gesturePasswordView = [[GesturePasswordView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [gesturePasswordView.tentacleView setResetDelegate:self];
    [gesturePasswordView.tentacleView setStyle:2];
    [gesturePasswordView.imgView setHidden:YES];
    [gesturePasswordView.forgetButton setHidden:YES];
    [gesturePasswordView.changeButton setHidden:YES];
    [self.view addSubview:gesturePasswordView];
   
    

    
}
#pragma -mark 清空记录
- (void)clear{
    KeychainItemWrapper * keychin = [[KeychainItemWrapper alloc]initWithIdentifier:@"Gesture" accessGroup:nil];
    [keychin resetKeychainItem];
}

#pragma -mark 改变手势密码
- (void)change{
    [self reset];
}

#pragma -mark 忘记手势密码
- (void)forget{
   [self dismissViewControllerAnimated:YES completion:nil];
    UINavigationController * nav= [[UINavigationController alloc]initWithRootViewController:[ViewController new]];
    
   // ViewController *login=[[ViewController alloc]init];
//    [self.navigationController pushViewController:login animated:YES];
    [self clear];
    [PL_USER_STORAGE removeObjectForKey:PL_USER_TOKEN];
    [PL_USER_STORAGE removeObjectForKey:PL_USER_COOKIES];
    [PL_USER_STORAGE removeObjectForKey:PL_USER_PASSWORD];
    [PL_USER_STORAGE synchronize];
    
    isDisRest=@"0";
    [[NSUserDefaults standardUserDefaults]setObject:isDisRest forKey:@"IsDis"];

    self.view.window.rootViewController = nav;
    
}

- (BOOL)verification:(NSString *)result{
    if ([result isEqualToString:password]) {
        [gesturePasswordView.state setTextColor:[UIColor colorWithRed:2/255.f green:174/255.f blue:240/255.f alpha:1]];
        [gesturePasswordView.state setText:@"输入正确"];
        //[self presentViewController:(UIViewController) animated:YES completion:nil];
//        MainViewController *main=[[MainViewController alloc]init];
//        [self.navigationController pushViewController:main animated:YES];
        [self dismissViewControllerAnimated:YES completion:nil];
        
        return YES;
    }
    [gesturePasswordView.state setTextColor:[UIColor redColor]];
    Quantity++;
    [gesturePasswordView.state setText:[NSString stringWithFormat:@"手势密码错误 %d次 剩余 %d次",Quantity,Quantity_--]];
    if (Quantity==5) {
        PL_ALERT_SHOW(@"密码错误次数太多,请重新登录设置");
        
       [self forget];
    }
    return NO;
}

- (BOOL)resetPassword:(NSString *)result{
    if ([previousString isEqualToString:@""]) {
        previousString=result;
        [gesturePasswordView.tentacleView enterArgin];
        [gesturePasswordView.state setTextColor:[UIColor colorWithRed:2/255.f green:174/255.f blue:240/255.f alpha:1]];
        [gesturePasswordView.state setText:@"请验证输入密码"];
        return YES;
    }
    else {
        if ([result isEqualToString:previousString]) {
            KeychainItemWrapper * keychin = [[KeychainItemWrapper alloc]initWithIdentifier:@"Gesture" accessGroup:nil];
            [keychin setObject:@"<帐号>" forKey:(__bridge id)kSecAttrAccount];
            [keychin setObject:result forKey:(__bridge id)kSecValueData];
            //[self presentViewController:(UIViewController) animated:YES completion:nil];
            [self.navigationController pushViewController:[MainViewController new] animated:YES];
            [gesturePasswordView.state setTextColor:[UIColor colorWithRed:2/255.f green:174/255.f blue:240/255.f alpha:1]];
            [gesturePasswordView.state setText:@"已保存手势密码"];
            [self dismissViewControllerAnimated:YES completion:nil];
            
            return YES;
        }
        else{
            previousString =@"";
            [gesturePasswordView.state setTextColor:[UIColor redColor]];
            [gesturePasswordView.state setText:@"两次密码不一致，请重新输入"];
            return NO;
        }
    }
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)])
    {
        [[UIDevice currentDevice] performSelector:@selector(setOrientation:) withObject:(__bridge id)((void *)(UIInterfaceOrientationPortrait))];
        
    }
}
- (void)viewDidLayoutSubviews
{
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)])
    {
        [[UIDevice currentDevice] performSelector:@selector(setOrientation:) withObject:(__bridge id)((void *)(UIInterfaceOrientationPortrait))];
        
    }
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return (toInterfaceOrientation== UIInterfaceOrientationPortrait);
    
}
//- (NSUInteger)supportedInterfaceOrientations
//{
//    return UIInterfaceOrientationMaskPortrait;
//    
//}
- (BOOL)shouldAutorotate
{
    return YES;
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
