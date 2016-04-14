//
//  PayViewController.m
//  MeituanCongDome
//
//  Created by JCong on 16/2/16.
//  Copyright © 2016年 梁健聪. All rights reserved.
//

#import "PayViewController.h"
#import "Order.h"
#import "DataSigner.h"
#import <AlipaySDK/AlipaySDK.h>
#import "APAuthV2Info.h"

@implementation Product

@end
@interface PayViewController ()

@end

@implementation PayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString *)generateTradeNO
{
    static int kNumber = 15;
    
    NSString *sourceStr = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    NSMutableString *resultStr = [[NSMutableString alloc] init];
    srand(time(0));
    for (int i = 0; i < kNumber; i++)
    {
        unsigned index = rand() % [sourceStr length];
        NSString *oneStr = [sourceStr substringWithRange:NSMakeRange(index, 1)];
        [resultStr appendString:oneStr];
    }
    NSLog(@"trade no: %@", resultStr);
    return resultStr;
    
}


- (IBAction)onPay:(UIButton *)sender {
    /*
     *点击获取prodcut实例并初始化订单信息
     */
    Product *mproduct = [Product new];
    mproduct.price = 0.01;
    mproduct.body = @"这是模拟支付";
    mproduct.subject = @"支付测试";
    /*
     *商户的唯一的parnter和seller。
     *签约后，支付宝会为每个商户分配一个唯一的 parnter 和 seller。
     */
    
    /*============================================================================*/
    /*=======================需要填写商户app申请的===================================*/
    /*============================================================================*/
    NSString *partner = @"2088911305708354";
    NSString *seller = @"huao429006@163.com";
    //-----BEGIN PRIVATE KEY-----
    NSString *privateKey = @"MIICdgIBADANBgkqhkiG9w0BAQEFAASCAmAwggJcAgEAAoGBAMyTmbie5nZdLKLw2y6gr+fDlPxmltwUBSJGD/iabppehX913o4iiOKEbzyJoVA9RVv2PZgm9ee3pNqij3kibFWNC1dGKIzizo44+QBoQvJuk6Q3ozAhJyaArYDAAXkYWVSZKTLiK5I/wr4rxEcKqnPl9AX3U2ofOMfXwKJlP8l3AgMBAAECgYBBI+6avt4bamfAKnlgS4I3hit2gyQeR7GqzCxhuKrnNJnFkD6he5WiqxDQcfKPnjLrqWjLffxnIC65/3E33SIpOYSIFTl1wpKKlju2Z3zDq6eQcpTCqD05quy1ZXTX3jQr4UbUnwa+QGwbWejoRkJJb2wEVTnjSbd4Sas733QUgQJBAPSLJ3pmOG8xseG0GMVftMFkbvxLeM+3t2IAkxqPnRXUdV4gYgn5XzzA5KYaL563Y3N/sfpl/qbv0l1nQ3t5xScCQQDWKR3D/K/eiIgHTival7tjvEivuQHkjLSmkjrnzzlac947Px0HKgm0aqqvLL0xCJwhIITYyM6YyOjm5glZwKsxAkBBsOPhAHamgB39uIhy9Nu0m8sooQmKGxr7C5Z4qx2SkKkaqO5NKZ0Iz/RcHmquYysnCqV/00hOBdxn1OaO084/AkEAlvLaIRcNGwwe3Q9TR7rlAPJoRTtgwygN+M5fKJ7eLQw4WogsvKz7tCfu8JPXMiWAbrUODgLT48rQplcDxjhQMQJAdM8bIRm7b5uuJ68SXwpno9VHC2x1V1uKo/nEIt5d6mOP9xdAz3dADif9I/0dcr4wYcA3ChxSSzwKgURcTKilrg==";
    //-----END PRIVATE KEY-----
    /*============================================================================*/
    /*============================================================================*/
    /*============================================================================*/
    
    //partner和seller获取失败,提示
    if ([partner length] == 0 ||
        [seller length] == 0 ||
        [privateKey length] == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"缺少partner或者seller或者私钥。"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    /*
     *生成订单信息及签名
     */
    //将商品信息赋予AlixPayOrder的成员变量
    Order *order = [[Order alloc] init];
    order.partner = partner;
    order.seller = seller;
    order.tradeNO = [self generateTradeNO]; //订单ID（由商家自行制定）
    order.productName = mproduct.subject; //商品标题
    order.productDescription = mproduct.body; //商品描述
    order.amount = [NSString stringWithFormat:@"%.2f",mproduct.price]; //商品价格
    order.notifyURL =  @"http://www.aoyolo.com"; //回调URL
    
    order.service = @"mobile.securitypay.pay";
    order.paymentType = @"1";
    order.inputCharset = @"utf-8";
    order.itBPay = @"30m";
    order.showUrl = @"m.alipay.com";
    
    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
    NSString *appScheme = @"aoyolo";
    
    //将商品信息拼接成字符串
    NSString *orderSpec = [order description];
    NSLog(@"orderSpec = %@",orderSpec);
    
    //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
    id<DataSigner> signer = CreateRSADataSigner(privateKey);
    NSString *signedString = [signer signString:orderSpec];
    
    //将签名成功字符串格式化为订单字符串,请严格按照该格式
    NSString *orderString = nil;
    if (signedString != nil) {
        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                       orderSpec, signedString, @"RSA"];
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            NSLog(@"reslut = %@",resultDic);
        }];
    }
}

@end
