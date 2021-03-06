//
//  PackageViewController.h
//  BYFCApp
//
//  Created by zzs on 15/1/22.
//  Copyright (c) 2015年 PengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PackageViewController : UIViewController<UIAlertViewDelegate>
{
    UIButton *gongfeiBtn;
    UIButton *zifeiBtn;
}
@property (weak, nonatomic) IBOutlet UIButton *tiyanban;
@property (weak, nonatomic) IBOutlet UILabel *kucun;
@property (weak, nonatomic) IBOutlet UILabel *dingjiaF;
@property (weak, nonatomic) IBOutlet UILabel *jingjiaF;
@property (weak, nonatomic) IBOutlet UILabel *priceRequest;
@property (weak, nonatomic) IBOutlet UILabel *packagePrice;

//@property (weak, nonatomic) IBOutlet UIButton *gongfeiBtn;
//@property (weak, nonatomic) IBOutlet UIButton *zifeiBtn;
@property (weak, nonatomic) IBOutlet UIButton *shenqingBtn;

@property(nonatomic,strong)NSDictionary *dict;

- (IBAction)gongfeiClick:(UIButton *)sender;
- (IBAction)zifeiClick:(UIButton *)sender;
- (IBAction)shenqingClick:(UIButton *)sender;


@end
