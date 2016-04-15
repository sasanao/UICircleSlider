//
//  UICircleSlider.m
//  circleslider
//
//  Created by dpcc on 2016/04/13.
//  Copyright © 2016年 kdl. All rights reserved.
//

#import "UICircleSlider.h"

@implementation UICircleSlider

- (id) initWithCoder:(NSCoder*)coder {
    self = [super initWithCoder:coder];
    if(self) {
        _imageView = [[UIImageView alloc]init];
        [self addSubview:_imageView];
        _panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(detectSwipe:)];
        [self addGestureRecognizer:_panGesture];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _imageView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    [self doTransform];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    _imageView.alpha = 0.8f;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    _imageView.alpha = 1.0f;
}

- (void)detectSwipe:(UIPanGestureRecognizer*)sender
{
    if (sender.state == UIGestureRecognizerStateEnded) {
        _imageView.alpha = 1.0f;
    }
    
    CGPoint pt = [sender locationInView:self.superview];

    if (sender.state == UIGestureRecognizerStateBegan) {
        _beforePoint = pt;
    }
    
    self.value +=  (pt.x - _beforePoint.x) * 0.5;
    _beforePoint = pt;
    
    if (self.value > self.maximumValue) {
        self.value = self.maximumValue;
    }
    if (self.value < self.minimumValue) {
        self.value = self.minimumValue;
    }
    
    [self doTransform];
}

- (void)doTransform
{
    float centervalue = (self.maximumValue - self.minimumValue) / 2;
    float value1 = self.value - centervalue;
    float value2 = (value1 / centervalue) * 150 * -1;
    
    CGImageRef imageRef = [self CGImageRotatedByAngle:[self.image CGImage] angle:value2];
    UIImage* img = [UIImage imageWithCGImage: imageRef];
    _imageView.image = img;
    
    [self.delegate didChangeValue:self];
}

- (CGImageRef)CGImageRotatedByAngle:(CGImageRef)imgRef angle:(CGFloat)angle
{
    CGFloat angleInRadians = angle * (M_PI / 180);
    CGFloat width = CGImageGetWidth(imgRef);
    CGFloat height = CGImageGetHeight(imgRef);
    
    CGRect imgRect = CGRectMake(0, 0, width, height);
    CGAffineTransform transform = CGAffineTransformMakeRotation(angleInRadians);
    CGRect rotatedRect = CGRectApplyAffineTransform(imgRect, transform);
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    CGContextRef bmContext = CGBitmapContextCreate(NULL,
                                                   rotatedRect.size.width,
                                                   rotatedRect.size.height,
                                                   8,
                                                   0,
                                                   colorSpace,
                                                   kCGImageAlphaPremultipliedFirst);
    CGContextSetAllowsAntialiasing(bmContext, YES);
    CGContextSetShouldAntialias(bmContext, YES);
    CGContextSetInterpolationQuality(bmContext, kCGInterpolationHigh);
    CGColorSpaceRelease(colorSpace);
    CGContextTranslateCTM(bmContext,
                          +(rotatedRect.size.width/2),
                          +(rotatedRect.size.height/2));
    CGContextRotateCTM(bmContext, angleInRadians);
    CGContextTranslateCTM(bmContext,
                          -(rotatedRect.size.width/2),
                          -(rotatedRect.size.height/2));
    CGContextDrawImage(bmContext, CGRectMake(0, 0,
                                             rotatedRect.size.width,
                                             rotatedRect.size.height),
                       imgRef);
    
    CGImageRef rotatedImage = CGBitmapContextCreateImage(bmContext);
    CFRelease(bmContext);
    
    return rotatedImage;
}

@end
