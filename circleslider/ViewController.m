//
//  ViewController.m
//  circleslider
//
//  Created by dpcc on 2016/04/12.
//  Copyright © 2016年 kdl. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    circleSlider.image = [UIImage imageNamed:@"volume"];
    circleSlider.minimumValue = 0;
    circleSlider.maximumValue = 100;
    circleSlider.value = 0;
    circleSlider.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)didChangeValue:(UICircleSlider *)sender
{
    [valueLabel setText:[NSString stringWithFormat:@"%.2f", sender.value]];
}

@end
