//
//  HomeViewController.m
//  MeituanCongDome
//
//  Created by JCong on 15/10/20.
//  Copyright © 2015年 梁健聪. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DropDownChooseProtocol.h"
@interface HomeViewController : UIViewController<DropDownChooseDataSource,DropDownChooseDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end
