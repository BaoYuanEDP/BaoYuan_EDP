//
//  SinaListViewController.h
//  BYFCApp
//
//  Created by zzs on 15/4/1.
//  Copyright (c) 2015年 PengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SinaListViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    UIView *bgView;
    UITableView *table;
    UITableView *table2;
    NSArray *array;
    NSString *requeStr;
    NSMutableArray *selectArr;
    NSInteger indexSection;
    NSDictionary *dic;
    NSDictionary * dic1;
    BOOL hide3;
    NSMutableArray *typeArr1;
    NSMutableArray *typeArr2;
    NSMutableArray *typeArr3;
}
@property(nonatomic,strong)UIButton *button;
@property(nonatomic,strong)NSString *string;
@end
