//
//  MyCustomCellFor6.m
//  BYFCApp
//
//  Created by zzs on 14/12/17.
//  Copyright (c) 2014年 PengLee. All rights reserved.
//

#import "MyCustomCellFor6.h"

@implementation MyCustomCellFor6

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initView];
    }
    return self;
}
-(void)initView
{
    _gou=[[UIImageView alloc]initWithFrame:CGRectMake(8, 18, 18, 18)];
    [self addSubview:_gou];
}


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
