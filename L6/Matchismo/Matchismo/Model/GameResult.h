//
//  GameResult.h
//  Matchismo
//
//  Created by Justin Lee on 6/25/16.
//  Copyright © 2016 Justin Lee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameResult : NSObject

@property (nonatomic, readonly) NSDate *start;
@property (nonatomic, readonly) NSDate *end;
@property (nonatomic, readonly) NSTimeInterval duration;
@property (nonatomic) int score;
@property (nonatomic, strong) NSString *gameType;

@end
