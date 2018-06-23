//
//  ViewController.m
//  HeaderDemo
//
//  Created by zyd on 2018/6/22.
//  Copyright © 2018年 zyd. All rights reserved.
//

#import "ViewController.h"
#import "NonHoveringHeaderView.h"
#import "HoveringHeaderView.h"
#import "UITableViewHeaderFooterView+Attribute.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISwitch *switchView;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.tableView registerClass:NonHoveringHeaderView.class forHeaderFooterViewReuseIdentifier:NSStringFromClass(NonHoveringHeaderView.class)];
    [self.tableView registerClass:HoveringHeaderView.class forHeaderFooterViewReuseIdentifier:NSStringFromClass(HoveringHeaderView.class)];
    [self.view addSubview:self.tableView];
    [self.view bringSubviewToFront:self.switchView];
}

#pragma mark -- UISwitch

- (IBAction)handleSwitchEvent:(UISwitch *)sender {
    [self.tableView reloadData];
}

#pragma mark -- UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 10;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(UITableViewCell.class)];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass(UITableViewCell.class)];
    }
    cell.textLabel.text = (indexPath.row ? @"1234" : @"qwer");
    return cell;
}

#pragma mark -- UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 30.0f;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    Class headerClass = self.switchView.isOn ? NonHoveringHeaderView.class : HoveringHeaderView.class;
    UITableViewHeaderFooterView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass(headerClass)];
    header.tableView = tableView;
    header.section = section;
    header.textLabel.text = @"测试";
    return header;
}

#pragma mark -- getter method

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 20, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = UIView.new;
    }
    return _tableView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
