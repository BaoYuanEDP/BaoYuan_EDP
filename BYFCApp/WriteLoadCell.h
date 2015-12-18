//
//  WriteLoadCell.h
//  BYFCApp
//
//  Created by PengLee on 15/2/10.
//  Copyright (c) 2015年 PengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WriteLoadCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextView *genjinTextView;
@property (weak, nonatomic) IBOutlet UIButton *commitBtn;

@property (weak, nonatomic) IBOutlet UILabel *countNum;
@end
