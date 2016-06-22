//
//  SimplePopupView.h
//  https://github.com/shengpeng3344
//
//  Created by Simply on 16/6/16.
//  Copyright © 2016年 mhjmac. All rights reserved.
//

#import "UIView+SimplePopupView.h"
#import "UIView+SetRect.h"
@implementation UIView (SimplePopupView)

- (void)showPopView:(SimplePopupView*)popView AtPoint:(CGPoint)point;
{
    UIView *screenView = [[UIApplication sharedApplication].delegate window];
    CGPoint center = [self.superview convertPoint:self.center toView:screenView];
    CGPoint origin = [self.superview convertPoint:self.frame.origin toView:screenView];
    CGFloat tmpX;
    CGFloat tmpY;
    switch (popView.direction) {
        case PopViewDirectionTop:
            if (popView.isMargin) {
                if (popView.trianglePercent >= 0.5) {
                    tmpX = origin.x+point.x*self.bounds.size.width - popView.frame.size.width;
                    tmpY = origin.y+point.y*self.bounds.size.height;
                }else{
                    tmpX = origin.x+point.x*self.bounds.size.width;
                    tmpY = origin.y+point.y*self.bounds.size.height;
                }
            }else{
                tmpX = origin.x+point.x*self.bounds.size.width-popView.frame.size.width*popView.trianglePercent;
                tmpY = origin.y+point.y*self.bounds.size.height;
            }
            break;
        case PopViewDirectionLeft:
            if (popView.isMargin) {
                if (popView.trianglePercent >= 0.5) {
                    tmpX = origin.x+point.x*self.bounds.size.width;
                    tmpY = origin.y+point.y*self.bounds.size.height-popView.frame.size.height;
                }else{
                    tmpX = origin.x+point.x*self.bounds.size.width;
                    tmpY = origin.y+point.y*self.bounds.size.height;
                }
            }else{
                tmpX = origin.x+point.x*self.bounds.size.width;
                tmpY = origin.y+point.y*self.bounds.size.height-popView.frame.size.height*popView.trianglePercent;
            }
            
            break;
        case PopViewDirectionButton:
            if (popView.isMargin) {
                if (popView.trianglePercent >= 0.5) {
                    tmpX = origin.x+point.x*self.bounds.size.width - popView.frame.size.width;
                    tmpY = origin.y+point.y*self.bounds.size.height-popView.frame.size.height;
                }else{
                    tmpX = origin.x+point.x*self.bounds.size.width;
                    tmpY = origin.y+point.y*self.bounds.size.height-popView.frame.size.height;
                }
            }else{
                tmpX = origin.x+point.x*self.bounds.size.width-popView.frame.size.width*popView.trianglePercent;
                tmpY = origin.y+point.y*self.bounds.size.height-popView.frame.size.height;
            }
            break;
        case PopViewDirectionRight:
            if (popView.isMargin) {
                if (popView.trianglePercent >= 0.5) {
                    tmpX = origin.x+point.x*self.bounds.size.width-popView.frame.size.width;
                    tmpY = origin.y+point.y*self.bounds.size.height-popView.frame.size.height;
                }else{
                    tmpX = origin.x+point.x*self.bounds.size.width-popView.frame.size.width;
                    tmpY = origin.y+point.y*self.bounds.size.height;
                }
            }else{
                tmpX = origin.x+point.x*self.bounds.size.width-popView.frame.size.width;
                tmpY = origin.y+point.y*self.bounds.size.height-popView.frame.size.height*popView.trianglePercent;
            }
            break;
        default:
            break;
    }
    popView.viewOrigin = CGPointMake(tmpX, tmpY);
    
}



- (void)hidePopView
{
    
}


@end
