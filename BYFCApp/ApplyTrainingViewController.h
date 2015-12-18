//
//  ApplyTrainingViewController.h
//  BYFCApp
//
//  Created by 王鹏 on 15/12/1.
//  Copyright © 2015年 PengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ApplyTrainingViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *MainTableView;
@property (weak, nonatomic) IBOutlet UILabel *Applicant_Lael;
@property (weak, nonatomic) IBOutlet UILabel *EmployeeID_Label;
@property (strong, nonatomic) IBOutlet UIView *HeaderView;
@property (weak, nonatomic) IBOutlet UITextView *ReasonTextView;
@property (strong, nonatomic) IBOutlet UIView *FooterView;

@property (weak, nonatomic) IBOutlet UILabel *ResonTextViewLabel;


@end
