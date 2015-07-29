//
//  ViewController.m
//  CustomNavignonSimple
//
//  Created by shlity on 15/7/27.
//  Copyright (c) 2015年 shlity. All rights reserved.
//

#import "ViewController.h"
#import "WSHeaderView.h"


@interface ViewController ()

@end

@implementation ViewController{
    WSHeaderView *_header;
    __weak UIImageView *_expandView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createdTabelView];
}

- (void)createdTabelView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    //init headview
    _header = [[WSHeaderView alloc]init];
    
    //set header view
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 263)];
    [imageView setImage:[UIImage imageNamed:@"mengyin"]];
    _header = [WSHeaderView expandWithScrollView:_tableView expandView:imageView];
    
    //set navigation view
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width , 64)];
    view.backgroundColor = [UIColor clearColor];
    UIColor *color = [UIColor colorWithRed:250/255.0 green:250/255.0 blue:250/255.0 alpha:1];
    view = [_header setupNavigationColor:color withTitle:@"detaile"];
    [self.view addSubview:view];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.navigationController.navigationBar.hidden = YES;
}

#pragma mark -- UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identityCell = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identityCell];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identityCell];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"current row:%ld",indexPath.row];
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
