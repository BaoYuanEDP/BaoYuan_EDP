//
//  DatePickerView.m
//  BYFCApp
//
//  Created by PengLee on 15/5/21.
//  Copyright (c) 2015年 PengLee. All rights reserved.
//

#import "DatePickerView.h"
#import "PL_Header.h"
@interface DatePickerView()
{
    NSString *_dateString;
}
@end


@implementation DatePickerView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
        self.backgroundColor = [[UIColor grayColor]colorWithAlphaComponent:0.7];
        [self loadDatePicker];
        
    }
    return self;
}
-(void)loadDatePicker
{
    UIDatePicker *datePicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(10, 120,PL_WIDTH - 20 , 300)];
    datePicker.backgroundColor = [UIColor whiteColor];
    datePicker.datePickerMode  = UIDatePickerModeDate;
    [datePicker setCalendar:[NSCalendar currentCalendar]];
    [datePicker setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh_Hans_CN"]];
    [datePicker addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:datePicker];
    UIButton *sureButton = [[UIButton alloc]initWithFrame:CGRectMake(10, datePicker.frame.origin.y + datePicker.frame.size.height + 3, datePicker.frame.size.width, 20)];
    [self addSubview:sureButton];
    sureButton.layer.borderColor = [UIColor blackColor].CGColor;
    sureButton.layer.borderWidth = 0.2f;
    [sureButton setTitle:@"确定" forState:UIControlStateNormal];
    [sureButton addTarget:self action:@selector(didClickSureButton:) forControlEvents:UIControlEventTouchUpInside];
    
    NSDate *date = datePicker.date;
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    _dateString = [dateFormat stringFromDate:date];
    
}
-(void)didClickSureButton:(UIButton *)sender
{
    self.blockString(_dateString);
    [self fadeOut];
   
//    if ([self.dateDelegate respondsToSelector:@selector(transformAdateString:)]) {
//        [self.dateDelegate transformAdateString:_dateString];
//    }
}
-(void)dateChanged:(id)sender
{
    UIDatePicker *picker = (UIDatePicker *)sender;
    NSDate *date = picker.date;
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    _dateString = [dateFormat stringFromDate:date];
    
    
}

-(void)addSelfInAView:(UIView *)sup comPleteBlock:(void (^)(NSString *str))block
{
    self.blockString = nil;
    self.blockString = block;
    [sup.window addSubview:self];
    [self bringSubviewToFront:sup.window];
    [self fadeIn];
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


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self clearTel:nil];
}
- (void)clearTel:(UIGestureRecognizer *)tap
{
    [self fadeOut];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
