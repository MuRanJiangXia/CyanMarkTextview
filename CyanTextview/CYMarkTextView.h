//
//  CYMarkTextView.h
//  CyanTextview
//
//  Created by cyan on 2017/8/16.
//  Copyright © 2017年 cyan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CYMarkTextView : UITextView

@property(nonatomic,strong)UIFont *cyTextFont;
@property(nonatomic,strong)UIColor *cytextColor;

@property(nonatomic,assign)NSRange cyCelectedRange;

/**
 刷新 富文本
 */
-(void)reloadAttri;


@end
