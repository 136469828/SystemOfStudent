//
//  SevreCell.m
//  MeituanCongDome
//
//  Created by JCong on 15/10/22.
//  Copyright © 2015年 梁健聪. All rights reserved.
//

#import "SevreCell.h"
#import "SeverModel.h"
#import "UIImageView+WebCache.h"
@implementation SevreCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)configCellWithSeverModels:(NSArray *)severModels{
    for (int i = 0; i<3; i++) {
        UILabel *mainLabel = (UILabel *)[self viewWithTag:90 + i];
        UILabel *dqLabel = (UILabel *)[self viewWithTag:100 + i];
        UIImageView *severImage = (UIImageView *)[self viewWithTag:110 + i];
        
        SeverModel *sever = severModels[i];
        
        mainLabel.text = sever.maintitle;
        dqLabel.text = sever.deputytitle;
        [severImage sd_setImageWithURL:[NSURL URLWithString:sever.imageUrl]];
    }
}
@end
