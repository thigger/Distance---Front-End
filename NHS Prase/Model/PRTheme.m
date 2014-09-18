//
//  PRTheme.m
//  NHS Prase
//
//  Created by Josh Campion on 02/09/2014.
//  Copyright (c) 2014 The Distance. All rights reserved.
//

#import "PRTheme.h"


@implementation PRTheme

NSString * PRLocalizedStringWithDefaultValue(NSString *key, NSString *tbl, NSBundle *bundle, NSString *val, NSString *comment)
{
    NSString *localizedString = TDLocalizedStringWithDefaultValue(key, tbl, bundle, val, comment);
    
    if (![localizedString isNonNullString] || [localizedString isEqualToString:key]) {
        localizedString = [[[TDTheme sharedTheme] localizedBundle] localizedStringForKey:key value:val table:@"Questionnaire"];
    }
    
    return ([localizedString isNonNullString] && ![localizedString isEqualToString:key]) ? localizedString : val;
}

-(UIFont *)preferredFontForTextStyle:(NSString *)fontStyle
{
    UIFont *themeFont = [super preferredFontForTextStyle:fontStyle];
    
    NSString *contentSize = [UIApplication sharedApplication].preferredContentSizeCategory;
    
    //  This is a good standard OS wide text size...
    CGFloat fontSize = 14.0;
    
    // ... adjust the font size based on the user's choice ...
    if ([contentSize isEqualToString:UIContentSizeCategoryExtraSmall]) {
        fontSize = 11.0;
        
    } else if ([contentSize isEqualToString:UIContentSizeCategorySmall]) {
        fontSize = 12.0;
        
    } else if ([contentSize isEqualToString:UIContentSizeCategoryMedium]) {
        fontSize = 14.0;
        
    } else if ([contentSize isEqualToString:UIContentSizeCategoryLarge]) {
        fontSize = 16.0;
        
    } else if ([contentSize isEqualToString:UIContentSizeCategoryExtraLarge]) {
        fontSize = 18.0;
        
    } else if ([contentSize isEqualToString:UIContentSizeCategoryExtraExtraLarge]) {
        fontSize = 20.0;
        
    } else if ([contentSize isEqualToString:UIContentSizeCategoryExtraExtraExtraLarge]) {
        fontSize = 22.0;
    }
    
    // increase as Prase uses large fonts throughout
    fontSize += 3.0;
    
    if ([fontStyle isEqualToString:UIFontTextStyleHeadline]) {
        // used only for dark blue headlines
        fontSize += 4.0;
        
    } else if ([fontStyle isEqualToString:UIFontTextStyleSubheadline]) {
        // used for most headings, explanations and prompts
        fontSize += 0.0;
        
    } else if ([fontStyle isEqualToString:UIFontTextStyleBody]) {
        // used for used inputted data
        fontSize -= 2.0;
        
    } else if ([fontStyle isEqualToString:UIFontTextStyleCaption1]) {
        // used for navigation buttons
        fontSize -= 1.0;
        
    } else if ([fontStyle isEqualToString:UIFontTextStyleCaption2]) {
        // used for the Questionnaire CMS introduction
        fontSize += 2.0;
        
    } else if ([fontStyle isEqualToString:UIFontTextStyleFootnote]) {
        
        fontSize -= 4.0;
    }
    
    return [themeFont fontWithSize:fontSize];
}

+(NSDictionary *)languageDictionary
{
    static NSDictionary *languageOptions = nil;
    
    if (languageOptions == nil) {
        languageOptions = @{@"en": @"English",
                            @"fr": @"Français"};
    }
    
    return languageOptions;
}

-(instancetype)init
{
    self = [super init];
    
    if (self != nil) {
        _neutralColor = [UIColor colorWithHex:@"#42c4fa" alpha:1.0];
        _mainColor = [UIColor colorWithHex:@"#32327b" alpha:1.0];
        _positiveColor = [UIColor colorWithHex:@"#8bc53f" alpha:1.0];
        _negativeColor = [UIColor colorWithHex:@"#eb008b" alpha:1.0];
        _backColor = [UIColor lightGrayColor];
        
        NSString *fontName = @"Helvetica";
        self.preferredFontNameForHeadline = @"Helvetica Bold";
        self.preferredFontNameForSubHeadline = @"Helvetica Bold";
        self.preferredFontNameForBody = fontName;
        self.preferredFontNameForCaption1 = @"Helvetica Bold";
        self.preferredFontNameForCaption2 = fontName;
        self.preferredFontNameForFootnote = fontName;
    }
    
    return self;
}

-(UIColor *)colourForIdentifier:(NSString *)identifier
{
    if ([identifier isEqualToString:@"negative"]) {
        return self.negativeColor;
    }
    
    if ([identifier isEqualToString:@"positive"]) {
        return self.positiveColor;
    }
    
    if ([identifier isEqualToString:@"neutral"]) {
        return self.neutralColor;
    }
    
    if ([identifier isEqualToString:@"main"]) {
        return self.mainColor;
    }
    
    if ([identifier isEqualToString:@"back"]) {
        return self.backColor;
    }
    
    return [super colourForIdentifier:identifier];
}

@end
