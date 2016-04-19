//
//  AddInsuranceController.m
//  youqinghai
//
//  Created by 舒永超 on 16/4/19.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import "AddInsuranceController.h"

@interface AddInsuranceController ()

@property (weak, nonatomic) IBOutlet UIButton *addInsuranceBtn;

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;

@property (weak, nonatomic) IBOutlet UITextField *NoTextField;

@end

@implementation AddInsuranceController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"添加保险人";
    [self.addInsuranceBtn viewWithCornerRadius:3];
    
}
- (IBAction)addInsuranceAction:(id)sender {
    NSString *name = self.nameTextField.text;
    if (name.length < 2 || name.length > 4) {
        [self.view makeToast:@"请输入正确的名字"];
        return;
    }
    
    NSString *cardNo = self.NoTextField.text;
    if (cardNo.length != 18) {
        [self.view makeToast:@"请输入正确的身份证号码"];
        return;
    }
    
    [CardNo initVODBCache];
    
    CardNo *model = [[CardNo alloc] init];
    model.cardNum = cardNo;
    model.userName = name;
    
    [model cacheObject];
    
    [self.view makeToast:@"添加成功"];
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end