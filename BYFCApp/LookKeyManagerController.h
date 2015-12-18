//
//  ViewController.h
//  单个demo
//
//  Created by 王鹏 on 15/12/8.
//  Copyright © 2015年 王鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface LookKeyManagerController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *MaintTabeleView;
@property (weak, nonatomic) IBOutlet UIView *CyscrollView;

@property (strong, nonatomic) IBOutlet UIView *ScroolViewBackGround;
@property(nonatomic,strong)NSMutableArray*KeyArray;
@property(nonatomic,strong)NSMutableArray*ImageViewArray;

@end

