//
//  MyPhoneViewController.h
//  BYFCApp
//
//  Created by zzs on 15/4/20.
//  Copyright (c) 2015年 PengLee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecordTableViewCell.h"
enum
{
    Type_Vister = 0,
    Type_Room,
};
typedef NSInteger Type;

@interface MyPhoneViewController : UIViewController
//@property (weak, nonatomic) IBOutlet UITableView *recordTableview;
//
//@property(nonatomic,strong) RecordTableViewCell *recordViewCell;
@property(nonatomic,assign) Type type;
@end
