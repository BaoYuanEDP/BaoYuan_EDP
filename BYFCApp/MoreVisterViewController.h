//
//  MoreVisterViewController.h
//  BYFCApp
//
//  Created by PengLee on 15/5/6.
//  Copyright (c) 2015年 PengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MoreVisterViewControllerDelegate<NSObject>
@optional
-(void)transformTel:(NSString *)teleNumber;
-(void)freshCustomeList;
-(void)transformPubType:(NSString *)pubTypeStr;
-(void)transformtopStr3:(NSString *)topStr;
-(void)transformJiaoYiStr:(NSString *)jiaoyiStr;
-(void)dismiss;

@end

@interface MoreVisterViewController : UIViewController<MoreVisterViewControllerDelegate>
@property(nonatomic,strong) NSString *isPrivate;
@property(nonatomic,strong) NSString *typeStr;
@property(nonatomic,strong) NSString *pubTypeString;
@property(nonatomic,strong) NSString *jiaoyiStr;

@property(nonatomic,strong) NSString *jiaoyiTypeStr;

@property(nonatomic,strong) NSArray *arr;
@property(nonatomic,weak) id<MoreVisterViewControllerDelegate>delegate;
@end
