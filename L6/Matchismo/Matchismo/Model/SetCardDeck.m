//
//  SetCardDeck.m
//  Matchismo
//
//  Created by Justin Lee on 6/23/16.
//  Copyright © 2016 Justin Lee. All rights reserved.
//

#import "SetCardDeck.h"
#import "SetCard.h"

@implementation SetCardDeck

- (instancetype)init
{
	self = [super init];
	
	if (self) {
		for (NSString *color in [SetCard validColors]) {
			for (NSString *symbol in [SetCard validSymbols]) {
				for (NSString *shading in [SetCard validShadings]) {\
					for (int i = 1; i <= [SetCard maxNumber]; i++) {
						SetCard *card = [[SetCard alloc] init];
						card.number = i;
						card.shading = shading;
						card.symbol = symbol;
						card.color = color;
						
						[self addCard:card];
					}
				}
			}
		}
	}
	return self;
}

@end
