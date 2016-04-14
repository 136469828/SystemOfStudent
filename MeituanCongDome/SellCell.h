//
//  SellCell.h
//  MeituanCongDome
//
//  Created by JCong on 15/10/22.
//  Copyright © 2015年 梁健聪. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SellCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *sellACTImg;
@property (weak, nonatomic) IBOutlet UIView *sellView;

- (void)configCellWithSellModels:(NSArray *)sellModels;
@end
