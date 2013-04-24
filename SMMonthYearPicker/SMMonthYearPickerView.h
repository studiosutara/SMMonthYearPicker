//
//  MonthYearPickerView.h
//  shop
//
//  Created by Shilpa Modi on 3/3/13.
//  Copyright (c) 2013 Real Real. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MonthYearPickerViewDelegate <NSObject>
@optional
-(void) pickerViewDidPickMonth:(NSString*) month AndYear:(NSString*) year;
@end

@interface SMMonthYearPickerView : UIPickerView <UIPickerViewDataSource, UIPickerViewDelegate>
{
}

@property (nonatomic, weak) id mDelegate;
//@property (nonatomic, retain)  UIPickerView *pickerView;
@property (nonatomic, retain)  UILabel *label;

-(id) initWithFrame:(CGRect)frame;
-(NSString*) getCurrentMonth;
-(NSString*) getCurrentYear;

@end

