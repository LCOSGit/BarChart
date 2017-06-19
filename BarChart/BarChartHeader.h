//
//  BarChartHeader.h
//  BarChart
//
//  Created by lcos on 2017/6/19.
//  Copyright © 2017年 lcos. All rights reserved.
//

#ifndef BarChartHeader_h
#define BarChartHeader_h
#import <YYKit.h>
#import "Tool.h"


#define HEX(str) [Tool getColor:str]
#define barColor @"73A9F1"
#define barNegativeColor @"EFC95A"
#define SCREEN_WIDTH  ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define LXColor(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]
#define WEAK_SELF  __weak __typeof(self)weakSelf = self
#define F(string, args...) [NSString stringWithFormat:string, args]
#endif /* BarChartHeader_h */
