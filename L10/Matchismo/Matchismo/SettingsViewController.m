//
//  SettingsViewController.m
//  Matchismo
//
//  Created by Justin Lee on 6/29/16.
//  Copyright © 2016 Justin Lee. All rights reserved.
//

#import "SettingsViewController.h"
#import "GameSettings.h"

@interface SettingsViewController ()

@property (weak, nonatomic) IBOutlet UILabel *matchLabel;
@property (weak, nonatomic) IBOutlet UILabel *mismatchLabel;
@property (weak, nonatomic) IBOutlet UILabel *chooseLabel;

@property (nonatomic, strong) GameSettings *gameSettings;

@end

@implementation SettingsViewController

- (GameSettings *)gameSettings
{
	if (!_gameSettings) _gameSettings = [[GameSettings alloc] init];
	return _gameSettings;
}

- (void)setLabel:(UILabel *)label forSlider:(UISlider *)slider
{
	int sliderValue = lroundf(slider.value);
	label.text = [NSString stringWithFormat:@"%d", sliderValue];
}

- (IBAction)matchBonusSliderChanged:(UISlider *)sender
{
	[self setLabel:self.matchLabel forSlider:sender];
	self.gameSettings.matchBonus = lroundf(sender.value);
}

- (IBAction)mismatchPenaltySliderChanged:(UISlider *)sender
{
	[self setLabel:self.mismatchLabel forSlider:sender];
	self.gameSettings.mismatchPenalth = lroundf(sender.value);
}

- (IBAction)chooseCostSliderChanged:(UISlider *)sender
{
	[self setLabel:self.chooseLabel forSlider:sender];
	self.gameSettings.chooseCost = lroundf(sender.value);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
