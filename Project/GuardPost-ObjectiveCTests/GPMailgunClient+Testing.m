//
//  GPMailgunClient+Testing.m
//  GuardPost-ObjectiveC
//
//  Created by Sam Davies on 27/07/2013.
//  Copyright (c) 2013 sammyd. All rights reserved.
//

#import "GPMailgunClient+Testing.h"

@implementation GPMailgunClient (Testing)

- (void)resetAPIKey
{
    self.publicAPIKey = nil;
    [self clearAuthorizationHeader];
}

@end
