//
//  MyVisiterCell.h
//  BYFCApp
//
//  Created by zzs on 14/12/10.
//  Copyright (c) 2014年 PengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyVisiterCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *gou;
@property (weak, nonatomic) IBOutlet UIImageView *zu;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *yixiang;
@property (weak, nonatomic) IBOutlet UILabel *yixiangdu;
@property (weak, nonatomic) IBOutlet UILabel *roomInfo;
@property (weak, nonatomic) IBOutlet UILabel *yixiangPrice;
@property (weak, nonatomic) IBOutlet UIImageView *jinglituijian;
@property (weak, nonatomic) IBOutlet UIImageView *jixu;
@property (weak, nonatomic) IBOutlet UIImageView *xuequfang;
@property (weak, nonatomic) IBOutlet UIImageView *XX1;
@property (weak, nonatomic) IBOutlet UIImageView *XX2;
@property (weak, nonatomic) IBOutlet UIImageView *XX3;
@property (weak, nonatomic) IBOutlet UIImageView *XX4;
@property (weak, nonatomic) IBOutlet UIImageView *XX5;
@property (weak, nonatomic) IBOutlet UIButton *xiaoqu;
@property (weak, nonatomic) IBOutlet UIButton *pianqu;
@property (weak, nonatomic) IBOutlet UIButton *genjin;
@property (weak, nonatomic) IBOutlet UIButton *phoneBtn;
- (IBAction)genjinBtn:(id)sender;
- (IBAction)phoneBtn:(id)sender;
- (IBAction)xiaoqu:(UIButton *)sender;
- (IBAction)pianqu:(UIButton *)sender;

@end
