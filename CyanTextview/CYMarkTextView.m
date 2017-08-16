//
//  CYMarkTextView.m
//  CyanTextview
//
//  Created by cyan on 2017/8/16.
//  Copyright © 2017年 cyan. All rights reserved.
//

#import "CYMarkTextView.h"
@interface CYMarkTextView()




@end

@implementation CYMarkTextView


-(void)reloadAttri{
    NSString *regix = @"(#[^#]+#)";
    NSError *error;
    NSRegularExpression *regex = [NSRegularExpression
                                  regularExpressionWithPattern:regix
                                  options:0
                                  error:&error];
    
    //需要从新设置  颜色
    NSDictionary *dic = @{
                          NSForegroundColorAttributeName :_cytextColor,
                          NSFontAttributeName:_cyTextFont
                          };
    
    if (!error) { // 如果没有错误
        NSMutableAttributedString *attribute = [[NSMutableAttributedString alloc]initWithAttributedString:self.attributedText];
        [attribute addAttributes:dic range:[self.text rangeOfString:self.text]];
        
        
        // 获取特特定字符串的范围
        NSArray *array1 = [regex matchesInString:self.text options:0 range:NSMakeRange(0, self.text.length)];
        if ([array1 count]) {
            
            for (NSTextCheckingResult *objc in array1) {
                NSRange range = objc.range;
                
                [attribute addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(range.location, range.length)];

            }
        }

        self.attributedText = attribute;
        self.selectedRange = _cyCelectedRange;
        
    } else { // 如果有错误，则把错误打印出来
        NSLog(@"error - %@", error);
    }
}
@end
