//
//  PlayingCardView.h
//  SuperCard
//
//  Created by Justin Lee on 6/24/16.
//  Copyright © 2016 Justin Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayingCardView : UIView

@property (nonatomic) NSUInteger rank;
@property (nonatomic, strong) NSString *suit;
@property (nonatomic) BOOL faceUp;

@end
