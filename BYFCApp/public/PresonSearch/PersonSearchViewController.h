//
//  PersonSearchViewController.h
//  BYFCApp
//
//  Created by heaven on 15-7-8.
//  Copyright (c) 2015年 PengLee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersonSearchListVC.h"
@interface PersonSearchViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *textFiled;
- (IBAction)searchAction:(UIButton *)sender;

@end
