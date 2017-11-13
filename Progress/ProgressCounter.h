//
//  ProgressCounter.h
//  Progress
//
//  Created by Z on 06.11.17.
//  Copyright © 2017 KonstantinBulavenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EventsReceiver.h"

static NSString *CompletitionPercentageChangedAfterEventNotification = @"CompletitionPercentageChangedAfterEventNotification";

@interface ProgressCounter : NSObject

@property (strong, nonatomic) EventsReceiver *eventsReceiver;
@property (assign, nonatomic) double completitionPercentage;
@property (assign, nonatomic) double timerPercentCounter;
@property (strong, nonatomic) NSTimer *timer;
@property (assign, nonatomic) BOOL isSmoothProgres;


@end
