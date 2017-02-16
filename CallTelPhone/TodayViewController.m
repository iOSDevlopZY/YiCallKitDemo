//
//  TodayViewController.m
//  CallTelPhone
//
//  Created by Developer_Yi on 2017/2/16.
//  Copyright © 2017年 mac. All rights reserved.
//
#import "ViewController.h"
#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>

@interface TodayViewController () <NCWidgetProviding>
@property (weak, nonatomic) IBOutlet UILabel *telLabel;

@end

@implementation TodayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UITapGestureRecognizer *reg=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pass)];
    self.telLabel.userInteractionEnabled=YES;
    [self.telLabel addGestureRecognizer:reg];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
    // Perform any setup necessary in order to update the view.
    
    // If an error is encountered, use NCUpdateResultFailed
    // If there's no update required, use NCUpdateResultNoData
    // If there's an update, use NCUpdateResultNewData

    completionHandler(NCUpdateResultNewData);
}

- (void)pass
{
    [self.extensionContext openURL:[NSURL URLWithString:@"CallTelPhone://"] completionHandler:^(BOOL success) {
        NSLog(@"open url result:%d",success);
    }];
}
@end
