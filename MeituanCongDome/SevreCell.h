//
//  SevreCell.h
//  MeituanCongDome
//
//  Created by JCong on 15/10/22.
//  Copyright © 2015年 梁健聪. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SevreCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *leftLabel;
@property (weak, nonatomic) IBOutlet UIImageView *leftImage;
@property (weak, nonatomic) IBOutlet UIImageView *rightTopImage;
@property (weak, nonatomic) IBOutlet UILabel *rightTopLabel;
@property (weak, nonatomic) IBOutlet UIImageView *rightFootImage;
@property (weak, nonatomic) IBOutlet UILabel *rightFootLabel;
@property (weak, nonatomic) IBOutlet UILabel *leftMainTitle;
@property (weak, nonatomic) IBOutlet UILabel *rightTopMainTitle;
@property (weak, nonatomic) IBOutlet UILabel *rightFootMainTitle;

- (void)configCellWithSeverModels:(NSArray *)severModels;
@end
