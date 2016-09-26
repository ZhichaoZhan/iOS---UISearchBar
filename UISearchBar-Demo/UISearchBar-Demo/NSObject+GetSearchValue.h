//
//  NSObject+GetSearchValue.h
//  通讯录
//
//  Created by 詹志超 on 16/9/20.
//  Copyright © 2016年 zc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (GetSearchValue)


/**
 *  根据model的对应字段获取对象属性Value
 */
- (NSMutableString *)GetPropertyValueStrArr:(NSArray *)arr;

@end
