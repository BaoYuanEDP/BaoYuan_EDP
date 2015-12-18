//
//  VersionTableViewCell.h
//  VersionMainaTabelView
//
//  Created by Wangpu_IOS on 15/11/26.
//  Copyright © 2015年 Wangpu_IOS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VersionTableViewCell : UITableViewCell<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *VersionTableViewCell;
@property(nonatomic,strong)UINib*Loadnib;
@property(nonatomic,strong)NSMutableArray*SubDataArray;
@property(nonatomic,strong)NSMutableArray*VersionArray;
@end
