//
//  DetailUseViewController.m
//  SimplePopupView
//
//  Created by tangmi on 16/6/25.
//  Copyright © 2016年 Simply. All rights reserved.
//

#import "DetailUseViewController.h"
#import "UIView+SimplePopupView.h"
@interface DetailUseViewController ()<SimplePopupViewDelegate>

@end

@implementation DetailUseViewController
{
    UIButton *_button;
    SimplePopupView *_popView;
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
    NSArray *images = @[@"saoyisao",@"jiahaoyou"];
    //左
    
    _popView = [[SimplePopupView alloc]initWithFrame:CGRectMake(50, 50, 120, 80) andDirection:PopViewDirectionButton andTitles:tmpArray andImages:images trianglePecent:0.5]; //箭头位于popview中间0.5位置
    [_button showPopView:_popView AtPoint:CGPointMake(0.5, 0)];//箭头位于button的x=0.y=0.5比例处
    
    _popView.delegate = self; //需要正式使用时注意代理
    
    

}

- (void)clickButton{
    
    [_popView show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)simplePopupView:(SimplePopupView *)popView clickAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"代理方法，点击了第%ld行",(long)indexPath.row);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
