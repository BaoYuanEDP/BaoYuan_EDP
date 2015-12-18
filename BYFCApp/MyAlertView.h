//
//  MyAlertView.h
//  BYFCApp
//
//  Created by PengLee on 15/3/30.
//  Copyright (c) 2015年 PengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyAlertView : UIView
{
    UIView * senderView;
    UIView * alertView;
    
}
@property UILabel * titleLable;
@property UILabel * contentLable;
@property(nonatomic,copy) void (^block)(id obj);



- (instancetype)initWithTitle:(NSString *)title contentString:(NSString *)string call:(void (^)(id obj))block1;

- (void)fadeIn;
- (void)fadeOut;
- (void)showViewAnimation:(BOOL)animation showInView:(UIView *)myview;

@end
