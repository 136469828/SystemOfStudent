//
//  SellCell.m
//  MeituanCongDome
//
//  Created by JCong on 15/10/22.
//  Copyright © 2015年 梁健聪. All rights reserved.
//

#import "SellCell.h"
#import "SellModel.h"
#import "UIImageView+WebCache.h"
@implementation SellCell

- (void)awakeFromNib {
    self.sellView.layer.cornerRadius = 5;
    self.sellView.layer.masksToBounds = YES;
    self.sellView.layer.borderWidth = 0.5;
    self.sellView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)configCellWithSellModels:(NSArray *)sellModels{
    for (int i = 0; i < 3; i++) {
        UIImageView *imageView = (UIImageView *)[self viewWithTag:10 + i];
        UILabel *sellPrice = (UILabel *)[self viewWithTag:20 + i];
        UILabel *sellCamprice = (UILabel *)[self viewWithTag:30 + i];
        SellModel *sell = sellModels[i];
        //                NSLog(@"--%@",manger.sellDatas);
        sellPrice.text = [NSString stringWithFormat:@"￥%.1f",[sell.sellPrice floatValue]];
        sellCamprice.text = [NSString stringWithFormat:@"￥%.1f",[sell.sellCampaignprice floatValue]];
        [imageView sd_setImageWithURL:[NSURL URLWithString:sell.squareimhurl]];
    }
}
@end
