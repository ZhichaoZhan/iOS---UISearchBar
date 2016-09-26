//
//  ZCSearchBarView.m
//  通讯录
//
//  Created by 詹志超 on 16/9/20.
//  Copyright © 2016年 zc. All rights reserved.
//

#import "ZCSearchBarView.h"

#import "NSObject+GetSearchValue.h"

#import "ChineseToPinyin.h"

@implementation ZCSearchBarView{
    
    NSMutableArray *_searchResultArr;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.delegate = self;
    }
    return self;
}


- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
    _searchResultArr = [NSMutableArray array];
    
    for (int i = 0; i < _dataArr.count; i ++) {
        
        //如果str第一个字符是汉字, 先转成拼音, 取出第一个字母, 转成大写字母
        if (searchText.length > 0) {
            
            if ([self zhongwen:searchText]) {
                
                searchText = [ChineseToPinyin pinyinFromChiniseString:searchText];
                
                //如果str第一个字符是英文, 取出第一个字母, 转成大写字母
            }else if ([self yingwen:searchText]) {
                
                searchText = [searchText uppercaseString];
            }
        }

        
        
        id model = _dataArr[i];
        
        NSMutableString *searchStr = [model GetPropertyValueStrArr:_searchKyeArr];
        
        NSRange range = [searchStr rangeOfString:searchText];
        
        
        if (range.length > 0) {
            
            if (![_searchResultArr containsObject:model]) {
                
                [_searchResultArr addObject:model];
            }
            
        }else{
            
            [_searchResultArr removeObject:model];
            
        }
    }
    
    if (searchText.length > 0) {
        
        self.searchResult(_searchResultArr,YES);
        
    }else{
        
        self.searchResult(_searchResultArr,NO);

    }
}

- (void)setCornerRadius:(CGFloat)cornerRadius{
    
    _cornerRadius = cornerRadius;
    
    UITextField *searchField = [self valueForKey:@"searchField"];
    if (searchField) {
        [searchField setBackgroundColor:[UIColor whiteColor]];
        searchField.layer.cornerRadius = _cornerRadius;
        searchField.layer.masksToBounds = YES;
    }
}

- (void)setBorderWidth:(CGFloat)borderWidth{
    
    _borderWidth = borderWidth;
    
    UITextField *searchField = [self valueForKey:@"searchField"];
    if (searchField) {
        [searchField setBackgroundColor:[UIColor whiteColor]];
        searchField.layer.borderWidth = _borderWidth;
        searchField.layer.masksToBounds = YES;
    }
}

- (void)setBorderColor:(UIColor *)borderColor{
    
    _borderColor = borderColor;
    
    UITextField *searchField = [self valueForKey:@"searchField"];
    if (searchField) {
        [searchField setBackgroundColor:[UIColor whiteColor]];
        searchField.layer.borderColor = _borderColor.CGColor;
        searchField.layer.masksToBounds = YES;
    }
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

@end
