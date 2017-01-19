//
//  DetailUseViewController.m
//  SimplePopupView
//
//  Created by tangmi on 16/6/25.
//  Copyright © 2016年 Simply. All rights reserved.
//

#import "DetailUseViewController.h"
#import "UIView+SMPopView.h"
@interface DetailUseViewController ()

@end

@implementation DetailUseViewController
{
    UIButton *_button;
    SMPopView *_popView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor grayColor];
    
    _button  = [UIButton buttonWithType:UIButtonTypeCustom];
    _button.backgroundColor = [UIColor cyanColor];
    _button.frame = CGRectMake(0, 0, 80, 80);
    _button.center = self.view.center;
    [_button addTarget:self action:@selector(clickButton) forControlEvents:UIControlEventTouchUpInside];
    [_button setTitle:@"显示" forState:UIControlStateNormal];
    
    [self.view addSubview:_button];
    
    NSArray *tmpArray = @[@"扫一扫",@"添好友"];
    NSArray *images = nil;
    //左
    
    _popView = [[SMPopView alloc]initWithFrame:CGRectMake(50, 50, 120, 80) andDirection:SMPopViewDirectionButton andTitles:tmpArray andImages:images trianglePecent:0.5]; //箭头位于popview中间0.5位置
    [_button showPopView:_popView AtPoint:CGPointMake(0.5, 0)];//箭头位于button的x=0.y=0.5比例处
    
    [_popView setClickHandler:^(SMPopView *popView, NSIndexPath *indexPath) {
        NSLog(@"代理方法，点击了第%ld行",(long)indexPath.row);
    }];
}

- (void)clickButton{
    
    [_popView show];
}





@end
