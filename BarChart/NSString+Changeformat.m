//
//  NSString+Changeformat.m
//  BarChart
//
//  Created by lcos on 2017/6/19.
//  Copyright © 2017年 lcos. All rights reserved.
//

#import "NSString+Changeformat.h"
#import "BarChartHeader.h"

@implementation NSString (Changeformat)
- (NSString *)changeformat
{
    NSInteger numNew = self.integerValue;
    NSString * numStr = F(@"%ld",numNew);
    int count = 0;
    long long int a = numStr.longLongValue;
    while (a != 0)
    {
        count++;
        a /= 10;
    }
    NSMutableString *string = [NSMutableString stringWithString:numStr];
    NSMutableString *newstring = [NSMutableString string];
    while (count > 3) {
        count -= 3;
        NSRange rang = NSMakeRange(string.length - 3, 3);
        NSString *str = [string substringWithRange:rang];
        [newstring insertString:str atIndex:0];
        [newstring insertString:@"," atIndex:0];
        [string deleteCharactersInRange:rang];
    }
    [newstring insertString:string atIndex:0];
    return newstring;
}
@end
