//
//  GesturePasswordView.m
//  GesturePassword
//
//  Created by hb on 14-8-23.
//  Copyright (c) 2014年 黑と白の印记. All rights reserved.
//

#import "GesturePasswordView.h"
#import "GesturePasswordButton.h"
#import "TentacleView.h"
#import "PL_Header.h"

@implementation GesturePasswordView {
    NSMutableArray * buttonArray;
    
    CGPoint lineStartPoint;
    CGPoint lineEndPoint;
    int logoH;
    
}
@synthesize imgView;
@synthesize forgetButton;
@synthesize changeButton;

@synthesize tentacleView;
@synthesize state;
@synthesize gesturePasswordDelegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        buttonArray = [[NSMutableArray alloc]initWithCapacity:0];
        self.backgroundColor=[UIColor whiteColor];
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(PL_WIDTH/2-160, PL_HEIGHT/2-80, 320, 320)];
        //view.backgroundColor=[UIColor whiteColor];
        for (int i=0; i<9; i++) {
            NSInteger row = i/3;
            NSInteger col = i%3;
            // Button Frame
            
            NSInteger distance = 320/3;
            NSInteger size = distance/1.5;
            NSInteger margin = size/4;
            GesturePasswordButton * gesturePasswordButton = [[GesturePasswordButton alloc]initWithFrame:CGRectMake(col*distance+margin, row*distance-30, size, size)];
            
            [gesturePasswordButton setTag:i];
            [view addSubview:gesturePasswordButton];
            [buttonArray addObject:gesturePasswordButton];
            //view.backgroundColor=[UIColor whiteColor];
        }
        frame.origin.y=0;
        [self addSubview:view];
        
        if (PL_WIDTH>320) {
             logoH=160;
            
        }else
        {
             logoH=130;
        }
        
        UIImageView *logoImg=[[UIImageView alloc]initWithFrame:CGRectMake(PL_WIDTH/4, PL_WIDTH>320?64:44, PL_WIDTH/2,  logoH/2)];
        logoImg.image=[UIImage imageNamed:@"detail_home_logo.png"];
        logoImg.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:logoImg];
        
        tentacleView = [[TentacleView alloc]initWithFrame:view.frame];
        [tentacleView setButtonArray:buttonArray];
        [tentacleView setTouchBeginDelegate:self];
        [self addSubview:tentacleView];
        
        state = [[UILabel alloc]initWithFrame:CGRectMake(frame.size.width/2-140, frame.size.height/2-120-30, 280, 30)];
        [state setTextAlignment:NSTextAlignmentCenter];
        [state setFont:[UIFont systemFontOfSize:14.f]];
        [self addSubview:state];
        
        
//        imgView = [[UIImageView alloc]initWithFrame:CGRectMake(frame.size.width/2-35, frame.size.width/2-80, 70, 70)];
//        [imgView setBackgroundColor:[UIColor whiteColor]];
//        [imgView.layer setCornerRadius:35];
//        [imgView.layer setBorderColor:[UIColor grayColor].CGColor];
//        [imgView.layer setBorderWidth:3];
//        [self addSubview:imgView];
        
        forgetButton = [[UIButton alloc]initWithFrame:CGRectMake(frame.size.width/2-60, frame.size.height/2+190, 120, 30)];
        [forgetButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [forgetButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [forgetButton setTitle:@"忘记手势密码" forState:UIControlStateNormal];
        [forgetButton addTarget:self action:@selector(forget) forControlEvents:UIControlEventTouchDown];
        [self addSubview:forgetButton];
        
        changeButton = [[UIButton alloc]initWithFrame:CGRectMake(frame.size.width/2+30, frame.size.height/2+190, 120, 30)];
        [changeButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [changeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [changeButton setTitle:@"修改手势密码" forState:UIControlStateNormal];
        [changeButton addTarget:self action:@selector(change) forControlEvents:UIControlEventTouchDown];
       // [self addSubview:changeButton];
    }
    
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
/*
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGColorSpaceRef rgb = CGColorSpaceCreateDeviceRGB();
    CGFloat colors[] =
    {
        134 / 255.0, 157 / 255.0, 147 / 255.0, 1.00,
        3 / 255.0,  3 / 255.0, 37 / 255.0, 1.00,
    };
    CGGradientRef gradient = CGGradientCreateWithColorComponents
    (rgb, colors, NULL, sizeof(colors)/(sizeof(colors[0])*4));
    CGColorSpaceRelease(rgb);
    CGContextDrawLinearGradient(context, gradient,CGPointMake
                                (0.0,0.0) ,CGPointMake(0.0,self.frame.size.height),
                                kCGGradientDrawsBeforeStartLocation);
}
*/
- (void)gestureTouchBegin {
    [self.state setText:@""];
}

-(void)forget{
    [gesturePasswordDelegate forget];
}

-(void)change{
    [gesturePasswordDelegate change];
}


@end
