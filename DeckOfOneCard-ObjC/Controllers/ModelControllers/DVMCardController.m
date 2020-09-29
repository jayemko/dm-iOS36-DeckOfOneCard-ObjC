//
//  DVMCardController.m
//  DeckOfOneCard-ObjC
//
//  Created by Jason Koceja on 9/29/20.
//  Copyright © 2020 Koceja. All rights reserved.
//

#import "DVMCardController.h"

@implementation DVMCardController

static NSString * const BASE_URL_STRING = @"https://deckofcardsapi.com/api/deck/new/draw";
static NSString * const QUERY_ITEM_KEY_COUNT = @"count";
static NSString * const KEY_CARDS = @"cards";

+ (DVMCardController *)sharedController
{
    static DVMCardController *shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [DVMCardController new];
    });
    return shared;
}

- (void)drawNewCard:(NSInteger)numberOfCards
         completion:(void (^) (NSArray<DVMCard *> *cards,
                               NSError *error))completion
{
    NSString *cardCount = [@(numberOfCards) stringValue];
    NSURL *baseURL = [NSURL URLWithString:BASE_URL_STRING];
    NSURLComponents *components = [NSURLComponents componentsWithURL:baseURL
                                             resolvingAgainstBaseURL:true];
    NSURLQueryItem *countQueryItem =
    [NSURLQueryItem queryItemWithName:QUERY_ITEM_KEY_COUNT
                                value:cardCount];
    components.queryItems = @[countQueryItem];
    NSURL *requestURL = components.URL;
    
    [[NSURLSession.sharedSession dataTaskWithURL:requestURL
                               completionHandler:^(NSData * _Nullable data,
                                                   NSURLResponse * _Nullable response,
                                                   NSError * _Nullable error) {
        if (error) {
            NSLog(@"%s[%d]: %@\n---\n%@",__FUNCTION__,__LINE__, error, error.localizedDescription);
            return completion(nil, error);
        }
        NSLog(@"%s[%d]: %@\n---\n%@",__FUNCTION__,__LINE__, response, response.URL);
        
        if (!data){
            NSLog(@"%s[%d]: There appears to be no \"data\"",__FUNCTION__,__LINE__);
            return completion(nil, error);
        }
        
        NSDictionary *jsonDictionaries =
        [NSJSONSerialization JSONObjectWithData:data
                                        options:NSJSONReadingAllowFragments
                                          error:&error];
        
        if (!jsonDictionaries) {
            NSLog(@"%s[%d]: Error parsing JSON: %@\n---\n%@",__FUNCTION__,__LINE__, error, error.localizedDescription);
            return completion(nil, error);
        }
        
        NSArray *cardsArray = jsonDictionaries[KEY_CARDS];
        NSMutableArray *cards = [NSMutableArray new];
        for (NSDictionary *dict in cardsArray) {
            DVMCard *newCard = [DVMCard cardFromDictionary:dict];
            [cards addObject:newCard];
        }
        return completion(cards, nil);
        
    }] resume];
    
}

- (void)fetchCardImageForCard:(DVMCard *)card
                   completion:(void (^) (UIImage *image,
                                         NSError *error))completion
{
    NSURL *imageURL = [NSURL URLWithString:card.cardImageURLString];
    NSLog(@"%s[%d]: ImageURL: %@", __FUNCTION__,__LINE__, imageURL);
    
    [[NSURLSession.sharedSession dataTaskWithURL:imageURL
                               completionHandler:^(NSData * _Nullable data,
                                                   NSURLResponse * _Nullable response,
                                                   NSError * _Nullable error) {
        if (error) {
            NSLog(@"%s[%d]: %@\n---\n%@",__FUNCTION__,__LINE__, error, error.localizedDescription);
            return completion(nil, error);
        }
        NSLog(@"%s[%d]: %@\n---\n%@",__FUNCTION__,__LINE__, response, response.URL);
        
        if (!data){
            NSLog(@"%s[%d]: There appears to be no \"data\"",__FUNCTION__,__LINE__);
            return completion(nil, error);
        }
        
        UIImage *image = [UIImage imageWithData:data];
        return completion(image, nil);
        
    }] resume];
}

@end
