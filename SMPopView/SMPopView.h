//
//  SMPopView
//  https://github.com/shengpeng3344
//
//  Created by Simply on 16/6/16.
//  Copyright © 2016年 mhjmac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SMPopViewConst.h"

@class SMPopView;

typedef enum : NSUInteger {
    
    SMPopViewDirectionTop    = 1 << 0,
    SMPopViewDirectionLeft   = 1 << 1,
    SMPopViewDirectionButton = 1 << 2,
    SMPopViewDirectionRight  = 1 << 3,
    
} SMPopViewDirection;

typedef void (^SMHandlerBlock)(SMPopView *popView,NSIndexPath *indexPath);

@interface SMPopView : UIView


@property (nonatomic, strong) NSArray *images;  //图片数组

@property (nonatomic, strong) NSArray *titles;  //title数组

@property (nonatomic, assign) float trianglePercent;  //三角形在某一边位置的百分比 默认0.5  [0,1] 

@property (nonatomic, assign) SMPopViewDirection direction;  //三角形位于popview的方向  top left button right

@property (nonatomic, strong) UIColor *popColor;  //背景颜色

@property (nonatomic, strong) UIColor *popTintColor;  //title颜色

@property (nonatomic, assign) float edgeLength; //三角边长

@property (nonatomic, assign) BOOL isMargin; //是否在边缘

@property (nonatomic, assign) float CornerRadius; //隐藏圆角


- (instancetype)initWithFrame:(CGRect)frame
                 andDirection:(SMPopViewDirection)direction
                    andTitles:(NSArray *)titles;

- (instancetype)initWithFrame:(CGRect)frame
                 andDirection:(SMPopViewDirection)direction
                    andTitles:(NSArray *)titles
                    andImages:(NSArray *)images
               trianglePecent:(float)percent;

- (void)setClickHandler:(void (^)(SMPopView *popView,NSIndexPath *indexPath))handler;

- (void)show;

- (void)hide;


@end
