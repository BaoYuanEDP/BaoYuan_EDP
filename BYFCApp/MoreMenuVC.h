//
//  MoreMenuVC.h
//  BYFCApp
//
//  Created by PengLee on 15/4/13.
//  Copyright (c) 2015年 PengLee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PL_Header.h"
@protocol MoreMenuVCDelegate;

@interface MoreMenuVC : UIView
{
    UINavigationController * nav;
    
}
@property id <MoreMenuVCDelegate>moreDlegate;
@property (assign,nonatomic)BOOL isClear;

- (instancetype)initWithRootViewController:(UIViewController *)viewControler;
- (void)showTelWindow:(UIView *)myview andViewController:(id)viewController ;
- (void)dismissView;
- (void)fadeOut;

@end
@protocol MoreMenuVCDelegate <NSObject>

@optional
- (void)MoreViewSureClick;
- (void)sendViewToSuperView:(UIView *)viewself;




@end