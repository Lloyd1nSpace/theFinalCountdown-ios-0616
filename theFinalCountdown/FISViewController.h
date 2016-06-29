//
//  FISViewController.h
//  theFinalCountdown
//
//  Created by Joe Burgess on 7/9/14.
//  Copyright (c) 2014 Joe Burgess. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FISViewController : UIViewController {
    
    NSTimer *timer;
    // Declaring a property this way doesn't cause for me to call self. everytime, I can just call timer. This was also taken from the example I found in order to figure out how to get the timer to count down.
    
}

@end
