//
//  EventsReceiver.m
//  Progress
//
//  Created by Z on 06.11.17.
//  Copyright © 2017 KonstantinBulavenko. All rights reserved.
//

#import "EventsReceiver.h"

@implementation EventsReceiver


- (instancetype)init {
    self = [super init];
    if (self) {
        _events             = [NSMutableArray   array];
        _eventsCount        = 0;
        _isEventsActually   = 0;
        _actualEventsNumber = 0;
    }
    return self;
}


- (BOOL)receiveEvents {
    if(self.isEventsActually)  return false;
    self.events = [NSMutableArray array];
    self.eventsCount   =   1 + arc4random_uniform(1000);
    for (NSUInteger   i = 0; i < self.eventsCount; i++) {
        double randomNumber      =  (double) (0.000001 +  1.0 * arc4random_uniform(100)/ ( 1+ arc4random_uniform(1) )) / (double)(1000.0/ ( 1+ arc4random_uniform(5)) +arc4random_uniform(10000));
        
        NSNumber    *nextNumber  =  [NSNumber   numberWithDouble: randomNumber];
        [self.events addObject: nextNumber];
    }
    NSLog(@"Events : %@", self.events);
    return true;
}

- (void)runEvents {
    
    if(self.isEventsActually)  return;
   // if(self.)
    NSLog(@"It's  events running begin");
    dispatch_queue_t eventsSynchronusQueue   =  dispatch_queue_create("PROGRESS_EVENTS_QUEUE", DISPATCH_QUEUE_SERIAL);
    dispatch_async(eventsSynchronusQueue, ^{
        self.isEventsActually = true;
        for (NSInteger   i  = 0; i < self.eventsCount; i++) {
            NSLog(@"Event with number %li start", i);
            double   correctionTimeWaiting  =  (self.eventsCount < 100)? 0.1:0.001;
            [NSThread  sleepForTimeInterval:  (NSTimeInterval) [self.events objectAtIndex: i].doubleValue + correctionTimeWaiting];
            self.actualEventsNumber++;
            NSLog(@"Event with number %li ended. We send notification.", i);
            
            [[NSNotificationCenter  defaultCenter]   postNotificationName:ProgressEventsActualEventEndedNotification object: self];
        }
        self.isEventsActually = false;
        self.actualEventsNumber = 0;
        NSLog(@"It's  events running ending");

    });
}


@end
