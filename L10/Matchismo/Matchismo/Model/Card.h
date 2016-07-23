//
//  Card.h
//  Matchismo
//
//  Created by Justin Lee on 6/18/16.
//  Copyright © 2016 Justin Lee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property (strong, nonatomic) NSString *contents;

@property (nonatomic, getter=isChosen) BOOL chosen;
@property (nonatomic, getter=isMatched) BOOL matched;

@property (nonatomic) NSUInteger numOfCardsToMatch;

- (int)match:(NSArray *)otherCards;

@end