# SimplePopView
方便的弹出视图<br>

![](https://github.com/shengpeng3344/SimplePopView/blob/master/SimplePopupView/popViewGif.gif)

使用方法：
```ObjC
简单使用
- (instancetype)initWithFrame:(CGRect)frame
                 andDirection:(PopViewDirection)direction
                    andTitles:(NSArray *)titles;
```

```
自定义使用
- (instancetype)initWithFrame:(CGRect)frame
                 andDirection:(PopViewDirection)direction
                    andTitles:(NSArray *)titles
                    andImages:(NSArray *)images
               trianglePecent:(float)percent;

SimplePopupView *popView = [[SimplePopupView alloc]initWithFrame:CGRectMake(50, 50, 120, 80) andDirection:PopViewDirectionRight andTitles:tmpArray andImages:images trianglePecent:0.5];
```

```
//1.直接加入指定位置
SimplePopupView *popView = [[SimplePopupView alloc]initWithFrame:CGRectMake(50, 50, 120, 80) andDirection:PopViewDirectionRight andTitles:tmpArray];

[self.view addSubview:popView];
//响应事件中调用show方法
[popView show];
```
```
//2.调用UIView+SimplePopupView中方法
SimplePopupView *popView0 = [[SimplePopupView alloc]initWithFrame:CGRectMake(50, 50, 120, 80) andDirection:PopViewDirectionRight andTitles:tmpArray andImages:images trianglePecent:0.5]; //箭头位于popview右边缘中间0.5位置

[_button showPopView:popView0 AtPoint:CGPointMake(0, 0.5)];//箭头位于button的x=0.y=0.5比例处  
//然后响应事件中调用show方法
[popView0 show];

//这样popview就会显示在button的设置位置
```
