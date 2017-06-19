//
//  LCBar.h
//  BarChart
//
//  Created by lcos on 16/12/14.
//  Copyright © 2016年 zgbang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LCBar : UIView

/// 柱状图填充颜色
@property (nonatomic, strong) UIColor *strokeColor;

/// 文字描述
@property (nonatomic, copy) NSString *title;

//动画时间
@property (nonatomic, assign) CFTimeInterval durationTime;

//柱形图上文字长度
@property (nonatomic, assign) CGFloat kLabelW;

//文字颜色
@property (nonatomic, strong) UIColor * txtColor;

//是否显示阴影
@property (nonatomic, assign) BOOL showShadow;

//柱形图宽度
@property (nonatomic, assign) CGFloat kChartLineW;

//字体大小
@property (nonatomic, assign) CGFloat fontSize;

//自定义需求
@property (nonatomic, assign) BOOL isCustom;
@end
