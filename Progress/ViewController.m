//
//  ViewController.m
//  Progress
//
//  Created by Z on 03.11.17.
//  Copyright © 2017 KonstantinBulavenko. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [[NSNotificationCenter   defaultCenter]   addObserver:self selector:@selector(updatePercentage:) name:CompletitionPercentageChangedAfterEventNotification object:nil];
    
    _progressCounter   = [[ProgressCounter  alloc]   init];
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)updatePercentage: (NSNotification *) event {
    self.progressPercent.text  = [NSString   stringWithFormat:@"%5.2f%%", self.progressCounter.completitionPercentage];
    if(self.progressCounter.completitionPercentage == 100.00) {
        self.progressPercent.text  = @"Complete!";
        [self.activityIndicator  stopAnimating];
    
    }
}





@end
