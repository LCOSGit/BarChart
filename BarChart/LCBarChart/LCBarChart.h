//
//  LCBarChart.h
//  BarChart
//
//  Created by lcos on 16/12/14.
//  Copyright © 2016年 zgbang. All rights reserved.
//


#import <UIKit/UIKit.h>

typedef NSString *(^YDLabelFormatter)(NSString *yLabelValue);

@interface LCBarChart : UIView
/// x轴上文字显示
@property (nonatomic, strong) NSArray <NSString *>*xLabels;

/// y轴上文字显示
@property (nonatomic, strong) NSArray <NSString *>*yLabels;

/// y轴上数值
@property (nonatomic, strong) NSArray <NSNumber *>*yValues;

/// 对应每个柱状图的颜色
@property (nonatomic, strong) NSArray *strokeColors;

/// 底部label的高  //label长度 //为0时 不显示
@property (nonatomic, assign) CGFloat bottomH;

/// 显示规则
@property (nonatomic, copy) YDLabelFormatter formatter;

/// 柱状图等分比例默认按百分比等分 100
@property (nonatomic, assign) NSInteger uniformNumber;

//网格线颜色
@property (nonatomic, strong) UIColor *lineColor;

/// 以动画的方式绘制图表
- (void)strokeChart;

@end
