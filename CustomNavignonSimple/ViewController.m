//
//  ViewController.m
//  CustomNavignonSimple
//
//  Created by shlity on 15/7/27.
//  Copyright (c) 2015年 shlity. All rights reserved.
//

#import "ViewController.h"
#import "WSHeaderView.h"


@interface ViewController ()<WSHeaderViewDelegate>

@end

@implementation ViewController{
    WSHeaderView *header;
    __weak UIImageView *_expandView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createdTabelView];
}

- (void)createdTabelView
{
    //set header view
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 263)];
    [imageView setImage:[UIImage imageNamed:@"mengyin"]];
    header = [[WSHeaderView alloc]initWithTableViewWithHeaderImage:imageView.image withOTCoverHeight:imageView.frame.size.height withTableviewIsStyleGrouped:NO];
    header.delegate = self;
    header.title = @"detail";
    header.tableView.dataSource = self;
    header.tableView.delegate = self;
    header.tableView.separatorColor = [UIColor clearColor];
    header.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:header];
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
