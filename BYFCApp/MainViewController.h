//
//  MainViewController.h
//  BYFCApp
//
//  Created by zzs on 14/12/3.
//  Copyright (c) 2014年 PengLee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RoomSourceVC.h"
#import "WXApi.h"
@class  CATransView;
@class CATransViewBlack;
@interface MainViewController : UIViewController
{
    enum WXScene _scene;
    CATransView * transView;
    CATransViewBlack * blackView ;
    UILabel * nameLable;
    
}


//- (IBAction)btnClick:(UIButton *)sender;
//
//@property (weak, nonatomic) IBOutlet UITableView *table;
@property(strong,nonatomic)NSArray * resultArray;

@end
