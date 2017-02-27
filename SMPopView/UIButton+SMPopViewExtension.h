//
//  SMPopView
//  https://github.com/shengpeng3344
//
//  Created by Simply on 16/6/16.
//  Copyright © 2016年 mhjmac. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SMPopView;

@interface UIButton (SMPopViewExtension)

- (void)setPopView:(SMPopView*)popView AtPoint:(CGPoint)point;

@end
