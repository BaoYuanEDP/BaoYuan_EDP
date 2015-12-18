//
//  GoOutApplyListViewController.h
//  BYFCApp
//
//  Created by PengLee on 15/7/17.
//  Copyright (c) 2015年 PengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GoOutApplyListViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) NSMutableArray *arrayData;
@property (nonatomic, assign) NSInteger page;

@end
