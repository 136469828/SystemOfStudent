//
//  SecViewController.m
//  MeituanCongDome
//
//  Created by JCong on 15/10/20.
//  Copyright © 2015年 梁健聪. All rights reserved.
//

#import "OutsideViewController.h"
#import "UINavigationBar+Awesome.h"

#define NAVBAR_CHANGE_POINT 50

@interface OutsideViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@end

@implementation OutsideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setBarTintColor:RGBColor(53, 182, 169)];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;

    UIImageView *view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 300)];
    view.image = [UIImage imageNamed:@"bg.jpg"];
    _tableView.tableHeaderView = view;

    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor blueColor]];
    [self.view addSubview:_tableView];
    [self setNavigationItem];
}
#pragma mark - 设置navigationItem
- (void)setNavigationItem{

    
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
    seachButton.backgroundColor = [UIColor clearColor];
    seachButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [seachButton setTitle:[NSString stringWithFormat:@"输入商家、品类、商圈"]  forState:UIControlStateNormal];
    [seachButton setImage:[UIImage imageNamed:@"icon_textfield_search@2x"] forState:UIControlStateNormal];
    seachButton.layer.cornerRadius = 10;
    seachButton.layer.masksToBounds = YES;
    self.navigationItem.titleView = seachButton;
    UIBarButtonItem *rView = [[UIBarButtonItem alloc] initWithCustomView:barRightView];
    self.navigationItem.rightBarButtonItem = rView;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    UIColor * color = [UIColor colorWithRed:0/255.0 green:175/255.0 blue:240/255.0 alpha:0];
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY > NAVBAR_CHANGE_POINT) {
        CGFloat alpha = MIN(0, 0 - ((NAVBAR_CHANGE_POINT + 64 - offsetY) / 64));
        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:alpha]];
    } else {
        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:1]];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.tableView.delegate = self;
    [self scrollViewDidScroll:self.tableView];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.tableView.delegate = nil;
    [self.navigationController.navigationBar lt_reset];
}

#pragma mark UITableViewDatasource

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    return @"header";
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 15;
}

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    return 5;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.textLabel.text = @"text";
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 65;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
