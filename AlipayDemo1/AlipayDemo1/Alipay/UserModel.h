//
//  UserModel.h
//  支付宝demo
//
//  Created by 詹志超 on 15/12/26.
//  Copyright © 2015年 zhongtianhuigou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject

@property(nonatomic,strong)NSString *oderNumber;//订单的id
@property(nonatomic,strong)NSString *orderName;//订单的名称
@property(nonatomic,strong)NSString *orderDescri;//订单描述
@property(nonatomic,strong)NSString *orderPrice;//订单价格

@end
