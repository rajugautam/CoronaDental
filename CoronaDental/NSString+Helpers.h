//
//  NSString+Helpers.h
//  WordPress
//
//  Created by John Bickerstaff on 9/9/09.
// //

#import <UIKit/UIKit.h>

@interface NSString (Helpers)

// helper functions
- (NSString *) stringByUrlEncoding;
- (NSString *) stringByUrlDecoding;
- (NSString *) base64Encoding;
- (NSString *) trim;
- (BOOL) startsWith:(NSString *)s;
- (BOOL) containsString:(NSString * )aString;
- (NSString *)substringFrom:(NSInteger)a to:(NSInteger)b;
- (NSString*) unescapeUnicodeString:(NSString*)string;
- (NSString*) escapeUnicodeString:(NSString*)string;
- (BOOL)isNumeric;

@end


@interface NSObject (Helpers)
- (NSInteger)trimedLength;
@end
