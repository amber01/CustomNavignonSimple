//
//  WSHeaderView
//  CustomNavignonSimple
//
//  Created by shlity on 15/7/27.
//  Copyright (c) 2015年 shlity. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface WSHeaderView : NSObject <UIScrollViewDelegate>
{
    UIScrollView   *_scrollView;
    UIView         *_expandView;
    
    UIView         *_navView;
    UIView         *_lineView;
    UILabel        *_titleLabel;
    UIView         *_backView;
    UIButton       *_backBtn;
}

+ (id)expandWithScrollView:(UIScrollView*)scrollView expandView:(UIView*)expandView;
- (UIView *)setupNavigationColor:(UIColor *)color withTitle:(NSString *)titleStr;

@end
