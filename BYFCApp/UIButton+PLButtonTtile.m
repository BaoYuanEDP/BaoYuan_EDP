//
//  UIButton+PLButtonTtile.m
//  BYFCApp
//
//  Created by PengLee on 15/1/4.
//  Copyright (c) 2015年 PengLee. All rights reserved.
//

#import "UIButton+PLButtonTtile.h"

@implementation UIButton (PLButtonTtile)
- (void )setButtonNormalTile:(NSString *)string
{
    NSMutableAttributedString * attributeString = [[NSMutableAttributedString alloc]initWithString:string attributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1],NSFontAttributeName:[UIFont fontWithName:@"Arial" size:14]}];
    self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    self.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    self.contentEdgeInsets = UIEdgeInsetsMake(0, 20, 0, self.frame.size.width/3.5);
    [self setTitle:string forState:UIControlStateNormal];
    [self setAttributedTitle:attributeString forState:UIControlStateNormal];
    
    
   
}
@end
