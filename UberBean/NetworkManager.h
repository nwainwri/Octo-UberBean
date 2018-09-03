//
//  NetworkManager.h
//  UberBean
//
//  Created by Nathan Wainwright on 2018-09-02.
//  Copyright © 2018 Nathan Wainwright. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkManager : NSObject

@property (nonatomic, strong) NSDictionary *dictionary;

- (void) getDataFromUrlAndParse;

@end
