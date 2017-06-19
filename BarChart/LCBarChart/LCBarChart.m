//
//  LCBarChart.m
//  BarChart
//
//  Created by lcos on 16/12/14.
//  Copyright © 2016年 zgbang. All rights reserved.
//

#import "LCBarChart.h"
#import "LCBar.h"
#import "BarChartHeader.h"
#import "NSString+Changeformat.h"
/// 左边label的宽
static CGFloat leftW = 0;
/// 顶部预留高度 //  距下 
static CGFloat topH = 15;
/// 离右边的间距 //  距上
static CGFloat rightSpacing = 10;

@interface LCBarChart ()

@property (nonatomic, strong) CAShapeLayer *chartBottomLine;

@property (nonatomic, strong) CAShapeLayer *chartLeftLine;

@property (nonatomic, assign) CGSize labelSize;

@end

@implementation LCBarChart

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUpBarChart];
    }
    return self;
}

- (void)setUpBarChart {
    
    self.backgroundColor = [UIColor whiteColor];
    
    self.uniformNumber = 100;
    
    self.bottomH = 35;
    
    self.formatter = ^NSString *(NSString *value) {
        return [NSString stringWithFormat:@"%@",value];
    };
    
    /// 线条颜色
    self.lineColor = LXColor(255.0, 255.0, 255.0, 0.2);
    
    //网格线最底层
    UIBezierPath *bottomPath = [UIBezierPath bezierPathWithRect:CGRectMake(rightSpacing, self.height -topH - rightSpacing/6, self.width -rightSpacing - (self.bottomH + 10)/2, 1)];
    _chartBottomLine = [CAShapeLayer layer];
    _chartBottomLine.path = bottomPath.CGPath;
    _chartBottomLine.lineCap = kCALineCapButt;
    _chartBottomLine.fillColor = [self.lineColor CGColor];
    _chartBottomLine.lineWidth = 1.0;
    [self.layer addSublayer:_chartBottomLine];
    
    //竖网格线
    CGFloat gap = (self.width - rightSpacing*2 - self.bottomH)/3;
    for (int i = 0; i < 4; i++) {
        UIBezierPath *leftPath = [UIBezierPath bezierPathWithRect:CGRectMake(rightSpacing + i*gap, rightSpacing/2, 1, CGRectGetHeight(self.frame)-rightSpacing/3*2 - topH)];
        _chartLeftLine = [CAShapeLayer layer];
        _chartLeftLine.path = leftPath.CGPath;
        _chartLeftLine.lineCap = kCALineCapButt;
        _chartLeftLine.fillColor = [self.lineColor CGColor];
        _chartLeftLine.lineWidth = 1.0;
        [self.layer addSublayer:_chartLeftLine];
    }
}

- (void)strokeChart {
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    WEAK_SELF;
    [self.xLabels enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(CGRectGetWidth(weakSelf.frame)-weakSelf.bottomH, rightSpacing + ((CGRectGetHeight(weakSelf.frame)-leftW - topH - rightSpacing)/_xLabels.count*idx), weakSelf.bottomH, (CGRectGetHeight(weakSelf.frame)-leftW - rightSpacing - topH)/_xLabels.count);
        label.text = obj;
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentLeft;
        label.font = [UIFont systemFontOfSize:12];
        [weakSelf addSubview:label];
    }];
    
    [self.yLabels enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
        label.text = [NSString stringWithFormat:@"%@",obj];;
        label.font = [UIFont systemFontOfSize:11];
        [label sizeToFit];
        
        CGFloat kXLabelHeight = label.frame.size.height;
        float sectionHeight = (weakSelf.frame.size.height - weakSelf.bottomH - topH - kXLabelHeight ) / (_yLabels.count-1);
        label.frame = CGRectMake(0, weakSelf.frame.size.height-weakSelf.bottomH-(topH + sectionHeight * idx) , leftW-5, kXLabelHeight);
        label.textColor = [UIColor grayColor];
        label.textAlignment = NSTextAlignmentRight;
        //        [self addSubview:label];
    }];
    
    //字符串长度降序排序
    NSArray * sortedArray = [self.yValues sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        if ([obj1 length] > [obj2 length])
            return NSOrderedAscending;
        else if ([obj1 length] < [obj2 length])
            return NSOrderedDescending;
        else
            return NSOrderedSame;
    }];
    self.labelSize = [sortedArray.firstObject boundingRectWithSize:CGSizeMake(200, 0) options:NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil].size;
    
    [self.yValues enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        BOOL isNegative = false;
        CGFloat h  = (CGRectGetHeight(weakSelf.frame) - rightSpacing - topH)/_yValues.count;
        CGFloat w = (CGRectGetWidth(weakSelf.frame) - weakSelf.bottomH - 20) * fabsf(obj.floatValue/_uniformNumber);
        LCBar * bar = [[LCBar alloc] initWithFrame:CGRectMake(10,rightSpacing + h*idx, w, h)];
        if (obj.floatValue < 0) {
            isNegative = YES;
        }
        bar.showShadow = YES;
        bar.kLabelW = weakSelf.labelSize.width;
        bar.durationTime = bar.durationTime * fabsf(obj.floatValue/_uniformNumber);
        bar.strokeColor = [weakSelf barColorAtIndex:isNegative ? 1 : 0];
        bar.title =  weakSelf.formatter([(NSString *)obj changeformat]);
        [weakSelf addSubview:bar];
    }];
}

- (UIColor *)barColorAtIndex:(NSUInteger)index
{
    return self.strokeColors[index];
}


@end
