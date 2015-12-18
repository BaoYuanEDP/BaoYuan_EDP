//
//  LookKeyListCell.h
//  单个demo
//
//  Created by 王鹏 on 15/12/8.
//  Copyright © 2015年 王鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LookKeyListCell : UITableViewCell<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *SubCell;
@property(nonatomic,strong)NSMutableArray*ReceiveKeyArray;
@property(nonatomic,strong)NSMutableArray*DataArray;
@end
