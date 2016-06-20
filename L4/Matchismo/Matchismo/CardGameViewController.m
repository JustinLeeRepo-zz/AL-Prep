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

//property is weak b/c label is held strongly by view itself
//view will keep the label in the heap, so no strong pointer is necessary to keep in label in heap
//if label ever leaves the view, it will leave the heap and pointer will be set to nil
//Assignment 1 Required Task 3
@property (strong, nonatomic) Deck *deck;
@property (nonatomic, strong) CardMatchingGame *game;

//has to be strong b/c view doesn't have strong pointer to this array, but has strong pointer to all the buttons individually
//if not strong, this will constantly be set to 0, b/c no one would have a strong pointer to it
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

@end

@implementation CardGameViewController

@synthesize deck = _deck;

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

- (IBAction)touchCardButton:(UIButton *)sender
{
	int cardIndex = [self.cardButtons indexOfObject:sender];
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
