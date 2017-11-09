//
//  ProgressCounter.m
//  Progress
//
//  Created by Z on 06.11.17.
//  Copyright © 2017 KonstantinBulavenko. All rights reserved.
//

#import "ProgressCounter.h"



@interface ProgressCounter()

@property  (assign, nonatomic)  double              timerStep;
@property  (assign, nonatomic)  double              timerStepDeceleration;
@property  (assign, nonatomic)  double              timerBegin;
@property  (assign, nonatomic)  double              timerEnd;



@end


@implementation ProgressCounter




- (instancetype)init
{
    self = [super init];
    if (self) {
        _eventsReceiver  = [[EventsReceiver alloc] init];
        
        
        [[NSNotificationCenter  defaultCenter]  addObserver:self selector: @selector(observerActualEvent:) name:ProgressEventsActualEventEndedNotification object:nil];
        
        
        [_eventsReceiver   receiveEvents];
        [_eventsReceiver   runEvents];
        
        
        
        _timerPercentCounter    = 0;
        _timerStep              =  0.1;
        //(double)(_eventsReceiver.eventsCount > 100) * 100.0 / (1.0 +(double)_eventsReceiver.eventsCount) + (double)(_eventsReceiver.eventsCount <= 100) * 1;
        _timerBegin             = 0.0;
        _timerEnd               = 100.0;
       //  NSLog(@"timerStep = %lf", _timerStep);
        _timer   =  [NSTimer   timerWithTimeInterval: 0.02  target:self selector:@selector(fireMethod) userInfo:nil repeats: true];
       // [_timer  fire];
        [[NSRunLoop  currentRunLoop]   addTimer: _timer forMode: NSDefaultRunLoopMode];
        
    }
    return self;
}


-(void)observerActualEvent: (NSNotification *)  event {
    [self performSelectorOnMainThread: @selector(correctCompletitionPercentage) withObject:nil waitUntilDone: true];
}

-(void)correctCompletitionPercentage {
  //  NSLog(@"timer = %@", self.timer.valid?@"Valid":@"invalidated");
    if(self.eventsReceiver.eventsCount > 0)     {
        self.completitionPercentage   =  100.0 *( (double)self.eventsReceiver.actualEventsNumber )/ (double) (self.eventsReceiver.eventsCount);
        
    } else {
        self.completitionPercentage = 0;
    }
    
}


-(void)fireMethod  {
    
 //   NSLog(@"FireMethod");
    if(self.timerPercentCounter >= self.timerEnd)  {
        NSLog(@"timerEnd!!!");
        self.timerPercentCounter   = self.timerEnd;
        [self.timer    invalidate];
    } else {
    //  if (!(rand() %6))  NSLog(@" self.timerPercentCounter = %lf,  self.completitionPercentage = %lf", self.timerPercentCounter,  self.completitionPercentage);
      //  double   correctionWhenLessHundrid    = (self.completitionPercentage < self.timerPercentCounter) ? self.timerStep *  (self.completitionPercentage + 0.1) / (self.timerPercentCounter + 0.1): 0.9;
     //   self.timerStep   =    (double)(_eventsReceiver.eventsCount > 100) * self.timerStep *  ( self.completitionPercentage +0.1 ) /  ( self.timerPercentCounter +0.1)  + (double)(_eventsReceiver.eventsCount <= 100) * 1.0 * correctionWhenLessHundrid;
       /*
//              Do it slow when event is slow  do it fast when event is fast. 
        
        
        if((self.completitionPercentage + 0.5)  < (self.timerPercentCounter +0.5 ) )
        {
            
           if(self.timerStep > 0.000001) self.timerStep /= 2;
        }
         if((self.completitionPercentage + 0.5)  > (self.timerPercentCounter +0.5) ) {
            
             if(self.timerStep <= 0.125) self.timerStep *= 2;
        }
        
        if (!(rand() %10))  NSLog(@"timerStep = %g", self.timerStep);
        */
        self.timerPercentCounter += self.timerStep;
    }
     [[NSNotificationCenter  defaultCenter] postNotificationName:CompletitionPercentageChangedAfterEventNotification object:self];
}



@end
