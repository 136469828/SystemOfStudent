//
//  MTNextManger.h
//  MeituanCongDome
//
//  Created by JCong on 15/10/28.
//  Copyright © 2015年 梁健聪. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *MTNetManagerRefreshNotify;
@interface MTNextManger : NSObject

@property (nonatomic, strong) NSMutableArray *sellDatas;
@property (nonatomic, strong) NSMutableArray *OneDatas;
@property (nonatomic, strong) NSMutableArray *severDatas;
@property (nonatomic, strong) NSMutableArray *stopDatas;
@property (nonatomic, strong) NSMutableArray *advDatas;
@property (nonatomic, strong) NSString *mullsX;
@property (nonatomic, strong) NSString *mullsY;
+ (instancetype)shareInstance;
- (void)loadData;

@end
