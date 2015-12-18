//
//  GenjinView.h
//  BYFCApp
//
//  Created by PengLee on 15/3/17.
//  Copyright (c) 2015年 PengLee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PL_Header.h"
@interface GenjinView : UIView
{
    CGRect selfrect;
    UIView * _view;
    UILabel * _nameLable;
    UILabel * _fangshiLable;
    UILabel * _leixingLable;
    
    UILabel * _nameDetail;
    UILabel * _fangshiDetail;
    UILabel * _leixingDetail;
    
    UILabel * _detailText;
    UILabel * _dateLablel;
    
}
@property (strong,nonatomic)NSDictionary * resultDictionary;

- (id)initWithDictionary:(NSDictionary *)dictionary;
- (id)initWithUser_Name:(NSString *)name writeFs:(NSString *)string writeLX:(NSString *)leixing  contentString:(NSString *)content writeDate:(NSString *)dateString;

- (void)fadeIn;
- (void)fadeOut;
- (void)showInView:(UIView *)myView animation:(BOOL)animation;

@end
