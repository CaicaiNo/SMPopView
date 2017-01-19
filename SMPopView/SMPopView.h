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

/**
 箭头  三角形位置 [-1,1]
 */
@property (nonatomic, assign) float arrowValue;

/**
 三角形位于popview的方向  top left button right

 */
@property (nonatomic, assign) SMPopViewDirection direction;

/**
 背景颜色
 */
@property (nonatomic, strong) UIColor *popColor;

/**
 title颜色
 */
@property (nonatomic, strong) UIColor *popTintColor;

/**
 箭头 三角边长
 */
@property (nonatomic, assign) float arrowEdge;

/**
 当arrowValue值使得箭头会超过视图区域时，偏移量大小,大小与offsetBaseValue成正比
 */
@property (nonatomic, assign,readonly) float offset;

/**
 圆角系数 0 为直角
 */
@property (nonatomic, assign) float CornerRadius;


@property (nonatomic, assign) float offsetBaseValue;

- (instancetype)initWithFrame:(CGRect)frame
                    direction:(SMPopViewDirection)direction
                       titles:(NSArray *)titles;

- (instancetype)initWithFrame:(CGRect)frame
                    direction:(SMPopViewDirection)direction
                       titles:(NSArray *)titles
                       images:(NSArray *)images
                   arrowValue:(float)value;

- (void)setClickHandler:(void (^)(SMPopView *popView,NSIndexPath *indexPath))handler;

- (void)show;

- (void)hide;


@end
