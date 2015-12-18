//
//  TimeFilterView.m
//  BYFCApp
//
//  Created by PengLee on 15/5/5.
//  Copyright (c) 2015年 PengLee. All rights reserved.
//

#import "TimeFilterView.h"
#import "PL_Header.h"
#import "SHCCheckBox.h"


@implementation TimeFilterView
{
    
    UIButton *button1;
    UIButton *button2;
    UIButton *button3;
    UIButton *button4;
    UIButton *button5;
    UIButton *button6;
    BOOL isBoreColor;

}
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        //        self.backgroundColor=[UIColor whiteColor];
        frame = CGRectMake(self.frame.origin.x, self.frame.origin.y,self.frame.size.width,80);
        self.frame = frame;

        button1 = [[UIButton alloc]initWithFrame:CGRectMake(5, 0, self.frame.size.width/3-10, 30) ];
        [button1 setTitle:@"学区房" forState:UIControlStateNormal];
        [button1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal ];
        button1.tag=10001;
        button1.titleLabel.font=[UIFont systemFontOfSize:13.0];

        [self addSubview:button1];
        button2 = [[UIButton alloc]initWithFrame:CGRectMake(self.frame.size.width/3+5, 0, self.frame.size.width/3-10, 30)];
        button2.tag=10002;
        [button2 setTitle:@"经理推荐" forState:UIControlStateNormal];
        [button2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal ];
        button2.titleLabel.font=[UIFont systemFontOfSize:13.0];

        [self addSubview:button2];
        button3 = [[UIButton alloc]initWithFrame:CGRectMake(self.frame.size.width/3*2+5, 0, self.frame.size.width/3-10, 30)];
        [button3 setTitle:@"急售" forState:UIControlStateNormal];
        [button3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal ];
        button3.tag=10003;
        button3.titleLabel.font=[UIFont systemFontOfSize:13.0];

        button4 = [[UIButton alloc]initWithFrame:CGRectMake(5, 40, self.frame.size.width/3-10, 30)];
        [button4 setTitle:@"满二年" forState:UIControlStateNormal];
        [button4 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal ];
        button4.tag=10004;
        button4.titleLabel.font=[UIFont systemFontOfSize:13.0];
        
        [self addSubview:button4];
        button5 = [[UIButton alloc]initWithFrame:CGRectMake(self.frame.size.width/3+5, 40, self.frame.size.width/3-10, 30)];
        [button5 setTitle:@"独家" forState:UIControlStateNormal];
        [button5 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal ];
        button5.tag=10005;
        button5.titleLabel.font=[UIFont systemFontOfSize:13.0];
        
//        [self addSubview:button5];
        button6 = [[UIButton alloc]initWithFrame:CGRectMake(self.frame.size.width/3*2+5,40, self.frame.size.width/3-10, 30)];
        [button6 setTitle:@"钥匙" forState:UIControlStateNormal];
        button6.tag=10006;
        button6.titleLabel.font=[UIFont systemFontOfSize:13.0];
        
        [button6 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal ];
        
        [self addSubview:button6];

        [self addSubview:button3];
        [button1 setBackgroundImage:[UIImage imageNamed:@"第二个"] forState:UIControlStateNormal];
        [button2 setBackgroundImage:[UIImage imageNamed:@"第二个"] forState:UIControlStateNormal];
        [button3 setBackgroundImage:[UIImage imageNamed:@"第二个"] forState:UIControlStateNormal];
        [button4 setBackgroundImage:[UIImage imageNamed:@"第二个"] forState:UIControlStateNormal];
        [button5 setBackgroundImage:[UIImage imageNamed:@"第二个"] forState:UIControlStateNormal];
        [button6 setBackgroundImage:[UIImage imageNamed:@"第二个"] forState:UIControlStateNormal];


       
        
        button1.layer.borderWidth=0.5;
        button1.layer.borderColor=[[UIColor grayColor]CGColor];
        button1.layer.masksToBounds=YES;
        button2.layer.borderWidth=0.5;
        button2.layer.borderColor=[[UIColor grayColor]CGColor];
        button2.layer.masksToBounds=YES;
        button3.layer.borderWidth=0.5;
        button3.layer.borderColor=[[UIColor grayColor]CGColor];
        button3.layer.masksToBounds=YES;
        button4.layer.borderWidth=0.5;
        button4.layer.borderColor=[[UIColor grayColor]CGColor];
        button4.layer.masksToBounds=YES;
        button5.layer.borderWidth=0.5;
        button5.layer.borderColor=[[UIColor grayColor]CGColor];
        button5.layer.masksToBounds=YES;
        button6.layer.borderWidth=0.5;
        button6.layer.borderColor=[[UIColor grayColor]CGColor];
        button6.layer.masksToBounds=YES;

        
        [button1 addTarget:self action:@selector(didClickButton:) forControlEvents:UIControlEventTouchUpInside];
        [button2 addTarget:self action:@selector(didClickButton:) forControlEvents:UIControlEventTouchUpInside];
        [button3 addTarget:self action:@selector(didClickButton:) forControlEvents:UIControlEventTouchUpInside];
        
        [button4 addTarget:self action:@selector(didClickButton:) forControlEvents:UIControlEventTouchUpInside];
        [button5 addTarget:self action:@selector(didClickButton:) forControlEvents:UIControlEventTouchUpInside];
        [button6 addTarget:self action:@selector(didClickButton:) forControlEvents:UIControlEventTouchUpInside];
        
        
        [self SendNotifationStr1:@""];
        [self SendNotifationStr2:@""];
        [self SendNotifationStr3:@""];
        [self SendNotifationStr4:@""];
        [self SendNotifationStr5:@""];
        [self SendNotifationStr6:@""];

        }
    return self;
}
-(void)didClickButton:(UIButton *)sender
{
    isBoreColor=NO;
    if (sender.tag==10001) {
        if (sender.selected==isBoreColor) {
            button1.layer.borderColor=[[UIColor redColor]CGColor];
        }else
        {
            button1.layer.borderColor=[[UIColor grayColor]CGColor];
            
        }
        [button1 setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
       
        NSString*str1=[NSString stringWithFormat:@"%d",!button1.selected];
        NSLog(@"--------%@",str1);
        [self SendNotifationStr1 :str1];
        
        sender.selected=!sender.selected;
    }else if (sender.tag==10002)
    {
        if (sender.selected==isBoreColor) {
            button2.layer.borderColor=[[UIColor redColor]CGColor];
        }else
        {
            button2.layer.borderColor=[[UIColor grayColor]CGColor];
            
        }
    [button2 setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    NSString*str2=[NSString stringWithFormat:@"%d",!button2.selected];

        NSLog(@"--------%@",str2);
        [self SendNotifationStr2 :str2];
        sender.selected=!sender.selected;
    }else if (sender.tag==10003)
    {
        if (sender.selected==isBoreColor) {
            button3.layer.borderColor=[[UIColor redColor]CGColor];
        }else
        {
            button3.layer.borderColor=[[UIColor grayColor]CGColor];
        }
        [button3 setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
      
        NSString*str3=[NSString stringWithFormat:@"%d",!button3.selected];
        NSLog(@"--------%@",str3);
        [self SendNotifationStr3 :str3];

        
        sender.selected=!sender.selected;
        
    }else if (sender.tag==10004)
    {

        if (sender.selected==isBoreColor) {
            button4.layer.borderColor=[[UIColor redColor]CGColor];
        }else
        {
            button4.layer.borderColor=[[UIColor grayColor]CGColor];
        }
    [button4 setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
   
    NSString*str4=[NSString stringWithFormat:@"%d",!button4.selected];
    NSLog(@"--------%@",str4);
    [self SendNotifationStr4 :str4];
        button4.selected=!button4.selected;
}else if (sender.tag==10005)
{
    if (sender.selected==isBoreColor) {
        button5.layer.borderColor=[[UIColor redColor]CGColor];
    }else
    {
        button5.layer.borderColor=[[UIColor grayColor]CGColor];

    }
    [button5 setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    NSString*str5=@"";

    if (!button5.selected) {
        str5 = @"独家";
    }
    else
    {
        str5 = @"";
    }
    
    NSLog(@"--------%@",str5);
    [self SendNotifationStr5:str5];
    
    
    sender.selected=!sender.selected;
}else if (sender.tag==10006)
{
    if (sender.selected==isBoreColor) {
        button6.layer.borderColor=[[UIColor redColor]CGColor];
    }else
    {
        button6.layer.borderColor=[[UIColor grayColor]CGColor];
    }
    [button6 setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
     NSString*str6=[NSString stringWithFormat:@"%d",!button6.selected];
    NSLog(@"--------%@",str6);
    [self SendNotifationStr6 :str6];
    
    
    sender.selected=!sender.selected;
}

}
-(void)SendNotifationStr1:(NSString*)Str
{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"labelTextNotification1" object:Str];
    
}
-(void)SendNotifationStr2:(NSString*)Str
{
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"labelTextNotification2" object:Str];
    
}
-(void)SendNotifationStr3:(NSString*)Str
{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"labelTextNotification3" object:Str];
    
}
-(void)SendNotifationStr4:(NSString*)Str
{
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"labelTextNotification4" object:Str];
    
}
-(void)SendNotifationStr5:(NSString*)Str
{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"labelTextNotification5" object:Str];
    
}
-(void)SendNotifationStr6:(NSString*)Str
{
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"labelTextNotification6" object:Str];
    

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
