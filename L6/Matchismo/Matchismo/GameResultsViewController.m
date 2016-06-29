//
//  GameResultsViewController.m
//  Matchismo
//
//  Created by Justin Lee on 6/29/16.
//  Copyright © 2016 Justin Lee. All rights reserved.
//

#import "GameResultsViewController.h"
#import "GameResult.h"

@interface GameResultsViewController ()

@property (weak, nonatomic) IBOutlet UITextView *resultsTextView;
@property (nonatomic, strong) NSArray *results; //of GameResult(s)

@end

@implementation GameResultsViewController

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	self.results = [GameResult allGameResults];
	[self updateUI];
}

- (void)updateUI
{
	NSString *resultsStrings = @"";
	for (GameResult *result in self.results) {
		resultsStrings = [resultsStrings stringByAppendingString:[self stringFromGameResult:result]];
	}
	self.resultsTextView.text = resultsStrings;
}

- (NSString *)stringFromGameResult:(GameResult *)gameResult
{
	return [NSString stringWithFormat:@"%@: %d, (%@, %gs)\n",
			gameResult.gameType,
			gameResult.score,
			[NSDateFormatter localizedStringFromDate:gameResult.end
										   dateStyle:NSDateFormatterShortStyle
										   timeStyle:NSDateFormatterShortStyle],
			gameResult.duration];
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
