//
//  ViewController.m
//  UISearchBar-Demo
//
//  Created by 詹志超 on 16/9/26.
//  Copyright © 2016年 zzc. All rights reserved.
//

#import "ViewController.h"

#import "UserModel.h"

#import "ZCSearchBarView.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation ViewController{
    
    UITableView *_tableView;
    
    NSMutableArray *_dataArr;
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    UserModel *model1 = [UserModel new];
    model1.name = @"张三";
    model1.phone = @"10086";
    model1.age = @"20岁";
    
    UserModel *model2 = [UserModel new];
    model2.name = @"李四";
    model2.phone = @"999";
    
    UserModel *model3 = [UserModel new];
    model3.name = @"王五";
    model3.phone = @"7777";

    
    UserModel *model4 = [UserModel new];
    model4.name = @"chaoge";
    model4.phone = @"888";
    model4.age = @"18岁";
    
    
    NSMutableArray *muarr = [NSMutableArray arrayWithObjects:model1,model2,model3,model4, nil];
    
    _dataArr = muarr;
    
    

    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 60, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 60)];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellID"];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [self.view addSubview:_tableView];
    
    
    
    
    ZCSearchBarView *search = [[ZCSearchBarView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 60)];
    search.dataArr = muarr;
    search.searchKyeArr = @[@"name",@"phone",@"age"];
    [self.view addSubview:search];
    
    search.searchResult = ^(NSMutableArray *result,BOOL isSearch){
        
        if (isSearch) {
            
            _dataArr = result;
            
        }else{
            
            _dataArr = muarr;
        }
        
        [_tableView reloadData];
    };
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID" forIndexPath:indexPath];
    
    
    UserModel *model = _dataArr[indexPath.row];
    
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ , %@, %@",model.name,model.phone,model.age];
    
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
