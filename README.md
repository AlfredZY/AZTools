# AZTools  [![Build Status](https://travis-ci.org/AlfredZY/AZTools.svg?branch=master)](https://travis-ci.org/AlfredZY/AZTools)


### 快速集成

`pod 'AZTools'`

### 常用分类

##### UIView+AZGradient

- [快速实现view背景渐变色](http://www.jianshu.com/p/e7c9e94e165b)

##### UIViewController+AZPushAndPop
- [循环push同一种ViewController时，控制数量以及返回顺序](http://www.jianshu.com/p/06eca7ee5aeb)

##### NSObject+AZSafeArea
- [判断圆角（SafeArea）](https://www.jianshu.com/p/88eee80c05e1) 

##### UIButton+AZCountDown
- [几个属性设置搞定倒计时按钮](https://www.jianshu.com/p/42e4fd260240)

``` objc
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // 恢复倒计时
    [self.button az_cd_recover];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // ...   
  
    self.button.az_cd_identify = @"AZCountDownDemoBtn";
    self.button.az_cd_count = 60;
    self.button.az_cd_countdownBlock = ^(NSInteger countDown, UIButton * _Nonnull button) {
        [button setTitle:[NSString stringWithFormat:@"%lds",(long)countDown] forState:UIControlStateDisabled];
    };
    self.button.az_cd_endBlock = ^{
        NSLog(@"倒计时结束！");
    };
}

- (IBAction)startCountDown:(UIButton *)sender {
    // 用户点击开始倒计时
    [sender az_cd_start];
}
```



### 工具类

#### AZServiceDate
- 获取服务器时间，设置成功后，即使用户修改手机时间，也能获取到正确的服务器时间。

#### AZBlockHelper

- 获取Block的签名、参数个数

