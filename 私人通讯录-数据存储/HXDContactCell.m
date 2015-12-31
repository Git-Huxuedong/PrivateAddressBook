//
//  HXDContactCell.m
//  私人通讯录-数据存储
//
//  Created by huxuedong on 15/10/3.
//  Copyright © 2015年 胡学东. All rights reserved.
//

#import "HXDContactCell.h"

@interface HXDContactCell ()

//创建分割线属性
@property (weak, nonatomic) UIView *lineView;

@end

@implementation HXDContactCell

//当xib加载完毕后调用，只调用一次
- (void)awakeFromNib {
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor blackColor];
    lineView.alpha = 0.3;
    [self.contentView addSubview:lineView];
    self.lineView = lineView;
}

//布局子控件，当控件的frame确定或改变时调用
- (void)layoutSubviews {
    CGFloat lineViewH = 1;
    CGFloat lineViewW = self.bounds.size.width;
    CGFloat lineViewX = 0;
    CGFloat lineViewY = self.bounds.size.height - lineViewH;
    self.lineView.frame = CGRectMake(lineViewX, lineViewY, lineViewW, lineViewH);
}

@end
