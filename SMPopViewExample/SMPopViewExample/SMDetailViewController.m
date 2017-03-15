//
//  SMDetailViewController.m
//  SMPopViewExample
//
//  Created by tangmi on 17/3/15.
//  Copyright © 2017年 SM. All rights reserved.
//

#import "SMDetailViewController.h"
#import "SMPopView.h"

@interface SMDetailViewController ()

@property (weak, nonatomic) IBOutlet UIButton *showBtn;

@property (nonatomic, strong) SMPopView *popView;
@property (weak, nonatomic) IBOutlet UILabel *angleLabel;
@property (weak, nonatomic) IBOutlet UILabel *widthLabel;
@property (weak, nonatomic) IBOutlet UILabel *heightLabel;

@end

@implementation SMDetailViewController
{
    float width;
    float height;
}
- (void)viewDidLoad {
    [super viewDidLoad];

    
    
    
    NSArray *tmpArray = @[@"查找",@"定时",@"查找",@"定时",@"定时",@"查找",@"定时"];
    NSArray *images = @[@"SM_searchimg",@"SM_recentsimg",@"SM_searchimg",@"SM_recentsimg",@"SM_searchimg"];
    
    _popView = [[SMPopView alloc]initWithFrame:CGRectMake(0, 0, 80, 80)];
    _popView.cellHeight = 30.f;
    _popView.titles = tmpArray;
    _popView.images = images;
    _popView.direction = SMPopViewDirectionTop;
    _popView.arrowValue = 0.15f;
    _popView.textFont = [UIFont systemFontOfSize:12];
    _popView.textColor = [UIColor grayColor];
    
    _popView.forbidAutoHide = YES;
    

    // Do any additional setup after loading the view.
}
//由于xib 获取视图frame需要在下面方法后 才能获取准确的frame 将设置锚点放在方法中
- (void)viewDidLayoutSubviews
{
    [_showBtn setPopView:_popView AtPoint:CGPointMake(0.5, 1)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)show:(id)sender {
    if (_popView.isShow) {
        [_popView hide];
    }else{
        [_popView show];
    }
    
}

- (IBAction)changeColor:(id)sender {
    UISegmentedControl *segement = sender;
    
    if (segement.selectedSegmentIndex == 0) {
        _popView.contentColor = [UIColor whiteColor];
    }else{
        _popView.contentColor = [UIColor blackColor];
    }
}

- (IBAction)angleValue:(id)sender {
    
    UISlider *slider = sender;
    
    _popView.arrowValue = slider.value;
    
    _angleLabel.text = [NSString stringWithFormat:@"%.2f",slider.value];
    
}

- (IBAction)widthValue:(id)sender {
    
    
    
    UISlider *slider = sender;
    
    CGRect frame = _popView.frame;
    
    if (width == 0) {
        width = frame.size.width;
    }
    
    frame.size.width = width + slider.value;
    
    _popView.frame = frame;
    
    _widthLabel.text = [NSString stringWithFormat:@"%.1f",slider.value];
}

- (IBAction)heightValue:(id)sender {
    
    UISlider *slider = sender;
    
    CGRect frame = _popView.frame;
    
    if (height == 0) {
        height = frame.size.height;
    }
    
    frame.size.height = height + slider.value;
    
    _popView.frame = frame;
    
    _heightLabel.text = [NSString stringWithFormat:@"%.1f",slider.value];
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
