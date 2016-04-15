//
//  UICircleSlider.h
//  circleslider
//
//  Created by dpcc on 2016/04/13.
//  Copyright © 2016年 kdl. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UICircleSlider;
@protocol UICircleSliderDelegate <NSObject>
- (void)didChangeValue:(UICircleSlider*)sender;
@end

@interface UICircleSlider : UIView {
    UIImageView* _imageView;
    UIPanGestureRecognizer* _panGesture;
    CGPoint _beforePoint;
}

- (void)doTransform;

@property UIImage* image;
@property float maximumValue;
@property float minimumValue;
@property float value;

@property id<UICircleSliderDelegate> delegate;

@end
