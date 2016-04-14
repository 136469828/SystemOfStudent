//
//  MTNextManger.m
//  MeituanCongDome
//
//  Created by JCong on 15/10/28.
//  Copyright © 2015年 梁健聪. All rights reserved.
//

#import "MTNextManger.h"
#import "AFNetworking.h"

#import "SellModel.h"
#import "OneEDPHModel.h"
#import "SeverModel.h"
#import "StopModel.h"
#import "AdvModel.h"

#define URL @"http://app.360kad.com/Product/GetProductListByIds?pagetype=home&kclientid=62a806ad296a30b6845b193486ab3aad&utm_idfa=3D682E5B-5293-553B-ABA1-2D154135AGC8&utm_medium=iOS&utm_ot=15&utm_source=AppStore&utm_ver=3.3.2"
#import <MapKit/MapKit.h>
NSString *MTNetManagerRefreshNotify = @"MTNetManagerRefreshNotify";
static MTNextManger *manger = nil;
@implementation MTNextManger
+ (instancetype)shareInstance{
    static dispatch_once_t oneToken;
    dispatch_once(&oneToken, ^{
        if (!manger) {
            manger = [[[self class] alloc] init];
        
        }
    });
    return manger;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self loadData];
    }
    return self;
}
- (void)loadData{
    [self loadPOSTData];
    [self makeStopData];
    [self loadSellData];
    [self makeOneDatas];
//    [self advertisementData]; 可以删除（学习需要保留）
//    [self makeSeverDatas];
}
- (void)loadSellData{
    AFHTTPRequestOperationManager *manger = [AFHTTPRequestOperationManager manager];
    // 设置AF缓存(推陈出新机制)
    manger.requestSerializer.cachePolicy = NSURLRequestReturnCacheDataElseLoad;
    
    [manger GET:SELL_URL parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        id dataDic = responseObject[@"data"];

        id dataObj = dataDic[@"deals"];
        
        for (NSDictionary *dataDic in dataObj) {
            
            SellModel *sell = [[SellModel alloc] init];
            sell.squareimhurl = dataDic[@"mdcLogoUrl"];
            sell.sellPrice = dataDic[@"campaignprice"];
            sell.sellCampaignprice = dataDic[@"price"];
            
            if (self.sellDatas == nil) {
                self.sellDatas = [[NSMutableArray alloc] init];
            }
            
            [self.sellDatas addObject:sell];
        }
        //        NSLog(@"%ld",self.sellDatas.count);
        NSLog(@"Sell数据加载完成");
        [[NSNotificationCenter defaultCenter] postNotificationName:MTNetManagerRefreshNotify object:@(0)];
        
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        
    }];

}
- (void)makeOneDatas{
    
    AFHTTPRequestOperationManager *manger = [AFHTTPRequestOperationManager manager];
    manger.requestSerializer.cachePolicy = NSURLRequestReturnCacheDataElseLoad;
    [manger GET:ONEEDPH_URL parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        id datas = responseObject[@"data"];
        for (NSDictionary *dataDic in datas) {
            
            NSMutableString *stringDelete = [NSMutableString stringWithString:dataDic[@"imageurl"]];
            NSRange rage = [stringDelete rangeOfString:@"/w.h"];
            [stringDelete deleteCharactersInRange:rage];
            
            OneEDPHModel *one = [[OneEDPHModel alloc] init];
            one.maintitle = dataDic[@"maintitle"];
            one.deputytitle = dataDic[@"deputytitle"];
            one.imageUrl = stringDelete;
            
            if (self.OneDatas == nil) {
                self.OneDatas = [[NSMutableArray alloc] init];
            }
            
            [self.OneDatas addObject:one];
        }
        NSLog(@"Sell数据加载完成");
        [[NSNotificationCenter defaultCenter] postNotificationName:MTNetManagerRefreshNotify object:@(1)];
        
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        
    }];
}
- (void)makeSeverDatas{
    AFHTTPRequestOperationManager *manger = [AFHTTPRequestOperationManager manager];
    
        manger.requestSerializer.cachePolicy = NSURLRequestReturnCacheDataElseLoad;
    [manger GET:SEVER_URL parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        id datas = responseObject[@"data"];
        id dataArr = datas[@"topics"];
        for (NSDictionary *dataDic in dataArr) {
            
            NSMutableString *stringDelete = [NSMutableString stringWithString:dataDic[@"imageurl"]];
            NSRange rage = [stringDelete rangeOfString:@"/w.h"];
            [stringDelete deleteCharactersInRange:rage];
            
            
            SeverModel *sever = [[SeverModel alloc] init];
            sever.maintitle = dataDic[@"maintitle"];
            sever.deputytitle = dataDic[@"deputytitle"];
            sever.imageUrl = stringDelete;
            
            if (self.severDatas == nil) {
                self.severDatas = [[NSMutableArray alloc] init];
            }
            
            [self.severDatas addObject:sever];
        }
        NSLog(@"Sell数据加载完成");
        [[NSNotificationCenter defaultCenter] postNotificationName:MTNetManagerRefreshNotify object:@(2)];
        
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        
    }];
    
    
    
}
- (void)makeStopData{
    AFHTTPRequestOperationManager *manger = [AFHTTPRequestOperationManager manager];
    
    manger.requestSerializer.cachePolicy = NSURLRequestReturnCacheDataElseLoad;
    [manger GET:URL_SHOP parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        id dataArr = responseObject[@"data"];
        id data = dataArr[@"deals"];
        for (NSDictionary *dataDic in data) {
            StopModel *stop = [[StopModel alloc] init];
            stop.name = dataDic[@"mname"];
            stop.range = dataDic[@"range"];
            stop.price = dataDic[@"price"];
            stop.mtitle = dataDic[@"mtitle"];
            stop.solds = dataDic[@"solds"];
            stop.value = dataDic[@"value"];
            
            NSMutableString *stringDelete = [NSMutableString stringWithString:dataDic[@"imgurl"]];
            NSRange rage = [stringDelete rangeOfString:@"/w.h"];
            [stringDelete deleteCharactersInRange:rage];
            stop.image = stringDelete;
            stop.bookinginfo = dataDic[@"bookinginfo"];
            if (self.stopDatas == nil) {
                self.stopDatas = [[NSMutableArray alloc] init];
            }
            
            [self.stopDatas addObject:stop];
        }
        
        NSLog(@"stopCell数据加载完成");
        [[NSNotificationCenter defaultCenter] postNotificationName:MTNetManagerRefreshNotify object:@(4)];
        
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        
    }];
    
    
}
- (void)advertisementData{
    AFHTTPRequestOperationManager *manger = [AFHTTPRequestOperationManager manager];
    [manger GET:ADV_URL parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        NSMutableString *stringDelete = [[NSMutableString alloc] init];
        
        NSArray *dataArray =responseObject[@"data"];
        
        id datas = dataArray;
        
        NSArray *dicDatas = datas[@"topics"];
        
        for (NSDictionary *temDic in dicDatas) {
            
            stringDelete = [NSMutableString stringWithString:temDic[@"imageurl"]];
            NSRange rage = [stringDelete rangeOfString:@"/w.h"];
            [stringDelete deleteCharactersInRange:rage];
            AdvModel *adv = [[AdvModel alloc]init];
            adv.advImage = stringDelete;
            if (self.advDatas.count == 0) {
                self.advDatas = [[NSMutableArray alloc] init];
            }
            [self.advDatas addObject:adv.advImage];
        }
        NSLog(@"advertisement数据加载完成");
        [[NSNotificationCenter defaultCenter] postNotificationName:MTNetManagerRefreshNotify object:@(2)];

        
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        
    }];
}
// 获取当前位置数据
- (void)mullsData{
    AFHTTPRequestOperationManager *manger = [AFHTTPRequestOperationManager manager];
    manger.requestSerializer.cachePolicy = NSURLRequestReturnCacheDataElseLoad;
    [manger GET:URL_City parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSMutableArray *dataArrs = [NSMutableArray arrayWithObject:responseObject[@"data"]];
        for (NSDictionary *dataDic in dataArrs) {
            self.mullsX = dataDic[@"lat"];
            self.mullsY = dataDic[@"lng"];
//            continue;
            [self loadPOSTData];
        }

        
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        
    }];
}
- (void)loadPOSTData{
    AFHTTPRequestOperationManager *manger = [AFHTTPRequestOperationManager manager];
    
    [manger POST:URL parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
    } success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        id data = responseObject;
        
        if ([data isKindOfClass:[NSArray class]]) {
            NSLog(@"%@",data);
        }
        NSDictionary *dicData = data;
        NSLog(@"%@",dicData);
        
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        
    }];
    
    
    [manger POST:URL parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        id data = responseObject;
        
        if ([data isKindOfClass:[NSArray class]]) {
            NSLog(@"%@",data);
        }
        NSDictionary *dicData = data;
        NSLog(@"%@",dicData);
        
        
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        
    }];

}
@end
