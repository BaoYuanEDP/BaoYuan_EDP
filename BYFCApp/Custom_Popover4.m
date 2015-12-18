//
//  Custom_Popover4.m
//  BYFCApp
//
//  Created by 王鹏 on 15/12/4.
//  Copyright © 2015年 PengLee. All rights reserved.
//

#import "Custom_Popover4.h"

@implementation Custom_Popover4
+(Custom_Popover4 *)initCustom_Popover4
{
    Custom_Popover4*custom4=[[NSBundle mainBundle]loadNibNamed:@"Custom_Popover4" owner:self options:nil].lastObject;
    custom4.LinkmanView.hidden=YES;
        if (custom4.hangjiaBtn.selected==YES) {
        custom4.baoyuanBtn.selected=NO;
        
    }

    return custom4;
}

- (void)drawRect:(CGRect)rect {
    self.PhoneNumber.delegate=self;
    self.beizhuTextView.delegate=self;
    self.upXiuGaiBtn.layer.masksToBounds=YES;
    self.upXiuGaiBtn.layer.cornerRadius=5;
    self.lookKeyBtn.layer.masksToBounds=YES;
    self.lookKeyBtn.layer.cornerRadius=5;
 }
/**
 *  点击备注之后更改约束
 *
 *  @param textView <#textView description#>
 */
-(void)textViewDidBeginEditing:(UITextView *)textView
{
    self.QianPeiViewLayout.constant=-160;
    
    
}
/**
 *  输入联系人电话的时候更改约束
 *
 *  @param textField <#textField description#>
 */
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.QianPeiViewLayout.constant=-80;
}
/**
 *  键盘退下时
 */
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    self.QianPeiViewLayout.constant=20;

}
/**
 *  textView键盘退下时
 */
-(void)textViewDidEndEditing:(UITextView *)textView
{
    self.QianPeiViewLayout.constant=20;
}
@end
