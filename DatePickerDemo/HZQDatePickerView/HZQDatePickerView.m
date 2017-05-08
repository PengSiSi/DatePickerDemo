//
//  HZQDatePickerView.m
//  HZQDatePickerView
//
//  Created by 1 on 15/10/26.
//  Copyright © 2015年 HZQ. All rights reserved.
//

#import "HZQDatePickerView.h"
#import "UIColor+HexString.h"
//屏幕的宽度
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
//屏幕的高度
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

@interface HZQDatePickerView ()
@property (weak, nonatomic) IBOutlet UIButton *backButton;

@property (weak, nonatomic) IBOutlet UILabel *tipLable;
@property (nonatomic, strong) NSString *selectDate;

@property (weak, nonatomic) IBOutlet UIButton *cannelBtn;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;
@property (weak, nonatomic) IBOutlet UIView *backgVIew;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightPadding;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftPadding;

@end

@implementation HZQDatePickerView

+ (HZQDatePickerView *)instanceDatePickerView
{
    NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"HZQDatePickerView" owner:nil options:nil];
    return [nibView objectAtIndex:0];
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.backgVIew.layer.cornerRadius = 5;
    self.backgVIew.layer.borderWidth = 1;
    self.backgVIew.layer.borderColor = [[UIColor clearColor] CGColor];
    self.backgVIew.layer.masksToBounds = YES;
    
    /** 确定 */
    self.sureBtn.layer.cornerRadius = 4;
    self.sureBtn.layer.borderWidth = 1;
    [self.sureBtn setTitleColor:[UIColor orangeColor] forState:0];
    self.sureBtn.layer.borderColor = [[UIColor orangeColor] CGColor];
    self.sureBtn.layer.masksToBounds = YES;
    
    /** 取消按钮 */
    self.cannelBtn.layer.cornerRadius = 4;
    self.cannelBtn.layer.borderWidth = 1;
    self.cannelBtn.layer.borderColor = [[UIColor colorWithHex:@"BAB9B9"] CGColor];
    self.cannelBtn.layer.masksToBounds = YES;
    
    if (ScreenWidth > 320) {
        // IPHONE 6
        self.leftPadding.constant += 20;
        self.rightPadding.constant += 20;
        if (ScreenWidth > 400) {
            // IPHONE 6 PLUS
            self.leftPadding.constant += 20;
            self.rightPadding.constant += 20;
        }
    }
    [self.backButton addTarget:self action:@selector(backButtonClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)backButtonClick: (UIButton *)button {
    
    if (self.dismissBlock) {
        self.dismissBlock();
    }
}

- (NSString *)timeFormat
{
    NSDate *selected = [self.datePickerView date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *currentOlderOneDateStr = [dateFormatter stringFromDate:selected];
    return currentOlderOneDateStr;
}

- (NSString *)hourAndMinute {
    NSDate *selected = [self.datePickerView date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm"];
    NSString *currentOlderOneDateStr = [dateFormatter stringFromDate:selected];
    return currentOlderOneDateStr;
}

- (void)animationbegin:(UIView *)view {
    /* 放大缩小 */
    
    // 设定为缩放
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    
    // 动画选项设定
    animation.duration = 0.1; // 动画持续时间
    animation.repeatCount = -1; // 重复次数
    animation.autoreverses = YES; // 动画结束时执行逆动画
    
    // 缩放倍数
    animation.fromValue = [NSNumber numberWithFloat:1.0]; // 开始时的倍率
    animation.toValue = [NSNumber numberWithFloat:0.9]; // 结束时的倍率
    
    // 添加动画
    [view.layer addAnimation:animation forKey:@"scale-layer"];
    
}

// 退出键盘
- (IBAction)blackBtnClick:(id)sender {
    [self.superview endEditing:YES];
}

// 取消
- (IBAction)removeBtnClick:(id)sender {
    // 开始动画
    [self animationbegin:sender];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

// 确定
- (IBAction)sureBtnClick:(id)sender {
    // 开始动画
    [self animationbegin:sender];
    
    self.selectDate = [self timeFormat];
    
    NSString *hourWithMinuteStr = [self hourAndMinute];
    
    //delegate
    [self.delegate getSelectDate:self.selectDate type:self.type];
    
    //hourAndMinuteDelegate
    if ([_hourAndMinuteDelegate respondsToSelector:@selector(selectHourAndMinuteWithDatePickerView:selectedDateString:type:)]) {
        [_hourAndMinuteDelegate selectHourAndMinuteWithDatePickerView:self selectedDateString:hourWithMinuteStr type:_type];
    }
    
    if ([_selectDelegate respondsToSelector:@selector(selectDatePickerView:selectedDateString:type:)]) {
        [_selectDelegate selectDatePickerView:self selectedDateString:self.selectDate type:self.type];
    }
    
    [self removeBtnClick:nil];
}

- (void)setTipLabelText:(NSString *)tipLabelText {
    
    _tipLabelText = tipLabelText;
    self.tipLable.text = self.tipLabelText;
}

@end


