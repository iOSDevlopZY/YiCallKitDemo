//
//  ViewController.m
//  YiCallKitDemo
//
//  Created by Developer_Yi on 2017/2/15.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "ViewController.h"
#import <CallKit/CallKit.h>

@interface ViewController ()
//电话输入框
@property (weak, nonatomic) IBOutlet UITextField *phoneNumTextF;
//拨打电话
@property (weak, nonatomic) IBOutlet UIImageView *callView;
@property (nonatomic,strong) UIWebView *callWebView;
@end

@implementation ViewController


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //添加手势识别器
    self.callWebView=[[UIWebView alloc]init];
    UITapGestureRecognizer *reg=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(call:)];
    if(self.phoneNumTextF.text!=nil){
    self.callView.userInteractionEnabled=YES;
    }
    [self.callView addGestureRecognizer:reg];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - 打电话
- (void)call:(UITapGestureRecognizer*)reg
{
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt:%@",self.phoneNumTextF.text];
    [self.callWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    if (!self.callWebView.subviews) {
        [self.view addSubview:self.callWebView];
    }
}
#pragma mark - 更新号码
- (IBAction)updateNum:(id)sender {
    CXCallDirectoryManager *manager = [CXCallDirectoryManager sharedInstance];
    [manager reloadExtensionWithIdentifier:@"com.tq.cccccccccalldemo.CallDirectoryExtension" completionHandler:^(NSError * _Nullable error) {
        if (error == nil) {
            UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"提示"
                                                                           message:@"更新成功"
                                                                    preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                                  handler:^(UIAlertAction * action) {}];
            
            [alert addAction:defaultAction];
            [self presentViewController:alert animated:YES completion:nil];
        }else{
            UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"提示"
                                                                           message:@"更新失败"
                                                                    preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                                  handler:^(UIAlertAction * action) {}];
            
            [alert addAction:defaultAction];
            [self presentViewController:alert animated:YES completion:nil];
        }
    }];
}
@end
