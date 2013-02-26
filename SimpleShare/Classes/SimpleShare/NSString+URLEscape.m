//
//  NSString+URLEscape.m
//  SimpleShare
//
//  Created by Trinstan Chen on 02/20/2013.
//

#import "NSString+URLEscape.h"

@implementation NSString (URLEscape)

- (NSString *)urlEscape {
    
    return [self stringByAddingPercentEscapesUsingEncoding:
            NSASCIIStringEncoding];
}

@end
