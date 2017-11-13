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
    [[NSNotificationCenter   defaultCenter]   addObserver: self
                                                 selector: @selector(updatePercentage:)
                                                     name: CompletitionPercentageChangedAfterEventNotification
                                                   object: nil];
    _progressCounter = [[ProgressCounter alloc] init];
    _progressView = [[UIProgressView alloc]  initWithProgressViewStyle:UIProgressViewStyleDefault];
    _progressView.translatesAutoresizingMaskIntoConstraints  = YES;
    [_progressView setFrame:CGRectMake(0, 0, self.view.frame.size.width / 2, 10)];
    _progressView.center = CGPointMake(self.view.frame.size.width /2 , self.view.frame.size.height /2- 25);
    _progressView.progress = 0.0;
    NSLayoutConstraint      *constraintCenterHorizontal  =
    [NSLayoutConstraint   constraintWithItem: _progressView
                                   attribute: NSLayoutAttributeCenterX
                                   relatedBy: NSLayoutRelationEqual
                                      toItem: self.view
                                   attribute: NSLayoutAttributeCenterX
                                  multiplier: 1
                                    constant: 0];
    NSLayoutConstraint      *constraintCenterVertical  =
    [NSLayoutConstraint   constraintWithItem: _progressView
                                   attribute: NSLayoutAttributeCenterY
                                   relatedBy: NSLayoutRelationEqual
                                      toItem: self.view
                                   attribute:NSLayoutAttributeCenterY
                                  multiplier:1
                                    constant: - 30];
    [self.view addSubview: _progressView];
    [self.view  addConstraint: constraintCenterVertical];
    [self.view addConstraint: constraintCenterHorizontal];
    [_progressView setNeedsUpdateConstraints];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)updatePercentage: (NSNotification *) event {
    self.progressPercent.text  = [NSString   stringWithFormat:@"%5.0f%%", self.progressCounter.timerPercentCounter];
    [self.progressView setProgress:(float)((float) self.progressCounter.timerPercentCounter / 100.0)  animated: true ];
    if(self.progressCounter.timerPercentCounter == 100.00) {
        self.progressPercent.text  = @"Complete!";
    }
}

@end
