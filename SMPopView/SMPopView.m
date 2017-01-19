//
//  SMPopView
//  https://github.com/shengpeng3344
//
//  Created by Simply on 16/6/16.
//  Copyright © 2016年 mhjmac. All rights reserved.
//

#import "SMPopView.h"
#import "UIView+SMPopView.h"
#import "UIView+SetRect.h"

static float edgeWidth = 20;


@interface SMPopView () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIView *backView;

@property (nonatomic) UIEdgeInsets contentInset; //tableView的edgeInset

@property (nonatomic, assign) CGSize cellSize;  //tableView的cell大小

@property (nonatomic, copy) SMHandlerBlock clickHandler;

@end

@implementation SMPopView
{
    float _radius;  //圆角半径
    
}
- (void)setEdgeLength:(float)edgeLength
{
    _edgeLength = edgeLength;
    edgeWidth = _edgeLength; //设置三角边长
}

- (void)setCornerRadius:(float)CornerRadius
{
    _CornerRadius = CornerRadius;
    _radius = CornerRadius;
    self.tableView.layer.cornerRadius = _radius;
}

- (instancetype)initWithFrame:(CGRect)frame
                 andDirection:(SMPopViewDirection)direction
                    andTitles:(NSArray *)titles
                    andImages:(NSArray *)images
               trianglePecent:(float)percent
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor clearColor];
        //参数设置
        self.direction = direction;
        self.titles = titles;
        self.images = images;
        self.trianglePercent = percent;
        self.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);//暂时全为0
        
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(_contentInset.left,_contentInset.top, frame.size.width-(_contentInset.left+_contentInset.right), frame.size.height-(_contentInset.top+_contentInset.bottom)) style:UITableViewStylePlain];
        
        
        switch (direction) {  //根据箭头方向,tableView位移并改变size
            case SMPopViewDirectionTop:
                self.tableView.viewOrigin = CGPointMake(self.tableView.frame.origin.x, self.tableView.frame.origin.y+edgeWidth*cos(M_PI/3));
                self.tableView.viewSize = CGSizeMake(self.tableView.frame.size.width, self.tableView.frame.size.height-edgeWidth*cos(M_PI/3));
                if ((self.trianglePercent*self.tableView.frame.size.width < edgeWidth*cos(M_PI/3))||((1-self.trianglePercent)*self.tableView.frame.size.width < edgeWidth*cos(M_PI/3)))
                {
                    _isMargin = YES;
                }
                break;
            case SMPopViewDirectionLeft:
                self.tableView.viewOrigin = CGPointMake(self.tableView.frame.origin.x+edgeWidth*cos(M_PI/3), self.tableView.frame.origin.y);
                self.tableView.viewSize = CGSizeMake(self.tableView.frame.size.width-edgeWidth*cos(M_PI/3), self.tableView.frame.size.height);
                if ((self.trianglePercent*self.tableView.frame.size.height < edgeWidth*cos(M_PI/3))||((1-self.trianglePercent)*self.tableView.frame.size.height < edgeWidth*cos(M_PI/3)))
                {
                    _isMargin = YES;
                }
                break;
            case SMPopViewDirectionButton:
                self.tableView.viewSize = CGSizeMake(self.tableView.frame.size.width, self.tableView.frame.size.height-edgeWidth*cos(M_PI/3));
                if ((self.trianglePercent*self.tableView.frame.size.width < edgeWidth*cos(M_PI/3))||((1-self.trianglePercent)*self.tableView.frame.size.width < edgeWidth*cos(M_PI/3)))
                {
                    _isMargin = YES;
                }
                break;
            case SMPopViewDirectionRight:
                self.tableView.viewSize = CGSizeMake(self.tableView.frame.size.width-edgeWidth*cos(M_PI/3), self.tableView.frame.size.height);
                if ((self.trianglePercent*self.tableView.frame.size.height < edgeWidth*cos(M_PI/3))||((1-self.trianglePercent)*self.tableView.frame.size.height < edgeWidth*cos(M_PI/3)))
                {
                    _isMargin = YES;
                }
                break;
            default:
                break;
        }
        
        //根据tableView的大小设置cell高度  宽度暂时无作用
        self.cellSize = CGSizeMake(self.tableView.frame.size.width, self.tableView.frame.size.height/titles.count);
        
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tableView.showsHorizontalScrollIndicator = NO;
        self.tableView.showsVerticalScrollIndicator   = NO;
        self.tableView.backgroundColor = [UIColor whiteColor];
        _radius = 4;
        self.tableView.layer.cornerRadius = 4;
        self.tableView.scrollEnabled = NO;
        [self addSubview:self.tableView];
        
        
        
        
    }
    return self;
}


- (instancetype)initWithFrame:(CGRect)frame
                 andDirection:(SMPopViewDirection)direction
                    andTitles:(NSArray *)titles{
    
    return [self initWithFrame:frame andDirection:direction andTitles:titles andImages:nil trianglePecent:0.5];
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

- (void)hide:(BOOL)animated
{
    if (animated) {
        [self hide];//未编写动画
    }else{
        [self hide];
    }
    
}

- (void)clickBackView:(UITapGestureRecognizer*)sender
{
    [self hide:YES];
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

    cell.textLabel.text = _titles[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
 
    self.clickHandler(self,indexPath);
    
    [self hide];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return _cellSize.height;
}

#pragma mark - private methods

- (void)drawRect:(CGRect)rect {
   
    //    [colors[serie] setFill];
    // 设置背景色
    [[UIColor whiteColor] set];
    //拿到当前视图准备好的画板
    
    CGContextRef  context = UIGraphicsGetCurrentContext();
    //利用path进行绘制三角形
    CGContextBeginPath(context);//标记
    
    CGPoint startPoint;
    CGPoint middlePoint;
    CGPoint endPoint;
 
    
    CGFloat marginLength = edgeWidth/2;  //边缘状态下的三角宽度
    
    switch (self.direction) { //这里的坐标系是以Popview为准的
        case SMPopViewDirectionTop:
            if (_isMargin) {
                if (self.trianglePercent >= 0.5) {
                    startPoint = CGPointMake(self.frame.size.width-marginLength, edgeWidth*cos(M_PI/3));
                    middlePoint = CGPointMake(self.frame.size.width,0);
                    endPoint = CGPointMake(self.frame.size.width,edgeWidth*cos(M_PI/3)+_radius);
                }else{
                    startPoint = CGPointMake(marginLength, edgeWidth*cos(M_PI/3));
                    middlePoint = CGPointMake(0,0);
                    endPoint = CGPointMake(0,edgeWidth*cos(M_PI/3)+_radius);
                }
            }else{
                startPoint = CGPointMake(self.trianglePercent*self.frame.size.width-marginLength, edgeWidth*cos(M_PI/3));
                middlePoint = CGPointMake(self.trianglePercent*self.frame.size.width,0);
                endPoint = CGPointMake(self.trianglePercent*self.frame.size.width+marginLength,edgeWidth*cos(M_PI/3));
            }
            
            break;
        case SMPopViewDirectionLeft:
            if (_isMargin) {
                if (self.trianglePercent >= 0.5) {
                    startPoint = CGPointMake(edgeWidth*cos(M_PI/3), self.frame.size.height-marginLength);
                    middlePoint = CGPointMake(0,self.frame.size.height);
                    endPoint = CGPointMake(edgeWidth*cos(M_PI/3)+_radius, self.frame.size.height);
                }else{
                    startPoint = CGPointMake(edgeWidth*cos(M_PI/3), marginLength);
                    middlePoint = CGPointMake(0,0);
                    endPoint = CGPointMake(edgeWidth*cos(M_PI/3)+_radius, 0);
                }
            }else{
                startPoint = CGPointMake(edgeWidth*cos(M_PI/3), _trianglePercent*self.frame.size.height-marginLength);
                middlePoint = CGPointMake(edgeWidth*cos(M_PI/3), _trianglePercent*self.frame.size.height+marginLength);
                endPoint = CGPointMake(0,_trianglePercent*self.frame.size.height);
            }
            
            break;
        case SMPopViewDirectionButton:
            if (_isMargin) {
                if (self.trianglePercent >= 0.5) {
                    startPoint = CGPointMake(self.frame.size.width-marginLength, self.frame.size.height-edgeWidth*cos(M_PI/3));
                    middlePoint = CGPointMake(self.frame.size.width,self.frame.size.height);
                    endPoint = CGPointMake(self.frame.size.width,self.frame.size.height-(edgeWidth*cos(M_PI/3)+_radius));
                }else{
                    startPoint = CGPointMake(marginLength, self.frame.size.height-edgeWidth*cos(M_PI/3));
                    middlePoint = CGPointMake(0,self.frame.size.height);
                    endPoint = CGPointMake(0,self.frame.size.height-(edgeWidth*cos(M_PI/3)+_radius));
                }
            }else{
                startPoint = CGPointMake(self.trianglePercent*self.frame.size.width-marginLength,self.frame.size.height-edgeWidth*cos(M_PI/3));
                middlePoint = CGPointMake(self.trianglePercent*self.frame.size.width, self.frame.size.height);
                endPoint = CGPointMake(self.trianglePercent*self.frame.size.width+marginLength, self.frame.size.height-edgeWidth*cos(M_PI/3));
            }
            
            break;
        case SMPopViewDirectionRight:
            if (_isMargin) {
                if (self.trianglePercent >= 0.5) {
                    startPoint = CGPointMake(self.frame.size.width-edgeWidth*cos(M_PI/3), self.frame.size.height-marginLength);
                    middlePoint = CGPointMake(self.frame.size.width,self.frame.size.height);
                    endPoint = CGPointMake(self.frame.size.width-(edgeWidth*cos(M_PI/3)+_radius), self.frame.size.height);
                }else{
                    startPoint = CGPointMake(self.frame.size.width-edgeWidth*cos(M_PI/3), marginLength);
                    middlePoint = CGPointMake(self.frame.size.width,0);
                    endPoint = CGPointMake(self.frame.size.width-(edgeWidth*cos(M_PI/3)+_radius), 0);
                }
            }else{
                startPoint = CGPointMake(self.frame.size.width-edgeWidth*cos(M_PI/3), _trianglePercent*self.frame.size.height-marginLength);
                middlePoint = CGPointMake(self.frame.size.width, _trianglePercent*self.frame.size.height);
                endPoint = CGPointMake(self.frame.size.width-edgeWidth*cos(M_PI/3),_trianglePercent*self.frame.size.height+marginLength);
            }
            
            break;
        default:
            return;
    }
    
    CGContextMoveToPoint(context,
                         startPoint.x, startPoint.y);//设置起点
    
    CGContextAddLineToPoint(context,
                            middlePoint.x,middlePoint.y);
    
    CGContextAddLineToPoint(context,
                            endPoint.x,endPoint.y);
    
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
    
    //    [self setNeedsDisplay];
    
}


@end
