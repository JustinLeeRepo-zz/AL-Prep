//
//  PlayingCardDeck.m
//  Matchismo
//
//  Created by Justin Lee on 6/19/16.
//  Copyright © 2016 Justin Lee. All rights reserved.
//

#import "PlayingCardDeck.h"
#import	"PlayingCard.h"

@implementation PlayingCardDeck

//return object type of same object type that message was sent to
- (instancetype)init
{
	//initialize super class
	//check return of super class init to make it is properly initialized
	//return nil if can't be inited to let subclasses know...
	//a well formed object couldn't be created
	
	//if super class could be inited, then lets init self now
	self = [super init];
	
	if (self) {
		for (NSString *suit in [PlayingCard validSuits]) {
			for(NSUInteger rank = 1; rank <= [PlayingCard maxRank]; rank++) {
				PlayingCard *card = [[PlayingCard alloc] init];
				card.rank = rank;
				card.suit = suit;
				[self addCard:card];
			}
		}
	}
	
	return self;
}

@end

