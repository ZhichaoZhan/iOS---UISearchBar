//
//  ZCSearchBarView.h
//  通讯录
//
//  Created by 詹志超 on 16/9/20.
//  Copyright © 2016年 zc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZCSearchBarView : UISearchBar<UISearchBarDelegate>

//需要去搜索的指定字段
@property (nonatomic,strong)NSArray *searchKyeArr;

//搜索数据源
@property (nonatomic,strong)NSMutableArray *dataArr;

//设置圆角 尺寸
@property (nonatomic,assign)CGFloat cornerRadius;

//尺寸宽度
@property (nonatomic,assign)CGFloat borderWidth;

//边框颜色
@property (nonatomic,strong)UIColor *borderColor;


@property (nonatomic,copy)void(^searchResult)(NSMutableArray *result,BOOL isSearch);

@end
