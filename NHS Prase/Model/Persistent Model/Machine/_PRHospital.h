// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to PRHospital.h instead.

#import <CoreData/CoreData.h>


extern const struct PRHospitalAttributes {
	__unsafe_unretained NSString *id;
	__unsafe_unretained NSString *name;
} PRHospitalAttributes;

extern const struct PRHospitalRelationships {
	__unsafe_unretained NSString *trust;
	__unsafe_unretained NSString *wards;
} PRHospitalRelationships;

extern const struct PRHospitalFetchedProperties {
} PRHospitalFetchedProperties;

@class PRTrust;
@class PRWard;




@interface PRHospitalID : NSManagedObjectID {}
@end

@interface _PRHospital : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (PRHospitalID*)objectID;




@property (nonatomic, strong) NSNumber *id;


@property long long idValue;
- (long long)idValue;
- (void)setIdValue:(long long)value_;

//- (BOOL)validateId:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString *name;


//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) PRTrust* trust;

//- (BOOL)validateTrust:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSSet* wards;

- (NSMutableSet*)wardsSet;




@end

@interface _PRHospital (CoreDataGeneratedAccessors)

- (void)addWards:(NSSet*)value_;
- (void)removeWards:(NSSet*)value_;
- (void)addWardsObject:(PRWard*)value_;
- (void)removeWardsObject:(PRWard*)value_;

@end

@interface _PRHospital (CoreDataGeneratedPrimitiveAccessors)


- (NSNumber*)primitiveId;
- (void)setPrimitiveId:(NSNumber*)value;

- (long long)primitiveIdValue;
- (void)setPrimitiveIdValue:(long long)value_;




- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;





- (PRTrust*)primitiveTrust;
- (void)setPrimitiveTrust:(PRTrust*)value;



- (NSMutableSet*)primitiveWards;
- (void)setPrimitiveWards:(NSMutableSet*)value;


@end
