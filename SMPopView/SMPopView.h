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

@property (nonatomic, assign) float arrowValue;  //三角形位置 [-1,1]

@property (nonatomic, assign) SMPopViewDirection direction;  //三角形位于popview的方向  top left button right

@property (nonatomic, strong) UIColor *popColor;  //背景颜色

@property (nonatomic, strong) UIColor *popTintColor;  //title颜色

@property (nonatomic, assign) float edgeLength; //三角边长

@property (nonatomic, assign) float offset;


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
