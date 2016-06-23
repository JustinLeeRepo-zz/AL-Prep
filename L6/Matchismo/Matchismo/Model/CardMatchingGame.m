//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Justin Lee on 6/19/16.
//  Copyright © 2016 Justin Lee. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()

@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, strong) NSMutableArray *cards; //of Card
@property (nonatomic, strong) NSArray *lastChosenCards;
@property (nonatomic, readwrite) NSInteger lastScore;

@end

@implementation CardMatchingGame

- (NSMutableArray *)cards
{
	if (!_cards) {
		_cards = [[NSMutableArray alloc] init];
	}
	return _cards;
}

- (NSInteger)mode
{
	Card *card = [self.cards firstObject];
	_mode = card.numOfCardsToMatch;
	return _mode;
}

- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck
{
	self = [super init];
	
	if (self) {
		for (int i = 0; i < count; i++) {
			Card *card = [deck drawRandomCard];
			if(card) {
//				self.cards[i] = card;
				[self.cards addObject:card];
			} else {
				self = nil;
				break;
			}
		}
	}
	return self;
}

//not typed, just substituting
//#define MISMATCH_PENALTY 2

//typed as int
static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;

- (Card *)cardAtIndex:(NSUInteger)index
{
	return (index < [self.cards count]) ? self.cards[index] : nil;
}

- (void)chooseCardAtIndex:(NSUInteger)index
{
	Card *card = [self cardAtIndex:index];
	
	if (!card.isMatched) {
		if (card.isChosen) {
			card.chosen = NO;
		} else {
			//match against other chosen cards
			
			NSMutableArray *chosenCards = [[NSMutableArray alloc] init];
			for (Card *otherCard in self.cards) {
				if (otherCard.isChosen && !otherCard.isMatched) {
					[chosenCards addObject:otherCard];
				}
			}
			self.lastScore = 0;
			self.lastChosenCards = [chosenCards arrayByAddingObject:card];
			
			if ([chosenCards count] == self.mode - 1) {
					
				int matchScore = [card match:chosenCards];
				if (matchScore) {
					self.lastScore += matchScore * MATCH_BONUS;
					card.matched = YES;
					for (Card *chosenCard in chosenCards) {
						chosenCard.matched = YES;
					}
				} else {
					self.lastScore -= MISMATCH_PENALTY;
					for (Card *chosenCard in chosenCards) {
						chosenCard.chosen = NO;
					}
				}
			}
			
			self.score += self.lastScore - COST_TO_CHOOSE;
			card.chosen = YES;
		}
	}
}

- (instancetype)init
{
	return nil;
}
@end
