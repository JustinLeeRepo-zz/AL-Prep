//
//  PlayingCard.m
//  Matchismo
//
//  Created by Justin Lee on 6/19/16.
//  Copyright © 2016 Justin Lee. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

- (int)match:(NSArray *)otherCards
{
	int score = 0;
	
	if ([otherCards count] >= 1) {
		//first comparison
		for (PlayingCard *otherCard in otherCards) {
			if (otherCard.rank == self.rank) {
				score += 4;
			} else  if ([otherCard.suit isEqualToString:self.suit]) {
				score += 1;
			}
		}
		
		//remove first object of others and continue comparing until empty array
		NSMutableArray *otherCardsCopy = [otherCards mutableCopy];
		for (PlayingCard *otherCard in otherCards) {
			[otherCardsCopy removeObject:otherCard];
			for (PlayingCard *remaingingCard in otherCardsCopy) {
				if (remaingingCard.rank == otherCard.rank) {
					score += 4;
				} else  if ([otherCard.suit isEqualToString:remaingingCard.suit]) {
					score += 1;
				}
			}
		}
		
		
	}
	
	return score;
}

//override superclass's content getter
- (NSString *)contents
{
	NSArray *rankStrings = [PlayingCard rankStrings];
	return [rankStrings[self.rank] stringByAppendingString:self.suit];
	//	return [NSSting stringWithFormat:@"%d%@", self.rank, self.suit];
}

//must create instance variable when setter and geter are both implemented for property
@synthesize suit = _suit;

+ (NSArray *)validSuits
{
	return @[@"♥",@"♦",@"♠",@"♣"];
}

- (void)setSuit:(NSString *)suit
{
	if([[PlayingCard validSuits] containsObject:suit]) {
		_suit = suit;
	}
}

//override getter of suit
- (NSString *)suit
{
	return _suit ? _suit : @"?";
	//same but cleaner notation
	//return _suit ?: @"?";
}

+ (NSArray *)rankStrings
{
	return @[@"?", @"A", @"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
}

+ (NSUInteger)maxRank { return [[self rankStrings] count] - 1; }

- (void)setRank:(NSUInteger)rank
{
	if (rank <= [PlayingCard maxRank]) {
		_rank = rank;
	}
}

@end