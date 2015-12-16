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
    BOOL isNavBtnColorWhite;
    UIView *_lineView;
    UILabel *titleLabel;
}

- (WSHeaderView*)initWithTableViewWithHeaderImage:(UIImage*)headerImage withOTCoverHeight:(CGFloat)height withTableviewIsStyleGrouped:(BOOL)isStyleGrouped{
    CGRect bounds = [[UIScreen mainScreen] bounds];
    self = [[WSHeaderView alloc] initWithFrame:bounds];
    self.headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, bounds.size.width, height)];
    _headerImageView.contentMode = UIViewContentModeScaleAspectFill;
    _headerImageView.clipsToBounds = YES;
    if (headerImage) {
        [_headerImageView setImage:headerImage];
    }
    _expandHeight = height;
    if (isStyleGrouped) {
        self.tableView = [[UITableView alloc] initWithFrame:self.frame style:UITableViewStyleGrouped];
    }else{
        self.tableView = [[UITableView alloc] initWithFrame:self.frame];
    }
    self.tableView.tableHeaderView.backgroundColor = [UIColor clearColor];
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, bounds.size.width, height)];
    [self addSubview:self.tableView];
    [self.tableView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    [self.tableView addSubview:_headerImageView];
    self.naviView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, bounds.size.width, 64)];
    _naviView.backgroundColor = [UIColor colorWithRed:250/255.0 green:250/255.0 blue:250/255.0 alpha:0.0f];
    _lineView = [[UIView alloc]initWithFrame:CGRectMake(0, _naviView.frame.size.height - 0.5, [UIScreen mainScreen].bounds.size.width, 0.5)];
    _lineView.backgroundColor = [UIColor colorWithRed:209/255.0 green:209/255.0 blue:209/255.0 alpha:0.0f];
    [_naviView addSubview:_lineView];
    
    titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 30, self.frame.size.width, 20)];
    titleLabel.text = self.title;
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.font = [UIFont systemFontOfSize:19];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.hidden = YES;
    [_naviView addSubview:titleLabel];
    
    [self addSubview:_naviView];
    isNavBtnColorWhite = YES;
    return self;
}

- (void)animationForTableView{
    CGFloat offset = self.tableView.contentOffset.y;
    
    
    if (self.tableView.contentOffset.y > 0) {
        float alpha = 1-MAX(((WS_TABLE_HEADER_HEIGHT - (offset) - 64)/ (WS_TABLE_HEADER_HEIGHT - 64)),0);
        _naviView.backgroundColor = [UIColor colorWithRed:250/255.0 green:250/255.0 blue:250/255.0 alpha:alpha];
        _lineView.backgroundColor = [UIColor colorWithRed:209/255.0 green:209/255.0 blue:209/255.0 alpha:alpha];
        if (alpha>0.5) {
            if (isNavBtnColorWhite) {
                if ([self.delegate respondsToSelector:@selector(changNaviBtnColorToOther)]) {
                    [self.delegate changNaviBtnColorToOther];
                }
                isNavBtnColorWhite = NO;
            }
        }else{
            if (!isNavBtnColorWhite) {
                if ([self.delegate respondsToSelector:@selector(changNaviBtnColorToWhite)]) {
                    [self.delegate changNaviBtnColorToWhite];
                }
                isNavBtnColorWhite = YES;
            }
        }
        if (alpha > 0.5) {
            titleLabel.hidden = NO;
        }else{
            titleLabel.hidden = YES;
        }
    }else {
        float OxyK = (_expandHeight + (-offset))/_expandHeight;
        self.headerImageView.frame = CGRectMake(-self.frame.size.width*(OxyK-1)/2.0f, offset, self.frame.size.width*OxyK, _expandHeight + (-offset));
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    [self animationForTableView];
}

- (void)dealloc
{
    [self.tableView removeObserver:self forKeyPath:@"contentOffset"];
}

@end
