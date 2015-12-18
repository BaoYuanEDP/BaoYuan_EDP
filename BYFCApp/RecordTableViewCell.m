//
//  RecordTableViewCell.m
//  BYFCApp
//
//  Created by zzs on 15/4/21.
//  Copyright (c) 2015年 PengLee. All rights reserved.
//

#import "RecordTableViewCell.h"

#define CELLH self.frame.size.height
#define LABELH (CELLH/2-5)
@implementation RecordTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
    [self setNeedsDisplay];


}
-(void)drawRect:(CGRect)rect
{
//    CGFloat width = rect.size.width-25-CELLH-10;
        self.recordImage.frame = CGRectMake(5, 5, CELLH-10, CELLH-10);
        self.nameLabel.frame = CGRectMake(CELLH, 5, 100, LABELH);
        self.phoneLabel.frame = CGRectMake(CELLH, 10+LABELH, 100, LABELH);
        self.phoneTimeLabel.frame = CGRectMake(rect.size.width-150, 10+LABELH, 100, LABELH);
        self.nowLabel.frame = CGRectMake(rect.size.width-50, 10+LABELH, 50, LABELH);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
