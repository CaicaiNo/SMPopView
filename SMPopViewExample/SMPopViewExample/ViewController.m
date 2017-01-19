//
//  ViewController.m
//  SMPopView
//
//  Created by tangmi on 16/6/21.
//  Copyright © 2016年 Simply. All rights reserved.
//

#import "ViewController.h"
#import "SMPopView.h"
#import "UIView+SMPopView.h"

@interface ViewController ()

@property (nonatomic, strong) NSMutableArray *popArray;

@end

@implementation ViewController
{
    UIButton *_button;
    int i;
    int j;
    NSTimer *_timer1;
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
    
    NSArray *tmpArray = @[@"扫一扫",@"添好友"];
    NSArray *images = @[@"saoyisao",@"jiahaoyou"];
    //左
    
    SMPopView *popView0 = [[SMPopView alloc]initWithFrame:CGRectMake(50, 50, 120, 80) direction:SMPopViewDirectionRight titles:tmpArray images:images arrowValue:0.5]; //箭头位于popview中间0.5位置
    [_button showPopView:popView0 AtPoint:CGPointMake(0, 0.5)];//箭头位于button的x=0.y=0.5比例处

    //    popView0.delegate = self; //需要正式使用时注意代理
    
    [_popArray addObject:popView0];
    
    //上
    SMPopView *popView1 = [[SMPopView alloc]initWithFrame:CGRectMake(50, 50, 75, 80) direction:SMPopViewDirectionButton titles:tmpArray images:nil arrowValue:0.5];
    
    [_button showPopView:popView1 AtPoint:CGPointMake(0.5, 0)];
    [_popArray addObject:popView1];
    //右
    SMPopView *popView2 = [[SMPopView alloc]initWithFrame:CGRectMake(50, 50, 120, 80) direction:SMPopViewDirectionLeft titles:tmpArray images:images arrowValue:0.5];
    
    [_button showPopView:popView2 AtPoint:CGPointMake(1, 0.5)];
    
    [_popArray addObject:popView2];
    //下
    SMPopView *popView3 = [[SMPopView alloc]initWithFrame:CGRectMake(50, 50, 75, 80) direction:SMPopViewDirectionTop titles:tmpArray images:nil arrowValue:0.5];
    
    [_button showPopView:popView3 AtPoint:CGPointMake(0.5, 1)];
    
    [_popArray addObject:popView3];
    //左上
    SMPopView *popView4 = [[SMPopView alloc]initWithFrame:CGRectMake(50, 50, 120, 80) direction:SMPopViewDirectionButton titles:tmpArray images:images arrowValue:1];
    
    [_button showPopView:popView4 AtPoint:CGPointMake(0, 0)];
    
    [_popArray addObject:popView4];
    
    //右上
    SMPopView *popView5 = [[SMPopView alloc]initWithFrame:CGRectMake(50, 50, 120, 80) direction:SMPopViewDirectionButton titles:tmpArray images:images arrowValue:0];
    
    [_button showPopView:popView5 AtPoint:CGPointMake(1, 0)];
    
    [_popArray addObject:popView5];
    
    //左下
    SMPopView *popView6 = [[SMPopView alloc]initWithFrame:CGRectMake(50, 50, 120, 80) direction:SMPopViewDirectionTop titles:tmpArray images:images arrowValue:1];
    
    [_button showPopView:popView6 AtPoint:CGPointMake(0, 1)];
    
    [_popArray addObject:popView6];
    //右下
    SMPopView *popView7 = [[SMPopView alloc]initWithFrame:CGRectMake(50, 50, 120, 80) direction:SMPopViewDirectionTop titles:tmpArray images:images arrowValue:0];
    
    [_button showPopView:popView7 AtPoint:CGPointMake(1, 1)];
    
    [_popArray addObject:popView7];
}


- (void)clickButton{
    SMPopView *popView = [_popArray objectAtIndex:i];
    [popView show];
    i++;
    if (i >= 8) {
        i = 0;
    }
}

- (void)startFirstShow
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
