//
//  TextStatsViewController.m
//  Attributor
//
//  Created by Justin Lee on 6/22/16.
//  Copyright © 2016 Justin Lee. All rights reserved.
//

#import "TextStatsViewController.h"

@interface TextStatsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *colorfulCharactersLabel;
@property (weak, nonatomic) IBOutlet UILabel *outlinedCharactersLabel;

@end

@implementation TextStatsViewController

- (void)setTextToAnalyze:(NSAttributedString *)textToAnalyze
{
	_textToAnalyze = textToAnalyze;
	if (self.view.window) [self updateUI];
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	[self updateUI];
}

- (void)updateUI
{
	self.colorfulCharactersLabel.text = [NSString stringWithFormat:@"%d Colorful Characters", [[self charactersWithAttribute:NSForegroundColorAttributeName] length]];
	self.outlinedCharactersLabel.text = [NSString stringWithFormat:@"%d Outlined Characters", [[self charactersWithAttribute:NSStrokeWidthAttributeName] length]];
}

- (NSAttributedString *)charactersWithAttribute:(NSString *)attributeName
{
	NSMutableAttributedString *charcters = [[NSMutableAttributedString alloc] init];
	
	int index = 0;
	while (index < [self.textToAnalyze length]) {
		NSRange range;
		id value = [self.textToAnalyze attribute:attributeName atIndex:index effectiveRange:&range];
		if (value) {
			[charcters appendAttributedString:[self.textToAnalyze attributedSubstringFromRange:range]];
			index = range.location + range.length;
		} else {
			index++;
		}
	}
	
	return charcters;
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
