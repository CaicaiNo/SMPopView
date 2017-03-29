//
//  SMPopView
//  https://github.com/shengpeng3344
//
//  Created by Simply on 16/6/16.
//  Copyright © 2016年 mhjmac. All rights reserved.
//

#import "SMPopView.h"
#import "UIView+SMPopViewExtension.h"
#import "UIView+SMPopViewRect.h"
#import "SMCustomCell.h"

#define SMWidth self.frame.size.width
#define SMHeight self.frame.size.height

#ifndef kCFCoreFoundationVersionNumber_iOS_7_0
#define kCFCoreFoundationVersionNumber_iOS_7_0 847.20
#endif

#ifndef kCFCoreFoundationVersionNumber_iOS_8_0
#define kCFCoreFoundationVersionNumber_iOS_8_0 1129.15
#endif

#define SMMainThreadAssert() NSAssert([NSThread isMainThread], @"SMPopView needs to be accessed on the main thread.");


static float edgeWidth = 12;


@interface SMPopView () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIView *backView;

/**
 tableView's edgeInset
 */
@property (nonatomic) UIEdgeInsets contentInset;



@end

@implementation SMPopView





- (void)commonInit{
    
    self.backgroundColor = [UIColor clearColor];
    //参数设置
    _offset = edgeWidth;
    _arrowValue = 0.5;
    _autoFitSize = YES;
    _maxFitSizeCellNumber = 6;
    _contentInset = UIEdgeInsetsZero;//暂时全为0
    _direction = SMPopViewDirectionTop;
    
    [self setupViews];
    
    
}

- (void)setupViews{
    
    self.backgroundColor = [UIColor whiteColor];
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:self.bounds];
    tableView.translatesAutoresizingMaskIntoConstraints = NO;
    
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.showsHorizontalScrollIndicator = NO;
    tableView.showsVerticalScrollIndicator   = NO;
    tableView.bounces = NO;
    tableView.alwaysBounceHorizontal = NO;
    tableView.backgroundColor = [UIColor whiteColor];
    tableView.opaque = NO;
    [tableView setTableFooterView:[[UIView alloc]initWithFrame:CGRectZero]];
    tableView.contentInset = UIEdgeInsetsMake((CGFloat)fabs(edgeWidth*cos(M_PI/3)), 0, 0, 0);
    tableView.scrollEnabled = YES;
    
    _triangleView = [[SMTriangleView alloc]initWithFrame:self.bounds];
    _triangleView.fillColor        = [UIColor clearColor];
    _triangleView.areaColor        = [UIColor blackColor];
    
    [self setMaskPathByDirection:SMPopViewDirectionTop];
    
    
    self.maskView = _triangleView;
    self.layer.masksToBounds = YES;
    
    [self addSubview:tableView];
    _tableView = tableView;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super initWithCoder:aDecoder])) {
        [self commonInit];
    }
    return self;
}



#pragma mark UI


#pragma mark Properties

- (void)setMaskPathByDirection:(SMPopViewDirection)direction{
    UIBezierPath *path = [UIBezierPath bezierPath];
    CGPoint A;  //开始点 A
    CGPoint B;  //中间点 B
    CGPoint C;  //结束点 C
    
    CGPoint LeftTop = CGPointZero;
    CGPoint RightTop = CGPointMake(SMWidth, 0);
    CGPoint LeftBottom = CGPointMake(0, SMHeight);;
    CGPoint RightBottom = CGPointMake(SMWidth, SMHeight);
    
    CGFloat marginLength = edgeWidth/2;  //边缘状态下的三角宽度
    
    CGFloat basic;
    
    CGFloat mheight = (CGFloat)fabs(edgeWidth*cos(M_PI/3));
    
    switch (direction) { //这里的坐标系是以Popview为准的
        case SMPopViewDirectionTop:{
            
            basic = _arrowValue*SMWidth;
            
            if (SMWidth - basic < _offset) {
                basic -= (_offset - (SMWidth - basic));
            }else if (basic < _offset){
                basic += (_offset - basic);
            }
            
            A = CGPointMake(basic-marginLength, mheight);
            B = CGPointMake(basic,0);
            C = CGPointMake(basic+marginLength,mheight);
            
            [path moveToPoint:CGPointMake(0, mheight)];
            [path addLineToPoint:A];
            [path addLineToPoint:B];
            [path addLineToPoint:C];
            [path addLineToPoint:CGPointMake(SMWidth, mheight)];
            [path addLineToPoint:RightBottom];
            [path addLineToPoint:LeftBottom];
            
            _tableView.contentInset = UIEdgeInsetsMake(mheight, 0, 0, 0);
            
            
        }
            break;
        case SMPopViewDirectionLeft:{
            
            basic = _arrowValue*SMHeight;
            
            if (SMHeight - basic < _offset) {
                basic -= (_offset - (SMHeight - basic));
            }else if (basic < _offset){
                basic += (_offset - basic);
            }
            
            A = CGPointMake(mheight, basic-marginLength);
            B = CGPointMake(0,basic);
            C = CGPointMake(mheight, basic+marginLength);
            
            [path moveToPoint:CGPointMake(mheight, 0)];
            [path addLineToPoint:A];
            [path addLineToPoint:B];
            [path addLineToPoint:C];
            [path addLineToPoint:CGPointMake(mheight, SMHeight)];
            [path addLineToPoint:RightBottom];
            [path addLineToPoint:RightTop];
            
            _tableView.contentInset = UIEdgeInsetsZero;
        }
            break;
        case SMPopViewDirectionBottom:{
            
            basic = _arrowValue*SMWidth;
            
            if (SMWidth - basic < _offset) {
                basic -= (_offset - (SMWidth - basic));
            }else if (basic < _offset){
                basic += (_offset - basic);
            }
            
            A = CGPointMake(basic-marginLength,SMHeight-mheight);
            B = CGPointMake(basic, SMHeight);
            C = CGPointMake(basic+marginLength, SMHeight-mheight);
            
            [path moveToPoint:CGPointMake(0, SMHeight-mheight)];
            [path addLineToPoint:A];
            [path addLineToPoint:B];
            [path addLineToPoint:C];
            [path addLineToPoint:CGPointMake(SMWidth, SMHeight-mheight)];
            [path addLineToPoint:RightTop];
            [path addLineToPoint:LeftTop];
            
            _tableView.contentInset = UIEdgeInsetsMake(0, 0, mheight, 0);
        }
            
            break;
        case SMPopViewDirectionRight:{
            
            basic = _arrowValue*SMHeight;
            
            if (SMHeight - basic < _offset) {
                basic -= (_offset - (SMHeight - basic));
            }else if (basic < _offset){
                basic += (_offset - basic);
            }
            
            A = CGPointMake(SMWidth-mheight, basic-marginLength);
            B = CGPointMake(SMWidth, basic);
            C = CGPointMake(SMWidth-mheight, basic+marginLength);
            
            [path moveToPoint:CGPointMake(SMWidth-mheight, 0)];
            [path addLineToPoint:A];
            [path addLineToPoint:B];
            [path addLineToPoint:C];
            [path addLineToPoint:CGPointMake(SMWidth-mheight, SMHeight)];
            [path addLineToPoint:LeftBottom];
            [path addLineToPoint:LeftTop];
            
            _tableView.contentInset = UIEdgeInsetsZero;
        }
            
            break;
        default:
            return;
    }
    
    [path closePath];
    
    _triangleView.paths = @[path];
    _triangleView.frame = self.bounds;
    _tableView.height = self.height;
    //NSLog(@"%f,%f",self.bounds.size.width,self.bounds.size.height);
    //NSLog(@"%f,%f",_tableView.bounds.size.width,_tableView.bounds.size.height);
}

- (void)setTitles:(NSArray *)titles
{
    _titles = titles;
    if (_autoFitSize) {
        [self autoCalculateHeight];
    }
}

- (void)setDirection:(SMPopViewDirection)direction
{
    if (direction != _direction) {
        _direction = direction;
        
        [self setNeedsLayout];
        
    }
}

- (void)setContentColor:(UIColor *)contentColor
{
    if (contentColor !=_contentColor && ![contentColor isEqual:_contentColor]) {
        _contentColor = contentColor;
        _tableView.backgroundColor = contentColor;
        self.backgroundColor = contentColor;
        [self setNeedsLayout];
    }

}

- (void)setArrowEdge:(float)arrowEdge
{
    if (arrowEdge!=_arrowEdge) {
        _arrowEdge = arrowEdge;
        edgeWidth = arrowEdge;
        
    }
}

- (void)setCellHeight:(CGFloat)cellHeight
{
    if (cellHeight != _cellHeight) {
        _cellHeight = cellHeight;
        
    }
}



- (void)setContentInset:(UIEdgeInsets)contentInset
{
    if (!UIEdgeInsetsEqualToEdgeInsets(contentInset, _contentInset)) {
        _contentInset = contentInset;
        _tableView.contentInset  = contentInset;
    }
}


- (void)setArrowValue:(CGFloat)arrowValue
{
    if (arrowValue != _arrowValue) {
        _arrowValue = arrowValue;
    }
    
    [_triangleView setNeedsDisplay];//不会实时刷新
}


- (void)setAutoFitSize:(BOOL)autoFitSize
{
    if (autoFitSize != _autoFitSize) {
        _autoFitSize = autoFitSize;

    }
}



- (void)layoutSubviews
{
   /* if (_autoFitSize) {
        if (_titles.count > _maxFitSizeCellNumber){
            _tableView.bounces = YES;
        }else{
            _tableView.bounces = NO;
        }
        
    }else{
        _tableView.bounces = YES;
    }*/
    
    if (_autoFitSize && _cellHeight) {
        
        [self autoCalculateHeight];
        
        [self setMaskPathByDirection:_direction];
    }
    
    [super layoutSubviews];
 
}

- (void)autoCalculateHeight
{
    if (_maxFitSizeCellNumber != 0) {
        if (_titles.count > _maxFitSizeCellNumber) {
            self.height = edgeWidth*cos(M_PI/3) + _contentInset.top + _contentInset.bottom + _cellHeight*_maxFitSizeCellNumber;
            
        }else{
            self.height = edgeWidth*cos(M_PI/3) + _contentInset.top + _contentInset.bottom + _cellHeight*_titles.count;
        }
    }else{
        self.height = edgeWidth*cos(M_PI/3) + _contentInset.top + _contentInset.bottom + _cellHeight*_titles.count;
    }
}

#pragma mark - Layout

- (void)updateConstraints
{
    
    CGFloat mLeft = 0.f;
    CGFloat mRight = 0.f;
    switch (_direction) {
        case SMPopViewDirectionLeft:
            mLeft = (CGFloat)fabs(edgeWidth*cos(M_PI/3));
            break;
        case SMPopViewDirectionRight:
            mRight = -(CGFloat)fabs(edgeWidth*cos(M_PI/3));
            break;
        default:
            break;
    }
    
    
    UITableView *tableView = self.tableView;
    UIView *triangleView = self.triangleView;
    
    [self removeConstraints:self.constraints];
    [tableView removeConstraints:tableView.constraints];
    [triangleView removeConstraints:triangleView.constraints];
    //table constraint
    NSMutableArray *tableConstraints = [NSMutableArray array];
    [tableConstraints addObject:[NSLayoutConstraint constraintWithItem:tableView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.f constant:0]];
    
    [tableConstraints addObject:[NSLayoutConstraint constraintWithItem:tableView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.f constant:0]];
    
    [tableConstraints addObject:[NSLayoutConstraint constraintWithItem:tableView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.f constant:mLeft]];
    
    [tableConstraints addObject:[NSLayoutConstraint constraintWithItem:tableView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.f constant:mRight]];
    [self applyPriority:998.f toConstraints:tableConstraints];
    [self addConstraints:tableConstraints];
    
    
    //triangle constraints
    NSMutableArray *triangleConstraints = [NSMutableArray array];
    
    [triangleConstraints addObject:[NSLayoutConstraint constraintWithItem:triangleView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.f constant:0]];
    [triangleConstraints addObject:[NSLayoutConstraint constraintWithItem:triangleView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.f constant:0]];
    [triangleConstraints addObject:[NSLayoutConstraint constraintWithItem:triangleView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.f constant:0]];
    [triangleConstraints addObject:[NSLayoutConstraint constraintWithItem:triangleView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.f constant:0]];
    [self applyPriority:998.f toConstraints:triangleConstraints];
    [self addConstraints:triangleConstraints];
    
    [super updateConstraints];
}

- (void)applyPriority:(UILayoutPriority)priority toConstraints:(NSArray *)constraints {
    for (NSLayoutConstraint *constraint in constraints) {
        constraint.priority = priority;
    }
}

#pragma mark - hide show

- (void)show  //show方法
{
    SMMainThreadAssert();
    
    [self setNeedsDisplay];
    
    UIView *currentView = [[UIApplication sharedApplication].delegate window];
    if (!_forbidAutoHide) {
        _backView = [[UIView alloc]initWithFrame:currentView.bounds];
        _backView.backgroundColor = [UIColor clearColor];
        UITapGestureRecognizer *tagGR = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickBackView:)];
        [_backView addGestureRecognizer:tagGR];
        
        [currentView addSubview:_backView];
    }
    
    
    [currentView addSubview:self];
    
    self.isShow = YES;
   
    
}


- (void)hide  //隐藏方法
{
    SMMainThreadAssert();
    
    //[self.tableView reloadData]; //取消cell选择状态
    [self removeFromSuperview];
    if (_backView&&_backView.superview) {
        [_backView removeFromSuperview];
    }
    
    self.isShow = NO;
}


- (void)clickBackView:(UITapGestureRecognizer*)sender
{
    if (_forbidAutoHide) {
        
        NSLog(@"SMPopView:由于禁止自动隐藏,返回");
        
        return;
    }
    
    [self hide];
}

#pragma mark - tableViewDelegate and dataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.titles) {
        return self.titles.count;
    }else{
        return 0;
    }
    
}

static NSString *reuseCell = @"popViewCell";




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SMCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCell];
    if (cell == nil) {
        cell = [[SMCustomCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseCell];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (self.images.count > 0) {
        if (self.images.count - 1 >= indexPath.row) {
            cell.iconImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@",self.images[indexPath.row]]];
        }
        
    }
    if (self.textColor) {
        cell.titleLabel.textColor = self.textColor;
    }
    
    if (_textFont) {
        cell.titleLabel.font = _textFont;
    }else{
        cell.titleLabel.font = [UIFont systemFontOfSize:14];
    }

    if (_textAlignment) {
        cell.titleLabel.textAlignment = _textAlignment;
    }else{
        if (self.images.count == 0) {
            cell.titleLabel.textAlignment = NSTextAlignmentCenter;
        }else{
            cell.titleLabel.textAlignment = NSTextAlignmentLeft;
        }
    }
    
    cell.titleLabel.text = _titles[indexPath.row];
    if (self.contentColor) {
        cell.backgroundColor = self.contentColor;
    }else{
        cell.backgroundColor = [UIColor clearColor];
    }
 
    
    if (indexPath.row != self.titles.count - 1) {//设置分割线
        cell.separatorInset = UIEdgeInsetsMake(0, 15, 0, 15);
    }else{
        cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 600);

    }
    
    return cell;
}




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_delegate && [_delegate respondsToSelector:@selector(SMDidSelectRowAtIndexPath:)]) {
        [_delegate SMDidSelectRowAtIndexPath:indexPath];
        
        if (!_forbidAutoHide) {
            [self hide];
        }
        return;
    }
    
    if (self.clickHandler) {
         self.clickHandler(self,indexPath);
    }

    [self hide];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_cellHeight != 0) {
        return _cellHeight;
    }else{
        return 30;
    }
}

#pragma mark - private methods



/*- (void)drawRect:(CGRect)rect {
   
    [super drawRect:rect];
    
    // 设置背景色
    //[[UIColor whiteColor] set];
    //拿到当前视图准备好的画板
    
    CGContextRef  context = UIGraphicsGetCurrentContext();
    //利用path进行绘制三角形
    CGContextBeginPath(context);//标记

    CGPoint A;  //开始点 A
    CGPoint B;  //中间点 B
    CGPoint C;  //结束点 C
 
    
    CGFloat marginLength = edgeWidth/2;  //边缘状态下的三角宽度

    CGFloat basic;
    
    switch (self.direction) { //这里的坐标系是以Popview为准的
        case SMPopViewDirectionTop:{
            
            basic = _arrowValue*SMWidth + _offset;
            
            A = CGPointMake(basic-marginLength, edgeWidth*cos(M_PI/3)+_contentInset.top);
            B = CGPointMake(basic,0);
            C = CGPointMake(basic+marginLength,edgeWidth*cos(M_PI/3)+_contentInset.top);
            
            
        }
            break;
        case SMPopViewDirectionLeft:{

            basic = _arrowValue*SMHeight + _offset;
            
            A = CGPointMake(edgeWidth*cos(M_PI/3)+_contentInset.left, basic-marginLength);
            B = CGPointMake(edgeWidth*cos(M_PI/3)+_contentInset.left, basic+marginLength);
            C = CGPointMake(0,basic);
        }
            break;
        case SMPopViewDirectionBottom:{
            
            basic = _arrowValue*SMWidth +_offset;
            
            A = CGPointMake(basic-marginLength,SMHeight-edgeWidth*cos(M_PI/3)-_contentInset.bottom);
            B = CGPointMake(basic, SMHeight);
            C = CGPointMake(basic+marginLength, SMHeight-edgeWidth*cos(M_PI/3)-_contentInset.bottom);
        }
            
            break;
        case SMPopViewDirectionRight:{

            basic = _arrowValue*SMHeight + _offset;
            
            
            A = CGPointMake(SMWidth-edgeWidth*cos(M_PI/3)-_contentInset.right, basic-marginLength);
            B = CGPointMake(SMWidth, basic);
            C = CGPointMake(SMWidth-edgeWidth*cos(M_PI/3)-_contentInset.right, basic+marginLength);
        }
            
            break;
        default:
            return;
    }
    
    CGContextMoveToPoint(context,
                         A.x, A.y);//设置起点
    
    CGContextAddLineToPoint(context,
                            B.x,B.y);
    
    CGContextAddLineToPoint(context,
                            C.x,C.y);
    if (_borderWidth > 0) {
        // Set Line Width
        CGContextSetLineWidth(context, _borderWidth);
    }

    
    
    UIColor *fillColor;
    
    if (self.contentColor) {
        fillColor = self.contentColor;
    }else{
        fillColor = [UIColor whiteColor];
    }
    
    [fillColor setFill];  //设置填充色
    
    if (_borderColor) {
        // Set RGB Stroke Color
        [_borderColor setStroke];
    }else{
        [fillColor setStroke]; //设置边框颜色
    }
    
    CGContextDrawPath(context,
                      kCGPathFillStroke);//绘制路径path

}
*/

@end

@implementation SMTriangleView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.fillColor       = [UIColor whiteColor];
        self.backgroundColor = [UIColor clearColor];
        self.opaque          = NO;
    }
    
    return self;
}

- (void)setCornerRadius:(CGFloat)CornerRadius
{
    if (CornerRadius != _CornerRadius) {
        _CornerRadius = CornerRadius;
        
        [self setNeedsDisplay];
    }
}

- (void)setBorderWidth:(CGFloat)borderWidth
{
    if (borderWidth != _borderWidth) {
        _borderWidth = borderWidth;
        
        [self setNeedsDisplay];
    }
}

- (void)setBorderColor:(UIColor *)borderColor
{
    if (borderColor!=_borderColor && ![borderColor isEqual:_borderColor]) {
        _borderColor = borderColor;

        [self setNeedsDisplay];
    }
}

- (void)drawRect:(CGRect)rect {
    
    [super drawRect:rect];
    
    [self.fillColor setFill];
    UIRectFill(rect);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    if (self.areaColor && self.paths.count) {
        
        UIBezierPath *path = nil;
        
        for (int i = 0; i < self.paths.count; i++) {
            
            i == 0 ? path = self.paths[i] : [path appendPath:self.paths[i]];
        }
        
        CGFloat red   = 0;
        CGFloat green = 0;
        CGFloat blue  = 0;
        CGFloat alpha = 0;
        [self.areaColor getRed:&red green:&green blue:&blue alpha:&alpha];
        
        CGContextAddPath(context, path.CGPath);
        CGContextSetRGBFillColor(context, red, green, blue, alpha);
        CGContextFillPath(context);
        
    } else {
        
        for (UIBezierPath *path in self.paths) {
            
            CGContextAddPath(context, path.CGPath);
            CGContextSetBlendMode(context, kCGBlendModeClear);
            CGContextFillPath(context);
        }
    }
    
}

@end
