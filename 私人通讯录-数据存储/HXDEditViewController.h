//
//  HXDEditViewController.h
//  私人通讯录-数据存储
//
//  Created by huxuedong on 15/10/3.
//  Copyright © 2015年 胡学东. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HXDContact.h"
@class HXDEditViewController;

@protocol HXDEditViewControllerDelegate <NSObject>

@optional
- (void)editViewController:(HXDEditViewController *)editViewController;

@end

@interface HXDEditViewController : UIViewController

@property (strong, nonatomic) HXDContact *contact;
@property (weak, nonatomic) id<HXDEditViewControllerDelegate> delegate;

@end
