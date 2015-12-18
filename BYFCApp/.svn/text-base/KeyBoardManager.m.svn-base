//
//  KeyBoardManager.m
//  BYFCApp
//
//  Created by PengLee on 15/3/30.
//  Copyright (c) 2015年 PengLee. All rights reserved.
//

#import "KeyBoardManager.h"
#import "PL_Header.h"
@interface KeyBoardManager ()

@end

@implementation KeyBoardManager

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(ksyWillAnimation:) name:UIKeyboardDidChangeFrameNotification object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)ksyWillAnimation:(NSNotification *)note
{
    UIView * fview = [self.view firstResponder];
    
    
    CGFloat fy = CGRectGetMaxY(fview.frame);
    NSDictionary * dict = note.userInfo;
    CGRect endFrame = [[dict objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    CGFloat delta = endFrame.origin.y - fy-40;
    
    if (delta <0)
    {
        CGAffineTransform pTransform = CGAffineTransformMakeTranslation(0, delta);
        [UIView animateWithDuration:0.25 animations:^{
            //            self.view.center = CGPointMake(self.view.center.x, self.view.center.y+delta);
            self.view.transform = pTransform;
            
            
        }];
        
        
        
    }
    else
    {
        CGAffineTransform pTransform = CGAffineTransformMakeTranslation(0, 0);
        [UIView animateWithDuration:0.25 animations:^{
            //            self.view.center = CGPointMake(self.view.center.x, self.view.bounds.size.height/2);
            self.view.transform = pTransform;
            
        }];
        
        
    }
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
