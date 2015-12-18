//
//  UIButton+Externtions.m
//  button 上添加图片和文字
//
//  Created by PengLee on 15/1/30.
//  Copyright (c) 2015年 PengLee. All rights reserved.
//

#import "UIButton+Externtions.h"

@implementation UIButton (Externtions)
//NSAttributedString
//图片在上 ，文字在下
- (void)setImage:(UIImage *)image attributeTitle:(NSString *)attriString
{
   //sizeWithAttributes  这个只是对单个文本有作用
    
    CGSize titleSize = [attriString boundingRectWithSize:CGSizeMake(1000, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName :[UIFont fontWithName:@"HelveticaNeue-Light" size:14.0]} context:nil].size;
    //NSMutableAttributedString * attStr = [[NSMutableAttributedString alloc]initWithString:attriString];
    
    
    
    [self.imageView setContentMode:UIViewContentModeCenter];
    
    [self setImageEdgeInsets:UIEdgeInsetsMake(0, -10,10,-titleSize.width)];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    // [self setImage:image forState:UIControlStateNormal];
    [self setBackgroundImage:image forState:UIControlStateNormal];
    
    self.titleLabel.text = attriString;
    [self.titleLabel setContentMode:UIViewContentModeCenter];
    [self.titleLabel setBackgroundColor:[UIColor clearColor]];
    [self.titleLabel setFont:[UIFont systemFontOfSize:12.0f]];
    self.titleLabel.textColor = [UIColor redColor];
    
    [self setTitleEdgeInsets:UIEdgeInsetsMake(self.frame.size.height-15, -image.size.width, 0.0, 0.0)];
   // [self setAttributedTitle:attStr forState:UIControlStateNormal];
    [self setTitle:attriString forState:UIControlStateNormal];
    [self setTitleColor:[UIColor magentaColor] forState:UIControlStateNormal];
    
}
@end
