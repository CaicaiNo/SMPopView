//
//  SMPopView
//  https://github.com/shengpeng3344
//
//  Created by Simply on 16/6/16.
//  Copyright © 2016年 mhjmac. All rights reserved.
//


#define  Width   [UIScreen mainScreen].bounds.size.width

#define  Height  [UIScreen mainScreen].bounds.size.height

#define  StatusBarHeight      20.f

#define  NavigationBarHeight  44.f

#define  TabbarHeight         49.f

#define  StatusBarAndNavigationBarHeight   (20.f + 44.f)

#define  iPhone4_4s     (Width == 320.f && Height == 480.f ? YES : NO)

#define  iPhone5_5s     (Width == 320.f && Height == 568.f ? YES : NO)

#define  iPhone6_6s     (Width == 375.f && Height == 667.f ? YES : NO)

#define  iPhone6_6sPlus (Width == 414.f && Height == 736.f ? YES : NO)
