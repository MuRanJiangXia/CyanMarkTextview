//
//  ViewController.m
//  CyanTextview
//
//  Created by cyan on 2017/8/16.
//  Copyright © 2017年 cyan. All rights reserved.
//

#import "ViewController.h"
#import "ShowViewController.h"
#import "CYMarkTextView.h"

#ifdef DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr,"%s中%s:%d\t%s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String],[[[NSString stringWithUTF8String:__FUNCTION__] lastPathComponent] UTF8String] ,__LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String])
#else
#define NSLog(FORMAT, ...) nil
#endif


@interface ViewController ()<UITextViewDelegate,ShowVCDelegate>{
    
    CYMarkTextView *_textView;

}
@property(nonatomic,assign)NSRange selectedRange;

@property(nonatomic,strong)UIFont *textFont;
@property(nonatomic,strong)UIColor *textColor;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _textView = [[CYMarkTextView alloc]initWithFrame:CGRectMake(30, 40, 200, 300)];
    
    _textView.backgroundColor = [UIColor yellowColor];
    _textView.delegate = self;
    _textView.textColor = [UIColor redColor];
    _textView.font = [UIFont systemFontOfSize:18];
    [self.view addSubview:_textView];
    
    _textView.cytextColor = _textView.textColor;
    _textView.cyTextFont = _textView.font;
    

//    [_textView reloadAttri];
    
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    
    paragraphStyle.lineSpacing = 10;// 字体的行间距
    NSDictionary *attributes = @{
                                 NSForegroundColorAttributeName:[UIColor redColor],
                                 NSFontAttributeName:[UIFont systemFontOfSize:16],
                                 NSParagraphStyleAttributeName:paragraphStyle
                                 };
    _textView.typingAttributes = attributes;
    
    _textView.text = @"#云的微博红包###美美的红包#的微博#美美的红包###云的微博红包##云的微博红包#";

    [_textView reloadAttri];

}




-(BOOL)textViewShouldBeginEditing:(UITextView *)textView{

    //里延时调用一个函数，只要延0.1s，之后再获取光标就正常了
    [self performSelector:@selector(textViewDidChange:) withObject:textView afterDelay:0.1f];
    
    
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text;{
    
    
    if ([text isEqualToString:@"#"]) {
        _textView.cyCelectedRange = textView.selectedRange;
        ShowViewController *showVC  = [ShowViewController new];
        showVC.delegate = self;
        
        [self presentViewController:showVC animated:YES completion:^{
            ;
        }];
        
    }
    
    return YES;
}

-(void)textViewDidChange:(UITextView *)textView{

    
    UITextRange *selectedRange = [textView markedTextRange];
    //获取高亮部分
    UITextPosition *pos = [textView positionFromPosition:selectedRange.start offset:0];
    
    //如果在变化中是高亮部分在变，就不要计算字符了
    if (selectedRange && pos) {
        NSLog(@"有高亮状态文字");
        
        return ;
    }
    //保留光标的位置
    _textView.cyCelectedRange = textView.selectedRange;
    [_textView reloadAttri];
    

    

}

#pragma mark  ShowVCDelegate
-(void)showVCChooseText:(NSString *)text{
    NSMutableString *muStr = [[NSMutableString alloc]initWithString:_textView.text] ;
    [muStr insertString:text atIndex: _textView.cyCelectedRange.location];
    _textView.text = [NSString stringWithFormat:@"%@",muStr];
    
    _textView.cyCelectedRange = NSMakeRange(_textView.cyCelectedRange.location + text.length, _textView.cyCelectedRange.length);
    
    [_textView reloadAttri];
    [_textView becomeFirstResponder];
    


}





//  根据NSTextRange转换成 NSRange
- (NSRange) selectedRange:(UITextView *)textField
{
    UITextPosition* beginning = textField.beginningOfDocument;
    UITextRange* selectedRange = textField.selectedTextRange;
    UITextPosition* selectionStart = selectedRange.start;
    UITextPosition* selectionEnd = selectedRange.end;
    const NSInteger location = [textField offsetFromPosition:beginning toPosition:selectionStart];
    const NSInteger length = [textField offsetFromPosition:selectionStart toPosition:selectionEnd];
    
    NSRange range =  NSMakeRange(location, length);
    return range;
}

@end
