//
//  HXDEditViewController.m
//  私人通讯录-数据存储
//
//  Created by huxuedong on 15/10/3.
//  Copyright © 2015年 胡学东. All rights reserved.
//

#import "HXDEditViewController.h"

@interface HXDEditViewController ()

@property (weak, nonatomic) IBOutlet UITextField *nameText;
@property (weak, nonatomic) IBOutlet UITextField *phoneText;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;

@end

@implementation HXDEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //为nameText添加点击事件，当开始输入时，执行inputText方法
    [self.nameText addTarget:self action:@selector(inputText) forControlEvents:UIControlEventEditingChanged];
    //为phoneText添加点击事件，当开始输入时，执行inputText方法
    [self.phoneText addTarget:self action:@selector(inputText) forControlEvents:UIControlEventEditingChanged];
    //将模型中的数据赋值给nameText
    self.nameText.text = self.contact.name;
    //将模型中的数据赋值给phoneText
    self.phoneText.text = self.contact.phone;
    //主动判断是否有输入
    [self inputText];
}

- (void)inputText {
    //当姓名和电话输入框有数据的时候，设置保存按钮可用
    self.saveButton.enabled = self.nameText.text.length && self.phoneText.text.length;
}

- (IBAction)editOption:(UIBarButtonItem *)sender {
    //判断当前姓名和电话输入框是否为不可用，不可用时说明可以点击编辑按钮，并点击编辑按钮
    if (self.nameText.enabled == NO || self.phoneText.enabled == NO) {
        //设置编辑按钮为取消按钮
        sender.title = @"取消";
        //设置姓名输入框为可用
        self.nameText.enabled = YES;
        //设置电话输入框为可用
        self.phoneText.enabled = YES;
        //开启电话输入框的第一相应者
        [self.phoneText becomeFirstResponder];
        //设置显示保存按钮
        self.saveButton.hidden = NO;
        //判断当前姓名和电话输入框是否为可用，可用时说明可以点击取消按钮，并点击取消按钮
    } else {
        //设置取消按钮为编辑按钮
        sender.title = @"编辑";
        //设置姓名输入框为不可用
        self.nameText.enabled = NO;
        //设置电话输入框为不可用
        self.phoneText.enabled = NO;
        //设置姓名输入框中的数据为模型中name属性保存的数据
        self.nameText.text = self.contact.name;
        //设置电话输入框中的数据为模型中phone属性保存的数据
        self.phoneText.text = self.contact.phone;
        //设置隐藏保存按钮
        self.saveButton.hidden = YES;
    }
}

- (IBAction)saveAction {
    //将姓名输入框中的数据赋值给模型中的name属性
    self.contact.name = self.nameText.text;
    //将电话输入框中的数据赋值给模型中的phone属性
    self.contact.phone = self.phoneText.text;
    //判断代理是否实现了协议中的方法
    if ([self.delegate respondsToSelector:@selector(editViewController:)]) {
        //代理执行协议中的方法
        [self.delegate editViewController:self];
    }
    //跳转到上一个控制器
    [self.navigationController popViewControllerAnimated:YES];
}

@end
