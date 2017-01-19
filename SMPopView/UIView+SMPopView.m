//
//  SMPopView
//  https://github.com/shengpeng3344
//
//  Created by Simply on 16/6/16.
//  Copyright © 2016年 mhjmac. All rights reserved.
//

#import "UIView+SMPopView.h"
#import "UIView+SetRect.h"

@implementation UIView (SMPopView)

- (void)showPopView:(SMPopView*)popView AtPoint:(CGPoint)point;
{
    UIView *screenView = [[UIApplication sharedApplication].delegate window];
    CGFloat W = popView.frame.size.width;
    CGFloat H = popView.frame.size.height;
    
    CGFloat SW = self.frame.size.width;
    CGFloat SH = self.frame.size.height;
    
    CGPoint P = point;
    CGPoint O = [self.superview convertPoint:self.frame.origin toView:screenView];
    CGFloat X;
    CGFloat Y;
    
    CGFloat offset = popView.offset;
    
    switch (popView.direction) {
        case SMPopViewDirectionTop:{
            X = O.x + SW*P.x - W*popView.arrowValue - offset;
            Y = O.y + SH*P.y;
        }
            break;
        case SMPopViewDirectionLeft:{
            X = O.x + SW*P.x;
            Y = O.y + SH*P.y - H*popView.arrowValue - offset;
        }
            
            break;
        case SMPopViewDirectionButton:{
            X = O.x + SW*P.x - W*popView.arrowValue - offset;
            Y = O.y + SH*P.y - H;
        }
            break;
        case SMPopViewDirectionRight:{
            X = O.x + SW*P.x - W;
            Y = O.y + SH*P.y - H*popView.arrowValue - offset;
            break;
        }
        default:
            break;
    }
    popView.viewOrigin = CGPointMake(X, Y);
    
}





@end
