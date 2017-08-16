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
    //保留光标的位置
    _textView.cyCelectedRange = textView.selectedRange;
    

    [_textView reloadAttri];

}

#pragma mark  ShowVCDelegate
-(void)showVCChooseText:(NSString *)text{
    NSMutableString *muStr = [[NSMutableString alloc]initWithString:_textView.text] ;
    [muStr insertString:text atIndex: _textView.cyCelectedRange.location];
    
    _textView.text = [NSString stringWithFormat:@"%@",muStr];
    
    NSLog(@"location : %ld,length : %ld",_textView.cyCelectedRange.location,_textView.cyCelectedRange.length);
    
    _textView.cyCelectedRange = NSMakeRange(_textView.cyCelectedRange.location + text.length, _textView.cyCelectedRange.length);
    
    [_textView reloadAttri];
    [_textView becomeFirstResponder];
    


}

@end
