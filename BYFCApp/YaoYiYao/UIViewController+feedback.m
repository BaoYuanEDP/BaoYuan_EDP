//
//  UIViewController+feedback.m
//  accert
//
//  Created by zzs on 15/4/17.
//  Copyright (c) 2015年 PengLee. All rights reserved.
//

#import "UIViewController+feedback.h"
#import "PL_Header.h"
@implementation UIViewController (feedback)
- (BOOL)canBecomeFirstResponder
{
    return YES;
}
//摇动结束
- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    
    
//    if ([[[feed apprenceShow] getCurrentVC ] isKindOfClass:[feed class]])
//    {
//        return;
//        
//        
//    }
//    else
//    {
//        if ([feed isCurrentViewControllerVisible:[feed new]])
//        {
//            return;
//            
//        }
//        else
//        {
//
//            NSLog(@"------------------------------------------------------------");
//            [self cutterViewToDocument];
//            
//            [self presentViewController:[feed apprenceShow] animated:NO completion:nil];
//
//            
//        }
//        
//    }
    
    
}
- (void)cutterViewToDocument
 {
     NSLog(@"%s",__FUNCTION__);
        UIWindow *screenWindow = [[UIApplication sharedApplication] keyWindow];

        UIGraphicsBeginImageContext(screenWindow.frame.size);
         [screenWindow.layer renderInContext:UIGraphicsGetCurrentContext()];
         UIImage *screenShot = UIGraphicsGetImageFromCurrentImageContext();
         UIGraphicsEndImageContext();
         UIImageWriteToSavedPhotosAlbum(screenShot, nil, nil, nil);
     
         NSData *screenShotPNG = UIImagePNGRepresentation(screenShot);
         NSError *error = nil;
         [screenShotPNG writeToFile:[[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"by.error.png"] options:NSAtomicWrite error:&error];
     //NSLog(@"%@",NSHomeDirectory());
}
@end
