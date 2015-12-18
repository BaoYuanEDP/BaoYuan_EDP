//
//  GusterVC.m
//  BYFCApp
//
//  Created by PengLee on 14/12/3.
//  Copyright (c) 2014年 PengLee. All rights reserved.
//

#import "GusterVC.h"

@interface GusterVC ()<JMPasswordViewDelegate>
{
   // NSString * password;
    
}
//记录手势密码
@property(nonatomic,copy)NSString * passWord;

- (IBAction)passBack:(UIButton *)sender;
@end

@implementation GusterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //self.view.backgroundColor = [UIColor whiteColor];
    [self initGuster];
    
    
}
-(void)initGuster
{
    JMPasswordView * passWord = [[JMPasswordView alloc]initWithFrame:CGRectMake(0, 0, 300, 400)];
    
    self.view.backgroundColor = passWord.backgroundColor;
    passWord.delegate = self;
    
    [self.view addSubview:passWord];
    [passWord setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    
    //高度
    NSLayoutConstraint * passHeight = [NSLayoutConstraint constraintWithItem:passWord attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:400];
    [passWord addConstraint:passHeight];
    NSLayoutConstraint *passwidth = [NSLayoutConstraint constraintWithItem:passWord attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:300];
    [passWord addConstraint:passwidth];
    
    NSLayoutConstraint *centerX = [NSLayoutConstraint constraintWithItem:passWord attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0];
    [self.view addConstraint:centerX];
    NSLayoutConstraint *centerY = [NSLayoutConstraint constraintWithItem:passWord attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0];
    [self.view addConstraint:centerY];
}

-(void)recordPassBack
{
    
}
-(void)JMPasswordView:(JMPasswordView *)passwordView withPassword:(NSString *)password
{
    NSLog(@"pass %@",password);
//    self.passWord = [PL_USER_STORAGE objectForKey:@"sspassword"];
//    if (self.passWord ==nil)
//    {
//        [PL_USER_STORAGE setObject:self.passWord forKey:@"sspassword"];
//        [PL_USER_STORAGE synchronize];
//        [self.navigationController pushViewController:[MainViewController new] animated:YES];
//    }
//    else
//    {
//        if (self.passWord==[NSString stringWithFormat:@"0125"])
//        {
//            [self.navigationController pushViewController:[MainViewController new] animated:YES];
//            
//        }
//    }
    if ([password isEqualToString:@"0125"]) {
        [self.navigationController pushViewController:[MainViewController new] animated:YES];
    }
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

- (IBAction)passBack:(UIButton *)sender {
    
    
    
    
    
}
@end
