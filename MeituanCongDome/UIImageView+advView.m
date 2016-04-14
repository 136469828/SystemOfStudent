//
//  UIImageView+advView.m
//  MeituanCongDome
//
//  Created by JCong on 15/10/22.
//  Copyright © 2015年 梁健聪. All rights reserved.
//

#import "UIImageView+advView.h"
#import "AdvModel.h"
static AdvModel *adv = nil;

@implementation UIImageView (advView)
- (void)setImageWithURL:(NSString *)urlString andPlaceImage:(UIImage *)placeImg{
    // 可以加写判断本地是否有缓存图片
    /*
     if (!localCache){
     下载
     }
     ...
     */
    if (self.image != nil) {
        return ;
    }
    self.image = placeImg;
    dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_async(globalQueue, ^{
        
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
        
        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
            if (data == nil) {
                self.image = placeImg;
                return ;
            }
            
            NSMutableString *stringDelete = [[NSMutableString alloc] init];
            
            NSDictionary *dicData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            NSArray *dataArray =dicData[@"data"];
            
            id datas = dataArray;
            
            NSArray *dicDatas = datas[@"topics"];
            
            for (NSDictionary *temDic in dicDatas) {
                
                stringDelete = [NSMutableString stringWithString:temDic[@"imageurl"]];
                NSRange rage = [stringDelete rangeOfString:@"/w.h"];
                [stringDelete deleteCharactersInRange:rage];
                
            }
            
            
            NSData *dataAdv = [NSData dataWithContentsOfURL:[NSURL URLWithString:stringDelete]];
            
            NSLog(@"downLoad");
            
            dispatch_async(dispatch_get_main_queue(), ^{
                self.image = [UIImage imageWithData:dataAdv];
            });
        }];
        
        
    });
    
    
}
@end
