//
//  ViewController.m
//  DatePickerDemo
//
//  Created by 思 彭 on 2017/4/24.
//  Copyright © 2017年 思 彭. All rights reserved.
//

#import "ViewController.h"
#import "HZQDatePickerView.h"

@interface ViewController ()<SelectDatePickerViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    HZQDatePickerView *datePickerView = [HZQDatePickerView instanceDatePickerView];
    // 注意要设置frame
    datePickerView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    // 代理
    datePickerView.selectDelegate = self;
    [datePickerView setTipLabelText:@"请选择结束时间"];
    // 需要添加到view
    [self.view addSubview:datePickerView];
    __weak typeof(datePickerView) weakDatePickerView = datePickerView;
    
    // 点击灰色背景dismiss
    datePickerView.dismissBlock = ^{
        [weakDatePickerView removeFromSuperview];
    };
}

- (void)selectDatePickerView:(HZQDatePickerView *)datePickerView selectedDateString:(NSString *)selectDateString type:(DateType)type {
    
    NSLog(@"selectDateString = %@",selectDateString);
}

@end
