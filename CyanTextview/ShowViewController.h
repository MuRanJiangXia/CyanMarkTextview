//
//  ShowViewController.h
//  SDPlay
//
//  Created by cyan on 2017/8/15.
//  Copyright © 2017年 cyan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ShowVCDelegate <NSObject>

-(void)showVCChooseText:(NSString *)text;

@end
@interface ShowViewController : UIViewController

@property(nonatomic,weak)id<ShowVCDelegate>delegate;


@end
