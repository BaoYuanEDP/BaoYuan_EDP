//
//  LookKeySubCell.m
//  单个demo
//
//  Created by 王鹏 on 15/12/8.
//  Copyright © 2015年 王鹏. All rights reserved.
//

#import "LookKeySubCell.h"
#import "PL_Header.h"
@implementation LookKeySubCell

- (void)awakeFromNib {
    // Initialization code
    
    self.SubCellView.layer.cornerRadius=8;
    self.SubCellView.layer.masksToBounds=YES;
    
    
}
-(void)AddObjectsKeySubCellArray:(NSDictionary*)Dic
{
     
        self.NameLanel.text=Dic[@"UserName"];
    if ([Dic[@"WhereKey"] isEqualToString:@"宝源"]) {
        self.TypeLabel.text=@"宝原";
    }else
    {
        self.TypeLabel.text=Dic[@"WhereKey"];
    }
    
        self.PassWordLabel.text=[NSString stringWithFormat:@"密码:%@",Dic[@"PasswordKey"]];
        self.PhoneNumber.text=Dic[@"ContactMess"];
        self.RemarksLabel.text=Dic[@"Remark"];
        self.DateLabel.text=Dic[@"DateTime"];
        [self.KeyNumber setTitle:Dic[@"HouseKey"] forState:0];
  
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
