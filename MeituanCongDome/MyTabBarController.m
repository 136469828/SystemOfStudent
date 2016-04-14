//
//  MainViewController.m
//  MeituanCongDome
//
//  Created by JCong on 15/10/20.
//  Copyright © 2015年 梁健聪. All rights reserved.
//

#import "MyTabBarController.h"
#import "HomeViewController.h"
#import "OutsideViewController.h"
#import "InfoViewController.h"
#import "MoreViewController.h"

#define RGBColor(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]

@interface MyTabBarController ()

@end

@implementation MyTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTabBarController];
    //设置tabbar上标题的颜色
//    [self.tabBar setTintColor:RGBColor(53, 182, 169)];
    //设置tabbar的背景图片
//    [self.tabBar setBackgroundImage:[UIImage imageNamed:@"bg_tabbar"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

    
}
#pragma mark TabBarView
- (void)setTabBarController{
    
    HomeViewController *homeVC = [[HomeViewController alloc] init];
    [self setUpOneChildViewController:homeVC Homepage:[UIImage imageNamed:@"icon_tabbar_merchant_normal"] Selected:[UIImage imageNamed:@"icon_tabbar_merchant_selected"] title:@"团购"];
    OutsideViewController *outsideVC = [[OutsideViewController alloc] init];
    [self setUpOneChildViewController:outsideVC Homepage:[UIImage imageNamed:@"icon_tabbar_onsite"] Selected:[UIImage imageNamed:@"icon_tabbar_onsite_selected"] title:@"上门"];
    
    InfoViewController *infoVC = [[InfoViewController alloc] init];
    [self setUpOneChildViewController:infoVC Homepage:[UIImage imageNamed:@"icon_tabbar_mine"] Selected:[UIImage imageNamed:@"icon_tabbar_mine_selected"] title:@"我的"];
    
    MoreViewController *moreVC = [[MoreViewController alloc] init];
    [self setUpOneChildViewController:moreVC Homepage:[UIImage imageNamed:@"icon_tabbar_misc"] Selected:[UIImage imageNamed:@"icon_tabbar_misc_selected"] title:@"更多"];
    
    
    
}
#pragma mark 快速创建TabBarView模板
- (void)setUpOneChildViewController:(UIViewController *)viewController Homepage:(UIImage *)homepage Selected:(UIImage *)selectedImage title:(NSString *)title{
    
    UINavigationController *navC = [[UINavigationController alloc]initWithRootViewController:viewController];
//    navC.title = title; // 标题
//    navC.tabBarItem = [[UITabBarItem alloc] initWithTitle:title image:[homepage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]selectedImage:selectedImage];

    navC.tabBarItem = [[UITabBarItem alloc] initWithTitle:title image:homepage selectedImage:[selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
//    [navC.navigationBar setTranslucent:NO];  // 不透明

    [self addChildViewController:navC];
}

@end
