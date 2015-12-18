//
//  PhoneNumberTableViewCell.m
//  BYFCApp
//
//  Created by PengLee on 15/5/14.
//  Copyright (c) 2015年 PengLee. All rights reserved.
//

#import "PhoneNumberTableViewCell.h"

@implementation PhoneNumberTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.phoneNumTextfield.userInteractionEnabled = NO;
    
    [self layoutIfNeeded];
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    if (self.phoneNumTextfield.userInteractionEnabled== YES) {
        self.phoneNumTextfield.borderStyle = UITextBorderStyleRoundedRect;

    }
    else
    {
        self.phoneNumTextfield.borderStyle = UITextBorderStyleNone;
    }
    for (UIView *subView in self.contentView.superview.subviews) {
        if ([NSStringFromClass(subView.class) hasSuffix:@"SeparatorView"]) {
            subView.hidden = NO;
        }
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(IBAction)clickEditButton:(UIButton *)sender andEvent:(UIEvent *)event
{
    CGPoint point = [[[event allTouches]anyObject] locationInView:self.superview];
    
    NSLog(@"%d",[sender.currentImage isEqual:[UIImage imageNamed:@"sun"]]);
    
    if ([sender.currentImage isEqual:[UIImage imageNamed:@"sun"]]) {
//        [sender setImage:[UIImage imageNamed:@"tijiao"] forState:UIControlStateNormal];
//        self.phoneNumTextfield.userInteractionEnabled = YES;
//        self.phoneNumTextfield.borderStyle            = UITextBorderStyleLine;
//        [self.phoneNumTextfield becomeFirstResponder];
        sender.hidden = YES;
    }
    else
    {
        [self.phoneNumTextfield resignFirstResponder];
         [sender setImage:[UIImage imageNamed:@"tijiao"] forState:UIControlStateNormal];
//        self.phoneNumTextfield.layer.borderWidth      = 0;
//        self.phoneNumTextfield.layer.borderColor      = [UIColor clearColor].CGColor;
        self.phoneNumTextfield.borderStyle            = UITextBorderStyleRoundedRect;
        
        self.phoneNumTextfield.userInteractionEnabled = NO;
        
        if ([self.phoneNumberDelegate respondsToSelector:@selector(editPhoneNumber:)])
        {
            [self.phoneNumberDelegate editPhoneNumber:point];
        }
    }
}
-(IBAction)clickDeleteButton:(UIButton *)sender andEvent:(UIEvent *)event
{
    CGPoint point = [[[event allTouches]anyObject] locationInView:self.superview];
    
    
    if ([self.phoneNumberDelegate respondsToSelector:@selector(deletePhoneNumber:)]) {
        [self.phoneNumberDelegate deletePhoneNumber:point];
    }
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    textField.borderStyle = UITextBorderStyleRoundedRect;
    [textField resignFirstResponder];
}
@end
