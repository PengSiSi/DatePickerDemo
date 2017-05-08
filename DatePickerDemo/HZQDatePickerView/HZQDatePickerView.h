//
//  HZQDatePickerView.h
//  HZQDatePickerView
//
//  Created by 1 on 15/10/26.
//  Copyright © 2015年 HZQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HourAndMinutePickerViewDelegate;
@protocol HZQDatePickerViewDelegate;
@protocol SelectDatePickerViewDelegate;


typedef enum {
    
    // 开始日期
    DateTypeOfStart = 0,
    
    // 结束日期
    DateTypeOfEnd,
    
}DateType;

typedef void(^BackButtonClickBlock)(void);

@interface HZQDatePickerView : UIView

+ (HZQDatePickerView *)instanceDatePickerView;

@property (weak, nonatomic) IBOutlet UIDatePicker *datePickerView;

@property (nonatomic, weak) id<HZQDatePickerViewDelegate> delegate;

@property (weak, nonatomic) id<HourAndMinutePickerViewDelegate> hourAndMinuteDelegate;/**< 自己新增选择小时、分的代理*/
@property (weak, nonatomic) id<SelectDatePickerViewDelegate> selectDelegate;/**< 自己新增的选择时间带View的代理*/


@property (nonatomic, assign) DateType type;
@property (nonatomic, copy) NSString *tipLabelText;
@property (nonatomic, copy) BackButtonClickBlock dismissBlock; // 点击灰色的dismiss

@end

///2016-06-07 AlicePan添加带pickerView的选择小时分的代理
@protocol HourAndMinutePickerViewDelegate <NSObject>

- (void)selectHourAndMinuteWithDatePickerView:(HZQDatePickerView *)datePickerView selectedDateString:(NSString *)selectDateString type:(DateType)type;
@end

@protocol HZQDatePickerViewDelegate <NSObject>

- (void)getSelectDate:(NSString *)date type:(DateType)type;

@end

///2016-06-11 AlicePan添加带pickerView的选择日期的代理
@protocol SelectDatePickerViewDelegate <NSObject>

- (void)selectDatePickerView:(HZQDatePickerView *)datePickerView selectedDateString:(NSString *)selectDateString type:(DateType)type;

@end
