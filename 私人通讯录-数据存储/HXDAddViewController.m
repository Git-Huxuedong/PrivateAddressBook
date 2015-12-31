//
//  HXDAddViewController.m
//  私人通讯录-数据存储
//
//  Created by huxuedong on 15/10/3.
//  Copyright © 2015年 胡学东. All rights reserved.
//

#import "HXDAddViewController.h"
#import "HXDContact.h"

@interface HXDAddViewController ()

@property (weak, nonatomic) IBOutlet UITextField *nameText;
@property (weak, nonatomic) IBOutlet UITextField *phoneText;
@property (weak, nonatomic) IBOutlet UIButton *addButton;

@end

@implementation HXDAddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //为nameText添加点击事件，当开始输入时，执行inputText方法
    [self.nameText addTarget:self action:@selector(inputText) forControlEvents:UIControlEventEditingChanged];
    //为phoneText添加点击事件，当开始输入时，执行inputText方法
    [self.phoneText addTarget:self action:@selector(inputText) forControlEvents:UIControlEventEditingChanged];
}

- (void)inputText {
    //姓名和电话都输入时，将添加按钮设置成可用
    self.addButton.enabled = self.nameText.text.length && self.phoneText.text.length;
}

//当view显示完毕后执行的方法
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    //将nameText设置为第一响应者，弹出nameText的键盘
    [self.nameText becomeFirstResponder];
}

- (IBAction)addAction {
    //调用类方法，创建一个已经赋值好的HXDContact模型
    HXDContact *contact = [HXDContact contactWithName:self.nameText.text andPhone:self.phoneText.text];
    //判断代理是否实现了协议中的方法
    if ([self.delegate respondsToSelector:@selector(addViewController:didClickAddContact:)]) {
        //代理执行协议中的方法，并传入模型数据
        [self.delegate addViewController:self didClickAddContact:contact];
    }
    //跳转到上一个控制器
    [self.navigationController popViewControllerAnimated:YES];
}

@end
