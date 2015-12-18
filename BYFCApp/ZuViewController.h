//
//  ZuViewController.h
//  BYFCApp
//
//  Created by zzs on 14/12/18.
//  Copyright (c) 2014年 PengLee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PL_Header.h"
#import "CWStarRateView.h"

@interface ZuViewController : UIViewController<CWStarRateViewDelegate>
{
    UITextField *nameTF;
    UITextField *phoneTF;
    UITextField *areaTF;
    UITextField *SMF;
    UITextField *SMF2;
    UITextField *priceMaxTF;
    UITextField *priceMinTF;
    UITextField *zupriceMaxTF;
    UITextField *zupriceMinTF;
    NSMutableArray  * _signArray;
    NSInteger score;
    UIButton *areaBtn;
    UIButton *sex;
    NSString *sexStr;
    NSString * _string1;
    NSString * _string2;
    NSString *areaId;
    
}

@property (strong, nonatomic) CWStarRateView *starRateView;
@property(strong,nonatomic)NSString *tradeStr;
@property (strong,nonatomic)NSString * titleArea;

@end
