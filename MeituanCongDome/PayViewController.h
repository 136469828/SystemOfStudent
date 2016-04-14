//
//  PayViewController.h
//  MeituanCongDome
//
//  Created by JCong on 16/2/16.
//  Copyright © 2016年 梁健聪. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Product : NSObject{
@private
    float     _price;
    NSString *_subject;
    NSString *_body;
    NSString *_orderId;
}

@property (nonatomic, assign) float price;
@property (nonatomic, copy) NSString *subject;
@property (nonatomic, copy) NSString *body;
@property (nonatomic, copy) NSString *orderId;

@end



@interface PayViewController : UIViewController

@end
