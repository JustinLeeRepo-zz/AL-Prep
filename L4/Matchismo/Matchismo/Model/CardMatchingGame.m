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
			
			self.state = [NSMutableString stringWithFormat:@"%@", card.contents];
			NSMutableArray *chosenCards = [[NSMutableArray alloc] init];
			for (Card *otherCard in self.cards) {
				if (otherCard.isChosen && !otherCard.isMatched) {
					[chosenCards addObject:otherCard];
					[self.state	appendString:otherCard.contents];
				}
			}
			
			if ([chosenCards count] == self.mode + 1) {
					
				int matchScore = [card match:chosenCards];
				if (matchScore) {
					self.score += matchScore * MATCH_BONUS;
					card.matched = YES;
					for (Card *chosenCard in chosenCards) {
						chosenCard.matched = YES;
					}
					[self.state appendString:[NSString stringWithFormat:@" matches for %d points", matchScore * MATCH_BONUS]];
				} else {
					self.score -= MISMATCH_PENALTY;
					for (Card *chosenCard in chosenCards) {
						chosenCard.chosen = NO;
					}
					[self.state appendString: [NSString stringWithFormat:@" mismatch for %d penalty points", MISMATCH_PENALTY]];
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
