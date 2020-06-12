//
//  ViewController.m
//  Demo
//
//  Created by Alfred on 2019/4/29.
//  Copyright © 2019年 AZ. All rights reserved.
//

#import "ViewController.h"
#import "UIView+AZGradient.h"

#import "AZBlockDemo.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIButton *button;
@property (weak, nonatomic) IBOutlet UIView *customView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        
    [self.label az_setGradientBackgroundWithColors:@[[UIColor redColor],[UIColor orangeColor]] locations:nil startPoint:CGPointMake(0, 0) endPoint:CGPointMake(1, 0)];
    [self.button az_setGradientBackgroundWithColors:@[[UIColor redColor],[UIColor orangeColor]] locations:nil startPoint:CGPointMake(0, 0) endPoint:CGPointMake(1, 0)];
    [self.customView az_setGradientBackgroundWithColors:@[[UIColor redColor],[UIColor orangeColor]] locations:nil startPoint:CGPointMake(0, 0) endPoint:CGPointMake(1, 0)];
    
    
    AZBlockDemo *blockD = [AZBlockDemo new];
    [blockD performBlock:^id _Nullable{
        NSLog(@"perform0");
        return nil;
    }];
    
    [blockD performBlock:^id _Nullable(id info){
        NSLog(@"perform1:%@",info);
        return nil;
    }];
    
    [blockD performBlock:^id _Nullable(id info,id info2){
        NSLog(@"perform2:%@-%@",info,info2);
        return nil;
    }];    
}



@end
