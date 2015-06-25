//
//  NSString+Helpers.m
//  WordPress
//
//  Created by John Bickerstaff on 9/9/09.
//  
//

#import "NSString+Helpers.h"
//#import "NSData+Base64.h"

@implementation NSString (Helpers)

#pragma mark Helpers
- (NSString *) stringByUrlEncoding
{
	return (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL,  (__bridge CFStringRef)self,  NULL,  (CFStringRef)@"!*'();:@&=+$,/?%#[]",  kCFStringEncodingUTF8));
}

- (NSString *) stringByUrlDecoding
{
	return [self stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

- (NSString *)base64Encoding {
    return nil;
	//NSData *stringData = [self dataUsingEncoding:NSUTF8StringEncoding];
	//NSString *encodedString = [stringData base64EncodedString];

	//return encodedString;
}

- (NSString*)trim  {
    if ([self isKindOfClass:[NSString class]]) {
        return [self stringByTrimmingCharactersInSet:[NSCharacterSet
                                                      whitespaceAndNewlineCharacterSet]];
    }
	return self;
}

- (BOOL)startsWith:(NSString*)s {
	if([self length] < [s length]) return NO;
	return [s isEqualToString:[self substringFrom:0 to:[s length]]];
	
}

- (NSString*)substringFrom:(NSInteger)a to:(NSInteger)b
{
	NSRange r;
	r.location = a;
	r.length = b - a;
	return [self substringWithRange:r];
	
} 
- (BOOL)containsString:(NSString *)aString {
	NSRange range = [[self lowercaseString] rangeOfString:[aString
														   lowercaseString]];
	return range.location != NSNotFound;
}

- (NSString*) unescapeUnicodeString:(NSString*)string
{
    // unescape quotes and backwards slash
    NSString* unescapedString = [string stringByReplacingOccurrencesOfString:@"\\\"" withString:@"\""];
    unescapedString = [unescapedString stringByReplacingOccurrencesOfString:@"\\\\" withString:@"\\"];
    
    // tokenize based on unicode escape char
    NSMutableString* tokenizedString = [NSMutableString string];
    NSScanner* scanner = [NSScanner scannerWithString:unescapedString];
    while ([scanner isAtEnd] == NO)
    {
        // read up to the first unicode marker
        // if a string has been scanned, it's a token
        // and should be appended to the tokenized string
        NSString* token = @"";
        [scanner scanUpToString:@"\\u" intoString:&token];
        if (token != nil && token.length > 0)
        {
            [tokenizedString appendString:token];
            continue;
        }
        
        // skip two characters to get past the marker
        // check if the range of unicode characters is
        // beyond the end of the string (could be malformed)
        // and if it is, move the scanner to the end
        // and skip this token
        NSUInteger location = [scanner scanLocation];
        NSInteger extra = scanner.string.length - location - 4 - 2;
        if (extra < 0)
        {
            NSRange range = {location, -extra};
            [tokenizedString appendString:[scanner.string substringWithRange:range]];
            [scanner setScanLocation:location - extra];
            continue;
        }
        
        // move the location pas the unicode marker
        // then read in the next 4 characters
        location += 2;
        NSRange range = {location, 4};
        token = [scanner.string substringWithRange:range];
        unichar codeValue = (unichar) strtol([token UTF8String], NULL, 16);
        [tokenizedString appendString:[NSString stringWithFormat:@"%C", codeValue]];
        
        // move the scanner past the 4 characters
        // then keep scanning
        location += 4;
        [scanner setScanLocation:location];
    }
    
    // done
    return tokenizedString;
}

- (NSString*) escapeUnicodeString:(NSString*)string
{
    // lastly escaped quotes and back slash
    // note that the backslash has to be escaped before the quote
    // otherwise it will end up with an extra backslash
    NSString* escapedString = [string stringByReplacingOccurrencesOfString:@"\\" withString:@"\\\\"];
    escapedString = [escapedString stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    
    // convert to encoded unicode
    // do this by getting the data for the string
    // in UTF16 little endian (for network byte order)
    NSData* data = [escapedString dataUsingEncoding:NSUTF16LittleEndianStringEncoding allowLossyConversion:YES];
    size_t bytesRead = 0;
    const char* bytes = data.bytes;
    NSMutableString* encodedString = [NSMutableString string];
    
    // loop through the byte array
    // read two bytes at a time, if the bytes
    // are above a certain value they are unicode
    // otherwise the bytes are ASCII characters
    // the %C format will write the character value of bytes
    while (bytesRead < data.length)
    {
        uint16_t code = *((uint16_t*) &bytes[bytesRead]);
        if (code > 0x007E)
        {
            [encodedString appendFormat:@"\\u%04X", code];
        }
        else
        {
            [encodedString appendFormat:@"%C", code];
        }
        bytesRead += sizeof(uint16_t);
    }
    
    // done
    return encodedString;
}

- (BOOL)isNumeric
{
    const char *s = [self UTF8String];
	
	for (size_t i=0;i<strlen(s);i++)
	{
		if ((s[i]<'0' || s[i]>'9') && (s[i] != '.'))
		{
			return NO;
		}
	}
	return YES;
}

@end


@implementation NSObject (Helpers)
- (NSInteger)trimedLength  {
    if ([self isKindOfClass:[NSString class]]) {
        return [[(id)self stringByTrimmingCharactersInSet:[NSCharacterSet
                                                       whitespaceAndNewlineCharacterSet]] length];
    }
    else if ([self isKindOfClass:[NSArray class]]) {
        return [(id)self count];
    }
    else if ([self isKindOfClass:[NSDictionary class]]) {
        return [(id)self count];
    }
	return 0;
}
@end