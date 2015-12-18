//
//  Custom_Popover5.m
//  BYFCApp
//
//  Created by 王鹏 on 15/12/7.
//  Copyright © 2015年 PengLee. All rights reserved.
//

#import "Custom_Popover5.h"

@implementation Custom_Popover5

-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    
    
    return self;
}
+(Custom_Popover5 *)initWithLoadView5
{
    Custom_Popover5*Custom_5=[[UINib nibWithNibName:@"Custom_Popover5" bundle:nil]instantiateWithOwner:self options:nil].lastObject;
    
    return Custom_5;
}

- (void)drawRect:(CGRect)rect {
   
    self.ScrollView.delegate=self;
    self.ScrollView.contentSize=CGSizeMake(self.MainBackgroundView.frame.size.width-60,[UIScreen mainScreen].bounds.size.width-55*2+270+45+100);
    self.ScrollView.showsHorizontalScrollIndicator=NO;
    self.userInteractionEnabled=YES;
    self.BackgroundView.layer.cornerRadius=5;
    self.BackgroundView.layer.masksToBounds=YES;
    self.CommitImage.layer.cornerRadius=5;
    self.CommitImage.layer.masksToBounds=YES;
    
    self.MainBackgroundView.userInteractionEnabled=YES;
    
    
}
- (IBAction)ChestCardBtn:(UIButton *)sender {
    sender.selected=YES;
    if (sender.selected==YES) {
    
          self.ChestCardLayout.constant=200;
   }
        
    
    
}
- (IBAction)keyBook:(UIButton *)sender {
   
    sender.selected=YES;

    if (sender.selected==YES) {
    
            self.KeyBookLayout.constant=200;

       
    }
    
}


@end
