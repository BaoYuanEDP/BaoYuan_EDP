//
//  RoomTableViewController.h
//  BYFCApp
//
//  Created by PengLee on 15/3/2.
//  Copyright (c) 2015年 PengLee. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol PopOverDelegate;

@interface RoomTableViewController : UITableViewController
@property (nonatomic,strong)NSMutableArray      * resultArray;
@property(nonatomic,weak)id <PopOverDelegate> delegate;

- (NSMutableArray *)loadWithData:(NSArray *)resultArray;

@end
@protocol PopOverDelegate <NSObject>

@required
- (void)didSelectPopOverRowIndex:(NSIndexPath *)indexpath  cellTitleText:(NSString *)title;



@end