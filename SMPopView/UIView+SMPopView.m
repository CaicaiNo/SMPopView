//
//  SMPopView
//  https://github.com/shengpeng3344
//
//  Created by Simply on 16/6/16.
//  Copyright © 2016年 mhjmac. All rights reserved.
//

#import "UIView+SMPopView.h"
#import "UIView+SetRect.h"

#define SMWidth self.bounds.size.width
#define SMHeight self.bounds.size.height

@implementation UIView (SMPopView)

- (void)showPopView:(SMPopView*)popView AtPoint:(CGPoint)point;
{
    UIView *screenView = [[UIApplication sharedApplication].delegate window];
    CGPoint P = point;
    CGPoint O = [self.superview convertPoint:self.frame.origin toView:screenView];
    CGFloat X;
    CGFloat Y;
    switch (popView.direction) {
        case SMPopViewDirectionTop:
            if (popView.isMargin) {
                if (popView.trianglePercent >= 0.5) {
                    X = O.x + O.x*SMWidth - popView.frame.size.width;
                    Y = O.y + O.y*SMHeight;
                }else{
                    X = O.x + O.x*SMWidth;
                    Y = O.y + O.y*SMHeight;
                }
            }else{
                X = O.x + O.x*SMWidth - popView.frame.size.width*popView.trianglePercent;
                Y = O.y + O.y*SMHeight;
            }
            break;
        case SMPopViewDirectionLeft:
            if (popView.isMargin) {
                if (popView.trianglePercent >= 0.5) {
                    X = O.x + O.x*SMWidth;
                    Y = O.y + O.y*SMHeight - popView.frame.size.height;
                }else{
                    X = O.x + O.x*SMWidth;
                    Y = O.y + O.y*SMHeight;
                }
            }else{
                X = O.x + O.x*SMWidth;
                Y = O.y + O.y*SMHeight - popView.frame.size.height*popView.trianglePercent;
            }
            
            break;
        case SMPopViewDirectionButton:
            if (popView.isMargin) {
                if (popView.trianglePercent >= 0.5) {
                    X = O.x + O.x*SMWidth - popView.frame.size.width;
                    Y = O.y + O.y*SMHeight - popView.frame.size.height;
                }else{
                    X = O.x + O.x*SMWidth;
                    Y = O.y + O.y*SMHeight - popView.frame.size.height;
                }
            }else{
                X = O.x + O.x*SMWidth - popView.frame.size.width*popView.trianglePercent;
                Y = O.y + O.y*SMHeight - popView.frame.size.height;
            }
            break;
        case SMPopViewDirectionRight:
            if (popView.isMargin) {
                if (popView.trianglePercent >= 0.5) {
                    X = O.x + O.x*SMWidth - popView.frame.size.width;
                    Y = O.y + O.y*SMHeight - popView.frame.size.height;
                }else{
                    X = O.x + O.x*SMWidth - popView.frame.size.width;
                    Y = O.y + O.y*SMHeight;
                }
            }else{
                X = O.x + O.x*SMWidth - popView.frame.size.width;
                Y = O.y + O.y*SMHeight - popView.frame.size.height*popView.trianglePercent;
            }
            break;
        default:
            break;
    }
    popView.viewOrigin = CGPointMake(X, Y);
    
}





@end
