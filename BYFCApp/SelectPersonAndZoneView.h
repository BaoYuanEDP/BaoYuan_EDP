//
//  SelectPersonAndZoneView.h
//  BYFCApp
//
//  Created by 向远波 on 15/5/20.
//  Copyright (c) 2015年 PengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectPersonAndZoneView : UIView<UITableViewDelegate,UITableViewDataSource>
@property(copy,nonatomic) void (^blockString)(NSString *str);
-(instancetype)initWithFrame:(CGRect)frame andData:(NSArray *)dataArray;

-(void)addSelfInAView:(UIView *)superView;

@end
