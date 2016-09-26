//
//  NSObject+GetSearchValue.m
//  通讯录
//
//  Created by 詹志超 on 16/9/20.
//  Copyright © 2016年 zc. All rights reserved.
//

#import "NSObject+GetSearchValue.h"

#import "ChineseToPinyin.h"

@implementation NSObject (GetSearchValue)


- (NSMutableString *)GetPropertyValueStrArr:(NSArray *)arr{
    
    NSMutableString *mstr = [[NSMutableString alloc]init];
    
    for (int i = 0; i<arr.count; i++){
        
        NSString *propertyName = arr[i];
        
        id propertyValue = [self valueForKey:(NSString *)propertyName];
        
        if (propertyValue){
            
            if ([self zhongwen:propertyValue]) {
                //中文转英文
                
                propertyValue = [ChineseToPinyin pinyinFromChiniseString:propertyValue];
                
            }else if ([self yingwen:propertyValue]) {
                
                //英文转大写
                
                propertyValue = [propertyValue uppercaseString];
            }
            
            
            [mstr appendFormat:@"%@",propertyValue];
        }
    }
    
    return mstr;
}


- (BOOL)yingwen:(NSString*)str
{
    //正则 a-z  A-Z
    NSString *passWordRegex = @"[a-zA-Z]";
    
    //正则匹配
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    
    //截取第一个字符判断
    BOOL a = [passWordPredicate evaluateWithObject:[str substringToIndex:1]];
    
    return a ;
}


//判断是否为中文
- (BOOL)zhongwen:(NSString*)str{
    
    //截取第一个字符
    NSString*sub = [str substringToIndex:1];
    
    unichar c = [sub characterAtIndex:0];
    if (c >=0x4E00 && c <=0x9FFF)
        return YES ;
    return NO;
}

@end
