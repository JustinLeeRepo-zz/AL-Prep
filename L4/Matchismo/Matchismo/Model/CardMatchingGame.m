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

@end

@implementation CardMatchingGame

- (NSMutableArray *)cards
{
	if (!_cards) {
		_cards = [[NSMutableArray alloc] init];
	}
	return _cards;
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
			for (Card *otherCard in self.cards) {
				if (otherCard.isChosen && !otherCard.isMatched) {
					int matchScore = [card match:@[otherCard]];
					if (matchScore) {
						self.score += matchScore * MATCH_BONUS;
						card.matched = YES;
						otherCard.matched = YES;
					} else {
						self.score -= MISMATCH_PENALTY;
						otherCard.chosen = NO;
					}
					break;
				}
			}
			self.score -= COST_TO_CHOOSE;
			card.chosen = YES;
		}
	}
}

- (instancetype)init
{
	return nil;
}
@end
