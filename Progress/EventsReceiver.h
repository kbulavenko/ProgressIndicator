//
//  EventsReceiver.h
//  Progress
//
//  Created by Z on 06.11.17.
//  Copyright © 2017 KonstantinBulavenko. All rights reserved.
//

#import <Foundation/Foundation.h>

static   NSString     *ProgressEventsActualEventEndedNotification   = @"ProgressEventsActualEventEndedNotification";

@interface EventsReceiver : NSObject

@property (strong, nonatomic) NSMutableArray<NSNumber *> *events;            //  The Events collection
@property (assign, nonatomic) NSInteger eventsCount;        // It's number of all events
@property (assign, nonatomic) BOOL isEventsActually;   //Some event is Now Activ
@property (assign, nonatomic) NSInteger actualEventsNumber; // Number of current event in collection

- (BOOL)receiveEvents;
- (void)runEvents;


@end




