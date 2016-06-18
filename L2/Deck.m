//
//  Deck.m
//  
//
//  Created by Justin Lee on 6/17/16.
//
//

#import "Deck.h"

@interface Deck()
@property (strong, nonatomic) NSMutableArray *cards; //of Card type object
@end

@implementation Deck

- (NSMutableArray *)cards
{
	if (!_cards) {
		_cards = [[NSMutableArray alloc] init];
	}
	return _cards;
}

- (void)addCard:(Card *)card atTop:(BOOL)atTop
{
	if (atTop) {
		[self.cards insertObject:card atIndex:0];
	} else {
		[self.cards addObject:card];
	}
}

- (void)addCard:(Card *)card
{
	[self addCard:card atTop:NO];
}

- (Card *)drawRandonCard
{
	Card *randomCard = nil;
	
	if ([self.cards count]) {
		unsigned index = arc4random() % [self.cards count];
		randomCard = self.cards[index];
		[self.cards removeObjectAtIndex:index];
	}
	
	return randomCard;
}

@end
