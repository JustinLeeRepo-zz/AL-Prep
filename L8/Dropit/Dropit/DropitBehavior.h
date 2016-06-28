//
//  DropitBehavior.h
//  Dropit
//
//  Created by Justin Lee on 6/27/16.
//  Copyright © 2016 Justin Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DropitBehavior : UIDynamicBehavior

- (void)addItem:(id <UIDynamicItem>)item;
- (void)removeItem:(id <UIDynamicItem>)item;

@end
