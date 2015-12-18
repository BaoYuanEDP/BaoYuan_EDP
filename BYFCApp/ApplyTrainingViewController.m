//
//  ApplyTrainingViewController.m
//  BYFCApp
//
//  Created by 王鹏 on 15/12/1.
//  Copyright © 2015年 PengLee. All rights reserved.
//

#import "ApplyTrainingViewController.h"
#import "PL_Header.h"
#import "TrainingModel.h"
#import "TrainingTableViewCell.h"
const char*QueueMainTableView;
@interface ApplyTrainingViewController ()<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate>
{
//    请求的传输的参数
//    课程类型
    NSString*Type;
//    课程名称
    NSString*Name;
//    课程时间
    NSString*Date;
//    类型的number
    NSString*Type_Number;
//    培训no
    NSString*noLabel;
//    CellIndexPath
    NSIndexPath*index2;
    
}
@property(nonatomic,strong)NSMutableArray*TrainingData;
@property(nonatomic,strong)UINib*loadnib;
@end

@implementation ApplyTrainingViewController


-(UINib *)loadnib
{
    if (!_loadnib) {
        _loadnib=[UINib nibWithNibName:@"TrainingTableViewCell" bundle:nil];
    }
    return _loadnib;
}
-(NSMutableArray *)TrainingData
{
    if (!_TrainingData) {
        _TrainingData=[NSMutableArray array];
    }
    return _TrainingData;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"培训申请";
    [self TrainingDataRequest];

   
    UIButton*LeftBut=[[UIButton alloc]initWithFrame:CGRectMake(10, 10, 10, 20)];
    [LeftBut setBackgroundImage:[UIImage imageNamed:@"返回.png"] forState:0];
    [LeftBut addTarget:self action:@selector(returnPopView) forControlEvents:UIControlEventTouchDown];
    UIBarButtonItem*barLeft=[[UIBarButtonItem alloc]initWithCustomView:LeftBut];
    self.navigationItem.leftBarButtonItem=barLeft;
    
  }
-(void)TrainingDataRequest
{
    PL_PROGRESS_SHOW;
    [[MyRequest defaultsRequest]GetLessonListUserid:[PL_USER_STORAGE objectForKey:PL_USER_NAME] Token:[PL_USER_STORAGE objectForKey:PL_USER_TOKEN] string:^(NSMutableArray *array) {
        
        [self.TrainingData addObjectsFromArray:array];
        PL_PROGRESS_DISMISS;
        dispatch_queue_t MainTableViewQueue=dispatch_queue_create(QueueMainTableView, DISPATCH_QUEUE_SERIAL);
        dispatch_sync(MainTableViewQueue, ^{
            
            self.Applicant_Lael.text=[PL_USER_STORAGE objectForKey:PL_USER_TRUE_NAME];
            self.EmployeeID_Label.text=[PL_USER_STORAGE objectForKey:PL_USER_code];
            self.MainTableView.dataSource=self;
            self.MainTableView.delegate=self;
            self.ReasonTextView.layer.cornerRadius=10;
            self.ReasonTextView.layer.masksToBounds=YES;
            self.ReasonTextView.delegate=self;
            [self.MainTableView reloadData];
            NSLog(@"子线程");
        });
        
        
        
        
    }];
    
    
    
}
-(void)returnPopView

{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark--MainTabelViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.TrainingData.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    TrainingTableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:@"subcell"];
    if (!cell) {
        cell=[[self.loadnib instantiateWithOwner:self options:nil] lastObject];
        
    }
    TrainingModel*model=self.TrainingData[indexPath.row];
    cell.SubCell_Date.text=model.LessonDate;
    cell.SubCell_Name.text=model.LessonName;
    cell.SubCell_Type.text=model.LessonTypeName;
    cell.Type_Number.hidden=YES;
    cell.NOlABEL.hidden=YES;
    cell.NOlABEL.text=model.LessonNo;
    cell.Type_Number.text=[NSString stringWithFormat:@"%@",model.LessonType];
       cell.selectedBackgroundView=[[UIImageView alloc]initWithImage:[self createImageWithColor:[UIColor colorWithRed:242.0f/255.0f green:76.0f/255.0f blue:47.0f/255.0f alpha:0.8]]];
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return self.HeaderView;
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return self.FooterView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 106;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 103;
}
#pragma mark--SelectTabelViewCell
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    TrainingTableViewCell*cell=(TrainingTableViewCell*)[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row inSection:0]];
        cell.SubCell_Type.textColor=[UIColor whiteColor];
        cell.SubCell_Name.textColor=[UIColor whiteColor];
        cell.SubCell_Date.textColor=[UIColor whiteColor];
        cell.SubCell_Date.font=[UIFont systemFontOfSize:15];
        cell.SubCell_Name.font=[UIFont systemFontOfSize:15];
        cell.SubCell_Type.font=[UIFont systemFontOfSize:15];
        Type=cell.SubCell_Type.text;
        Date=cell.SubCell_Date.text;
        Name=cell.SubCell_Name.text;
        Type_Number=cell.Type_Number.text;
        noLabel=cell.NOlABEL.text;

 
    
    
}
#pragma mark--点击之后的cell变换方法
-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TrainingTableViewCell*cell=(TrainingTableViewCell*)[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row inSection:0]];
    
    cell.SubCell_Type.textColor=[UIColor blackColor];
    cell.SubCell_Name.textColor=[UIColor blackColor];
    cell.SubCell_Date.textColor=[UIColor blackColor];
    cell.SubCell_Date.font=[UIFont systemFontOfSize:12];
    cell.SubCell_Name.font=[UIFont systemFontOfSize:12];
    cell.SubCell_Type.font=[UIFont systemFontOfSize:12];
  

    
}

- (IBAction)SureComintRequest:(UIButton *)sender {
    
    if ([self.ReasonTextView.text isEqualToString:@""]) {
        
        PL_ALERT_SHOW(@"请填写申请理由");
    }else
    {
         [self SureComintRequest];
    }
    
    
    
    
    
    
    
}
-(void)SureComintRequest
{
    PL_PROGRESS_SHOW;
    [[MyRequest defaultsRequest]LessonLeaveLessonNo:noLabel LessonName:Name LessonType:Type_Number LessonTypeName:Type Reason:self.ReasonTextView.text Userid:[PL_USER_STORAGE objectForKey:PL_USER_NAME] Token:[PL_USER_STORAGE objectForKey:PL_USER_TOKEN] completeBack:^(id obj) {
       
        NSString*BackStr=obj;
        if ([BackStr isEqualToString:@"OK"]) {
            
            PL_ALERT_SHOW(@"已成功发起流程，请等待审核");
            
            [self.navigationController popViewControllerAnimated:YES];
            
        }else if ([BackStr isEqualToString:@"1"])
        {
          PL_ALERT_SHOW(@"申请失败");
        }else if ([BackStr isEqualToString:@"2"])
        {
            PL_ALERT_SHOW(@"流程发起失败");
        }else if ([BackStr isEqualToString:@"exception"])
        {
            PL_ALERT_SHOW(@"奔溃性的错误");
        }

        
        PL_PROGRESS_DISMISS;
    }];
    
    
    
}
-(UIImage*) createImageWithColor:(UIColor*) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}
#pragma mark--textViewDelegate
-(void)textViewDidBeginEditing:(UITextView *)textView
{
    
        self.ResonTextViewLabel.hidden=YES;
    
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        
        [textView resignFirstResponder];
        if ([textView.text isEqualToString:@""]) {
            
            self.ResonTextViewLabel.hidden=NO;
        }else
        {
            self.ResonTextViewLabel.hidden=YES;
            
        }
    }

    return YES;
}

@end
