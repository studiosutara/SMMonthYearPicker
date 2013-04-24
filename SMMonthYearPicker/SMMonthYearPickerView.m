//
//  MonthYearPickerView.m
//  shop
//
//  Created by Shilpa Modi on 3/3/13.
//  Copyright (c) 2013 Real Real. All rights reserved.
//

#import "SMMonthYearPickerView.h"

static const uint MAX_YEARS=10;

@interface  SMMonthYearPickerView()
@property (nonatomic, strong) NSIndexPath *todayIndexPath;
@property (nonatomic, strong) NSArray *months;
@property (nonatomic, strong) NSMutableArray *years;
@end

@implementation SMMonthYearPickerView

-(id) initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame]))
    {
        [super setDataSource:self];
        [super setDelegate:self];
        self.showsSelectionIndicator = YES;
        [self fillMonths];
        [self fillYears];
    }
    
    return self;
}

-(void) fillMonths
{
    self.months = [[NSArray alloc] initWithObjects:@"01",
                                                  @"02",
                                                  @"03",
                                                  @"04", @"05", @"06", @"07", @"08", @"09", @"10", @"11", @"12", nil];
}

-(void) fillYears
{
    NSDateComponents *components = [[NSCalendar currentCalendar]
                                    components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:[NSDate date]];
    
    NSInteger currentYear = [components year];

    self.years = [[NSMutableArray alloc] init];
    
    for(int i=0; i<MAX_YEARS; i++)
    {
        NSString* str = [NSString stringWithFormat:@"%d", currentYear+i];
        NSLog(@"Str = %@", str );
        [self.years insertObject:str atIndex:i];
    }
}

-(NSString*) getCurrentMonth
{
    return [self.months objectAtIndex:[self selectedRowInComponent:0]];
}

-(NSString*) getCurrentYear
{
    return [self.years objectAtIndex:[self selectedRowInComponent:1]];
}

#pragma mark - UIPickerViewDelegate
-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    if(component == 0)
        return 200;
    else
        return 100;
}

-(UIView *)pickerView: (UIPickerView *)pickerView
           viewForRow: (NSInteger)row
         forComponent: (NSInteger)component
          reusingView: (UIView *)view
{
    UILabel* label = nil;
    CGFloat width = 0;
    
    if(component == 0)
        width = 200;
    else
        width = 100;
    
    if(!view.tag)
    {
        label = [[UILabel alloc] initWithFrame:CGRectMake(30, 10, width, 30)];
        label.tag = 1;
    }
    else
    {
        label = (UILabel*) view;
    }
    
    if(component == 0)
        label.text = [self.months objectAtIndex:row];
    else
        label.text = [self.years objectAtIndex:row];
    
    label.textAlignment = UITextAlignmentCenter;
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:18.f];
    label.userInteractionEnabled = NO;

    return label;
}

-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 30;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (self.mDelegate)
    {
        if ([self.mDelegate respondsToSelector:@selector(pickerViewDidPickMonth:AndYear:)])
        {
            NSString* month = [self.months objectAtIndex:[pickerView selectedRowInComponent:0]];
            NSString* year = [self.years objectAtIndex:[pickerView selectedRowInComponent:1]];
            [self.mDelegate pickerViewDidPickMonth:month AndYear:year];
        }
    }
}

#pragma mark - UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if(component == 0)
        return [self.months count];
    else
        return [self.years count];
}

@end
