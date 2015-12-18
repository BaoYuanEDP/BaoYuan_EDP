//
//  UpgradeVC.h
//  BYFCApp
//
//  Created by heaven on 15-7-10.
//  Copyright (c) 2015年 PengLee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PL_Header.h"

@interface UpgradeVC : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *arrayData;
@end
