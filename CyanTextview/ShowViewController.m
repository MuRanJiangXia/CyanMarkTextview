//
//  ShowViewController.m
//  SDPlay
//
//  Created by cyan on 2017/8/15.
//  Copyright © 2017年 cyan. All rights reserved.
//

#import "ShowViewController.h"
#import "ShowCell.h"

// 屏幕宽度
#define MainScreenWidth [UIScreen mainScreen].bounds.size.width
// 屏幕高度
#define MainScreenHeight [UIScreen mainScreen].bounds.size.height

@interface ShowViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSArray *_cellArr;
}

@property(nonatomic,strong)UITableView *table;

@end

@implementation ShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.table];
    [self loadData];
}

-(void)loadData{
    NSArray *arr = @[@"#云的微博红包#",@"#美美的红包#",@"#ds红包#",@"#mm红包#"];
    _cellArr = arr;
    [self.table reloadData];
}

#pragma mark --- table
-(UITableView *)table{
    if (!_table) {
        _table = [[UITableView alloc]initWithFrame:CGRectMake(0, 20,MainScreenWidth, MainScreenHeight ) style:UITableViewStyleGrouped];
        [_table registerClass:[ShowCell class] forCellReuseIdentifier:@"ShowCell"];
        
        _table.delegate = self;
        _table.dataSource = self;
        _table.backgroundColor =   [UIColor whiteColor];
        //去掉头部留白
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 0.001)];
        view.backgroundColor = [UIColor redColor];
        _table.tableHeaderView = view;
        //去掉边线
//        _table.separatorStyle = UITableViewCellSeparatorStyleNone;
        
    }
    return _table;
}

#pragma mark UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _cellArr.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ShowCell  *cell =  [tableView dequeueReusableCellWithIdentifier:@"ShowCell" forIndexPath:indexPath];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //    cell.delegete = self;
    cell.cellLab.text = _cellArr[indexPath.row];
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView  deselectRowAtIndexPath:indexPath animated:YES];
    NSLog(@"_celltext : %@",_cellArr[indexPath.row]);
    
    [self dismissViewControllerAnimated:YES completion:^{
        ;
    }];
    if ([self.delegate respondsToSelector:@selector(showVCChooseText:)]) {
        [self.delegate showVCChooseText:_cellArr[indexPath.row]];
    }
}

@end
