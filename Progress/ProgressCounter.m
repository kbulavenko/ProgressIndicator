//
//  ProgressCounter.m
//  Progress
//
//  Created by Z on 06.11.17.
//  Copyright © 2017 KonstantinBulavenko. All rights reserved.
//

#import "ProgressCounter.h"

@implementation ProgressCounter




- (instancetype)init
{
    self = [super init];
    if (self) {
        _eventsReceiver  = [[EventsReceiver alloc] init];
        
        
        
        [[NSNotificationCenter  defaultCenter]  addObserver:self selector: @selector(observerActualEvent:) name:ProgressEventsActualEventEndedNotification object:nil];
        
        
        [_eventsReceiver   receiveEvents];
        [_eventsReceiver   runEvents];
        
    }
    return self;
}


-(void)observerActualEvent: (NSNotification *)  event {
    [self performSelectorOnMainThread: @selector(correctCompletitionPercentage) withObject:nil waitUntilDone: true];
}

-(void)correctCompletitionPercentage {
    if(self.eventsReceiver.eventsCount > 0)     {
        self.completitionPercentage   =  100.0 *( (double)self.eventsReceiver.actualEventsNumber )/ (double) (self.eventsReceiver.eventsCount);
    } else {
        self.completitionPercentage = 0;
    
    }
    
    [[NSNotificationCenter  defaultCenter] postNotificationName:CompletitionPercentageChangedAfterEventNotification object:self];
    
}






@end
