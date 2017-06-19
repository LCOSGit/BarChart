//
//  LCDetailBarChart.m
//  BarChart
//
//  Created by lcos on 16/12/23.
//  Copyright © 2016年 zgbang. All rights reserved.
//

#import "LCDetailBarChart.h"
#import "LCBar.h"
#import "BarChartHeader.h"
/// 左边label的宽
static CGFloat leftW = 0;
/// 顶部预留高度 //  距下
static CGFloat topH = 15;
/// 离右边的间距 //  距上
static CGFloat rightSpacing = 10;

@interface LCDetailBarChart ()

@property (nonatomic, strong) CAShapeLayer *chartBottomLine;

@property (nonatomic, strong) CAShapeLayer *chartLeftLine;

@property (nonatomic, assign) CGSize labelSize;

@end

@implementation LCDetailBarChart

- (instancetype)init {
    if (self = [super init]) {
        [self setUpBarChart];
    }
    return self;
}

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
    
    self.barLineW = 36;
    
    self.barCount = 7;
    
    self.formatter = ^NSString *(NSString *value) {
        return [NSString stringWithFormat:@"%@",value];
    };
    
    /// 线条颜色
    self.lineColor = LXColor(193.0, 193.0, 193.0, 1);;
}

- (void)strokeChart {
    
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.layer.sublayers makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
    CGFloat barHeight = (self.height - rightSpacing/2 - topH)/_barCount;
    CGFloat height = barHeight*_yValues.count;
    self.contentSize = CGSizeMake(self.width, height + 10);
    
    //横网格线
    CGFloat gapY = (self.height - rightSpacing/2 - topH)/_barCount;
    for (int i = 0; i < (_yValues.count ? _yValues.count + 1 : 0); i++) {
        UIBezierPath *bottomPath = [UIBezierPath bezierPathWithRect:CGRectMake(rightSpacing, rightSpacing/2 + i*gapY, self.width -rightSpacing - (self.bottomH + 10)/2, 1)];
        _chartBottomLine = [CAShapeLayer layer];
        _chartBottomLine.path = bottomPath.CGPath;
        _chartBottomLine.lineCap = kCALineCapButt;
        _chartBottomLine.fillColor = [self.lineColor CGColor];
        _chartBottomLine.lineWidth = 1.0;
        [self.layer addSublayer:_chartBottomLine];
    }
    
    //竖网格线
    CGFloat gap = (self.width - 10)/_barCount * 2;
    for (int j = 0; j < 4; j++) {
        UIBezierPath *leftPath = [UIBezierPath bezierPathWithRect:CGRectMake(rightSpacing + j*gap, rightSpacing/2, 1, height)];
        _chartLeftLine = [CAShapeLayer layer];
        _chartLeftLine.path = leftPath.CGPath;
        _chartLeftLine.lineCap = kCALineCapButt;
        _chartLeftLine.fillColor = [self.lineColor CGColor];
        _chartLeftLine.lineWidth = 1.0;
        [self.layer addSublayer:_chartLeftLine];
    }

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
    NSArray * sortedArray = [self.yTitles sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        if ([obj1 length] > [obj2 length])
            return NSOrderedAscending;
        else if ([obj1 length] < [obj2 length])
            return NSOrderedDescending;
        else
            return NSOrderedSame;
    }];
    self.labelSize = [sortedArray.firstObject boundingRectWithSize:CGSizeMake(300, 0) options:NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
    
    
    [self.yValues enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        BOOL isNegative = false;
        CGFloat w = (weakSelf.width - weakSelf.bottomH - 20) * fabsf(obj.floatValue/_uniformNumber);
        LCBar * bar = [[LCBar alloc] initWithFrame:CGRectMake(10,rightSpacing/2 + barHeight*idx, w, barHeight)];
        if (obj.floatValue < 0) {
            isNegative = YES;
        }
        bar.kChartLineW = self.barLineW;
        bar.txtColor = HEX(@"333333");
        bar.fontSize = 15;
        bar.isCustom = YES;
        
        bar.kLabelW = weakSelf.labelSize.width;
        bar.durationTime = bar.durationTime * fabsf(obj.floatValue/_uniformNumber);
        bar.strokeColor = [weakSelf barColorAtIndex:isNegative ? 1 : 0];
        bar.title =  weakSelf.formatter(weakSelf.yTitles[idx]);
        [weakSelf addSubview:bar];
    }];
}

- (UIColor *)barColorAtIndex:(NSUInteger)index
{
    return self.strokeColors[index];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
