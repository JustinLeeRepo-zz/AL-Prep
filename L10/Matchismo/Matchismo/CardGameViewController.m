//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Justin Lee on 6/17/16.
//  Copyright © 2016 Justin Lee. All rights reserved.
//

#import "CardGameViewController.h"
#import "CardMatchingGame.h"
#import "GameResult.h"
#import "GameSettings.h"

@interface CardGameViewController ()

@property (nonatomic, strong) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

@property (nonatomic, strong) GameResult *gameResult;
@property (nonatomic, strong) GameSettings *gameSettings;

@end

@implementation CardGameViewController

- (GameResult *)gameResult
{
	if (!_gameResult) _gameResult = [[GameResult alloc] init];
	_gameResult.gameType = self.gameType;
	return _gameResult;
}

- (GameSettings *)gameSettings
{
	if (!_gameSettings) _gameSettings = [[GameSettings alloc] init];
	return _gameSettings;
}

- (CardMatchingGame *)game
{
	if (!_game) {
		_game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count] usingDeck:[self createDeck]];
		_game.matchBonus = self.gameSettings.matchBonus;
		_game.mismatchPenalth = self.gameSettings.mismatchPenalth;
		_game.chooseCost = self.gameSettings.chooseCost;
	}
	return _game;
}

- (Deck *)createDeck //abstract
{
	return nil	;
}

//Assignment 2 Task 2
- (IBAction)touchReDealButton:(UIButton *)sender {
	self.game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count] usingDeck:[self createDeck]];
	self.game = nil;
	self.gameResult = nil;
	//Assignment 2 Task 4
//	self.modeSegmentedControl.enabled = YES;
	[self updateUI];
	
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
	
	self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
	self.gameResult.score = self.game.score;
}

- (NSAttributedString *)titleForCard:(Card *)card // abstract
{
	return nil;
}

- (UIImage *)backgroundImageForCard:(Card *)card // abstract
{
	return nil;
}

@end
