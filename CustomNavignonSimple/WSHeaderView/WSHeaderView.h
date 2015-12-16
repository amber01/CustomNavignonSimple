//
//  WSHeaderView
//  CustomNavignonSimple
//
//  Created by shlity on 15/7/27.
//  Copyright (c) 2015年 shlity. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
@protocol WSHeaderViewDelegate <NSObject>
@optional
-(void)changNaviBtnColorToWhite;
-(void)changNaviBtnColorToOther;
@end

@interface WSHeaderView : UIView
@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) UIImageView *headerImageView;
@property (nonatomic, retain) UIView *naviView;
@property (nonatomic, copy)   NSString  *title;

@property (nonatomic, weak) id <WSHeaderViewDelegate> delegate;
- (WSHeaderView*)initWithTableViewWithHeaderImage:(UIImage*)headerImage withOTCoverHeight:(CGFloat)height withTableviewIsStyleGrouped:(BOOL)isStyleGrouped;
@end
