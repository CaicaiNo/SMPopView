//
//  ViewController.m
//  SMPopView
//
//  Created by tangmi on 16/6/21.
//  Copyright © 2016年 Simply. All rights reserved.
//

#import "SMExampleController.h"
#import "SMPopView.h"
#import "UIView+SMPopViewExtension.h"

@interface SMExampleController ()

@property (nonatomic, strong) NSMutableArray *popArray;

@property (nonatomic, strong) NSMutableArray *colorPool;

@property (nonatomic, strong) SMPopView *popView;

@end

@implementation SMExampleController
{
    UIButton *_button;
    int i;
    int j;
    NSTimer *_timer1;
}

- (NSMutableArray *)colorPool
{
    if (!_colorPool) {
        NSArray *colorStrPol = @[@"F5F5F9",@"F7DA64",@"C6F98B",@"91C854",@"FFE9BF",@"FFB0F2",@"FFB0F2",@"8FD7CF",@"787776"];
        NSMutableArray *colorPolM = [NSMutableArray array];
        for (NSString *colorString in colorStrPol) {
            // 依次取出r/g/b字符串
            NSRange range;
            range.location = 0;
            range.length = 2;
            // r
            NSString *rString = [colorString substringWithRange:range];
            
            // g
            range.location = 2;
            NSString *gString = [colorString substringWithRange:range];
            
            // b
            range.location = 4;
            NSString *bString = [colorString substringWithRange:range];
            
            // 转换为数值
            unsigned int r, g, b;
            [[NSScanner scannerWithString:rString] scanHexInt:&r];
            [[NSScanner scannerWithString:gString] scanHexInt:&g];
            [[NSScanner scannerWithString:bString] scanHexInt:&b];
            
            UIColor *color = [UIColor colorWithRed:(float)r / 255.0 green:(float)g / 255.0 blue:(float)b / 255.0 alpha:1.0];;
            [colorPolM addObject:color];
        }
        _colorPool = colorPolM;
    }
    return _colorPool;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _popArray = [NSMutableArray new];
    
    _button  = [UIButton buttonWithType:UIButtonTypeCustom];
    _button.backgroundColor = [UIColor cyanColor];
    _button.frame = CGRectMake(0, 0, 80, 80);
    _button.center = self.view.center;
    [_button addTarget:self action:@selector(clickButton) forControlEvents:UIControlEventTouchUpInside];
    [_button setTitle:@"显示" forState:UIControlStateNormal];
    [self.view addSubview:_button];
    
    i= 0;
    
    self.view.backgroundColor = [UIColor grayColor];
    
    NSArray *tmpArray = @[@"查找",@"定时",@"查找",@"定时",@"定时",@"查找",@"定时"];
    NSArray *images = @[@"SM_searchimg",@"SM_recentsimg"];
    //左
    
    _popView = [[SMPopView alloc]initWithFrame:CGRectMake(0, 0, 80, 80)];
    _popView.cellHeight = 30.f;
    _popView.titles = tmpArray;
    _popView.arrowValue = 0.15f;
    _popView.CornerRadius = 1.f;
    _popView.maxFitSizeCellNumber = 3;
    _popView.textFont = [UIFont systemFontOfSize:12];
    _popView.textColor = [UIColor grayColor];
    [_button setPopView:_popView AtPoint:CGPointMake(1, 1)];
    
    
}


- (void)clickButton{
    [_popView show];
}

- (void)startFirstShow
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
