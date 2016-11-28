// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to PRConcern.m instead.

#import "_PRConcern.h"

@implementation PRConcernID
@end

@implementation _PRConcern

+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"PRConcern" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"PRConcern";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"PRConcern" inManagedObjectContext:moc_];
}

- (PRConcernID*)objectID {
	return (PRConcernID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic preventNote;

@dynamic preventQuestion;

@dynamic question;

@dynamic record;

@dynamic seriousQuestion;

@dynamic ward;

@dynamic whatNote;

@dynamic whyNote;

@end

@implementation PRConcernRelationships 
+ (NSString *)preventNote {
	return @"preventNote";
}
+ (NSString *)preventQuestion {
	return @"preventQuestion";
}
+ (NSString *)question {
	return @"question";
}
+ (NSString *)record {
	return @"record";
}
+ (NSString *)seriousQuestion {
	return @"seriousQuestion";
}
+ (NSString *)ward {
	return @"ward";
}
+ (NSString *)whatNote {
	return @"whatNote";
}
+ (NSString *)whyNote {
	return @"whyNote";
}
@end

