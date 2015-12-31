//
//  HXDLoginViewController.m
//  私人通讯录-数据存储
//
//  Created by huxuedong on 15/10/3.
//  Copyright © 2015年 胡学东. All rights reserved.
//

#import "HXDLoginViewController.h"
#import "MBProgressHUD+MJ.h"
#define kAccount @"account"
#define kPassword @"password"
#define kRmbPassword @"rmbPassword"
#define kAutoLogin @"autoLogin"
#define kSaveData [NSUserDefaults standardUserDefaults]


@interface HXDLoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *accountTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UISwitch *rememberPassword;
@property (weak, nonatomic) IBOutlet UISwitch *autoLogin;
@property (weak, nonatomic) IBOutlet UIButton *login;

@end

@implementation HXDLoginViewController

//view加载完成后执行
- (void)viewDidLoad {
    [super viewDidLoad];
    //为账号输入框添加点击事件，当开始输入时执行inputText方法
    [self.accountTextField addTarget:self action:@selector(inputText) forControlEvents:UIControlEventEditingChanged];
    //为密码输入框添加点击事件，当开始输入时执行inputText方法
    [self.passwordTextField addTarget:self action:@selector(inputText) forControlEvents:UIControlEventEditingChanged];
    //从文件中读取账号并赋值给账号输入框
    self.accountTextField.text = [kSaveData objectForKey:kAccount];
    //从文件中读取记住密码按钮的状态并设置记住密码按钮的状态
    self.rememberPassword.on = [kSaveData boolForKey:kRmbPassword];
    //如果记住密码按钮开启
    if (self.rememberPassword.on)
        //从文件中读取密码并赋值给密码输入框
        self.passwordTextField.text = [kSaveData objectForKey:kPassword];
    //从文件中读取自动登录按钮的状态并设置自动登录按钮的状态
    self.autoLogin.on = [kSaveData boolForKey:kAutoLogin];
    //如果自动登录按钮开启
    if (self.autoLogin.on)
        //调用点击登录按钮方法
        [self loginButton];
    //调用inputText方法，主动判断是否有输入
    [self inputText];
}

//判断输入的方法
- (void)inputText {
    //当账号和密码都有输入时，将登录按钮设置为可用
    self.login.enabled = self.accountTextField.text.length && self.passwordTextField.text.length;
}

//view即将消失时执行
- (void)viewWillDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    //将键盘推出
    [self.view endEditing:YES];
}

//记住密码按钮的方法
- (IBAction)rmbPasswordSwitch {
    //当记住密码的按钮关闭时
    if (self.rememberPassword.on == NO) {
        //将自动登录按钮也设置为关闭
        [self.autoLogin setOn:NO animated:YES];
    }
}

//自动登录按钮的方法
- (IBAction)autoLoginSwitch {
    //当自动登录的按钮开启时
    if (self.autoLogin.on == YES) {
        //将记住密码的按钮也开启
        [self.rememberPassword setOn:YES animated:YES];
    }
}

//点击登录按钮的方法
- (IBAction)loginButton {
    //显示正在登录界面
    [MBProgressHUD showMessage:@"正在登录..."];
    //延时3秒后执行
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //将正在登录界面移除
        [MBProgressHUD hideHUD];
        //判断账户和密码是否输入正确
        if ([self.accountTextField.text isEqualToString:@"hxd"] && [self.passwordTextField.text isEqualToString:@"19920216hxd"]) {
            //跳转，执行sugue
            [self performSegueWithIdentifier:@"loginToContact" sender:nil];
            //用偏好设置方法保存账号到文件中
            [kSaveData setObject:self.accountTextField.text forKey:kAccount];
            //用偏好设置方法保存密码到文件中
            [kSaveData setObject:self.passwordTextField.text forKey:kPassword];
            //用偏好设置方法保存记住密码按钮的状态到文件中
            [kSaveData setBool:self.rememberPassword.on forKey:kRmbPassword];
            //用偏好设置方法保存自动登录按钮的状态到文件中
            [kSaveData setBool:self.autoLogin.on forKey:kAutoLogin];
        } else
            //显示提示信息界面
            [MBProgressHUD showError:@"账户名或密码错误！"];
    });
}
/*
 [self performSegueWithIdentifier:@"loginToContact" sender:nil];的底层实现
 1.根据Identifier标识去storyboard中寻找线，找到之后就会创建segue对象
 2.设置segue的来源控制器
 3.创建目的控制器，并且设置segue的目的控制器
 4.[self prepareForSegue:sender]做跳转之前的准备操作
 5.[segue perform]跳转
    perform底层：[self.navigationController pushViewController:segue.destinationViewController animated:YES];
 */

//执行segue之后，跳转控制器之前执行方法进行赋值
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    //获取segue的目的控制器
    UIViewController *viewController = segue.destinationViewController;
    //设置目的控制器的标题（顺传）
    viewController.navigationItem.title = [NSString stringWithFormat:@"%@的联系人",self.accountTextField.text];
}

@end
