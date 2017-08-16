//
//  ShowCell.m
//  SDPlay
//
//  Created by cyan on 2017/8/15.
//  Copyright © 2017年 cyan. All rights reserved.
//

#import "ShowCell.h"

@implementation ShowCell


-(instancetype)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    if (self) {
        
        [self createUI];
    }
    return self;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    
    return  self;
}
-(void)createUI{
    
    _cellLab  = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 50)];
    _cellLab.backgroundColor = [UIColor redColor];
    _cellLab.text = @"label";
    _cellLab.textColor = [UIColor yellowColor];
    _cellLab.textAlignment = NSTextAlignmentCenter;
    _cellLab.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:_cellLab];
    
}


@end
