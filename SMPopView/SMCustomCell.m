//
//  SMCustomCell.m
//  SMPopViewExample
//
//  Created by tangmi on 17/3/15.
//  Copyright © 2017年 SM. All rights reserved.
//

#import "SMCustomCell.h"

@interface SMCustomCell ()


@property (nonatomic, strong) UIImageView *iconView;

@end

@implementation SMCustomCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self loadContent];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self loadContent];
    // Initialization code
}

- (void)setIconImage:(UIImage *)iconImage
{
    _iconView.image = iconImage;
    _iconImage = iconImage;
    
}


- (void)loadContent{
    
    self.iconView = [[UIImageView alloc]init];
    
    self.iconView.contentMode = UIViewContentModeScaleAspectFit;
    
    self.iconView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.contentView addSubview:self.iconView];
    
    self.titleLabel = [[UILabel alloc]init];
    
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.titleLabel sizeToFit];
    
    [self.contentView addSubview:self.titleLabel];

    [self _privateUpdateConstraints];
}
- (void)applyPriority:(UILayoutPriority)priority toConstraints:(NSArray *)constraints {
    for (NSLayoutConstraint *constraint in constraints) {
        constraint.priority = priority;
    }
}

- (void)_privateUpdateConstraints{
    [self removeConstraints:self.constraints];
    
    CGFloat tap = 8;
    CGFloat left = 15;
    if (self.iconImage) {
        //imageView constraint
        NSMutableArray *imageConstraints = [NSMutableArray array];
        
        [imageConstraints addObject:[NSLayoutConstraint constraintWithItem:self.iconView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1.f constant:left]];
        [imageConstraints addObject:[NSLayoutConstraint constraintWithItem:self.iconView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.f constant:tap]];
        [imageConstraints addObject:[NSLayoutConstraint constraintWithItem:self.iconView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1.f constant:-tap]];
        [imageConstraints addObject:[NSLayoutConstraint constraintWithItem:self.iconView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.iconView attribute:NSLayoutAttributeHeight multiplier:1.f constant:0]];
        
        [self applyPriority:998.f toConstraints:imageConstraints];
        
        [self addConstraints:imageConstraints];
    }
    
    
    //textLabel constraint
    NSMutableArray *textConstraints = [NSMutableArray array];
    
    if (self.iconImage) {
        [textConstraints addObject:[NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.iconView attribute:NSLayoutAttributeRight multiplier:1.f constant:5]];
    }else{
        [textConstraints addObject:[NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterX multiplier:1.f constant:0]];
    }
    
    
    [textConstraints addObject:[NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1.f constant:0]];
    
    [self applyPriority:998.f toConstraints:textConstraints];
    
    [self addConstraints:textConstraints];
}

- (void)updateConstraints{
    
    [self _privateUpdateConstraints];

    [super updateConstraints];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
