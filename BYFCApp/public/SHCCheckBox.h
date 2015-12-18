//
//  SHCCheckBox.h
//  DemoView
//
//  Created by shc on 15/6/17.
//  Copyright (c) 2015年 shc. All rights reserved.
//

#import <UIKit/UIKit.h>

//选择控件
@interface SHCCheckBox : UIControl
{
    //图片视图
    
    //普通状态图片
    
    //选中状态图片
   
    
    UILabel*     _lableText;
    
    //事件对象拥有者
    id  _target ;
    //事件函数对象
    SEL _selector ;
    //是否选中状态
    BOOL _isON ;
}

//选中属性
@property(nonatomic,strong)UIImageView* _imageView ;
@property(nonatomic,strong)UIImage*  _imageNormal ;
@property(nonatomic,strong) UIImage*     _imageSelected ;
@property (assign,nonatomic) BOOL on ;

- (id)initWithFrame:(CGRect)frame titleText:(NSString *)titleText;

@end

