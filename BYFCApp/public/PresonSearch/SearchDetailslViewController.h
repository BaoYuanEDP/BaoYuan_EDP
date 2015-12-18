//
//  SearchDetailslViewController.h
//  BYFCApp
//
//  Created by heaven on 15-7-9.
//  Copyright (c) 2015年 PengLee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PL_Header.h"
@interface SearchDetailslViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *persionNum;
@property (weak, nonatomic) IBOutlet UILabel *zhiwei;
@property (weak, nonatomic) IBOutlet UILabel *quyu;
@property (weak, nonatomic) IBOutlet UILabel *fenbu;
@property (weak, nonatomic) IBOutlet UILabel *phoneNum;
@property (weak, nonatomic) IBOutlet UILabel *phone;
@property (weak, nonatomic) IBOutlet UILabel *chunchen;
@property (weak, nonatomic) IBOutlet UILabel *youbian;
@property (weak, nonatomic) IBOutlet UILabel *dianziyouxiang;
@property (weak, nonatomic) IBOutlet UILabel *dizhi;
@property (weak, nonatomic) IBOutlet UILabel *depar;
@property (weak, nonatomic) IBOutlet UIImageView *phone1;
@property (weak, nonatomic) IBOutlet UIImageView *phone2;
@property (nonatomic, strong) UIWebView *phoneCallWebView;
@property (nonatomic, strong) PersonSearchCellModel *model;
- (void)dialPhoneNumber:(NSString *)aPhoneNumber;
@end
