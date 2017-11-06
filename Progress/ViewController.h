//
//  ViewController.h
//  Progress
//
//  Created by Z on 03.11.17.
//  Copyright © 2017 KonstantinBulavenko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProgressCounter.h"

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;


@property (weak, nonatomic) IBOutlet UILabel *progressPercent;

@property (strong, nonatomic)  ProgressCounter      *progressCounter;


@end

