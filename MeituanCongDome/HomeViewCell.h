//
//  HomeViewCell.h
//  MeituanCongDome
//
//  Created by JCong on 15/10/20.
//  Copyright © 2015年 梁健聪. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *mname;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *rangeAndMtitle;
@property (weak, nonatomic) IBOutlet UILabel *subcate;
@property (weak, nonatomic) IBOutlet UILabel *solds;
@property (weak, nonatomic) IBOutlet UIImageView *bookinginfoImage;
@property (weak, nonatomic) IBOutlet UILabel *valueLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;

@end
