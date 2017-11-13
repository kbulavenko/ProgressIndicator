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
        double randomNumber      =
        (double) (0.000001 +  1.0 * arc4random_uniform(100)/( 1+ arc4random_uniform(1) )) /
        (double)(1000.0/ ( 1+ arc4random_uniform(5)) +arc4random_uniform(10000));
        NSNumber    *nextNumber  =  [NSNumber   numberWithDouble: randomNumber];
        [self.events addObject: nextNumber];
    }
    NSLog(@"Events.count : %li", self.events.count);
    return true;
}

- (void)runEvents {
    if(self.isEventsActually)  return;
    NSLog(@"It's  events running begin");
    dispatch_queue_t eventsSynchronusQueue   =  dispatch_queue_create("PROGRESS_EVENTS_QUEUE", DISPATCH_QUEUE_SERIAL);
    dispatch_async(eventsSynchronusQueue, ^{
        self.isEventsActually = true;
        for (NSInteger   i  = 0; i < self.eventsCount; i++) {
            NSLog(@"EventsCount  =  %li Event with number %li start, event longterm = %lf", self.eventsCount, i,[self.events objectAtIndex: i].doubleValue) ;
            self.actualEventsNumber++;
            double   correctionTimeWaiting  =  (self.eventsCount < 100)? 0.1:0.001;
            correctionTimeWaiting     =   pow (0.3   ,  log10(10 + self.eventsCount));
            [NSThread  sleepForTimeInterval:  (NSTimeInterval) [self.events objectAtIndex: i].doubleValue + correctionTimeWaiting];
            self.actualEventsNumber++;
            [[NSNotificationCenter  defaultCenter]   postNotificationName:ProgressEventsActualEventEndedNotification object: self];
        }
        self.isEventsActually = false;
        self.actualEventsNumber = 0;
        NSLog(@"It's  events running ending");
    });
}



@end
