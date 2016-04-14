//
//  StopModel.h
//  MeituanCongDome
//
//  Created by JCong on 15/10/20.
//  Copyright © 2015年 梁健聪. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StopModel : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *image;
@property (nonatomic, strong) NSString *range;
@property (nonatomic, strong) NSString *mtitle;
@property (nonatomic, strong) NSString *subcate;
@property (nonatomic, strong) NSNumber *price;
@property (nonatomic, strong) NSNumber *solds;
@property (nonatomic, strong) NSString *bookinginfo;
@property (nonatomic, strong) NSString *value;
@property (nonatomic, strong) NSNumber *mllsX;
@property (nonatomic, strong) NSNumber *mllY;

@property (nonatomic, strong) NSString *distance;
@end
