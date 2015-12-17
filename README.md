上下滑动TableView时让Navigation渐变，并且让headerView中的图片也跟着拖动放大
![gif](http://ww1.sinaimg.cn/bmiddle/63f96e20gw1eujs63fb39g208s0gax6p.gif "gif logo") 

使用方法:
    
    //init headview
UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 263)];
    [imageView setImage:[UIImage imageNamed:@"mengyin"]];
    header = [[WSHeaderView alloc]initWithTableViewWithHeaderImage:imageView.image withOTCoverHeight:imageView.frame.size.height withTableviewIsStyleGrouped:NO withTitle:@"detail"];

    
    
