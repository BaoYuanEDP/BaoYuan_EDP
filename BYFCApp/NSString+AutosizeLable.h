//
//  NSString+AutosizeLable.h
//  BYFCApp
//
//  Created by PengLee on 15/3/30.
//  Copyright (c) 2015年 PengLee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSString (AutosizeLable)
+ (CGSize)getSizeWithWidth:(CGFloat)width content:(NSString *)str font:(NSInteger)font;

@end
