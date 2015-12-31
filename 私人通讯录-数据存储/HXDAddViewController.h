//
//  HXDAddViewController.h
//  私人通讯录-数据存储
//
//  Created by huxuedong on 15/10/3.
//  Copyright © 2015年 胡学东. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HXDAddViewController,HXDContact;

@protocol HXDAddViewControllerDelegate <NSObject>

@optional
//代理方法，addViewController控制器点击添加按钮保存contact数据
- (void)addViewController:(HXDAddViewController *)addViewController didClickAddContact:(HXDContact *)contact;

@end

@interface HXDAddViewController : UIViewController

@property (weak, nonatomic) id<HXDAddViewControllerDelegate> delegate;

@end
