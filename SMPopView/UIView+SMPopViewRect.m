//
//  UIView+SMPopViewRect.m
//  SMPopViewExample
//
//  Created by tangmi on 17/1/20.
//  Copyright © 2017年 SM. All rights reserved.
//

#import "UIView+SMPopViewRect.h"

@implementation UIView (SMPopViewRect)
- (CGPoint)viewOrigin {
    
    return self.frame.origin;
}

- (void)setViewOrigin:(CGPoint)viewOrigin {
    
    CGRect newFrame = self.frame;
    newFrame.origin = viewOrigin;
    self.frame      = newFrame;
}

- (CGSize)viewSize {
    
    return self.frame.size;
}

- (void)setViewSize:(CGSize)viewSize {
    
    CGRect newFrame = self.frame;
    newFrame.size   = viewSize;
    self.frame      = newFrame;
}

- (CGFloat)x {
    
    return self.frame.origin.x;
}

- (void)setX:(CGFloat)x {
    
    CGRect newFrame   = self.frame;
    newFrame.origin.x = x;
    self.frame        = newFrame;
}

- (CGFloat)y {
    
    return self.frame.origin.y;
}

- (void)setY:(CGFloat)y {
    
    CGRect newFrame   = self.frame;
    newFrame.origin.y = y;
    self.frame        = newFrame;
}

- (CGFloat)width {
    
    return CGRectGetWidth(self.bounds);
}

- (void)setWidth:(CGFloat)width {
    
    CGRect newFrame     = self.frame;
    newFrame.size.width = width;
    self.frame          = newFrame;
}

- (CGFloat)height {
    
    return CGRectGetHeight(self.bounds);
}

- (void)setHeight:(CGFloat)height {
    
    CGRect newFrame      = self.frame;
    newFrame.size.height = height;
    self.frame           = newFrame;
}

- (CGFloat)top {
    
    return self.frame.origin.y;
}

- (void)setTop:(CGFloat)top {
    
    CGRect newFrame   = self.frame;
    newFrame.origin.y = top;
    self.frame        = newFrame;
}

- (CGFloat)bottom {
    
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom:(CGFloat)bottom {
    
    CGRect newFrame   = self.frame;
    newFrame.origin.y = bottom - self.frame.size.height;
    self.frame        = newFrame;
}

- (CGFloat)left {
    
    return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)left {
    
    CGRect newFrame   = self.frame;
    newFrame.origin.x = left;
    self.frame        = newFrame;
}

- (CGFloat)right {
    
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setRight:(CGFloat)right {
    
    CGRect newFrame   = self.frame;
    newFrame.origin.x = right - self.frame.size.width;
    self.frame        = newFrame;
}

- (CGFloat)centerX {
    
    return self.center.x;
}

- (void)setCenterX:(CGFloat)centerX {
    
    CGPoint newCenter = self.center;
    newCenter.x       = centerX;
    self.center       = newCenter;
}

- (CGFloat)centerY {
    
    return self.center.y;
}

- (void)setCenterY:(CGFloat)centerY {
    
    CGPoint newCenter = self.center;
    newCenter.y       = centerY;
    self.center       = newCenter;
}

- (CGFloat)middleX {
    
    return CGRectGetWidth(self.bounds) / 2.f;
}

- (CGFloat)middleY {
    
    return CGRectGetHeight(self.bounds) / 2.f;
}

- (CGPoint)middlePoint {
    
    return CGPointMake(CGRectGetWidth(self.bounds) / 2.f, CGRectGetHeight(self.bounds) / 2.f);
}

@end
