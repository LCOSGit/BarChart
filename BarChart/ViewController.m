//
//  ViewController.m
//  BarChart
//
//  Created by lcos on 2017/6/19.
//  Copyright © 2017年 lcos. All rights reserved.
//
#import "ViewController.h"
#import "LCBarChart.h"
#import "Tool.h"
#import "BarChartHeader.h"
static NSString *topViewBG = @"3b7dd0";
@interface ViewController ()
@property (nonatomic, strong)LCBarChart * barChart;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.view addSubview:self.barChart];
    self.barChart.yValues = @[@"440", @"6", @"-300", @"283", @"490", @"236"];
    NSNumber *maxNum = [self.barChart.yValues valueForKeyPath:@"@max.intValue"];
    self.barChart.uniformNumber = maxNum.intValue ?:1;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"开始" forState:UIControlStateNormal];
    button.backgroundColor = HEX(topViewBG);
    button.frame = CGRectMake((SCREEN_WIDTH - 100)/2, CGRectGetMaxY(self.barChart.frame) + 10, 100, 50);
    [button addTarget:self action:@selector(strokeChart) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)strokeChart {
    [self.barChart strokeChart];
}

- (LCBarChart *)barChart {
    if (!_barChart) {
        _barChart = [[LCBarChart alloc] initWithFrame:CGRectMake(0, 100, SCREEN_WIDTH, 300)];
        _barChart.formatter = ^NSString *(NSString *value) {
            return [NSString stringWithFormat:@"%@",value];
        };
        _barChart.strokeColors = @[HEX(barColor),HEX(barNegativeColor)];
        _barChart.backgroundColor = HEX(topViewBG);
        _barChart.xLabels = [Tool returnWeekForChart];
        [_barChart strokeChart];
    }
    return _barChart;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
