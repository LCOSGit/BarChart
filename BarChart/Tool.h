//
//  Tool.h
//  BarChart
//
//  Created by lcos on 2017/6/19.
//  Copyright © 2017年 lcos. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Tool : NSObject
+ (UIColor *)getColor:(NSString*)hexColor;
+ (NSArray *)returnWeekForChart;
NSString *formatFloat(float f);
@end
