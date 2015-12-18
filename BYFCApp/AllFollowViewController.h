//
//  AllFollowViewController.h
//  BYFCApp
//
//  Created by zzs on 15/3/17.
//  Copyright (c) 2015年 PengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AllFollowViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSArray *array;
    UITableView *table;
}
@end
