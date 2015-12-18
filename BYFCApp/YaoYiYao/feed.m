//
//  feed.m
//  accert
//
//  Created by PengLee on 15/4/17.
//  Copyright (c) 2015年 PengLee. All rights reserved.
//

#import "feed.h"
#define view_left_insets 40
#define view_top_insets 80

@interface feed ()


@end
static feed * __defult = nil;

@implementation feed
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
        
    _isShowView = YES;
    
}
- (void)viewDidDisappear:(BOOL)animated
{
    _isShowView = NO;
    
}
+(BOOL)isCurrentViewControllerVisible:(feed *)viewController
{
    return (viewController.isViewLoaded && viewController.view.window);
    
    
    
}
//获取当前屏幕显示的viewcontroller
- (UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //self.view.backgroundColor = [[UIColor clearColor] colorWithAlphaComponent:0.5] ;
    
    
    NSLog(@"chuxian");
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self initView];
//    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickremove)];
//    [self.view addGestureRecognizer:tap];

    
}
- (void)initView
{
    UIView * bg_view = [[UIView alloc]initWithFrame:CGRectMake(view_left_insets, view_top_insets, PL_WIDTH-2*view_left_insets, PL_HEIGHT/2-40)];
    bg_view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:bg_view];
    NSInteger padding = 8;
    
    UILabel * titleLable = [[UILabel alloc]init];
    [bg_view addSubview:titleLable];
    titleLable.text = @"标题:";
    titleLable.font = [UIFont boldSystemFontOfSize:PL_ROOM_DETAIL_FONT_SIGN_SIZE];
    [titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bg_view.mas_left).with.offset(padding);
        make.top.equalTo(bg_view.mas_top).offset(padding);
        make.width.equalTo(@(view_left_insets));
        make.height.equalTo(@25);
        
    }];
    UITextField * textFieldContent = [[UITextField alloc]init];
    textFieldContent.placeholder = @"请输入标题";
    
    textFieldContent.layer.borderColor= [UIColor blackColor].CGColor;
    textFieldContent.layer.borderWidth = 1.0;
    textFieldContent.autocapitalizationType = UITextAutocapitalizationTypeNone;
    textFieldContent.clearButtonMode = UITextFieldViewModeAlways;
   // textFieldContent.backgroundColor = [UIColor redColor];
    [bg_view addSubview:textFieldContent];
    [textFieldContent mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.equalTo(@(view_left_insets-15));
        make.left.equalTo(titleLable.mas_right);
        make.right.equalTo(bg_view.mas_right).offset(-padding);
        make.top.equalTo(bg_view.mas_top).offset(padding);
        
    }];
    UILabel * feedLable = [[UILabel alloc]init];
    feedLable.text = @"意见反馈:";
    
    [bg_view addSubview:feedLable];
    [feedLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titleLable.mas_left);
        make.top.equalTo(textFieldContent.mas_bottom);
        make.width.greaterThanOrEqualTo(titleLable.mas_width);
        make.height.equalTo(titleLable.mas_height);
        
    }];
    UITextView * textView =[[UITextView alloc]init];
    textView.layer.borderWidth = 1.0;
    textView.text = @"反馈";
    
    textView.layer.borderColor = [UIColor blackColor].CGColor;
    [bg_view addSubview:textView];
    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bg_view.mas_left).offset(padding);
        make.top.equalTo(feedLable.mas_bottom);
        make.right.equalTo(bg_view.mas_right).offset(-padding);
        make.bottom.equalTo(bg_view.mas_bottom).offset(-5*padding);
        
        
    }];
    UIButton * sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [sureBtn setBackgroundImage:[UIImage imageNamed:@"提交按钮@2x.png"] forState:UIControlStateNormal];
    [sureBtn addTarget:self action:@selector(commitClick) forControlEvents:UIControlEventTouchUpInside];
    
    [bg_view addSubview:sureBtn];
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bg_view.mas_left).offset(padding);
        make.top.equalTo(textView.mas_bottom).offset(padding);
        make.width.equalTo(@(view_left_insets*1.5));
        make.height.equalTo(@(view_left_insets-10));
        
    }];
    UIButton * cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancleBtn setBackgroundImage:[UIImage imageNamed:@"取消@2x.png"] forState:UIControlStateNormal];
    [cancleBtn addTarget:self action:@selector(cancleClick) forControlEvents:UIControlEventTouchUpInside];
    
    [bg_view addSubview:cancleBtn];
    [cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(bg_view.mas_right).offset(-padding);
        make.top.equalTo(textView.mas_bottom).offset(padding);
        make.width.equalTo(sureBtn.mas_width);
        make.height.equalTo(@(view_left_insets-10));
        
    }];
    
    //取截图n
    NSString *aPath = [NSString stringWithFormat:@"%@/Documents/%@.png",NSHomeDirectory(),@"by.error"];
    NSLog(@"%@",aPath);
    UIImage *image = [[UIImage alloc]initWithContentsOfFile:aPath];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(5, PL_HEIGHT-230, 120, 200)];
    imageView.image = image;
    [self.view addSubview:imageView];
    
    
}
#pragma mark --提交
- (void)commitClick
{
    NSLog(@"提交");
    [self clickremove];
     [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)cancleClick
{
    [self clickremove];
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark --
- (void)clickremove
{
    [self.view endEditing:YES];
    
   
    
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
    
}
- (id)init
{
    if (self = [super init]){
        
        
    }
    return self;
    
    
}
+ (id)allocWithZone:(struct _NSZone *)zone
{

    
    static dispatch_once_t oncetoken;
    dispatch_once(&oncetoken, ^{
        __defult = [super allocWithZone:zone];
    });
    return __defult;
    
}
+ (feed *)apprenceShow
{

    
    static dispatch_once_t oncetoken;
    dispatch_once(&oncetoken, ^{
        __defult = [[[self class] alloc] init];
    });

    return __defult;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
