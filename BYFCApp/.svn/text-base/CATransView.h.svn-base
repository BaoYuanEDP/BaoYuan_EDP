//
//  CATransView.h
//  BYFCApp
//
//  Created by PengLee on 15/3/4.
//  Copyright (c) 2015年 PengLee. All rights reserved.
//
#pragma mark --公告通用视图
#import <UIKit/UIKit.h>
#import "NoticeCell.h"

@interface CATransView : UIView<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,copy)void (^idBlock)(id obj);
@property BOOL isChangeColor;
@property UITableView * catableView;
@property NSMutableArray * colloletionArray;

- (id)initWithFrame:(CGRect)frame setBackGroundImage:(UIImage *)image loadWithButtonImage:(UIImage  *)buttonImage completeBack:(void (^)(id obj))block;


@end
