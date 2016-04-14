//
//  HomeViewController.m
//  MeituanCongDome
//
//  Created by JCong on 15/10/20.
//  Copyright © 2015年 梁健聪. All rights reserved.
//

#import "HomeViewController.h"

#import "HomeViewCell.h"
#import "SellCell.h"
#import "SevreCell.h"
#import "OneYuanCell.h"
#import "AdvertisementCell.h"

#import "StopModel.h"
#import "SellModel.h"
#import "AdvModel.h"
#import "SeverModel.h"
#import "OneEDPHModel.h"

#import "MTNextManger.h"

#import "UIImageView+advView.h"
#import "UIImageView+WebCache.h"

#import "MJRefresh/MJRefresh.h"
#import "DropDownListView.h"

#import "PayViewController.h"
#define ScreenWidth ([UIScreen mainScreen].bounds.size.width)
@interface HomeViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,copy)    UIScrollView *scroll;
@property(nonatomic,copy)    UIPageControl *pageControl;


@end

@implementation HomeViewController
{
    double prices;
    NSMutableArray *listNameArr;
    NSArray *heights;

}
// 销毁通知中心
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - 创建UI
- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *cachPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask, YES) objectAtIndex:0];
    NSLog(@"path :%@",cachPath);
    [self.navigationController.navigationBar setBarTintColor:RGBColor(53, 182, 169)];
    
    _tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
//    NSLog(@"%@ %@",NSStringFromClass([UIScreen mainScreen].bounds),NSStringFromClass(self.view.bounds));
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];

    [self setHearAndFootView];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reloadTableData:) name:MTNetManagerRefreshNotify object:nil];
    
    heights = @[@(160),@(210),@(1),@(1),@(100)]; // 每组高度

    [self setNavigationItem];
    [self registerNib];
    // 使用最基本的下拉刷新
#if 0
    MJRefreshNormalHeader *normalHeader =[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [[MTNextManger shareInstance] loadData];
    }];
    self.tableView.header = normalHeader;
#endif
    [[MTNextManger shareInstance] loadData];
    [self upDateData];
    NSLog(@"UI创建完成");
}
#pragma mark - 上/下拉刷新
- (void)upDateData{
    // 创建带动画的下拉刷新
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        sleep(1);
        [self.tableView reloadData];
        [self.tableView.header endRefreshing];
    }];
    NSArray *imageGifs = @[[UIImage imageNamed:@"icon_listheader_animation_1"],[UIImage imageNamed:@"icon_listheader_animation_2"]];
    [header setImages:imageGifs forState:MJRefreshStateRefreshing];
    self.tableView.header = header;
    
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        // 加载更多的网络请求
        sleep(1);
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:4] withRowAnimation:UITableViewRowAnimationAutomatic];
        [self.tableView.footer endRefreshing];
    }];
    self.tableView.footer = footer;

}
#pragma mark - 刷新UI
- (void)reloadTableData:(NSNotification *)note{
    NSLog(@"刷新UI");
    NSInteger section = [note.object integerValue];
    
    //根据段数刷新表格
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationAutomatic];

}
#pragma mark - 设置navigationItem
- (void)setNavigationItem{
#pragma mark - 设置左侧下拉菜单
    listNameArr = [NSMutableArray arrayWithArray:@[@[@"深圳"]]];
    DropDownListView *listView = [[DropDownListView alloc] initWithFrame:CGRectMake(0, 0, 65, 30)dataSource:self delegate:self];
    listView.mSuperView = self.view;
    
    UIBarButtonItem *lBut = [[UIBarButtonItem alloc] initWithCustomView:listView];
    
    self.navigationItem.leftBarButtonItem = lBut;
#pragma mark - 设置navigationItem右侧按钮
    UIView *barRightView = [[UIView alloc] initWithFrame:CGRectMake(0, 5, 90, 40)];
    barRightView.backgroundColor = [UIColor clearColor];
    
    UIButton *scanButton = [UIButton buttonWithType:UIButtonTypeCustom];
    scanButton.frame = CGRectMake(0, 0, 40, 40);
    [scanButton setImage:[UIImage imageNamed:@"icon_homepage_scan@2x"]forState:UIControlStateNormal];
    [barRightView addSubview:scanButton];
    
    UIButton *messageButton = [UIButton buttonWithType:UIButtonTypeCustom];
    messageButton.frame = CGRectMake(45, 0, 40, 40);
    [messageButton setImage:[UIImage imageNamed:@"icon_message_white@2x"]forState:UIControlStateNormal];
    [barRightView addSubview:messageButton];
#pragma mark - 设置navigationItem中间搜索按钮
    UIButton *seachButton = [UIButton buttonWithType:UIButtonTypeCustom];
    seachButton.frame = CGRectMake(0, 0, 210, 20);
    seachButton.backgroundColor = RGBColor(74, 161, 144);
    seachButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [seachButton setTitle:[NSString stringWithFormat:@"输入商家、品类、商圈"]  forState:UIControlStateNormal];
    [seachButton setImage:[UIImage imageNamed:@"icon_textfield_search@2x"] forState:UIControlStateNormal];
    seachButton.layer.cornerRadius = 10;
    seachButton.layer.masksToBounds = YES;
    self.navigationItem.titleView = seachButton;
    UIBarButtonItem *rView = [[UIBarButtonItem alloc] initWithCustomView:barRightView];
    self.navigationItem.rightBarButtonItem = rView;
}
#pragma mark - 设置头尾视图
- (void)setHearAndFootView{
#pragma mark - 设置头视图
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 375, 170)];
    headerView.backgroundColor = RGBColor(239, 239, 244);
    _tableView.tableHeaderView = headerView;
    
    UIView *topButtonView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 160)];
    topButtonView.backgroundColor = [UIColor whiteColor];
    [headerView addSubview:topButtonView];
    
    _scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0,0,[UIScreen mainScreen].bounds.size.width, 160)];

    _scroll.contentSize = CGSizeMake(2*[UIScreen mainScreen].bounds.size.width, 160);
    _scroll.bounces = YES;
    _scroll.pagingEnabled = YES;
    _scroll.delegate = self; // 实现协议
    _scroll.showsHorizontalScrollIndicator = NO;
    [topButtonView addSubview:_scroll];
    
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(5, 120, 375, 60)];
    // pageControl 小点颜色
    _pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    _pageControl.currentPageIndicatorTintColor =RGBColor(53, 182, 169);
    _pageControl.numberOfPages = 2;
    [_pageControl addTarget:self action:@selector(change:)forControlEvents:UIControlEventValueChanged];
    [topButtonView addSubview:_pageControl];
    
    NSArray *buttonTitles = @[@"美食", @"电影", @"酒店", @"KTV", @"丽人", @"休闲娱乐", @"今日新单", @"购物", @"优惠买单", @"周边游", @"火车票", @"外卖", @"生活服务", @"小吃快餐", @"美发", @"全部分类"];
    
    NSArray *imageNames = @[@"icon_homepage_foodCategory", @"icon_homepage_movieCategory", @"icon_homepage_hotelCategory", @"icon_homepage_KTVCategory", @"icon_homepage_beautyCategory", @"icon_homepage_entertainmentCategory", @"icon_homepage_dailyNewDealCategory", @"icon_homepage_shoppingCategory", @"icon_homepage_CouponCategory", @"icon_homepage_aroundjourneyCategory", @"icon_homepage_travellingCategory", @"icon_homepage_takeoutCategory", @"icon_homepage_lifeServiceCategory", @"icon_homepage_fastfoodCategory", @"icon_homepage_haircutCategory", @"icon_homepage_moreCategory"];
    
    for (int i = 0; i < buttonTitles.count; i++) {
        NSInteger index = i % 8;
        NSInteger page = i / 8;
        CGFloat xCoordinate;
        xCoordinate = ScreenWidth/4;
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(index * xCoordinate, page * (50 + 30) + 5, 70, 70);
        button.tag = i+1;
        
        [button setTitle:buttonTitles[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:13];
        
        [button setImage:[UIImage imageNamed:imageNames[i]] forState:UIControlStateNormal];
        //上  左  下  右
        button.titleEdgeInsets = UIEdgeInsetsMake(0, -30, -50, 0);
        
        button.imageEdgeInsets = UIEdgeInsetsMake(0, 18, 20, 0);
        
        [_scroll.viewForFirstBaselineLayout addSubview:button];
    }
#pragma mark - 设置尾视图
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 200)];
    footView.backgroundColor = RGBColor(239, 239, 244);
    UIView *footTopView = [[UIView alloc] initWithFrame:CGRectMake(10, 5, 355, 30)];
    footTopView.backgroundColor = [UIColor whiteColor];
    UILabel *footTopLabel = [[UILabel alloc] initWithFrame:footTopView.bounds];
    footTopLabel.text = @"查看全部团购";
    footTopLabel.textAlignment = YES;
    footTopLabel.textColor = RGBColor(53, 182, 169);
    footTopLabel.font = [UIFont systemFontOfSize:14];
    [footTopView addSubview:footTopLabel];
    
    UIView *footLastView = [[UIView alloc] initWithFrame:CGRectMake(10, 45, 355, 110)];
    footLastView.backgroundColor = [UIColor whiteColor];
    
    UILabel *footLastLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 60, 335, 30)];
    footLastLabel.text = @"我的美团DNA";
    footLastLabel.textAlignment = YES;
    footLastLabel.textColor = [UIColor whiteColor];
    footLastLabel.backgroundColor = RGBColor(53, 182, 169);
    footLastLabel.layer.cornerRadius = 5;
    footLastLabel.layer.masksToBounds = YES;
    [footLastView addSubview:footLastLabel];
    
    [footView addSubview:footLastView];
    [footView addSubview:footTopView];
    
    _tableView.tableFooterView = footView;

    
}
#pragma mark - 注册Cell
- (void)registerNib{
    /*
     #import "HomeViewCell.h"
     #import "SellCell.h"
     #import "SevreCell.h"
     #import "OneYuanCell.h"
     #import "AdvertisementCell.h"
     */
    [_tableView registerNib:[UINib nibWithNibName:@"HomeViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [_tableView registerNib:[UINib nibWithNibName:@"SellCell" bundle:nil] forCellReuseIdentifier:@"sell"];
    [_tableView registerNib:[UINib nibWithNibName:@"SevreCell" bundle:nil] forCellReuseIdentifier:@"severcell"];
    [_tableView registerNib:[UINib nibWithNibName:@"OneYuanCell" bundle:nil] forCellReuseIdentifier:@"onecell"];
    [_tableView registerNib:[UINib nibWithNibName:@"AdvertisementCell" bundle:nil] forCellReuseIdentifier:@"advcell"];
}
#pragma mark - scrollView协议
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    int page = scrollView.contentOffset.x/375;
    _pageControl.currentPage = page;
}

- (void)change:(UIPageControl *)pageControl{
    
    switch (pageControl.currentPage) {
        case 0:
            [_scroll setContentOffset:CGPointMake(0,0) animated:YES];
            break;
        case 1:
            [_scroll setContentOffset:CGPointMake(375,0) animated:YES];
            
            break;
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    
}
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 4) {
        MTNextManger *manger = [MTNextManger shareInstance];
        NSLog(@"%ld",manger.stopDatas.count);
        return manger.stopDatas.count;
//        return 20;
    }
    return 1;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    switch (indexPath.section) {
        case 0:
        {
            SellCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"sell"];

            if ([MTNextManger shareInstance].sellDatas.count != 0) {
                [cell configCellWithSellModels:[MTNextManger shareInstance].sellDatas];

            }else
            {
                cell.hidden = YES;
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
            break;
            
        case 1:
        {
            OneYuanCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"onecell"];
            
            if ([MTNextManger shareInstance].OneDatas.count != 0) {
                [cell configCellWithOneModels:[MTNextManger shareInstance].OneDatas];
                
            }else
            {
                cell.hidden = YES;
            }
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
            break;
            
        case 2:
        {
            AdvertisementCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"advcell"];

            [cell.advImage setImageWithURL:ADV_URL andPlaceImage:[UIImage imageNamed:@"errorImage"]];

            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.hidden = YES;
            return cell;
        }
            break;
        case 3:
        {
            SevreCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"severcell"];
            
            if ([MTNextManger shareInstance].severDatas.count != 0) {
                [cell configCellWithSeverModels:[MTNextManger shareInstance].severDatas];
                
            }else
            {
                cell.hidden = YES;
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.hidden = YES;
            return cell;
        }
            case 4:
            {
                HomeViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"cell"];
                MTNextManger *manger = [MTNextManger shareInstance];
                if (manger.stopDatas.count == 0) {
                    cell.hidden = YES;
                }else{
                StopModel *stop = manger.stopDatas[indexPath.row];
                
                cell.mname.text = stop.name;
                //    NSLog(@"%@",stop.name);

                cell.price.text = [NSString stringWithFormat:@"￥%.1f",[stop.price floatValue]];
                cell.rangeAndMtitle.text = [NSString stringWithFormat:@"[%@]%@",stop.range,stop.mtitle];
                cell.valueLabel.text = [NSString stringWithFormat:@"￥%ld",[stop.value integerValue]];
                cell.rangeAndMtitle.numberOfLines = 2;
                cell.rangeAndMtitle.adjustsFontSizeToFitWidth = YES;
                if (stop.bookinginfo.length != 0) {
                    cell.bookinginfoImage.hidden = YES;
                }
                cell.solds.text = [NSString stringWithFormat:@"已售%@", stop.solds];
                cell.distanceLabel.text = stop.distance;
                [cell.icon sd_setImageWithURL:[NSURL URLWithString:stop.image]];
                cell.selectionStyle = UITableViewCellSelectionStyleBlue;
                return cell;
                }
            }
            break;
            default:break;
    }
    return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"click");
    PayViewController *payV = [[PayViewController alloc] init];
    payV.hidesBottomBarWhenPushed = YES;
    [self presentViewController:payV animated:YES completion:nil];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [heights[indexPath.section]doubleValue];
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section != 4) {
        return nil;
    }
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 375, 30)];
    label.backgroundColor = [UIColor whiteColor];
    label.text = @"  猜你喜欢";
    label.font = [UIFont systemFontOfSize:15];

    return label;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 4) {
        return 40;
    }
    return 10;
}

#pragma mark - dropDownListDelegate
//-(void) chooseAtSection:(NSInteger)section index:(NSInteger)index
//{
//    // 选中的操作
//}

#pragma mark - dropdownList DataSource
-(NSInteger)numberOfSections
{
    return [listNameArr count];
}
-(NSInteger)numberOfRowsInSection:(NSInteger)section
{
    NSArray *arry =listNameArr[section];
    return [arry count];
}
-(NSString *)titleInSection:(NSInteger)section index:(NSInteger) index
{
    return listNameArr[section][index];
}
-(NSInteger)defaultShowSection:(NSInteger)section
{
    return 0;
}
@end
