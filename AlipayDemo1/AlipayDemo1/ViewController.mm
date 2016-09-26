//
//  ViewController.m
//  AlipayDemo1
//
//  Created by 詹志超 on 16/9/23.
//  Copyright © 2016年 zzc. All rights reserved.
//

#import "ViewController.h"
#import "Order.h"
#import "DataSigner.h"
#import "APAuthV2Info.h"
#import <AlipaySDK/AlipaySDK.h>

#import "UserModel.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)payment:(UIButton *)sender {
    
    
    /*
     *点击获取product实例并初始化订单信息
     */
    /*
     *商户唯一的partner 和seller
     签约后会给商户分配唯一的partner 和seller
     */
    //填写用户申请的
    NSString *partner=@"";
    NSString *seller=@"";
    NSString *privateKey=@"";//下载的公匙私匙文件
    
    //partner 和seller获取失败
    if([partner length]==0||[seller length]==0||[privateKey length]==0)
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"缺少partner或者seller" delegate:nil cancelButtonTitle:@"cancel" otherButtonTitles: nil];
        [alert show];
        return;
    }
    //生成订单信息及签名
    //将商品信息赋予ALixpayOrder的成员变量
    UserModel *Model=[[UserModel alloc]init];
    Order *order=[[Order alloc]init];
    order.partner=partner;
    order.seller=seller;
    //    order.tradeNO=Model.oderNumber;//订单号
    //    order.productName=Model.orderName;//商品名称
    //    order.productDescription=Model.orderDescri;//商品描述
    //    order.amount=Model.orderPrice;//商品价格
    order.tradeNO=@"12398998d66522416565";
    order.productName=@"ipone6s玫瑰金";
    order.productDescription=@"但是";
    order.amount=@"0.01";
    order.notifyURL=@"http://www.xxx.com";//回调url
    //下面这些参数都是固定的
    order.service=@"mobile.securitypay.pay";
    order.paymentType=@"1";
    order.inputCharset=@"utf-8";
    order.itBPay=@"30m";
    order.showUrl=@"m.alipay.com";
    
    //用户注册scheme，在info.plist 定义URL types 用于快捷支付成功后重新唤起商户应用
    NSString *appSheme=@"chaoge";
    
    //将商品信息拼接成字符串
    NSString *orderFormat=[order description];
    
    //获取私匙并将商户信息签名，外部商户可以根据情况存放私匙和签名，只要遵循RSA签名规范将签名字符串base64编码和UrlEncode
    id<DataSigner>signer=CreateRSADataSigner(privateKey);
    
    NSString *signString=[signer signString:orderFormat];
    
    //将签名成功字符格式化为订单字符串，请严格按照格式
    NSString *orderString=nil;
    
    if(signString!=nil)
    {
        orderString=[NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",orderFormat,signString,@"RSA"];
        NSLog(@"%@",orderString);
        [[AlipaySDK defaultService]payOrder:orderString fromScheme:appSheme callback:^(NSDictionary *resultDic) {
            NSLog(@"------%@",resultDic);
            NSString *msg=[resultDic objectForKey:@"result"];
            if(msg.length==0)
            {
                msg=@"支付失败";
                
                
            }else{
                
            }
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:msg delegate:nil cancelButtonTitle:@"cancel" otherButtonTitles:nil];
            [alert show];
        }];
        
    }
    
}

@end
