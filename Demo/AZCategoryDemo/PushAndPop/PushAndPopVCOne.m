//
//  PushAndPopVCOne.m
//  AZCategoryDemo
//
//  Created by Alfred Zhang on 2017/7/30.
//  Copyright © 2017年 Alfred Zhang. All rights reserved.
//

#import "PushAndPopVCOne.h"

#import "UIViewController+PushAndPop.h"

@interface PushAndPopVCOne ()

@property (weak, nonatomic) IBOutlet UILabel *indexLabel;

@end

@implementation PushAndPopVCOne

+ (NSUInteger)cyclePushLimitNumber {
    return 3;
}

- (void)dealloc {
    NSLog(@"dealloc %s",__func__);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.indexLabel.text = [NSString stringWithFormat:@"%ld",(long)_index];
    self.title = @"VC One";

}

- (void)setIndex:(NSInteger)index {
    _index = index;
    self.indexLabel.text = [NSString stringWithFormat:@"%ld",(long)_index];
}

- (IBAction)pushOneAction:(UIButton *)sender {
    PushAndPopVCOne *vc = [[PushAndPopVCOne alloc] init];
    vc.index = self.index + 1;
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)pushTwoAction:(UIButton *)sender {
    UIViewController *vc = [[NSClassFromString(@"PushAndPopVCTwo") alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
