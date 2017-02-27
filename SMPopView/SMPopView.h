//
//  SMPopView
//  https://github.com/shengpeng3344
//
//  Created by Simply on 16/6/16.
//  Copyright © 2016年 mhjmac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SMPopViewConst.h"
#import "UIButton+SMPopViewExtension.h"
#import "UIView+SMPopViewExtension.h"

@class SMPopView;

typedef enum : NSUInteger {
    
    SMPopViewDirectionTop,
    SMPopViewDirectionLeft,
    SMPopViewDirectionBottom,
    SMPopViewDirectionRight,
    
} SMPopViewDirection;

@protocol SMPopViewDelegate <NSObject>

- (void)SMDidSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@end


typedef void (^SMHandlerBlock)(SMPopView *popView,NSIndexPath *indexPath);

@interface SMPopView : UIView

@property (nonatomic, weak) id<SMPopViewDelegate> delegate;

@property (nonatomic, strong) NSArray *images;  //图片数组  图片像素推荐 1x(20*20） 2x(40*40)...

@property (nonatomic, strong) NSArray *titles;  //title数组

/**
 箭头  三角形位置 [0,1]
 */
@property (nonatomic, assign) CGFloat arrowValue;

/**
 弹出视图指向方向  默认为SMPopViewDirectionTop,箭头指向上方视图
 */
@property (nonatomic, assign) SMPopViewDirection direction;

/**
    popView cornerRadius default is 1;
 */
@property (nonatomic, assign) CGFloat CornerRadius;


/**
 当arrowValue值为0 or 1 使得箭头会超过视图区域时 偏移基值
 */
@property (nonatomic, assign) float offsetBaseValue;


/**
 cell高度
 */
@property (nonatomic, assign) CGFloat cellHeight;

/**
 cell 文本对齐方式 当有图片时 默认为 NSTextAlignmentLeft，无图片时  为NSTextAlignmentCenter
 */
@property (nonatomic) NSTextAlignment  textAlignment;

/**
   适应cell大小来控制整个视图size
 */
@property (nonatomic, assign) BOOL autoFitSize;

/**
  最大的自动适配cell数量,当你cell数量大于此值时，视图不会再增长 default is 6
 */
@property (nonatomic, assign) NSInteger maxFitSizeCellNumber;

/**
  click return block , if use delegate ,this block will be not execute
 */
@property (nonatomic, copy) SMHandlerBlock clickHandler;


/**
 tableView's edgeInset
 */
@property (nonatomic) UIEdgeInsets contentInset;

#pragma mark - more

/**
  cell background color
 */
@property (nonatomic, strong) UIColor *contentColor UI_APPEARANCE_SELECTOR;

/**
 cell text color
 */
@property (nonatomic, strong) UIColor *textColor UI_APPEARANCE_SELECTOR;

/**
  cell text font
 */
@property (nonatomic, strong) UIFont *textFont UI_APPEARANCE_SELECTOR;

/**
 箭头 三角边长
 */
@property (nonatomic, assign) float arrowEdge;

/**
 当arrowValue值使得箭头会超过视图区域时，偏移量大小,大小与offsetBaseValue成正比
 */
@property (nonatomic, assign,readonly) float offset;

/**
 forbid auto hide popView when you click cell
 */
@property (nonatomic, assign) BOOL forbidAutoHide;


- (void)show;

- (void)hide;


@end
