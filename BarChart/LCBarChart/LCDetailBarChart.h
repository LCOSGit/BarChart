//
//  LCDetailBarChart.h
//  BarChart
//
//  Created by lcos on 16/12/23.
//  Copyright © 2016年 zgbang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NSString *(^LCLabelFormatter)(NSString *yLabelValue);

@interface LCDetailBarChart : UIScrollView
/// x轴上文字显示
@property (nonatomic, strong) NSArray <NSString *>*xLabels;

/// y轴上文字显示
@property (nonatomic, strong) NSArray <NSString *>*yLabels;

/// y轴上数值
@property (nonatomic, strong) NSArray <NSNumber *>*yValues;

/// y轴上的标题
@property (nonatomic, strong) NSArray <NSString *>*yTitles;

/// 对应每个柱状图的颜色
@property (nonatomic, strong) NSArray *strokeColors;

/// 底部label的高  //label长度 //为0时 不显示
@property (nonatomic, assign) CGFloat bottomH;

/// 显示规则
@property (nonatomic, copy) LCLabelFormatter formatter;

/// 柱状图等分比例默认按百分比等分 100
@property (nonatomic, assign) NSInteger uniformNumber;

//网格线颜色
@property (nonatomic, strong) UIColor *lineColor;
//bar宽度
@property (nonatomic, assign) CGFloat barLineW;
//显示bar个数
@property (nonatomic, assign) NSInteger barCount;
/// 以动画的方式绘制图表
- (void)strokeChart;
@end
