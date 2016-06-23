//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Justin Lee on 6/17/16.
//  Copyright © 2016 Justin Lee. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface CardGameViewController ()

@property (nonatomic, strong) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *stateLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *modeSegmentedControl;

@end

@implementation CardGameViewController

- (CardMatchingGame *)game
{
	if (!_game) {
		_game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count] usingDeck:[self createDeck]];
	}
	return _game;
}

- (Deck *)createDeck
{
	return [[PlayingCardDeck alloc] init];
}

//Assignment 2 Task 2
- (IBAction)touchReDealButton:(UIButton *)sender {
	self.game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count] usingDeck:[self createDeck]];
	self.game.mode = self.modeSegmentedControl.selectedSegmentIndex;
	//Assignment 2 Task 4
	self.modeSegmentedControl.enabled = YES;
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
	self.modeSegmentedControl.enabled = NO;
	[self.game chooseCardAtIndex:cardIndex];
	[self updateUI];
}

- (void)updateUI
{
	for (UIButton *cardButton in self.cardButtons) {
		int cardIndex = [self.cardButtons indexOfObject:cardButton];
		Card *card = [self.game cardAtIndex:cardIndex];
		[cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
		[cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
		cardButton.enabled = !card.isMatched;
	}
	NSMutableArray *contentStrings = [[NSMutableArray alloc] init];
	for (Card *card in self.game.lastChosenCards) {
		[contentStrings addObject:card.contents];
	}
	NSMutableString *state = [[contentStrings componentsJoinedByString:@" "] mutableCopy];
	if (self.game.lastScore != 0) {
		NSString *pointString = self.game.lastScore > 0 ? [NSString stringWithFormat:@" matches for %d points", self.game.lastScore] : [NSString stringWithFormat:@" mismatch for %d penalty points", self.game.lastScore];
		[state appendString:pointString];
	}
	
	self.stateLabel.text = state;
	self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
}

- (NSString *)titleForCard:(Card *)card
{
	return card.isChosen ? card.contents : @"";
}

- (UIImage *)backgroundImageForCard:(Card *)card
{
	return [UIImage imageNamed:card.isChosen ? @"cardfront" : @"cardback"];
}

@end
