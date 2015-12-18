//
//  RoomStyleViewController.h
//  BYFCApp
//
//  Created by PengLee on 15/4/13.
//  Copyright (c) 2015年 PengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol StyleDelegate;
#import "GestureMenuViewController.h"
@interface RoomStyleViewController : UIViewController
{
    UITextField * textfield;
    UITextField * textfield1;
    UITextField * textfield2;
    UITextField * textfield3;
    UITextField * textfield4;
    UITextField * textfield5;
    UITextField * textfield6;

}
@property (assign,nonatomic)NSInteger isShowSection;

@property (strong,nonatomic)NSString * text1String;
@property (strong,nonatomic)NSString * text2String;
@property (strong,nonatomic)NSString * propertyStyle;
@property (strong,nonatomic)NSString * imageStyle;
@property (strong,nonatomic)NSString * jiaoYiStyle;


@property (strong,nonatomic)NSString * tradeArrStyle;
@property (strong,nonatomic)NSString * propertyOccupyArrStyle;
@property (strong,nonatomic)NSString * propertyOwn1ArrStyle;
@property (strong,nonatomic)NSString * propertyDirectionArrStyle;
@property (strong,nonatomic)NSString * propertyTrustArrStyle;
@property (strong,nonatomic)NSString * custTelAcceptStrStyle;

@property (weak,nonatomic)id < StyleDelegate>roomdelegate;

@property (nonatomic, strong) GestureMenuViewController * gest;
@end
@protocol StyleDelegate <NSObject>

@optional

- (void)sendSelfText1:(NSString *)text1 selfText2:(NSString *)text2 styleString:(NSString *)string;

@end