//
//  HistoryViewController.m
//  Matchismo
//
//  Created by Justin Lee on 6/23/16.
//  Copyright © 2016 Justin Lee. All rights reserved.
//

#import "HistoryViewController.h"

@interface HistoryViewController ()
@property (weak, nonatomic) IBOutlet UITextView *historyTextView;

@end

@implementation HistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	int i = 1;
	NSMutableAttributedString *historyString = [[NSMutableAttributedString alloc] init];
	for (NSAttributedString *state in self.historyArray) {
		NSString *moveNumberString = [NSString stringWithFormat:@"%d) ", i];
		NSAttributedString *moveNumAttributedStr = [[NSAttributedString alloc] initWithString:moveNumberString];
		[historyString appendAttributedString:moveNumAttributedStr];
		[historyString appendAttributedString:state];
		[historyString appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n"]];
		i++;
	}
	self.historyTextView.attributedText = historyString;
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
