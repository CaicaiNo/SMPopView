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


static float CORNOR_DEFAULT = 0;

static float edgeWidth = 12;


@interface SMPopView () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIView *backView;

@property (nonatomic) UIEdgeInsets contentInset; //tableView的edgeInset

@property (nonatomic, copy) SMHandlerBlock clickHandler;



@end

@implementation SMPopView
{
    float _radius;  //圆角半径
    
}

- (void)setArrowEdge:(float)arrowEdge
{
    _arrowEdge = arrowEdge;
    edgeWidth = arrowEdge;
}


- (void)setCornerRadius:(float)CornerRadius
{
    _CornerRadius = CornerRadius;
    _radius = CornerRadius;
    self.tableView.layer.cornerRadius = _radius;
}

- (instancetype)initWithFrame:(CGRect)frame
                    direction:(SMPopViewDirection)direction
                       titles:(NSArray *)titles
                       images:(NSArray *)images
                   arrowValue:(float)value
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor clearColor];
        //参数设置
        _direction = direction;
        _titles = titles;
        _images = images;
        _arrowValue = value;
        _contentInset = UIEdgeInsetsMake(0, 0, 0, 0);//暂时全为0
        _offset = 0;
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(_contentInset.left,_contentInset.top, frame.size.width-(_contentInset.left+_contentInset.right), frame.size.height-(_contentInset.top+_contentInset.bottom)) style:UITableViewStylePlain];
        
        _offsetBaseValue = edgeWidth;
        
        [self setBasicTableView];
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.showsVerticalScrollIndicator   = NO;
        _tableView.backgroundColor = [UIColor whiteColor];
        [_tableView setTableFooterView:[[UIView alloc]initWithFrame:CGRectZero]];
        _radius = CORNOR_DEFAULT;
        _tableView.layer.cornerRadius = CORNOR_DEFAULT;
        _tableView.scrollEnabled = NO;
        [self addSubview:_tableView];
        
        
        
        
    }
    return self;
}

- (void)setPopColor:(UIColor *)popColor
{
    _popColor = popColor;
    _tableView.backgroundColor = popColor;
    
}

- (void)setCellSize:(CGSize)cellSize
{
    _cellSize = cellSize;
    _tableView.frame = CGRectMake(_contentInset.left,_contentInset.top, cellSize.width, cellSize.height*_titles.count);
    self.viewSize = CGSizeMake(_contentInset.left+cellSize.width+_contentInset.right, _contentInset.top+_contentInset.bottom+cellSize.height);
    [self layoutSubviews];
}

- (void)setOffsetBaseValue:(float)offsetBaseValue
{
    _offsetBaseValue = offsetBaseValue;
    [self setBasicTableView];
}

- (void)setBasicTableView
{
    float SMAbs = _arrowValue>0.5?fabs(1-_arrowValue):_arrowValue;
    //根据tableView的大小设置cell高度  宽度暂时无作用
    _cellSize = CGSizeMake(_tableView.frame.size.width, (_tableView.frame.size.height)/self.titles.count);
    switch (_direction) {  //根据箭头方向,tableView位移并改变size
        case SMPopViewDirectionTop:{
            _cellSize = CGSizeMake(_tableView.frame.size.width, (_tableView.frame.size.height-edgeWidth*cos(M_PI/3))/self.titles.count);
            if (SMAbs*SMWidth < edgeWidth/2) {
                _offset = _arrowValue>0.5?-_offsetBaseValue:_offsetBaseValue;
            }
            _tableView.viewOrigin = CGPointMake(_tableView.frame.origin.x, _tableView.frame.origin.y+edgeWidth*cos(M_PI/3));
            _tableView.viewSize = CGSizeMake(_tableView.frame.size.width, _tableView.frame.size.height-edgeWidth*cos(M_PI/3));
        }
            break;
        case SMPopViewDirectionLeft:{
            if (SMAbs*SMHeight < edgeWidth/2) {
                _offset = _arrowValue>0.5?_offsetBaseValue:-_offsetBaseValue;
            }
            _tableView.viewOrigin = CGPointMake(_tableView.frame.origin.x+edgeWidth*cos(M_PI/3), _tableView.frame.origin.y);
            _tableView.viewSize = CGSizeMake(_tableView.frame.size.width-edgeWidth*cos(M_PI/3), _tableView.frame.size.height);
        }
            break;
        case SMPopViewDirectionButton:{
            _cellSize = CGSizeMake(_tableView.frame.size.width, (_tableView.frame.size.height-edgeWidth*cos(M_PI/3))/self.titles.count);
            if (SMAbs*SMWidth < edgeWidth/2) {
                _offset = _arrowValue>0.5?-_offsetBaseValue:_offsetBaseValue;
            }
            _tableView.viewSize = CGSizeMake(_tableView.frame.size.width, _tableView.frame.size.height-edgeWidth*cos(M_PI/3));
        }
            
            break;
        case SMPopViewDirectionRight:{
            if (SMAbs*SMHeight < edgeWidth/2) {
                _offset = _arrowValue>0.5?_offsetBaseValue:-_offsetBaseValue;
            }
            _tableView.viewSize = CGSizeMake(_tableView.frame.size.width-edgeWidth*cos(M_PI/3), _tableView.frame.size.height);
        }
            break;
        default:
            break;
    }
}

- (instancetype)initWithFrame:(CGRect)frame
                    direction:(SMPopViewDirection)direction
                       titles:(NSArray *)titles{
    
    return [self initWithFrame:frame direction:direction titles:titles images:nil arrowValue:0.5];
}

- (void)show  //show方法
{
    
    UIView *currentView = [[UIApplication sharedApplication].delegate window];
    _backView = [[UIView alloc]initWithFrame:currentView.bounds];
    _backView.backgroundColor = [UIColor clearColor];
    UITapGestureRecognizer *tagGR = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickBackView:)];
    [_backView addGestureRecognizer:tagGR];
    
    [currentView addSubview:_backView];
    [currentView addSubview:self];
    
    
}


- (void)hide  //隐藏方法
{
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
    return self.titles.count;
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
    if (self.popTintColor) {
        cell.textLabel.textColor = self.popTintColor;
    }
    cell.textLabel.font = [UIFont systemFontOfSize:14];
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
    if (_popColor) {
        cell.backgroundColor = _popColor;
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
    return _cellSize.height;
}

#pragma mark - private methods

- (void)drawRect:(CGRect)rect {
   
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
        case SMPopViewDirectionButton:{
            
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
    
    CGContextClosePath(context);//路径结束标志，不写默认封闭
    
    UIColor *fillColor;
    
    if (self.popColor) {
        fillColor = self.popColor;
    }else{
        fillColor = [UIColor whiteColor];
    }
    
    [fillColor setFill];  //设置填充色
    
    [fillColor setStroke]; //设置边框颜色
    
    CGContextDrawPath(context,
                      kCGPathFillStroke);//绘制路径path

    
}


@end
