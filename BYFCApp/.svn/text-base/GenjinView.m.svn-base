//
//  GenjinView.m
//  BYFCApp
//
//  Created by PengLee on 15/3/17.
//  Copyright (c) 2015年 PengLee. All rights reserved.
//

#import "GenjinView.h"
#define VIEW_SCREEN_INSETS_LEFT 10
#define VIEW_SCREEN_INSETS_TOP 84
#define LABLE_INSETS 25
#define LABLE_HEIGHT 25
#define ALERT_FONT 13
#define alert_font 10
#define font_name @"TimesNewRomanPS-BoldMT"
#define NAME_WIDTH 40
#define MESSAGE_HEI 25
@implementation GenjinView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (id)initWithDictionary:(NSDictionary *)dictionary{
    return self;
    
}
- (id)initWithUser_Name:(NSString *)name writeFs:(NSString *)string writeLX:(NSString *)leixing  contentString:(NSString *)content writeDate:(NSString *)dateString
{
    CGRect  rect = [[UIScreen mainScreen]applicationFrame];
    selfrect = rect;
    
    if (self = [super initWithFrame:rect])
    {
        self.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.5];
       
        
        
        self.opaque =YES;
        
        self.layer.cornerRadius = 3.0f;
        //self.layer.masksToBounds = YES;
        
       // self.resultDictionary = dictionary;
        [self loadData_Name:name FS:string leixing:leixing content:content date:dateString];
        
    }
    return self;
    
}
- (void)loadData_Name:(NSString *)str1 FS:(NSString *)str2 leixing:(NSString *)leixing content:(NSString *)string date:(NSString *)date
{
    _view  = [[UIView alloc]initWithFrame:CGRectMake(VIEW_SCREEN_INSETS_LEFT, VIEW_SCREEN_INSETS_TOP, (PL_WIDTH-2*VIEW_SCREEN_INSETS_LEFT), PL_HEIGHT-2*VIEW_SCREEN_INSETS_TOP)];
    _view.layer.cornerRadius = 5.0f;
    _view.layer.masksToBounds = YES;
    [self addSubview:_view];
    _view.backgroundColor =[UIColor whiteColor];
    _nameLable = [[UILabel alloc]initWithFrame:CGRectMake(VIEW_SCREEN_INSETS_LEFT/4, LABLE_INSETS, 2.5*LABLE_INSETS,LABLE_HEIGHT)];
    _nameLable.text = @"跟进人:";
    _nameLable.backgroundColor = [UIColor clearColor];
    _nameLable.font = [UIFont fontWithName:font_name size:ALERT_FONT];
    
    [_view addSubview:_nameLable];
    
    _nameDetail = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_nameLable.frame)-VIEW_SCREEN_INSETS_LEFT*1.2, CGRectGetMinY(_nameLable.frame), NAME_WIDTH*1.4, MESSAGE_HEI)];
    _nameDetail.text = str1;
    //_nameDetail.adjustsFontSizeToFitWidth = YES;
    _nameDetail.backgroundColor = [UIColor clearColor];
    _nameDetail.textAlignment = NSTextAlignmentLeft;
    _nameDetail.font = [UIFont fontWithName:font_name size:ALERT_FONT];
    
    [_view addSubview:_nameDetail];
    _fangshiLable = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetWidth(_view.frame)/3-VIEW_SCREEN_INSETS_LEFT*2+15, CGRectGetMinY(_nameLable.frame), CGRectGetWidth(_nameLable.frame)+VIEW_SCREEN_INSETS_LEFT, CGRectGetHeight(_nameLable.frame))];
    _fangshiLable.text = @"跟进方式:";
    _fangshiLable.font = [UIFont fontWithName:font_name size:ALERT_FONT];
    [_view addSubview:_fangshiLable];
    _fangshiDetail = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_fangshiLable.frame)-VIEW_SCREEN_INSETS_LEFT*1.2, CGRectGetMinY(_nameDetail.frame), 1.5*LABLE_INSETS, MESSAGE_HEI)];
    _fangshiDetail.text = str2;
    _fangshiDetail.textAlignment= NSTextAlignmentLeft;
    _fangshiDetail.font = [UIFont fontWithName:font_name size:ALERT_FONT];
    [_view addSubview:_fangshiDetail];
    
    
    _leixingLable = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetWidth(_view.frame)*2/3-VIEW_SCREEN_INSETS_LEFT*2, LABLE_INSETS, CGRectGetWidth(_fangshiLable.frame), CGRectGetHeight(_fangshiLable.frame))];
    _leixingLable.text = @"跟进类型:";
    _leixingLable.font = [UIFont fontWithName:font_name size:ALERT_FONT];
    [_view addSubview:_leixingLable];
    _leixingDetail = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_leixingLable.frame)-VIEW_SCREEN_INSETS_LEFT*1.2, CGRectGetMinY(_nameDetail.frame), 2.5*LABLE_INSETS, MESSAGE_HEI)];
    _leixingDetail.text = leixing;
   // _leixingDetail.adjustsFontSizeToFitWidth = YES;
    _leixingDetail.textAlignment= NSTextAlignmentLeft;
    _leixingDetail.font = [UIFont fontWithName:font_name size:ALERT_FONT];
    [_view addSubview:_leixingDetail];
    UILabel * lineLable = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_leixingLable.frame)+1, CGRectGetWidth(_view.frame), 1)];
    lineLable.backgroundColor = [UIColor grayColor];
    [_view addSubview:lineLable];
    
    
    _detailText = [[UILabel alloc]initWithFrame:CGRectMake(VIEW_SCREEN_INSETS_LEFT, VIEW_SCREEN_INSETS_TOP/2+VIEW_SCREEN_INSETS_LEFT*1.2, CGRectGetWidth(_view.frame)-2*VIEW_SCREEN_INSETS_LEFT, 2*MESSAGE_HEI)];
    _detailText.font = [UIFont systemFontOfSize:ALERT_FONT];
    CGSize textSize = [self getSizeWithWidth:CGRectGetWidth(_detailText.frame) content:string font:ALERT_FONT];
    _detailText.backgroundColor = [UIColor clearColor];
    _detailText.numberOfLines =0;
   // _detailText.adjustsFontSizeToFitWidth = YES;
    _detailText.lineBreakMode =NSLineBreakByWordWrapping|NSLineBreakByCharWrapping;
    if (string.length)
    {
        _detailText.text =[NSString stringWithFormat:@"%@",string];
        
    }
    else
    {
         _detailText.text = @"暂无跟进信息";
        
    }
   // _detailText.text = string;
    CGFloat sizesTing = _detailText.text.length<10?(textSize.width+1.5*VIEW_SCREEN_INSETS_LEFT):(textSize.width);
    CGFloat sizeSmall = _detailText.text.length <10? (textSize.height+ 2*VIEW_SCREEN_INSETS_LEFT):(textSize.height+1.6*VIEW_SCREEN_INSETS_LEFT);
    
    
   
    _detailText.frame = CGRectMake(VIEW_SCREEN_INSETS_LEFT, VIEW_SCREEN_INSETS_TOP/2+VIEW_SCREEN_INSETS_LEFT*1.2, sizesTing,sizeSmall);
    [_view addSubview:_detailText];
    _detailText.backgroundColor = [UIColor clearColor];
    _dateLablel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetWidth(_view.frame)*2/3-VIEW_SCREEN_INSETS_LEFT*5, CGRectGetMaxY(_detailText.frame), VIEW_SCREEN_INSETS_TOP*1.8, MESSAGE_HEI)];
    _dateLablel.text = date;
    _dateLablel.font = [UIFont fontWithName:font_name size:ALERT_FONT];
    _detailText.adjustsFontSizeToFitWidth = YES;
    [_view addSubview:_dateLablel];
    
    CGFloat lableH = _detailText.text.length<10 ?(1.5*VIEW_SCREEN_INSETS_TOP):CGRectGetMaxY(_dateLablel.frame)+VIEW_SCREEN_INSETS_TOP/3 ;
    
    _view.frame = CGRectMake(VIEW_SCREEN_INSETS_LEFT, VIEW_SCREEN_INSETS_TOP, (PL_WIDTH-2*VIEW_SCREEN_INSETS_LEFT),  lableH);
    
    
}
- (CGSize)getSizeWithWidth:(CGFloat)width content:(NSString *)str font:(NSInteger)font
{
    
    if (str.length == 0 || !str) {
        
        return CGSizeZero;
    }
    
    
    NSDictionary * attDic = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:[UIColor blackColor],[UIFont systemFontOfSize:font], nil] forKeys:[NSArray arrayWithObjects:NSForegroundColorAttributeName,NSFontAttributeName, nil]];
    
    
    NSAttributedString * attStr = [[NSAttributedString alloc]initWithString:str attributes:attDic];
    NSRange range = NSMakeRange(0, attStr.length);
    NSDictionary * dic = [attStr attributesAtIndex:0 effectiveRange:&range];
    
    
    CGRect  rect = [str boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:dic context:Nil];
    return rect.size;
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
- (void)showInView:(UIView *)myView animation:(BOOL)animation
{
   AppDelegate * del = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [del.window addSubview:self];
    
    if (animation)
    {
        [self fadeIn];
        
    }
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self fadeOut];
    
}
@end
