//
//  MyAlertView.m
//  BYFCApp
//
//  Created by PengLee on 15/3/30.
//  Copyright (c) 2015年 PengLee. All rights reserved.
//

#import "MyAlertView.h"
#import "PL_Header.h"
#import "NSString+AutosizeLable.h"
#define PL_LEFT_INSET 100
#define PL_TOP_HEITHT 80
#define PL_ALERT_LABLE_HEIGHT 40
#define PL_ALERT_FONT 18
#define LABLE_INSET 10
@implementation MyAlertView
@synthesize titleLable,contentLable;

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithTitle:(NSString *)title contentString:(NSString *)string call:(void (^)(id))block1
{
    CGRect rect = CGRectMake(0, 0, PL_HEIGHT, PL_WIDTH);
    
    

    if (self = [super initWithFrame:rect]) {
        self.backgroundColor = [[UIColor grayColor]colorWithAlphaComponent:0.6];
        self.frame = rect;
        self.block = block1;
        
        
        alertView = [[UIView alloc]initWithFrame:CGRectMake(PL_HEIGHT>=650 ?200 :PL_LEFT_INSET, PL_TOP_HEITHT, PL_HEIGHT>=650 ?PL_HEIGHT-2*200: PL_HEIGHT-2*PL_LEFT_INSET, 150)];
        alertView.backgroundColor = [UIColor whiteColor];
        alertView.layer.cornerRadius = 6.0f;
        alertView.layer.masksToBounds = YES;
        
        [self addSubview:alertView];
        titleLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, CGRectGetWidth(alertView.frame), PL_ALERT_LABLE_HEIGHT)];
        titleLable.font = [UIFont boldSystemFontOfSize:PL_ALERT_FONT];
        titleLable.text = title;
        titleLable.textAlignment = NSTextAlignmentCenter;
        [alertView addSubview:titleLable];
        contentLable = [[UILabel alloc]initWithFrame:CGRectMake(LABLE_INSET, CGRectGetMaxX(titleLable.frame), CGRectGetWidth(alertView.frame)-2*LABLE_INSET, 25)];
        
        contentLable.font = [UIFont systemFontOfSize:PL_ALERT_FONT-2];
         CGSize lableSize = [NSString getSizeWithWidth:CGRectGetWidth(alertView.frame)-2*LABLE_INSET content:string font:PL_ALERT_FONT-2];
        
        contentLable.backgroundColor = [UIColor clearColor];
          contentLable.text =string;
         contentLable.numberOfLines = 0;
        contentLable.lineBreakMode =NSLineBreakByWordWrapping|NSLineBreakByCharWrapping;
        
     
        
        contentLable.frame = CGRectMake(LABLE_INSET, CGRectGetMaxY(titleLable.frame)-5,lableSize.width, lableSize.height);
      
        
       [alertView addSubview:contentLable];
        UILabel * lineLable = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(contentLable.frame)+5, CGRectGetWidth(alertView.frame), 1)];
        lineLable.backgroundColor = [[UIColor grayColor]colorWithAlphaComponent:0.3];
        [alertView addSubview:lineLable];
        UIButton * okButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [okButton setTitle:@"确认" forState:UIControlStateNormal];
        [okButton addTarget:self action:@selector(okClick:) forControlEvents:UIControlEventTouchUpInside];
        okButton.frame = CGRectMake(0, CGRectGetMaxY(lineLable.frame), CGRectGetWidth(alertView.frame)/2, PL_ALERT_LABLE_HEIGHT);
        [okButton setTitleColor:[[UIColor blackColor] colorWithAlphaComponent:0.8] forState:UIControlStateNormal];
        
        [alertView addSubview:okButton];
        UIButton * cacleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [cacleButton setTitle:@"取消" forState:UIControlStateNormal];
        [cacleButton addTarget:self action:@selector(cacleClick:) forControlEvents:UIControlEventTouchUpInside];
        cacleButton.frame = CGRectMake(CGRectGetMaxX(okButton.frame), CGRectGetMaxY(lineLable.frame), CGRectGetWidth(alertView.frame)/2, PL_ALERT_LABLE_HEIGHT);
        [cacleButton setTitleColor:[[UIColor blackColor] colorWithAlphaComponent:0.8] forState:UIControlStateNormal];
        
        [alertView addSubview:cacleButton];
        UILabel * line = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetWidth(alertView.frame)/2, CGRectGetMaxY(lineLable.frame), 1, PL_ALERT_LABLE_HEIGHT)];
        line.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.3];
        
        [alertView addSubview:line];
       
        
        alertView.frame = CGRectMake(PL_HEIGHT>=650 ?200 :PL_LEFT_INSET, PL_TOP_HEITHT,PL_HEIGHT>=650 ?PL_HEIGHT-2*200: PL_HEIGHT-2*PL_LEFT_INSET, CGRectGetMaxY(okButton.frame));
//        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(myviewremove:)];
//        [self addGestureRecognizer:tap];
        
        
        
        
    }
    return self;
    
}
- (void)myviewremove:(UIGestureRecognizer *)tapnote
{
    [self fadeOut];
}
- (void)okClick:(UIButton *)button
{
    self.block(button);
    [self fadeOut];
}
- (void)cacleClick:(UIButton *)button
{
    [self fadeOut];
}
- (void)fadeIn
{
    self.transform = CGAffineTransformMakeScale(1.4, 1.4);
    self.alpha = 0;
    [UIView animateWithDuration:0.25 animations:^{
        self.alpha = 1;
        self.transform = CGAffineTransformMakeScale(1, 1);
    }];

}
- (void)fadeOut

{
    [UIView animateWithDuration:.25 animations:^{
        self.transform = CGAffineTransformMakeScale(1.4, 1.4);
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        if (finished) {
            [self removeFromSuperview];
        }
    }];
    
}
- (void)showViewAnimation:(BOOL)animation showInView:(UIView *)myview
{
    senderView =myview ;
    [senderView addSubview:self];
    
    if (animation)
    {
        [self fadeIn];
    }
}
//- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    // tell the delegate the cancellation
//    
//    // dismiss self
//    [self fadeOut];
//}

@end
