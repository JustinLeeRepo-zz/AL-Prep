//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Justin Lee on 6/17/16.
//  Copyright © 2016 Justin Lee. All rights reserved.
//

#import "CardGameViewController.h"
#import "CardMatchingGame.h"
#import "HistoryViewController.h"
#import "GameResult.h"

@interface CardGameViewController ()

@property (nonatomic, strong) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *stateLabel;
//Assignment 2 Task 4
//@property (weak, nonatomic) IBOutlet UISegmentedControl *modeSegmentedControl;
@property (nonatomic, strong) NSMutableArray *flipHistory;
@property (weak, nonatomic) IBOutlet UISlider *historySlider;
@property (nonatomic, strong) GameResult *gameResult;

@end

@implementation CardGameViewController

- (GameResult *)gameResult
{
	if (!_gameResult) _gameResult = [[GameResult alloc] init];
	_gameResult.gameType = self.gameType;
	return _gameResult;
}

- (CardMatchingGame *)game
{
	if (!_game) {
		_game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count] usingDeck:[self createDeck]];
	}
	return _game;
}

- (NSMutableArray *)flipHistory
{
	if (!_flipHistory) {
		_flipHistory = [[NSMutableArray alloc] init];
	}
	return _flipHistory;
}

- (Deck *)createDeck //abstract
{
	return nil	;
}
- (IBAction)changeHistorySlider:(UISlider *)sender
{
	int sliderValue = lroundf(sender.value);
	[sender setValue:sliderValue animated:NO];
	if ([self.flipHistory count]) {
		self.stateLabel.alpha = (sliderValue + 1 < [self.flipHistory count]) ? 0.5 : 1.0;
		self.stateLabel.text = [self.flipHistory objectAtIndex:sliderValue];
	}
	
}

//Assignment 2 Task 2
- (IBAction)touchReDealButton:(UIButton *)sender {
	self.game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count] usingDeck:[self createDeck]];
	self.flipHistory = nil;
	self.game = nil;
	self.gameResult = nil;
	//Assignment 2 Task 4
//	self.modeSegmentedControl.enabled = YES;
	[self updateUI];
	
}

//Assignment 2 Task 3
- (IBAction)gameModeChange:(UISegmentedControl *)sender {
	self.game.mode = sender.selectedSegmentIndex;
}


- (IBAction)touchCardButton:(UIButton *)sender
{
	int cardIndex = [self.cardButtons indexOfObject:sender];
	//Assignment 2 Task 4
//	self.modeSegmentedControl.enabled = NO;
	[self.game chooseCardAtIndex:cardIndex];
	[self updateUI];
}

- (void)updateUI
{
	for (UIButton *cardButton in self.cardButtons) {
		int cardIndex = [self.cardButtons indexOfObject:cardButton];
		Card *card = [self.game cardAtIndex:cardIndex];
		[cardButton setAttributedTitle:[self titleForCard:card] forState:UIControlStateNormal];
		[cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
		cardButton.enabled = !card.isMatched;
	}
	NSMutableAttributedString *state = [[NSMutableAttributedString alloc] init];
	for (Card *card in self.game.lastChosenCards) {
		[state appendAttributedString:[self titleForCard:card]];
		[state appendAttributedString:[[NSAttributedString alloc] initWithString:@" "]];
	}
	if (self.game.lastScore != 0) {
		NSString *pointString = self.game.lastScore > 0 ? [NSString stringWithFormat:@"matches for %d points", self.game.lastScore] : [NSString stringWithFormat:@"mismatch for %d points", self.game.lastScore];
		NSAttributedString *pointAttributedString = [[NSAttributedString alloc] initWithString:pointString];
		[state appendAttributedString:pointAttributedString];
	}
	
	[self.stateLabel setAttributedText:state];
	self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
	self.gameResult.score = self.game.score;
	[self.flipHistory addObject:state];
	[self setSliderRange];
}

- (void)setSliderRange
{
	self.historySlider.maximumValue = [self.flipHistory count] - 1;
	[self.historySlider setValue:self.historySlider.maximumValue animated:YES];
}

- (NSAttributedString *)titleForCard:(Card *)card // abstract
{
	return nil;
}

- (UIImage *)backgroundImageForCard:(Card *)card // abstract
{
	return nil;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if ([segue.identifier isEqualToString:@"Show History"]) {
		if ([segue.destinationViewController isKindOfClass:[HistoryViewController class]]) {
			HistoryViewController *historyViewController = (HistoryViewController *)segue.destinationViewController;
			historyViewController.historyArray = [self.flipHistory copy];
		}
	}
}

@end
