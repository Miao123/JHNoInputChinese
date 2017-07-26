//
//  ViewController.m
//  禁止粘贴文字
//
//  Created by 苗建浩 on 2017/7/25.
//  Copyright © 2017年 苗建浩. All rights reserved.
//

#import "ViewController.h"
#define NUMBERS @"00123456789zxcvbnmasdfghjklqwertyuiopZXCVBNMASDFGHJKLQWERTYUIOP_"

@interface ViewController ()<UITextFieldDelegate>
@property (nonatomic, strong) UITextField *textField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(10, 100, 200, 50)];
    textField.delegate = self;
    textField.backgroundColor = [UIColor redColor];
    self.textField = textField;
    [self.view addSubview:textField];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFiledEditChanged:)
                                                 name:@"UITextFieldTextDidChangeNotification"
                                               object:textField];
}


- (void)textFiledEditChanged:(NSNotification *)obj{
    UITextField *textField = (UITextField *)obj.object;
    NSLog(@"改变的值  %@",textField.text);
    
    NSString *string = textField.text;
    NSCharacterSet *cs;
    cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS] invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    NSLog(@"filtered = %@",filtered);
    BOOL basicTest = [string isEqualToString:filtered];
    
    if(!basicTest) {
        NSLog(@"进入第一个函数");
        
        _textField.text = filtered;
    }else{
        NSLog(@"进入第二个函数");
    }
}


- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"UITextFieldTextDidChangeNotification" object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
