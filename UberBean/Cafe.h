//
//  Cafe.h
//  UberBean
//
//  Created by Nathan Wainwright on 2018-09-02.
//  Copyright © 2018 Nathan Wainwright. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Cafe : NSObject

@property (nonatomic, weak) NSString *placeName;
@property (nonatomic, weak) NSString *imageUrl;

@property (nonatomic, weak) NSString *locLatitude;
@property (nonatomic, weak) NSString *locLongitude;

@property (nonatomic) BOOL isClosed;

- (instancetype)initWithYelp: (NSDictionary *)dictionary;


@end
