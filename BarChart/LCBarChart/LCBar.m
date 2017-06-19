//
//  LCBar.m
//  BarChart
//
//  Created by lcos on 16/12/14.
//  Copyright © 2016年 zgbang. All rights reserved.
//

#import "LCBar.h"
#import "BarChartHeader.h"
static CGFloat GapX = 10;

static CGFloat fontHeight = 15;

static CFTimeInterval kDefaultAnimationDuration = 1.0;

@interface LCBar ()

@property (nonatomic, strong) CATextLayer *textLayer;

@property (nonatomic, strong) CAShapeLayer *chartLine;

@property (nonatomic, strong) UIBezierPath * path;
@end

@implementation LCBar

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.durationTime = kDefaultAnimationDuration;
        [self setUpBar];
    }
    return self;
}

- (void)setUpBar {
    self.txtColor = [UIColor whiteColor];
    self.kChartLineW = 20;
    self.fontSize = 12;
}

- (void)setKLabelW:(CGFloat)kLabelW {
    _kLabelW = kLabelW;
    
    _path = [UIBezierPath bezierPath];
    if (self.width) {//不为0
        if (self.width < kLabelW) {//text长度大于柱形图
            [_path moveToPoint:CGPointMake(0,self.height / 2.0)];
            [_path addLineToPoint:CGPointMake(self.width,self.height/2.0)];
        }else {
            [_path moveToPoint:CGPointMake(0,self.height / 2.0)];
            [_path addLineToPoint:CGPointMake(self.width,self.height/2.0)];
        }
    }
    _chartLine = [CAShapeLayer layer];
    _chartLine.fillColor  = [[UIColor whiteColor] CGColor];
    _chartLine.path = _path.CGPath;
    _chartLine.lineWidth = self.kChartLineW;
    _chartLine.lineCap = kCALineCapButt;
    _chartLine.strokeEnd = 1.0;
    if (self.showShadow) {
        _chartLine.shadowColor = HEX(@"2F64B1").CGColor;
        _chartLine.shadowOffset = CGSizeMake(4, 0);
        _chartLine.shadowOpacity = 1;
    }
    [self.layer addSublayer:_chartLine];
    
    _textLayer = [CATextLayer layer];
    _textLayer.fontSize = self.fontSize;
    _textLayer.alignmentMode = kCAAlignmentLeft;
    _textLayer.foregroundColor = self.txtColor.CGColor;
    _textLayer.contentsScale = [UIScreen mainScreen].scale;
    CGRect frame = CGRectZero;
    CGFloat height = self.fontSize == 12 ? fontHeight : fontHeight + 5;
    if (self.isCustom) {
        frame = CGRectMake(0, (self.height-height)/2, SCREEN_WIDTH - 20, height);
        _textLayer.alignmentMode = kCAAlignmentCenter;
    }else {
        if (self.width) {//不为0
            if(self.width < kLabelW) {//
                frame = CGRectMake(self.width,(self.height-height)/2, kLabelW, height);
            }else {
                frame = CGRectMake((self.width - kLabelW)/2,(self.height-height)/2, kLabelW, height);
                _textLayer.alignmentMode = kCAAlignmentCenter;
            }
        }else {
            frame = CGRectMake(0, (self.height-height)/2, 20, height);
        }
    }
    _textLayer.frame = frame;
    [self.layer addSublayer:_textLayer];
    
}

- (void)setTitle:(NSString *)title {
    _title = title;
    self.textLayer.string = title;
}


- (void)setStrokeColor:(UIColor *)strokeColor {
    _strokeColor = strokeColor;
    self.chartLine.strokeColor = strokeColor.CGColor;
    [self strokeChart];
}

- (void)strokeChart {
    
    
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = self.durationTime;
    pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pathAnimation.fromValue = @0.0f;
    pathAnimation.toValue = @1.0f;
    [self.chartLine addAnimation:pathAnimation forKey:nil];
    
    CABasicAnimation *textAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    textAnimation.duration = self.durationTime;
    textAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    textAnimation.fromValue = [NSValue valueWithCGPoint:CGPointMake(GapX,self.height/2)];
    if(self.width < self.kLabelW) {
        textAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(self.width,self.height/2)];
    }else {
        textAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake((self.width)/2,self.height/2)];
    }
//    [self.textLayer addAnimation:textAnimation forKey:nil];
}


@end
