//
//  SHCCheckBox.m
//  DemoView
//
//  Created by shc on 15/6/17.
//  Copyright (c) 2015年 shc. All rights reserved.
//

#import "SHCCheckBox.h"

@implementation SHCCheckBox

//同步成员变量
@synthesize on = _isON ;

- (id)initWithFrame:(CGRect)frame titleText:(NSString *)titleText
{
    frame.size = CGSizeMake(20, 20) ;
    self = [super initWithFrame:frame];
    if (self) {
        __imageView = [[UIImageView alloc] init] ;
        __imageView.frame = CGRectMake(0, 5, 20, 20) ;
        [self addSubview:__imageView] ;
        _lableText = [[UILabel alloc] initWithFrame:CGRectMake(__imageView.frame.size.width, 5, 60, 20)];
        _lableText.text = titleText;
        _lableText.font = [UIFont fontWithName:@"Arial-BoldMT" size:15];
        [self addSubview:_lableText];
        //未选中图像
        __imageNormal = [UIImage imageNamed:@"unselect" ];
        //选中图像
        __imageSelected = [UIImage imageNamed:@"select"] ;
        __imageView.image= __imageNormal ;
        _isON = NO ;
           }
    return self;
}

-(void) addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents
{
    //只有当传入的参数的值包含有UIControlEventValueChanged定义值时才能添加事件(修改事件)
    if (UIControlEventValueChanged & controlEvents)
    {
        _target = target ;
        _selector = action ;
    }
}

-(void) setOn:(BOOL)on
{
    if (_isON != on)
    {
        _isON = on ;
               if (_isON == YES)
        {
            __imageView.image = __imageSelected ;
        }
        else
        {
            __imageView.image = __imageNormal ;
        }
        //当改变状态时调用事件函数
        if ([_target respondsToSelector:_selector] == YES)
        {
            [_target performSelector:_selector withObject:nil afterDelay:0] ;
        }
    }
}
//点击开始时改变状态
-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.on = !(self.on) ;
   

//  _isON = !_isON ;
}
//在结束点击时改变状态

@end
