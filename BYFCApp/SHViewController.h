//
//  SHViewController.h
//  BYFCApp
//
//  Created by zzs on 15/3/2.
//  Copyright (c) 2015年 PengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SHViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
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
}
@property(strong, nonatomic) NSMutableArray *typeArr3;
@property(strong, nonatomic) NSMutableArray *typeArr2;
@property(strong, nonatomic) NSMutableArray *typeArr1;

@property(nonatomic,strong)UIButton *button;
@property(nonatomic,strong)NSString *string;
@property(nonatomic,strong)NSMutableArray *treeOpenArray;
@property (strong, nonatomic) NSString *rowListTitle;//获取row数组的key
///判断是否展开或者合上的字符串.
@property (strong, nonatomic) NSString *treeOpenString;
@end
