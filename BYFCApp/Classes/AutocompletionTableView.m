//
//  AutocompletionTableView.m
//
//  Created by Gushin Arseniy on 11.03.12.
//  Copyright (c) 2012 Arseniy Gushin. All rights reserved.
//

#import "AutocompletionTableView.h"

@interface AutocompletionTableView () 
@property (nonatomic, strong) NSArray *suggestionOptions; // of selected NSStrings 
@property (nonatomic, strong) UITextField *textField; // will set automatically as user enters text
@property (nonatomic, strong) UIFont *cellLabelFont; // will copy style from assigned textfield
@end

@implementation AutocompletionTableView

@synthesize suggestionsDictionary = _suggestionsDictionary;
@synthesize suggestionOptions = _suggestionOptions;
@synthesize textField = _textField;
@synthesize cellLabelFont = _cellLabelFont;
@synthesize options = _options;

#pragma mark - Initialization
- (UITableView *)initWithTextField:(UITextField *)textField inViewController:(UIViewController *) parentViewController withOptions:(NSDictionary *)options
{
    //set the options first
    self.options = options;
    self.rowHeight = 44;
    
    // frame must align to the textfield 
    CGRect frame = CGRectMake(textField.frame.origin.x+80, textField.frame.origin.y+textField.frame.size.height+20, textField.frame.size.width-80, 160);
    
    // save the font info to reuse in cells
    self.cellLabelFont = textField.font;
    
    self = [super initWithFrame:frame
             style:UITableViewStylePlain];
    
    self.delegate = self;
    self.dataSource = self;
    self.scrollEnabled = YES;
    
    // turn off standard correction
    textField.autocorrectionType = UITextAutocorrectionTypeNo;
    
    // to get rid of "extra empty cell" on the bottom
    // when there's only one cell in the table
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, textField.frame.size.width, 1)]; 
    v.backgroundColor = [UIColor clearColor];
    [self setTableFooterView:v];
    self.hidden = YES;
    
    [parentViewController.view addSubview:self];
    [parentViewController.view  bringSubviewToFront:self];
    
    return self;
}

-(UITableView *)initWithTextField:(UITextField *)textField inView:(UIView *) parentView withOptions:(NSDictionary *)options
{
    //set the options first
    self.options = options;
    self.rowHeight = 44;
    
    // frame must align to the textfield
    CGRect frame = CGRectMake(50, 145, textField.frame.size.width+40, 160);
    
    // save the font info to reuse in cells
    self.cellLabelFont = textField.font;
    
    self = [super initWithFrame:frame
                          style:UITableViewStylePlain];
    self.layer.borderColor = [UIColor blackColor].CGColor;
    self.layer.borderWidth = 1.0f;
    
    self.delegate = self;
    self.dataSource = self;
    self.scrollEnabled = YES;
    
    // turn off standard correction
    textField.autocorrectionType = UITextAutocorrectionTypeNo;
    
    // to get rid of "extra empty cell" on the bottom
    // when there's only one cell in the table
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, textField.frame.size.width, 1)];
    v.backgroundColor = [UIColor clearColor];
    [self setTableFooterView:v];
    self.hidden = YES;
    
    [parentView addSubview:self];
    [parentView  bringSubviewToFront:self];
    
    return self;

}


#pragma mark - Logic staff
- (BOOL) substringIsInDictionary:(NSString *)subString
{
    NSMutableArray *tmpArray = [NSMutableArray array];
   // NSRange range;
//
//    for (NSString *tmpString in self.suggestionsDictionary)
//    {
//        range = ([[self.options valueForKey:ACOCaseSensitive] isEqualToNumber:[NSNumber numberWithInt:1]]) ? [tmpString rangeOfString:subString] : [tmpString rangeOfString:subString options:NSCaseInsensitiveSearch];
//        if (range.location != NSNotFound) [tmpArray addObject:tmpString];
//    }
//    if ([tmpArray count]>0)
//    {
//        self.suggestionOptions = tmpArray;
//        return YES;
//    }
    //不是中文
    if (subString.length>0 && ![ChineseInclude isIncludeChineseInString:subString]) {
        NSString *subsubString = [subString lowercaseStringWithLocale:[NSLocale currentLocale]];
        for (int i=0; i<self.suggestionsDictionary.count; i++) {
            if ([ChineseInclude isIncludeChineseInString:_suggestionsDictionary[i]])
            {
//                NSString *tempPinYinStr = [PinYinForObjc chineseConvertToPinYin:_suggestionsDictionary[i]];
//                NSRange titleResult=[tempPinYinStr rangeOfString:subString options:NSCaseInsensitiveSearch];
//                
//                if (titleResult.length>0) {
//                    [tmpArray addObject:_suggestionsDictionary[i]];
//                }
                NSString *tempPinYinHeadStr = [PinYinForObjc chineseConvertToPinYinHead:_suggestionsDictionary[i]];
                NSRange titleHeadResult=[tempPinYinHeadStr rangeOfString:subsubString options:NSAnchoredSearch];
                if (titleHeadResult.length>0) {
                    [tmpArray addObject:_suggestionsDictionary[i]];
                }

            }
            else {
                NSRange titleResult=[_suggestionsDictionary[i] rangeOfString:subsubString options:NSAnchoredSearch];
                if (titleResult.length>0) {
                    [tmpArray addObject:_suggestionsDictionary[i]];
                    
                    
                }
            }
            
        }
        self.suggestionOptions = tmpArray;
        return YES;
        
    }
    //是中文
    else if(subString.length>0 && [ChineseInclude isIncludeChineseInString:subString])
    {
        for (NSString *tempStr in _suggestionsDictionary) {
            NSRange titleResult=[tempStr rangeOfString:subString options:NSAnchoredSearch];
            if (titleResult.length>0) {
                [tmpArray addObject:tempStr];
            }
        }
        self.suggestionOptions = tmpArray;
        return YES;
    }
    return NO;
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.suggestionOptions.count ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *AutoCompleteRowIdentifier = @"AutoCompleteRowIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:AutoCompleteRowIdentifier];
    if (cell == nil) 
    {
        cell = [[UITableViewCell alloc] 
                 initWithStyle:UITableViewCellStyleDefault reuseIdentifier:AutoCompleteRowIdentifier];
    }
    cell.backgroundColor = [UIColor clearColor];
    
    if ([self.options valueForKey:ACOUseSourceFont]) 
    {
        cell.textLabel.font = [self.options valueForKey:ACOUseSourceFont];
    } else 
    {
        cell.textLabel.font = self.cellLabelFont;
    }
    cell.textLabel.adjustsFontSizeToFitWidth = NO;
    cell.textLabel.text = [self.suggestionOptions objectAtIndex:indexPath.row];

    return cell;
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.textField setText:[self.suggestionOptions objectAtIndex:indexPath.row]];
    [self hideOptionsView];
}

#pragma mark - UITextField delegate
- (void)textFieldValueChanged:(UITextField *)textField
{
    NSLog(@"%s",__FUNCTION__);
    self.textField = textField;
    NSString *curString = textField.text;
    NSLog(@"++++++%@",self.textField);
    if (![curString length])
    {
        [self hideOptionsView];
        return;
    } else if ([self substringIsInDictionary:curString])
        {
            [self showOptionsView];
            [self reloadData];
        } else [self hideOptionsView];
}

#pragma mark - Options view control
- (void)showOptionsView
{
    self.hidden = NO;
}

- (void) hideOptionsView
{
    NSLog(@"%s",__FUNCTION__);
    self.hidden = YES;
}

@end
