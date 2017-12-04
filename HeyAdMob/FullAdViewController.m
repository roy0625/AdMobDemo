//
//  FullAdViewController.m
//  HeyAdMob
//
//  Created by roy on 2017/12/4.
//  Copyright © 2017年 roy. All rights reserved.
//

#import "FullAdViewController.h"
@import GoogleMobileAds;

@interface FullAdViewController ()<GADInterstitialDelegate, GADRewardBasedVideoAdDelegate>
@property(nonatomic, strong) GADInterstitial *interstitial;  // 插頁式廣告
@property (weak, nonatomic) IBOutlet UILabel *rewardLbl;
@property (weak, nonatomic) IBOutlet UIButton *rewardBtn;

@end

@implementation FullAdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.interstitial = [self createAndLoadInterstitial];
    
    // 獎勵型影片廣告
    [GADRewardBasedVideoAd sharedInstance].delegate = self;
    GADRequest *request = [GADRequest request];
    // Requests test ads on simulators.
    request.testDevices = @[ kGADSimulatorID ];
    [[GADRewardBasedVideoAd sharedInstance] loadRequest:request
                                           withAdUnitID:@"ca-app-pub-1298520075061115/8296921564"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 創建插頁式廣告（插頁式廣告只會 load 一次，要換廣告要再創建）
- (GADInterstitial *)createAndLoadInterstitial {
    
    GADInterstitial *interstitial = [[GADInterstitial alloc] initWithAdUnitID:@"ca-app-pub-1298520075061115/2679786899"];
    interstitial.delegate = self;
    GADRequest *request = [GADRequest request];
    // Requests test ads on simulators.
    request.testDevices = @[ kGADSimulatorID ];
    [interstitial loadRequest:request];
    return interstitial;
}

#pragma mark - Button Action
- (IBAction)rewardAdBtn:(id)sender {
    if ([[GADRewardBasedVideoAd sharedInstance] isReady]) {
        [[GADRewardBasedVideoAd sharedInstance] presentFromRootViewController:self];
    }
}

#pragma mark - GADInterstitialDelegate
- (void)interstitialDidReceiveAd:(GADInterstitial *)ad {
    NSLog(@"Ad Load Success");
    [self.interstitial presentFromRootViewController:self];
}

- (void)interstitial:(GADInterstitial *)ad didFailToReceiveAdWithError:(GADRequestError *)error {
    NSLog(@"Ad Load Fail: %@", error.description);
}

#pragma mark - GADRewardBasedVideoAdDelegate
- (void)rewardBasedVideoAd:(GADRewardBasedVideoAd *)rewardBasedVideoAd
   didRewardUserWithReward:(GADAdReward *)reward {
    NSString *rewardMessage =
    [NSString stringWithFormat:@"Reward received with currency %@ , amount %lf",
     reward.type,
     [reward.amount doubleValue]];
    self.rewardLbl.text = rewardMessage;
    NSLog(@"%@", rewardMessage);
}

- (void)rewardBasedVideoAdDidReceiveAd:(GADRewardBasedVideoAd *)rewardBasedVideoAd {
    NSLog(@"Reward based video ad is received.");
    self.rewardBtn.hidden = NO;
}

- (void)rewardBasedVideoAdDidOpen:(GADRewardBasedVideoAd *)rewardBasedVideoAd {
    NSLog(@"Opened reward based video ad.");
}

- (void)rewardBasedVideoAdDidStartPlaying:(GADRewardBasedVideoAd *)rewardBasedVideoAd {
    NSLog(@"Reward based video ad started playing.");
}

- (void)rewardBasedVideoAdDidClose:(GADRewardBasedVideoAd *)rewardBasedVideoAd {
    NSLog(@"Reward based video ad is closed.");
}

- (void)rewardBasedVideoAdWillLeaveApplication:(GADRewardBasedVideoAd *)rewardBasedVideoAd {
    NSLog(@"Reward based video ad will leave application.");
}

- (void)rewardBasedVideoAd:(GADRewardBasedVideoAd *)rewardBasedVideoAd
    didFailToLoadWithError:(NSError *)error {
    NSLog(@"Reward based video ad failed to load.");
}

@end
