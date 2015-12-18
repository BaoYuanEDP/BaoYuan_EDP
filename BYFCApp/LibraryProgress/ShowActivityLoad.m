


//如果需要使用自定义的直接在这里就可以修改

#import "ShowActivityLoad.h"
static ShowActivityLoad * __shareDefault = nil;

@implementation ShowActivityLoad

+ (instancetype )shareDefault
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __shareDefault = [[ShowActivityLoad alloc]init];
        
        
    });
    return __shareDefault;
  
}
+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        __shareDefault =   [super allocWithZone:zone];
        
    });
    return __shareDefault;
    
}
- (instancetype)init
{
    if (self = [super init])
    {
        [self setBaseProgressUI];
    }
    return self;
}
//显示baseUI
- (void)setBaseProgressUI
{
    [KVNProgress appearance].statusColor = [UIColor darkGrayColor];
    [KVNProgress appearance].statusFont = [UIFont systemFontOfSize:17.0f];
    [KVNProgress appearance].circleStrokeForegroundColor = [UIColor darkGrayColor];
    [KVNProgress appearance].circleStrokeBackgroundColor = [[UIColor darkGrayColor] colorWithAlphaComponent:0.3f];
    [KVNProgress appearance].circleFillBackgroundColor = [UIColor clearColor];
    [KVNProgress appearance].backgroundFillColor = [UIColor colorWithWhite:0.9f alpha:0.9f];
    [KVNProgress appearance].backgroundTintColor = [UIColor whiteColor];
    [KVNProgress appearance].successColor = [UIColor darkGrayColor];
    [KVNProgress appearance].errorColor = [UIColor darkGrayColor];
    [KVNProgress appearance].circleSize = 75.0f;
    [KVNProgress appearance].lineWidth = 2.0f;
}
//显示自定义UI
- (void)setCustoomProgressUI
{
    [KVNProgress appearance].statusColor = [UIColor whiteColor];
    [KVNProgress appearance].statusFont = [UIFont fontWithName:@"HelveticaNeue-Thin" size:15.0f];
    [KVNProgress appearance].circleStrokeForegroundColor = [UIColor whiteColor];
    [KVNProgress appearance].circleStrokeBackgroundColor = [UIColor colorWithWhite:1.0f alpha:0.3f];
    [KVNProgress appearance].circleFillBackgroundColor = [UIColor colorWithWhite:1.0f alpha:0.1f];
    [KVNProgress appearance].backgroundFillColor = [UIColor colorWithRed:0.173f green:0.263f blue:0.856f alpha:0.9f];
    [KVNProgress appearance].backgroundTintColor = [UIColor colorWithRed:0.173f green:0.263f blue:0.856f alpha:1.0f];
    [KVNProgress appearance].successColor = [UIColor whiteColor];
    [KVNProgress appearance].errorColor = [UIColor whiteColor];
    [KVNProgress appearance].circleSize = 110.0f;
    [KVNProgress appearance].lineWidth = 1.0f;
}

- (void)showNormalProgress
{
    if ([self isNotFullScreen])
        {
        [KVNProgress showWithParameters:@{KVNProgressViewParameterFullScreen: @([self isNotFullScreen])}];
    } else {
        [KVNProgress show];
    }
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [KVNProgress dismiss];
//    });

}
- (void)showStatusAndSolidbg
{
    [KVNProgress showWithParameters:@{KVNProgressViewParameterStatus: @"努力加载中...",
                                      KVNProgressViewParameterBackgroundType: @(KVNProgressBackgroundTypeSolid),
                                      KVNProgressViewParameterFullScreen: @([self isNotFullScreen])}];
    
//    dispatch_main_after(10.0f, ^{
//        [self showErrorAndStatus];
//        
//    });
    dispatch_main_after(40.0f, ^{
        [self dismissProgress];
        
    });

    

}

- (void)showStatusAndDeterminnaterProgress
{
    if ([self isNotFullScreen]) {
        [KVNProgress showWithParameters:@{KVNProgressViewParameterStatus: @"Loading...",
                                          KVNProgressViewParameterFullScreen: @([self isNotFullScreen])}];
    } else {
        [KVNProgress showWithStatus:@"正在加载中..."];
    }
    
    dispatch_main_after(40.0f, ^{
        [KVNProgress dismiss];
    });

}
- (void)showSuccessAndStatus
{
    if ([self isNotFullScreen]) {
        [KVNProgress showSuccessWithParameters:@{KVNProgressViewParameterStatus: @"Success",
                                                 KVNProgressViewParameterFullScreen: @([self isNotFullScreen])}];
    } else {
        [KVNProgress showSuccessWithStatus:@"Success"];
    }
}
- (void)showProgress
{
    if ([self isNotFullScreen]) {
        [KVNProgress showProgress:0.0f
                       parameters:@{KVNProgressViewParameterStatus: @"Loading with progress...",
                                    KVNProgressViewParameterFullScreen: @([self isNotFullScreen])}];
    } else {
        [KVNProgress showProgress:0.0f
                           status:@"Loading with progress..."];
    }
    
    [self updateProgress];
    
    dispatch_main_after(2.7f, ^{
        [KVNProgress updateStatus:@"You can change to a multiline status text dynamically!"];
    });
    dispatch_main_after(5.5f, ^{
        [self showSuccessAndStatus];
    });

}
- (void)showErrorAndStatus
{
    if ([self isNotFullScreen]) {
        [KVNProgress showErrorWithParameters:@{KVNProgressViewParameterStatus: @"加载失败...",
                                               KVNProgressViewParameterFullScreen: @([self isNotFullScreen])}];
    } else {
        [KVNProgress showErrorWithStatus:@"加载失败..."];
    }

}
- (void)showRun
{
    if ([self isNotFullScreen]) {
        [KVNProgress showWithParameters:@{KVNProgressViewParameterStatus: @"提交中,请稍后",
                                          KVNProgressViewParameterFullScreen: @([self isNotFullScreen])}];
    } else {
        [KVNProgress showWithStatus:@"提交中,请稍后"];
    }
    
    
}
- (void)showImage
{
    if ([self isNotFullScreen]) {
        [KVNProgress showWithParameters:@{KVNProgressViewParameterStatus: @"图片上传中,请稍后",
                                          KVNProgressViewParameterFullScreen: @([self isNotFullScreen])}];
    } else {
        [KVNProgress showWithStatus:@"图片上传中,请稍后"];
    }

    
}
- (void)showCompletHUD
{
    [self setCustoomProgressUI];
    
    if ([self isNotFullScreen]) {
        [KVNProgress showProgress:0.0f
                       parameters:@{KVNProgressViewParameterStatus: @"You can custom several things like colors, fonts, circle size, and more!",
                                    KVNProgressViewParameterFullScreen: @([self isNotFullScreen])}];
    } else {
        [KVNProgress showProgress:0.0f
                           status:@"You can custom several things like colors, fonts, circle size, and more!"];
    }
    
    [self updateProgress];
    
    dispatch_main_after(5.0f, ^{
        [self showSuccessAndStatus];
        [self setBaseProgressUI];
    });

}
- (void)dismissProgress
{
   // [KVNProgress dismiss];
    dispatch_main_after(1.0f, ^{
        [KVNProgress dismiss];
        
    });
}
//是否需要全屏
- (BOOL)isCallFullScreen
{
    return YES;
}
- (BOOL)isNotFullScreen
{
    return NO;
    
}
#pragma mark - Helper

- (void)updateProgress
{
    dispatch_main_after(2.0f, ^{
        [KVNProgress updateProgress:0.3f
                           animated:YES];
    });
    dispatch_main_after(2.5f, ^{
        [KVNProgress updateProgress:0.5f
                           animated:YES];
    });
    dispatch_main_after(2.8f, ^{
        [KVNProgress updateProgress:0.6f
                           animated:YES];
    });
    dispatch_main_after(3.7f, ^{
        [KVNProgress updateProgress:0.93f
                           animated:YES];
    });
    dispatch_main_after(5.0f, ^{
        [KVNProgress updateProgress:1.0f
                           animated:YES];
    });
}





static void dispatch_main_after(NSTimeInterval delay, void (^block)(void))
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        block();
    });
}




@end
