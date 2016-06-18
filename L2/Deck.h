//
//  Deck.h
//  
//
//  Created by Justin Lee on 6/17/16.
//
//

#import <Foundation/Foundation.h>
#import	"Card.h"

@interface Deck : NSObject

- (void)addCard:(Card *)card atTop:(BOOL)atTop;
- (void)addCard:(Card *)card;

- (Card *)drawRandomCard;

@end