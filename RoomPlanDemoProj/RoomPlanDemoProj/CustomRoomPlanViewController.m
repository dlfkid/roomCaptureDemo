//
//  CustomRoomPlanViewController.m
//  RoomPlanDemoProj
//
//  Created by ravendeng on 2022/11/2.
//

#import "CustomRoomPlanViewController.h"
#import <Masonry/Masonry.h>

@interface CustomRoomPlanViewController ()

@property (nonatomic, strong) UIButton *closeButton;

@end

@implementation CustomRoomPlanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Custom Room Plan";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.closeButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.closeButton setTitle:@"close" forState:UIControlStateNormal];
    [self.closeButton addTarget:self action:@selector(closeButtonDidTappedAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.closeButton];
    
    [self.closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop).mas_offset(16);
        make.left.mas_equalTo(16);
    }];
}

- (void)closeButtonDidTappedAction:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
