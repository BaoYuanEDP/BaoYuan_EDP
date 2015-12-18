//
//  RoomCustomLable.m
//  BYFCApp
//
//  Created by PengLee on 15/2/9.
//  Copyright (c) 2015年 PengLee. All rights reserved.
//

#import "RoomCustomLable.h"

@implementation RoomCustomLable
- (instancetype)init
{
    if (self = [super init])
    {
        self.backgroundColor = [UIColor clearColor];
        
    }
    return self;
    
}
- (void)setGradientColors:(CGFloat [8])colors
{
    memcpy(gradientColors, colors, 8*sizeof(CGFloat));
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)drawTextInRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGContextSetTextDrawingMode(context, kCGTextFill);
    [super drawTextInRect:rect];
    CGImageRef alphaMask = NULL;
    if ([self drawGradient])
    {
        alphaMask = CGBitmapContextCreateImage(context);
        CGContextClearRect(context,rect);
        CGContextSaveGState(context);
        CGContextTranslateCTM(context, 0, rect.size.height);
        CGContextScaleCTM(context, 1.0, -1.0);
        CGContextClipToMask(context, rect, alphaMask);
        CGColorSpaceRef baseSpace = CGColorSpaceCreateDeviceRGB();
        CGGradientRef gradient = CGGradientCreateWithColorComponents(baseSpace, gradientColors, NULL, 2);
        CGColorSpaceRelease(baseSpace),baseSpace = NULL;
        CGPoint startPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMinY(rect));
        CGPoint endPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMaxY(rect));
        CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
        CGGradientRelease(gradient),gradient =  NULL;
        CGImageRelease(alphaMask);
        
    }
    if ([self drawOutline])
    {
        alphaMask = CGBitmapContextCreateImage(context);
        CGContextSetLineWidth(context, _outlineSize);
        CGContextSetLineJoin(context, kCGLineJoinRound);
        CGContextSetTextDrawingMode(context, kCGTextStroke);
        UIColor * tmpColor = self.textColor;
        self.textColor = [self outlineColor];
       [super drawTextInRect:CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, rect.size.height)];
        CGContextTranslateCTM(context, 0, rect.size.height);
        CGContextScaleCTM(context, 1.0, -1.0);
        CGContextDrawImage(context, rect, alphaMask);
        
        // Clean up
        CGImageRelease(alphaMask);
        
        // restore the original color
        self.textColor = tmpColor;
    }
}
@end
