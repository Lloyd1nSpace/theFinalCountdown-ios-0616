//
//  FISViewController.m
//  theFinalCountdown
//
//  Created by Joe Burgess on 7/9/14.
//  Copyright (c) 2014 Joe Burgess. All rights reserved.
//

#import "FISViewController.h"

@interface FISViewController ()

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UILabel *timerLabel;

@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UIButton *pauseButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;

@property (nonatomic) NSInteger afterRemainder;
@property (nonatomic) NSInteger remainder;
@property (nonatomic) NSTimeInterval coundDownInterval;
// Pulled this NSTimeInterval & NSIntegers from a stack overflow example of how to create a countdown timer.


@end

@implementation FISViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.timerLabel.hidden = YES;
    self.pauseButton.enabled = NO;
    self.cancelButton.enabled = NO;
    self.cancelButton.hidden = YES;
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewWillAppear:(BOOL)animated
{
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateCountDown {
    
    self.afterRemainder--;
    
    NSUInteger hours = self.afterRemainder / (60 * 60);
    NSUInteger minutes = (self.afterRemainder / 60) - (hours * 60);
    NSUInteger seconds = self.afterRemainder - (60 * minutes) - (60 * hours * 60);
    
    if (hours < 10 && minutes < 10 && seconds < 10) {
        
        self.timerLabel.text = [NSString stringWithFormat:@"0%lu : 0%lu : 0%lu", hours, minutes, seconds];
        
    } else if (minutes < 10 && seconds > 9 && hours < 10) {
        
        self.timerLabel.text = [NSString stringWithFormat:@"0%lu : 0%lu : %lu", hours, minutes, seconds];
        
    } else if (minutes > 9 && seconds > 9 && hours < 10)  {
        
        self.timerLabel.text = [NSString stringWithFormat:@"0%lu : %lu : %lu", hours, minutes, seconds];
        
    } else if (minutes > 9 && seconds < 10 && hours < 10) {
        
        self.timerLabel.text = [NSString stringWithFormat:@"0%lu : %lu : %lu", hours, minutes, seconds];
        
    } else if (minutes > 9 && seconds > 9 && hours > 9) {
        
        self.timerLabel.text = [NSString stringWithFormat:@"%lu : %lu : %lu", hours, minutes, seconds];
        
    }
    
    if (seconds == 0 && minutes == 0 && hours == 0)  {
        
        self.timerLabel.text = @"Timer done!";
        [timer invalidate];
        
    }
    // These if & else if statements were implementing the format for what the timerLabel would show depending on where in the timer the user is. It will also display "Timer done!" when the timer has completed.
    
}

- (IBAction)startButtonTapped:(id)sender {
    
    self.datePicker.hidden = YES;
    self.timerLabel.hidden = NO;
    self.pauseButton.enabled = YES;
    self.startButton.hidden = YES;
    self.startButton.enabled = NO;
    self.cancelButton.hidden = NO;
    self.cancelButton.enabled = YES;
    // Similar to Blackjack views, this was all about getting the right buttons & labels to work at the right time.
    
    self.coundDownInterval = (NSTimeInterval)self.datePicker.countDownDuration;
    self.remainder = self.coundDownInterval;
    self.afterRemainder = self.coundDownInterval - self.remainder % 60;
    
    timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateCountDown) userInfo:nil repeats:YES];
    // The above 4-5 lines are exactly what got the timer to count down. Utilizing the two NSInteger properties & the NSTimeInterval property declared above.
    
}

- (IBAction)pauseButtonTapped:(id)sender {
    
    if (timer == nil) {
        
        timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateCountDown) userInfo:nil repeats:YES];
        
    } else {
        
        [timer invalidate];
        timer = nil;
        
    }
    // NEVER NIL! Yes it's true, but I had to nil. Probably didn't have to but this is what worked for me. If you just put [timer invalidate]; it will pause the timer with no way to unpause. Implementing this if & else statement ensured that the timer would resume where it left off. Ever line of code above is necessary to get it work with these if / else statements.
    
}

- (IBAction)cancelButtonTapped:(id)sender {
    
    self.timerLabel.text = @"Ready?";
    self.pauseButton.enabled = NO;
    self.startButton.hidden = NO;
    self.startButton.enabled = YES;
    self.cancelButton.hidden = YES;
    self.timerLabel.hidden = YES;
    self.datePicker.hidden = NO;
    
    [timer invalidate];
    
}

@end
