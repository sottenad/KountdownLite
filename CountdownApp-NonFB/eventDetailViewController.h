//
//  eventDetailViewController.h
//  CountdownApp-NonFB
//
//  Created by Steve Ottenad on 10/2/13.
//  Copyright (c) 2013 Steve Ottenad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface eventDetailViewController : UIViewController{
    NSDate *countdownNSDate;
    
}

@property UIImage *myImage;
@property NSString *myTitle;
@property NSString *myDate;

@property UIColor *fontColor;


@property IBOutlet UIImageView *mainImageView;
@property IBOutlet UILabel *countdownTitle;
@property IBOutlet UILabel *countdownDate;
@property IBOutlet UIButton *closeButton;


-(void) updateTimer;
- (NSDate *)combineDate:(NSDate *)date withTime:(NSDate *)time;
-(IBAction)closeDetailView;

@end
