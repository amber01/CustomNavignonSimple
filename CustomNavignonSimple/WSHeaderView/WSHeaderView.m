//
//  WSHeaderView
//  CustomNavignonSimple
//
//  Created by shlity on 15/7/27.
//  Copyright (c) 2015年 shlity. All rights reserved.
//


#define WS_TABLE_HEADER_HEIGHT 263
#define WS_NAVIGATION_HEIGHT 64
#define kHeaderViewContentOffset @"contentOffset"

#import "WSHeaderView.h"

@implementation WSHeaderView{
    CGFloat _expandHeight;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

+ (id)expandWithScrollView:(UIScrollView*)scrollView expandView:(UIView*)expandView{
    WSHeaderView *expandHeader = [WSHeaderView new];
    [expandHeader expandWithScrollView:scrollView expandView:expandView];
    return expandHeader;
}

- (UIView *)setupNavigationColor:(UIColor *)color withTitle:(NSString *)titleStr{
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 64)];
    view.backgroundColor = [UIColor clearColor];
    
    _navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 64)];
    _navView.backgroundColor = color;
    _navView.alpha = 0;
    
    _lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 63.5, [UIScreen mainScreen].bounds.size.width, 0.5)];
    _lineView.backgroundColor = [UIColor colorWithRed:209/255.0 green:209/255.0 blue:209/255.0 alpha:1];
    _lineView.hidden = YES;
    
    //title
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, WS_NAVIGATION_HEIGHT/2, [UIScreen mainScreen].bounds.size.width, 20)];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.font = [UIFont fontWithName:@"Helvetica-bold" size:19];
    _titleLabel.textColor = [UIColor blackColor];
    _titleLabel.text = titleStr;
    _titleLabel.hidden = YES;
    [_navView addSubview:_titleLabel];
    
    [_navView addSubview:_lineView];
    [view addSubview:_navView];
    
    //back background View
    _backView = [[UIView alloc]initWithFrame:CGRectMake(17, WS_NAVIGATION_HEIGHT/2 - 3, 30, 30)];
    _backView.backgroundColor = [UIColor whiteColor];
    _backView.layer.cornerRadius = 15;
    _backView.clipsToBounds = YES;
    [view addSubview:_backView];
    
    //back button
    _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _backBtn.frame = CGRectMake(5, 6, 17, 17);
    [_backBtn setImage:[UIImage imageNamed:@"back_icon"] forState:UIControlStateNormal];
    [_backBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [_backView addSubview:_backBtn];
    
    return view;
}

- (void)expandWithScrollView:(UIScrollView*)scrollView expandView:(UIView*)expandView{
    
    
    _expandHeight = CGRectGetHeight(expandView.frame);
    
    _scrollView = scrollView;
    _scrollView.contentInset = UIEdgeInsetsMake(_expandHeight, 0, 0, 0);
    [_scrollView insertSubview:expandView atIndex:0];
    [_scrollView addObserver:self forKeyPath:kHeaderViewContentOffset options:NSKeyValueObservingOptionNew context:nil];
    [_scrollView setContentOffset:CGPointMake(0, - WS_TABLE_HEADER_HEIGHT)];

    _expandView = expandView;
    
    _expandView.contentMode= UIViewContentModeScaleAspectFill;
    _expandView.clipsToBounds = YES;
    
    [self reSizeView];

}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if (![keyPath isEqualToString:kHeaderViewContentOffset]) {
        return;
    }
    [self scrollViewDidScroll:_scrollView];
}

- (void)scrollViewDidScroll:(UIScrollView*)scrollView
{
    
    CGPoint  offset = scrollView.contentOffset;    //offset
    NSLog(@"——————offset—————— x:%f y:%f",offset.x,offset.y);
    
    
    CGFloat offsetY = scrollView.contentOffset.y;
    if(offsetY < _expandHeight * -1) {
        CGRect currentFrame = _expandView.frame;
        currentFrame.origin.y = offsetY;
        currentFrame.size.height = -1*offsetY;
        _expandView.frame = currentFrame;
    }else if (offset.y >= -WS_NAVIGATION_HEIGHT) {
        _navView.alpha = 1.0;
        _lineView.hidden = NO;
        _titleLabel.hidden = NO;
        _backView.backgroundColor = [UIColor clearColor];
    }else if (offset.y < -WS_NAVIGATION_HEIGHT){
        float alphaNum = (1-((offset.y)/-(WS_TABLE_HEADER_HEIGHT)))*1.298165173344;
        _backView.backgroundColor = [UIColor whiteColor];
        _lineView.hidden = YES;
        _titleLabel.hidden = YES;
        NSLog(@"alphaNum:%f",alphaNum);
        _navView.alpha = alphaNum;
    }
    if (offset.y < -WS_TABLE_HEADER_HEIGHT) {
        _navView.alpha = 0;
    }
}

- (void)reSizeView{
    [_expandView setFrame:CGRectMake(0, -1*_expandHeight, CGRectGetWidth(_expandView.frame), _expandHeight)];
}

- (void)dealloc{
    if (_scrollView) {
        [_scrollView removeObserver:self forKeyPath:kHeaderViewContentOffset];
        _scrollView = nil;
    }
    _expandView = nil;
}

- (void)backAction
{
    NSLog(@"action");
}

@end
