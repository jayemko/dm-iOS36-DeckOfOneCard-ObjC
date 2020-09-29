//
//  DVMCard.h
//  DeckOfOneCard-ObjC
//
//  Created by Jason Koceja on 9/29/20.
//  Copyright © 2020 Koceja. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DVMCard : NSObject

@property (nonatomic, copy, readonly) NSString *cardSuit;
@property (nonatomic, copy, readonly) NSString *cardImageURLString;

- (instancetype)initWithSuit:(NSString *)suit
           andImageURLString:(NSString *)imageURLString;

+ (instancetype)cardFromDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
