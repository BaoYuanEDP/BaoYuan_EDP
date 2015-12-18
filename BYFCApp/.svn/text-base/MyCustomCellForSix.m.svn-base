//
//  MyCustomCellForSix.m
//  BYFCApp
//
//  Created by zzs on 15/3/23.
//  Copyright (c) 2015年 PengLee. All rights reserved.
//

#import "MyCustomCellForSix.h"

@implementation MyCustomCellForSix

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)genjinBtn:(id)sender {
    NSLog(@"写跟进");
}

- (IBAction)phoneBtn:(id)sender {
    NSLog(@"打电话");
}

- (IBAction)xiaoqu:(UIButton *)sender {
    NSLog(@"小区");
    NSLog(@"%@",sender.titleLabel.text);
    [[NSUserDefaults standardUserDefaults]setObject:sender.titleLabel.text forKey:@"xiaoquClick"];
}

- (IBAction)pianqu:(UIButton *)sender {
    NSLog(@"片区");
    [[NSUserDefaults standardUserDefaults]setObject:sender.titleLabel.text forKey:@"pianquClick"];
}


@end
