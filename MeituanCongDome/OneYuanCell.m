//
//  OneYuanCell.m
//  MeituanCongDome
//
//  Created by JCong on 15/10/22.
//  Copyright © 2015年 梁健聪. All rights reserved.
//

#import "OneYuanCell.h"
#import "OneEDPHModel.h"
#import "UIImageView+WebCache.h"
@implementation OneYuanCell

- (void)awakeFromNib {
    // Initialization code
//    self.oneView.backgroundColor = [UIColor whiteColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)configCellWithOneModels:(NSArray *)oneModels{
    for (int i = 0; i < 5; i++) {
        UILabel *mainLabel = (UILabel *)[self viewWithTag:50 + i];
        UILabel *dqLabel = (UILabel *)[self viewWithTag:60 + i];
        UIImageView *oneImage = (UIImageView *)[self viewWithTag:70 + i];
        OneEDPHModel *one = oneModels[i];
        mainLabel.text = one.maintitle;
        dqLabel.text = one.deputytitle;
        [oneImage sd_setImageWithURL:[NSURL URLWithString: one.imageUrl ]];
        
    }
}
@end
