//
//  DVMCardController.h
//  DeckOfOneCard-ObjC
//
//  Created by Jason Koceja on 9/29/20.
//  Copyright © 2020 Koceja. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DVMCard.h"

NS_ASSUME_NONNULL_BEGIN

@interface DVMCardController : NSObject

+ (DVMCardController *)sharedController;

- (void)drawNewCard:(NSInteger)numberOfCards
         completion:(void (^) (NSArray<DVMCard *> *cards,
                               NSError *error))completion;

- (void)fetchCardImageForCard:(DVMCard *)card
                   completion:(void (^) (UIImage *image,
                                         NSError *error))completion;

@end

NS_ASSUME_NONNULL_END
