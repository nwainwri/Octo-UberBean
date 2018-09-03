//
//  Cafe.m
//  UberBean
//
//  Created by Nathan Wainwright on 2018-09-02.
//  Copyright © 2018 Nathan Wainwright. All rights reserved.
//

#import "Cafe.h"

@implementation Cafe

- (instancetype)initWithYelp: (NSDictionary *)dictionary {
  self = [super init];
  if (self) {
//    self.name = [dict objectForKey:@"Name"];
//     _locLatitude = latitude
//    _locLongitude = longitude
//    _placeName = name
//    _isClosed = is_closed
//    _imageUrl = image_url
    _locLatitude = [dictionary objectForKey:@"latitude"];
    _locLongitude = [dictionary objectForKey:@"longitude"];
    _placeName = [dictionary objectForKey:@"name"];
    _isClosed = [dictionary objectForKey:@"is_closed"];
    _imageUrl = [dictionary objectForKey:@"image_url"];
  }
  return self;
}


@end
