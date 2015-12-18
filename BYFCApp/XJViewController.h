//
//  XJViewController.h
//  BYFCApp
//
//  Created by zzs on 15/3/26.
//  Copyright (c) 2015年 PengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XJViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *table;
}
@property(nonatomic,strong)NSMutableArray *arryData;
@property (nonatomic, assign) NSInteger page;

@end
