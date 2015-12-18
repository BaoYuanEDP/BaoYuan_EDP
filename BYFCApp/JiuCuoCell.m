//
//  JiuCuoCell.m
//  BYFCApp
//
//  Created by PengLee on 15/8/12.
//  Copyright (c) 2015年 PengLee. All rights reserved.
//

#import "JiuCuoCell.h"

@implementation JiuCuoCell
{
    UITableView *tableView1;
}

-(instancetype)init
{
    self = [super init];
    if (self) {
    
        _jiuCuoDescription.delegate=self;
        _jiuCuoText.delegate=self;

        
        
    }
    return self;
}
-(void)createTableView
{
    tableView1 = [[UITableView alloc] initWithFrame:CGRectMake(_typeLabel.frame.origin.x-9, _typeLabel.frame.origin.y+25, 95,140)];
    arrayType = @[@"房间",@"客厅",@"卫生间",@"阳台",@"栋座",@"面积",@"房号",@"类型",@"所在楼层",@"总楼层",@"朝向",@"装修",@"业主"];
    tableView1.layer.borderWidth = 1;
    tableView1.layer.borderColor = [UIColor grayColor].CGColor;
    tableView1.delegate = self;
    tableView1.dataSource = self;
       [self addSubview:tableView1];
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40.0f;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arrayType.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellName = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if(!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
    }
    cell.textLabel.text = arrayType[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:14.0f];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _typeLabel.text = arrayType[indexPath.row];
    tableView1.hidden = YES;
    _dropBtn.selected = NO;
    _btnImage.image = [UIImage imageNamed:@"xiala.png"];
}
- (IBAction)dropAction:(id)sender {
    NSLog(@"下拉列表");
    
    if (_dropBtn.selected == NO) {
        [self createTableView];
        _dropBtn.selected = YES;
        _btnImage.image = [UIImage imageNamed:@"shangjiantou.png"];
        tableView1.hidden = NO;
        [_jiuCuoDescription resignFirstResponder];
        [_jiuCuoText resignFirstResponder];
        
    }
    else
    {
         _dropBtn.selected = NO;
        tableView1.hidden = YES;
        _btnImage.image = [UIImage imageNamed:@"xiala.png"];
        [_jiuCuoDescription resignFirstResponder];
        [_jiuCuoText resignFirstResponder];
    }
    
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    if ([string isEqualToString:@"\n"]) {
        [_jiuCuoText resignFirstResponder];
    }
    
    
    
    return YES;
    
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [_jiuCuoDescription resignFirstResponder];
    }
    
    return YES;
    
}
@end
