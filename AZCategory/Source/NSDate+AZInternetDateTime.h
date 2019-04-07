//
//  NSDate+AZInternetDateTime.h
//  MWFeedParser
//
//  Created by Michael Waterfall on 07/10/2010.
//  Copyright 2010 Michael Waterfall. All rights reserved.
//

#import <Foundation/Foundation.h>

// Formatting hints
typedef enum {
    AZDateFormatHintNone, 
    AZDateFormatHintRFC822, 
    AZDateFormatHintRFC3339
} AZDateFormatHint;

// A category to parse internet date & time strings
@interface NSDate (AZInternetDateTime)

// Get date from RFC3339 or RFC822 string
// - A format/specification hint can be used to speed up, 
//   otherwise both will be attempted in order to get a date
+ (NSDate *)az_dateFromInternetDateTimeString:(NSString *)dateString 
                                formatHint:(AZDateFormatHint)hint;

// Get date from a string using a specific date specification
+ (NSDate *)az_dateFromRFC3339String:(NSString *)dateString;
+ (NSDate *)az_dateFromRFC822String:(NSString *)dateString;

@end
