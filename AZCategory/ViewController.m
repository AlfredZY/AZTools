//
//  ViewController.m
//  AZCategory
//
//  Created by Alfred on 2018/11/13.
//  Copyright © 2018年 Alfred. All rights reserved.
//

#import "ViewController.h"
#import "NSObject+AZSafeArea.h"


@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;
@property (copy, nonatomic) NSArray *titles;
@property (copy, nonatomic) NSArray *classStrings;

@end

@implementation ViewController

+ (void)load {
    NSLog(@"load %d",AZ_HAS_SAFEAREA);
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"viewDidLoad %d",AZ_HAS_SAFEAREA);
    
    
    [self.view addSubview:self.tableView];
    self.tableView.frame = self.view.bounds;
    
    self.titles = @[@"Gradient",@"PushAndPop"];
    self.classStrings = @[@"GradientVC",@"PushAndPopVCOne"];
}

#pragma mark- TableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *kID = @"kID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kID];
    }
    cell.textLabel.text = self.titles[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIViewController *vc = [[NSClassFromString(self.classStrings[indexPath.row]) alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark- Getter

- (UITableView *)tableView {
    if (_tableView == nil) {
        UITableView *view = [[UITableView alloc] init];
        view.delegate = self;
        view.dataSource = self;
        _tableView = view;
    }
    return _tableView;
}

@end
