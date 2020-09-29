//
//  DVMCard.m
//  DeckOfOneCard-ObjC
//
//  Created by Jason Koceja on 9/29/20.
//  Copyright © 2020 Koceja. All rights reserved.
//

#import "DVMCard.h"

@implementation DVMCard

- (instancetype)initWithSuit:(NSString *)suit
           andImageURLString:(NSString *)imageURLString
{
    self = [super init];
    if (self) {
        _cardSuit = suit;
        _cardImageURLString = imageURLString;
    }
    return self;
}

+ (instancetype)cardFromDictionary:(NSDictionary *)dictionary
{
    NSString *suit = dictionary[[DVMCard suitKey]];
    NSString *imageURLString = dictionary[[DVMCard imageKey]];
    
    DVMCard *newCard = [[DVMCard alloc] initWithSuit:suit
                                   andImageURLString:imageURLString];
    return newCard;
}

+ (NSString *)suitKey
{
    return @"suit";
}

+ (NSString *)imageKey
{
    return @"image";
}
@end
