//
//  HXDContactListTableViewController.m
//  私人通讯录-数据存储
//
//  Created by huxuedong on 15/10/3.
//  Copyright © 2015年 胡学东. All rights reserved.
//

#import "HXDContactListTableViewController.h"
#import "HXDContact.h"
#import "HXDAddViewController.h"
#import "HXDEditViewController.h"
#define kContactsFilePath [NSTemporaryDirectory() stringByAppendingPathComponent:@"contacts.data"]

//为cell创建重用标识符
static NSString *ID = @"contacts_cell";

@interface HXDContactListTableViewController () <UIActionSheetDelegate,HXDAddViewControllerDelegate,HXDEditViewControllerDelegate>

@property (strong, nonatomic) NSMutableArray *contacts;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *trashButton;

@end

@implementation HXDContactListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //取消tableView的分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //为tableView注册自定义cell
    //[self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID];
}

//懒加载
- (NSMutableArray *)contacts {
    if (nil == _contacts) {
        //根据全路径，从文件中读取数据到数组中
        self.contacts = [NSKeyedUnarchiver unarchiveObjectWithFile:kContactsFilePath];
        //判断是否是第一次运行程序
        if (_contacts == nil)
            //初始化数组
            _contacts = [NSMutableArray array];
    }
    return _contacts;
}

//点击垃圾桶按钮
- (IBAction)trashAction:(UIBarButtonItem *)sender {
    if (self.tableView.editing == NO) {
        self.tableView.editing = YES;
        self.trashButton.title = @"删除";
    } else {
        self.tableView.editing = NO;
        self.trashButton.title = @"保存";
    }
    
}

//点击注销按钮
- (IBAction)cancelButton:(id)sender {
    //创建对话框
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"确定要注销吗？" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"注销" otherButtonTitles:nil, nil];
    //显示对话框到当前view
    [sheet showInView:self.view];
}

//当点击对话框中的按钮
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    //点击注销按钮
    if (buttonIndex == 0)
        //跳转到上一个控制器
        [self.navigationController popViewControllerAnimated:YES];
}

//设置当前控制器的目的控制器（为其它控制器传递当前控制器）
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    //如果目的控制器的类型是add控制器的类型
    if ([segue.destinationViewController isKindOfClass:[HXDAddViewController class]]) {
        //将add控制器作为当前控制器的目的控制器
        HXDAddViewController *addViewController = segue.destinationViewController;
        //将当前控制器作为add控制器的代理
        addViewController.delegate = self;
        //如果目的控制器的类型是edit控制器的类型
    } else {
        //获取选中的行数的indexPath（indexPath中包括section和row）
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        //获取选中行的模型数据
        HXDContact *contact = self.contacts[indexPath.row];
        //将edit控制器作为当前控制器的目的控制器
        HXDEditViewController *editViewController = segue.destinationViewController;
        //将模型中的数据赋值给edit控制器的contact属性
        editViewController.contact = contact;
        //将当前控制器作为edit控制器的代理
        editViewController.delegate = self;
    }
}

//实现addViewController控制器协议中的方法
- (void)addViewController:(HXDAddViewController *)addViewController didClickAddContact:(HXDContact *)contact {
    //设置联系人列表为不可编辑状态
    self.tableView.editing = NO;
    //将新模型添加到模型数组中
    [self.contacts addObject:contact];
    //刷新数据
    [self.tableView reloadData];
    //将数组储存到文件中
    [NSKeyedArchiver archiveRootObject:self.contacts toFile:kContactsFilePath];
}

//实现editViewController控制器协议中的方法
- (void)editViewController:(HXDEditViewController *)editViewController {
    //刷新数据
    [self.tableView reloadData];
    //将数组存储到文件中
    [NSKeyedArchiver archiveRootObject:self.contacts toFile:kContactsFilePath];
}

//组数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

//每组的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.contacts.count;
}

//每组每行的内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HXDContact *contact = self.contacts[indexPath.row];
    //从缓存池中找对应ID的cell，如果没找到，就获取自定义注册的cell，若没找到，则从storyboard中找，如果仍没找到就报错
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    cell.textLabel.text = contact.name;
    cell.detailTextLabel.text = contact.phone;
    return cell;
}

//记录将要编辑行的状态
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    //删除模型中对应行的数据
    [self.contacts removeObjectAtIndex:indexPath.row];
    //使用动画效果删除tableView中对应行的数据
    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationMiddle];
    //将新的模型数组存储到文件中
    [NSKeyedArchiver archiveRootObject:self.contacts toFile:kContactsFilePath];
}

//修改单元格右侧滑动删除按钮显示的文字
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"确认删除";
}

@end
