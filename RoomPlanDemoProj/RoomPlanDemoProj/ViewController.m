//
//  ViewController.m
//  RoomPlanDemoProj
//
//  Created by ravendeng on 2022/11/1.
//

#import "ViewController.h"
#import <Masonry/Masonry.h>
#import "BasicRoomPlanViewController.h"
#import "CustomRoomPlanViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UITextView *descriptionTextView;

@property (nonatomic, strong) UIButton *basicRPButton;

@property (nonatomic, strong) UIButton *customRPButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.text = @"RoomPlanDemo";
    self.titleLabel.font = [UIFont boldSystemFontOfSize:36];
    [self.view addSubview:self.titleLabel];
    
    self.descriptionTextView = [[UITextView alloc] initWithFrame:CGRectZero];
    self.descriptionTextView.userInteractionEnabled = NO;
    self.descriptionTextView.text = [self roomPlanDescriptionText];
    [self.descriptionTextView sizeToFit];
    [self.view addSubview:self.descriptionTextView];
    
    self.basicRPButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.basicRPButton setTitle:@"BasicRoomPlanUsage" forState:UIControlStateNormal];
    [self.basicRPButton addTarget:self action:@selector(basicRPButtonDidTappedButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.basicRPButton];
    
    self.customRPButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.customRPButton setTitle:@"customRoomPlanUsage" forState:UIControlStateNormal];
    [self.customRPButton addTarget:self action:@selector(customRPButtonDidTappedButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.customRPButton];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(30);
    }];
    
    [self.descriptionTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(30);
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(-16);
        make.height.mas_greaterThanOrEqualTo(100);
    }];
    
    [self.basicRPButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.descriptionTextView.mas_centerX);
        make.top.mas_equalTo(self.descriptionTextView.mas_bottom).mas_offset(30);
    }];
    
    [self.customRPButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.basicRPButton.mas_centerX);
        make.top.mas_equalTo(self.basicRPButton.mas_bottom).mas_offset(30);
    }];
}

- (NSString *)roomPlanDescriptionText {
    return @"To scan your room, point your device at all the walls, windows, doors and furniture in your space until your scan is complete. \n You can see a preview of your scan at the bottom of the screen so you can make sure your scan is correct. ";
}

#pragma mark - Actions

- (void)basicRPButtonDidTappedButton:(UIButton *)sender {
    BasicRoomPlanViewController *basicRPViewController = [[BasicRoomPlanViewController alloc] init];
    basicRPViewController.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:basicRPViewController animated:YES completion:nil];
}

- (void)customRPButtonDidTappedButton:(UIButton *)sender {
    CustomRoomPlanViewController *customRPViewController = [[CustomRoomPlanViewController alloc] init];
    customRPViewController.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:customRPViewController animated:YES completion:nil];
}

@end
