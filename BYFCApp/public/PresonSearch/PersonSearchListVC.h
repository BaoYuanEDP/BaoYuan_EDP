//
//  PersonSearchListVC.h
//  BYFCApp
//
//  Created by heaven on 15-7-9.
//  Copyright (c) 2015年 PengLee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PL_Header.h"
#import "SearchDetailslViewController.h"

@interface PersonSearchListVC : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *arrayData;
@property (nonatomic,strong) PersonSearchCellTableViewCell *cell;
//@property (nonatomic, strong) UpgradeCell *cellU;
@property (nonatomic,strong) NSString *strText;
@property (nonatomic, assign) NSInteger page;//页数
@end
