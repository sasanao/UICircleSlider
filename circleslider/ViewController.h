//
//  ViewController.h
//  circleslider
//
//  Created by dpcc on 2016/04/12.
//  Copyright © 2016年 kdl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UICircleSlider.h"

@interface ViewController : UIViewController<UICircleSliderDelegate> {
    IBOutlet UICircleSlider* circleSlider;
    IBOutlet UILabel* valueLabel;
}

@end
