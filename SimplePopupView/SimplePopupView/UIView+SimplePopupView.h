//
//  UIView+SimplePopupView.h
//  https://github.com/shengpeng3344
//
//  Created by Simply on 16/6/16.
//  Copyright © 2016年 mhjmac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SimplePopupView.h"
@interface UIView (SimplePopupView)


- (void)showPopView:(SimplePopupView*)popView AtPoint:(CGPoint)point;

- (void)hidePopView;

@end
