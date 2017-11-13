//
//  ProgressCounter.m
//  Progress
//
//  Created by Z on 06.11.17.
//  Copyright © 2017 KonstantinBulavenko. All rights reserved.
//

#import "ProgressCounter.h"

@interface ProgressCounter()
@property (assign, nonatomic) double timerStep;
@property (assign, nonatomic) double timerStepDeceleration;
@property (assign, nonatomic) double timerBegin;
@property (assign, nonatomic) double timerEnd;
@end

@implementation ProgressCounter

- (instancetype)init
{
    self = [super init];
    if (self) {
        _eventsReceiver  = [[EventsReceiver alloc] init];
        [[NSNotificationCenter  defaultCenter]  addObserver:self selector: @selector(observerActualEvent:) name:ProgressEventsActualEventEndedNotification object:nil];
        [_eventsReceiver receiveEvents];
        [_eventsReceiver runEvents];
        _timerPercentCounter = 0;
        _timerStep =  0.1;
        _isSmoothProgres = true;
        _timerBegin             = 0.0;
        _timerEnd               = 100.0;
        _timer   =  [NSTimer   timerWithTimeInterval: 0.02  target:self selector:@selector(fireMethod) userInfo:nil repeats: true];
        [[NSRunLoop  currentRunLoop]   addTimer: _timer forMode: NSDefaultRunLoopMode];
    }
    return self;
}

- (void)observerActualEvent: (NSNotification *)  event {
    [self performSelectorOnMainThread: @selector(correctCompletitionPercentage) withObject:nil waitUntilDone: true];
}

- (void)correctCompletitionPercentage {
    if(self.eventsReceiver.eventsCount > 0)     {
        self.completitionPercentage   =  100.0 *( (double)self.eventsReceiver.actualEventsNumber )/ (double) (self.eventsReceiver.eventsCount);
    } else {
        self.completitionPercentage = 0;
    }
}

- (void)fireMethod  {
    if(self.timerPercentCounter >= self.timerEnd)  {
        NSLog(@"timerEnd!!!");
        self.timerPercentCounter   = self.timerEnd;
        [self.timer    invalidate];
    } else {
        if (self.isSmoothProgres) {
            // Do it slow when event is slow  do it fast when event is fast.
            if(floor(self.completitionPercentage + 0.5)  < floor(self.timerPercentCounter +0.5 ) )  {
               if(self.timerStep > 0.000001) self.timerStep /= 2;
            }
            if(floor(self.completitionPercentage + 0.5)  > floor(self.timerPercentCounter +0.5) ) {
                 if(self.timerStep <= 0.025) self.timerStep *= 2;
            }
        }
        self.timerPercentCounter += self.timerStep;
    }
     [[NSNotificationCenter  defaultCenter] postNotificationName:CompletitionPercentageChangedAfterEventNotification object:self];
}

@end
