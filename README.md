上下滑动TableView时让Navigation渐变，并且让headerView中的图片也跟着拖动放大
![gif](http://ww1.sinaimg.cn/bmiddle/63f96e20gw1eujs63fb39g208s0gax6p.gif "gif logo") 

使用方法:
    
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
    
    
