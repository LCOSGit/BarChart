//
//  Tool.m
//  BarChart
//
//  Created by lcos on 2017/6/19.
//  Copyright © 2017年 lcos. All rights reserved.
//

#import "Tool.h"

@implementation Tool
#pragma mark - 输入16进制的设置转化成uicolor
+ (UIColor *)getColor:(NSString*)hexColor {
    unsigned int red,green,blue;
    
    NSRange range;
    
    range.length = 2;
    
    range.location = 0;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]]scanHexInt:&red];
    
    range.location = 2;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]]scanHexInt:&green];
    
    range.location = 4;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]]scanHexInt:&blue];
    return [UIColor colorWithRed:(float)(red/255.0f)green:(float)(green / 255.0f) blue:(float)(blue / 255.0f)alpha:1.0f];
    
}

+ (NSArray *)returnWeekForChart {
    NSDate *  senddate=[NSDate date];
    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"周日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六", nil];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/beijing"];
    
    [calendar setTimeZone: timeZone];
    
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
    
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:senddate];
    NSArray * week = @[@"周日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六"];
    NSMutableArray * newWeek = [NSMutableArray array];
    [week enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isEqualToString:[weekdays objectAtIndex:theComponents.weekday]]) {
            [newWeek addObjectsFromArray:[week subarrayWithRange:NSMakeRange(idx, 7 - idx)]];
            [newWeek addObjectsFromArray:[week subarrayWithRange:NSMakeRange(0, idx)]];
        }
    }];
    
    return [newWeek reverseObjectEnumerator].allObjects;
}

NSString *formatFloat(float f) {
    if (fmodf(f, 1)==0) {
        return [NSString stringWithFormat:@"%.0f",f];
    } else if (fmodf(f*10, 1)==0) {
        return [NSString stringWithFormat:@"%.1f",f];
    } else {
        return [NSString stringWithFormat:@"%.2f",f];
    }
}

@end
