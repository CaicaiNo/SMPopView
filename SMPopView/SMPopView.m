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






@end

@implementation SMPopView





- (void)commonInit{
    
    self.backgroundColor = [UIColor clearColor];
    //参数设置
    _offset = 12;
    _CornerRadius = 1;
    _arrowValue = 0.5;
    _contentInset = UIEdgeInsetsZero;//暂时全为0
    _direction = SMPopViewDirectionTop;
//    CGFloat width = self.bounds.size.width;
//    CGFloat height = self.bounds.size.height;
    
    _tableView = [[UITableView alloc]initWithFrame:self.bounds];
    _tableView.y = edgeWidth*cos(M_PI/3);
    _tableView.height = SMHeight - edgeWidth*cos(M_PI/3);
    
    _tableView.centerX = self.centerX;
    
    _offsetBaseValue = edgeWidth;

    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.showsVerticalScrollIndicator   = NO;
    _tableView.bounces = YES;
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.opaque = YES;
    [_tableView setTableFooterView:[[UIView alloc]initWithFrame:CGRectZero]];
    
    _tableView.scrollEnabled = YES;
    [self addSubview:_tableView];
    
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

- (void)updateViewsForColor:(UIColor *)color{
    if (!color) return;
    
    self.tableView.backgroundColor = color;
    
    
}

#pragma mark Properties

- (void)setDirection:(SMPopViewDirection)direction
{
    if (direction != _direction) {
        _direction = direction;
        
        switch (_direction) {
            case SMPopViewDirectionTop:
                _tableView.y = edgeWidth*cos(M_PI/3);
                _tableView.height = SMHeight - edgeWidth*cos(M_PI/3);
                break;
            case SMPopViewDirectionLeft:
                _tableView.x = edgeWidth*cos(M_PI/3);
                _tableView.width = SMWidth - edgeWidth*cos(M_PI/3);
                break;
            case SMPopViewDirectionBottom:
                _tableView.height = SMHeight - edgeWidth*cos(M_PI/3);
                break;
            case SMPopViewDirectionRight:
                _tableView.width = SMWidth - edgeWidth*cos(M_PI/3);
                break;
            default:
                break;
        }
        [self layoutIfNeeded];
    }
}

- (void)setContentColor:(UIColor *)contentColor
{
    if (contentColor !=_contentColor && ![contentColor isEqual:_contentColor]) {
        _contentColor = contentColor;
        _tableView.backgroundColor = contentColor;
        [self updateViewsForColor:contentColor];
    }

}

- (void)setArrowEdge:(float)arrowEdge
{
    if (arrowEdge!=_arrowEdge) {
        _arrowEdge = arrowEdge;
        edgeWidth = arrowEdge;
    }
}


- (void)setCornerRadius:(CGFloat)CornerRadius
{
    if (CornerRadius != _CornerRadius) {
        _CornerRadius = CornerRadius;
        self.tableView.layer.cornerRadius = CornerRadius;
        [self setNeedsDisplay];
    }
}

- (void)setCellHeight:(CGFloat)cellHeight
{
    if (cellHeight != _cellHeight) {
        _cellHeight = cellHeight;
        [self layoutIfNeeded];
    }
}



- (void)setContentInset:(UIEdgeInsets)contentInset
{
    if (!UIEdgeInsetsEqualToEdgeInsets(contentInset, _contentInset)) {
        _contentInset = contentInset;
        _tableView.contentInset  = contentInset;
        
        [self layoutIfNeeded];
    }
}

- (void)setOffsetBaseValue:(float)offsetBaseValue
{
    if (offsetBaseValue != _offsetBaseValue) {
        _offsetBaseValue = offsetBaseValue;
        
    }
}


- (void)setArrowValue:(CGFloat)arrowValue
{
    if (arrowValue != _arrowValue) {
        _arrowValue = arrowValue;
        [self setNeedsDisplay];
    }
}


- (void)setAutoFitSize:(BOOL)autoFitSize
{
    if (autoFitSize != _autoFitSize) {
        _autoFitSize = autoFitSize;
        
        
        [self layoutSubviews];

    }
}

- (void)layoutSubviews
{
    if (_autoFitSize) {
        _tableView.bounces = NO;
    }else{
        _tableView.bounces = YES;
    }
    
    if (_autoFitSize && _cellHeight) {
        self.height = edgeWidth*cos(M_PI/3) + _contentInset.top + _contentInset.bottom + _cellHeight*_titles.count;
        self.tableView.height = self.height - edgeWidth*cos(M_PI/3);
    }
    
    [super layoutSubviews];
 
}

- (void)show  //show方法
{
    SMMainThreadAssert();
    UIView *currentView = [[UIApplication sharedApplication].delegate window];
    _backView = [[UIView alloc]initWithFrame:currentView.bounds];
    _backView.backgroundColor = [UIColor clearColor];
    UITapGestureRecognizer *tagGR = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickBackView:)];
    [_backView addGestureRecognizer:tagGR];
    
    [currentView addSubview:_backView];
    [currentView addSubview:self];
    
    [self setNeedsDisplay];
    
}


- (void)hide  //隐藏方法
{
    SMMainThreadAssert();
    [self.tableView reloadData]; //取消cell选择状态
    [self removeFromSuperview];
    [_backView removeFromSuperview];
}


- (void)clickBackView:(UITapGestureRecognizer*)sender
{
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCell];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseCell];
    }
    
    if (self.images.count > 0) {
        if (self.images.count - 1 >= indexPath.row) {
            cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",self.images[indexPath.row]]];
        }
        
    }
    if (self.textColor) {
        cell.textLabel.textColor = self.textColor;
    }
    
    if (_textFont) {
        cell.textLabel.font = _textFont;
    }else{
        cell.textLabel.font = [UIFont systemFontOfSize:14];
    }

    if (_textAlignment) {
        cell.textLabel.textAlignment = _textAlignment;
    }else{
        if (self.images.count == 0) {
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
        }else{
            cell.textLabel.textAlignment = NSTextAlignmentLeft;
        }
    }
    
    cell.textLabel.text = _titles[indexPath.row];
    if (self.contentColor) {
        cell.backgroundColor = self.contentColor;
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

- (void)drawRect:(CGRect)rect {
   
    [super drawRect:rect];
    
    // 设置背景色
    [[UIColor whiteColor] set];
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
    
    CGContextFillPath(context);//路径结束标志，不写默认封闭
    
    UIColor *fillColor;
    
    if (self.contentColor) {
        fillColor = self.contentColor;
    }else{
        fillColor = [UIColor clearColor];
    }
    
    [fillColor setFill];  //设置填充色
    
    [fillColor setStroke]; //设置边框颜色
    
    CGContextDrawPath(context,
                      kCGPathFillStroke);//绘制路径path

    
}


@end
