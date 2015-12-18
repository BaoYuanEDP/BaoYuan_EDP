//
//  TransformKYViewController.h
//  BYFCApp
//
//  Created by PengLee on 15/5/19.
//  Copyright (c) 2015年 PengLee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PL_Header.h"
enum
{
    FromFlag_Private = 0,
    FromFlag_Public,
};
typedef NSInteger FromFlag;
enum
{
    ToFlag_Private = 0,
    ToFlag_Public,
};
typedef NSInteger ToFlag;
enum
{
    PubType_GS = 0,
    PubType_DQ,
    PubType_ZJ,
    PubType_QJ,
    PubType_ZB,
};
typedef NSInteger PubType;
@interface TransformKYViewController : UIViewController
{
     NSMutableArray *_array;
}
@property (strong, nonatomic) CWStarRateView *starRateView;
@property (strong, nonatomic) NSString *strCountID;

@end
