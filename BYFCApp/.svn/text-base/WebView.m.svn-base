//
//  WebView.m
//  BYFCApp
//
//  Created by PengLee on 15/3/6.
//  Copyright (c) 2015年 PengLee. All rights reserved.
//

#import "WebView.h"
#import "PL_Header.h"
@implementation WebView
@synthesize conmonWebView;

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithPoint:(float)frame  loadURL:(NSString *)URL
{
    if (self = [super init])
    {
         //self.backgroundColor = [UIColor whiteColor];
        self.frame  = CGRectMake(0, frame, PL_WIDTH, PL_HEIGHT-frame);
        
        self.layer.borderColor = [UIColor clearColor].CGColor;
        self.layer.borderWidth = 2.0f;
        NSURL * url =[NSURL URLWithString:URL];
        NSURLRequest * request =[[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30.0f];
        
        conmonWebView = [[UIWebView alloc]init];
        conmonWebView.backgroundColor = [UIColor whiteColor];
        [conmonWebView loadRequest:request];
        
        conmonWebView.scalesPageToFit = NO;
        conmonWebView.scrollView.showsHorizontalScrollIndicator = NO;
      //  conmonWebView.scrollView.alwaysBounceHorizontal = YES;
        // web.scrollView.bounces = YES;
        
//    conmonWebView.scrollView.contentSize = CGSizeMake(0, PL_HEIGHT-frame);
    conmonWebView.scrollView.scrollIndicatorInsets = UIEdgeInsetsZero;
         [self addSubview:conmonWebView];
       
        [conmonWebView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self).insets(UIEdgeInsetsMake(0, 0, 0, 0));
            
        }];
        
        self.autoresizesSubviews = YES;
        for (UIView * _aView in [conmonWebView subviews])
        {
            [(UIScrollView *)_aView setShowsVerticalScrollIndicator:NO];
            for (UIView * _inScrollow in _aView.subviews)
            {
                if ([_inScrollow isKindOfClass:[UIImageView class]])
                {
                    _inScrollow.hidden = YES;
                    
                }
            }
            [(UIScrollView *)_aView setPagingEnabled:YES];
            
        }

        
    }
    return self;
    
}
@end
