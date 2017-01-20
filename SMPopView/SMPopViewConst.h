//
//  SMPopView
//  https://github.com/shengpeng3344
//
//  Created by Simply on 16/6/16.
//  Copyright © 2016年 mhjmac. All rights reserved.
//


#define  Width   [UIScreen mainScreen].bounds.size.width

#define  Height  [UIScreen mainScreen].bounds.size.height

#define  SMStatusBarHeight      20.f

#define  SMNavigationBarHeight  44.f

#define  SMTabbarHeight         49.f

#define  SMStatusBarAndNavigationBarHeight   (20.f + 44.f)

#define  SM_iPhone4_4s     (Width == 320.f && Height == 480.f ? YES : NO)

#define  SM_iPhone5_5s     (Width == 320.f && Height == 568.f ? YES : NO)

#define  SM_iPhone6_6s     (Width == 375.f && Height == 667.f ? YES : NO)

#define  SM_iPhone6_6sPlus (Width == 414.f && Height == 736.f ? YES : NO)

#define  SMColorFromRGB(rgbValue, alp)	[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16)) / 255.0 \
green:((float)((rgbValue & 0xFF00) >> 8)) / 255.0 \
blue:((float)(rgbValue & 0xFF)) / 255.0 \
alpha:alp]


