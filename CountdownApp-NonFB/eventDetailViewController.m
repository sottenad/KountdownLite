//
//  eventDetailViewController.m
//  CountdownApp-NonFB
//
//  Created by Steve Ottenad on 10/2/13.
//  Copyright (c) 2013 Steve Ottenad. All rights reserved.
//

#import "eventDetailViewController.h"

@interface eventDetailViewController ()

@end

@implementation eventDetailViewController

@synthesize myDate, myImage, myTitle, fontColor, countdownTitle, countdownDate, mainImageView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd HH:mm:ss ZZZ"];
    [df setTimeZone:[NSTimeZone systemTimeZone]];
    
    NSDateFormatter *tf = [[NSDateFormatter alloc] init];
    [tf setDateFormat:@"h:m"];
    [df setTimeZone:[NSTimeZone systemTimeZone]];    

    countdownNSDate = [df dateFromString:myDate];




    
     
    countdownTitle.text = myTitle;
    mainImageView.image = myImage;
    
    [countdownTitle setTextColor:fontColor];
    [countdownDate setTextColor:fontColor];
    
    [self updateTimer];
    
    NSTimer* myTimer = [NSTimer scheduledTimerWithTimeInterval: 1.0 target: self
                                                      selector: @selector(updateTimer) userInfo: nil repeats: YES];
    
    
}

-(void) updateTimer{
    NSTimeInterval secondsBetweenDates = [countdownNSDate timeIntervalSinceDate: [NSDate date]];
    double secondsInAMinute = 60;
    double secondsInAnHour = secondsInAMinute * 60;
    double secondsInADay = secondsInAnHour * 24;

    NSInteger minutesBetweenDates = secondsBetweenDates / secondsInAMinute;
    NSInteger hoursBetweenDates = secondsBetweenDates / secondsInAnHour;
    NSInteger daysBetweenDates = secondsBetweenDates / secondsInADay;
    
    NSString *daysString = [[NSString alloc] initWithFormat:@"%i Day%@", daysBetweenDates, (daysBetweenDates == 1 ? @"" : @"s")];
    NSString *hoursString = [[NSString alloc] initWithFormat:@"%i Hour%@", hoursBetweenDates%24, (hoursBetweenDates%24 == 1 ? @"" : @"s")];
    NSString *minutesString = [[NSString alloc] initWithFormat:@"%i Minute%@", minutesBetweenDates%60, (minutesBetweenDates%60 == 1 ? @"" : @"s")];
    NSString *secondsString = [[NSString alloc] initWithFormat:@"%i Second%@", (NSInteger)secondsBetweenDates%60, ((NSInteger)secondsBetweenDates%60 == 1 ? @"" : @"s")];
    
    
    NSString *finalString = [[NSString alloc] initWithFormat:@"%@, %@, %@ & %@", daysString, hoursString, minutesString,secondsString];
    
    countdownDate.text = finalString;

}

-(void) closeDetailView{
    
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSDate *)combineDate:(NSDate *)date withTime:(NSDate *)time {
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    unsigned unitFlagsDate = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit;
    NSDateComponents *dateComponents = [gregorian components:unitFlagsDate fromDate:date];
    unsigned unitFlagsTime = NSHourCalendarUnit | NSMinuteCalendarUnit |  NSSecondCalendarUnit;
    NSDateComponents *timeComponents = [gregorian components:unitFlagsTime fromDate:time];
    
    [dateComponents setSecond:[timeComponents second]];
    [dateComponents setHour:[timeComponents hour]];
    [dateComponents setMinute:[timeComponents minute]];
    
    NSDate *combDate = [gregorian dateFromComponents:dateComponents];
    
    return combDate;
}

@end
