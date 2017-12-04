//
//  ViewController.m
//  HeyAdMob
//
//  Created by roy on 2017/12/2.
//  Copyright © 2017年 roy. All rights reserved.
//

#import "ViewController.h"
@import GoogleMobileAds;

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource, GADBannerViewDelegate>
@property(nonatomic, strong) GADBannerView *bannerView;
@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // In this case, we instantiate the banner with desired ad size.
    self.bannerView = [[GADBannerView alloc]
                       initWithAdSize:kGADAdSizeBanner];
    
    self.bannerView.adUnitID = @"ca-app-pub-1298520075061115/7963570028";
    self.bannerView.rootViewController = self;
    self.bannerView.delegate = self;
    
    // 廣告請求
    GADRequest *request = [GADRequest request];
    // 測試廣告，需設定才能在模擬器及實機上放測試廣告，因為開發期不能用真的廣告
    request.testDevices = @[
                            @"9ff18584dc80db0ed33f294de8768c7ced4e2845", kGADSimulatorID
                            ];
    [self.bannerView loadRequest:request];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView Delegate / DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.text = @"Hello";
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%ld", indexPath.row];
    cell.backgroundColor = [UIColor yellowColor];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - GADBannerViewDelegate
- (void)adViewDidReceiveAd:(GADBannerView *)bannerView {
    NSLog(@"Banner loaded successfully");
    self.myTableView.tableHeaderView = bannerView;
    
}

- (void)adView:(GADBannerView *)bannerView didFailToReceiveAdWithError:(GADRequestError *)error {
    NSLog(@"Banner loaded fail");
    NSLog(@"Error: %@", error);
}

@end
