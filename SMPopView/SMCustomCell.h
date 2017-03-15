//
//  SMCustomCell.h
//  SMPopViewExample
//
//  Created by tangmi on 17/3/15.
//  Copyright © 2017年 SM. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface SMCustomCell : UITableViewCell

@property (nonatomic, strong) UIImage *iconImage;


@property (nonatomic, strong) UILabel *titleLabel;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@end
