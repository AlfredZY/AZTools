//
//  PushAndPopVCTwo.m
//  AZCategoryDemo
//
//  Created by Alfred Zhang on 2017/7/30.
//  Copyright © 2017年 Alfred Zhang. All rights reserved.
//

#import "PushAndPopVCTwo.h"
#import "UIViewController+PushAndPop.h"

@interface PushAndPopVCTwo ()

@property (weak, nonatomic) IBOutlet UILabel *indexLabel;

@end

@implementation PushAndPopVCTwo

+ (NSUInteger)cyclePushLimitNumber {
    return 1;
}

- (void)dealloc {
    NSLog(@"dealloc %s",__func__);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.indexLabel.text = [NSString stringWithFormat:@"%ld",(long)_index];
    self.title = @"VC Two";
}

- (void)setIndex:(NSInteger)index {
    _index = index;
    self.indexLabel.text = [NSString stringWithFormat:@"%ld",(long)_index];
}

- (IBAction)pushOneAction:(UIButton *)sender {
    UIViewController *vc = [[NSClassFromString(@"PushAndPopVCOne") alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)pushTwoAction:(UIButton *)sender {
    PushAndPopVCTwo *vc = [[PushAndPopVCTwo alloc] init];
    vc.index = self.index + 1;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
