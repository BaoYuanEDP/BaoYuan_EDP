//
//  MoreMenuVC.m
//  BYFCApp
//
//  Created by PengLee on 15/4/13.
//  Copyright (c) 2015年 PengLee. All rights reserved.
//

#import "MoreMenuVC.h"
#import "PL_Header.h"
#import "MoreVisterViewController.h"
@interface MoreMenuVC()<GestureMenuViewControllerDelegate>

@end
@implementation MoreMenuVC

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
@property (nonatomic) */
- (instancetype)initWithRootViewController:(UIViewController *)viewControler
{
    CGRect rect=CGRectMake(0, 0, PL_WIDTH, PL_HEIGHT);
    
    
    if (self = [super initWithFrame:rect]) {
        self.frame = rect;
        self.backgroundColor = [[UIColor grayColor]colorWithAlphaComponent:0.5];
        
      //  [self bringSubviewToFront:viewControler.view];
       
        
    }
    return self;
    
}
- (void)viewClick:(UIGestureRecognizer *)note
{
    NSLog(@"%@",note);
    
    [self  fadeOut];
}
- (void)showTelWindow:(UIView *)myview andViewController:(id)viewController
{

     nav = [[UINavigationController alloc]initWithRootViewController:viewController];
    nav.view.frame =CGRectMake(PL_WIDTH, 0, PL_WIDTH-60, PL_HEIGHT);
    [UIView animateWithDuration:0.5 animations:^{
        nav.view.frame =CGRectMake(60, 0, PL_WIDTH-60, PL_HEIGHT);

    }];
    NSLog(@"-----%@",viewController);
    if ([NSStringFromClass([viewController class]) isEqualToString:@"GestureMenuViewController"]) {
//        GestureMenuViewController * gesView = [GestureMenuViewController new];
        ((GestureMenuViewController *)viewController).delegate = self;
       
        UIButton * backBnt = [UIButton buttonWithType:UIButtonTypeCustom];
        backBnt.frame = CGRectMake(0, 0, 40, 20);
        [backBnt addTarget:self action:@selector(viewRemoveClick11:) forControlEvents:UIControlEventTouchUpInside];
        //    [backBnt setBackgroundImage:[UIImage imageNamed:@"return.png"] forState:UIControlStateNormal];
        [backBnt setTitle:@"取消" forState:UIControlStateNormal];
        backBnt.titleLabel.font=[UIFont systemFontOfSize:17.0f];
        [backBnt setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        
        
        UIBarButtonItem * leftbtn = [[UIBarButtonItem alloc]initWithCustomView:backBnt];
        
//        UIBarButtonItem * leftbtn = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(viewRemoveClick11:)];
        ((GestureMenuViewController *)viewController).navigationItem.leftBarButtonItem = leftbtn;
        ((GestureMenuViewController *)viewController).navigationItem.leftBarButtonItem.tintColor = [UIColor grayColor];
        
        //    UIBarButtonItem * rightBtn = [[UIBarButtonItem alloc]initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(viewSureClick:)];
        //    gesView.navigationItem.rightBarButtonItem = rightBtn;
        
       
    }
    if ([NSStringFromClass([viewController class]) isEqualToString:@"MoreVisterViewController"]) {
        
        
        
        UIButton * backBnt = [UIButton buttonWithType:UIButtonTypeCustom];
        backBnt.frame = CGRectMake(0, 0, 40, 20);
        [backBnt addTarget:self action:@selector(viewRemoveClick11:) forControlEvents:UIControlEventTouchUpInside];
        //    [backBnt setBackgroundImage:[UIImage imageNamed:@"return.png"] forState:UIControlStateNormal];
        [backBnt setTitle:@"取消" forState:UIControlStateNormal];
        backBnt.titleLabel.font=[UIFont systemFontOfSize:17.0f];
        [backBnt setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        
        
        UIBarButtonItem * leftbtn = [[UIBarButtonItem alloc]initWithCustomView:backBnt];
//        UIBarButtonItem * leftbtn = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(viewRemoveClick11:)];
        ((MoreVisterViewController *)viewController).navigationItem.leftBarButtonItem = leftbtn;
        ((MoreVisterViewController *)viewController).navigationItem.leftBarButtonItem.tintColor = [UIColor grayColor];
    }
    [myview addSubview:self];
    [self  addSubview:nav.view];
    
   
    
    
    [self fadeIn];
    
    
    
}

-(void)dismiss
{
    [self fadeOut];
}
- (void)viewSureClick:(UIBarButtonItem *)bar
{
    
    NSLog(@"123");
    [self fadeOut];
}

- (void)viewRemoveClick11:(UIBarButtonItem *)bartem
{
    [self fadeOut];
    
}

- (void)dismissView
{
    [self fadeOut];
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch * touch = [touches anyObject];
    CGPoint point  = [touch locationInView:self];
    if (CGRectContainsPoint(nav.view.frame, point))
    {
        
        
    }
    else
    {
        [self fadeOut];
    }
    
    
}
- (void)fadeIn
{
    self.transform = CGAffineTransformMakeScale(1, 1);
    self.alpha = 0;
    [UIView animateWithDuration:0.25 animations:^{
        self.alpha = 1;
        self.transform = CGAffineTransformMakeScale(1, 1);
    }];
}
- (void)fadeOut
{
    self.backgroundColor = [UIColor clearColor];
    [UIView animateWithDuration:0.4 animations:^{
        self.transform = CGAffineTransformMakeScale(1, 1);
//        self.alpha = 0.0;
        self.frame = CGRectMake(PL_WIDTH,0, PL_WIDTH-60, PL_HEIGHT);
    } completion:^(BOOL finished) {
        if (finished) {
            if ([self.moreDlegate respondsToSelector:@selector(sendViewToSuperView:)])
            {
                [self.moreDlegate sendViewToSuperView:self ];
                
                
            }
        }
    }];
}
- (void)setIsClear:(BOOL)isClear
{
    _isClear = isClear;
    [self fadeOut];
}
@end
