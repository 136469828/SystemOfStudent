//
//  OneYuanCell.h
//  MeituanCongDome
//
//  Created by JCong on 15/10/22.
//  Copyright © 2015年 梁健聪. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OneYuanCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *oneView;


- (void)configCellWithOneModels:(NSArray *)oneModels;
@end
