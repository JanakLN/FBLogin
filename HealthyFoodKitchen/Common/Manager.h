//
//  MyFlyManager.h
//  MyFly
//
//  Created by Mac User7 on 26/06/15.
//  Copyright (c) 2015 Mac User7. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Common.h"
#import "AFNetworking.h"
#import "Helper.h"

typedef void(^myflyCompletionBlock)(BOOL success);

@interface Manager : NSObject

+(id)sharedInstance;

    
@property (nonatomic,strong) NSMutableDictionary *logindict;
@property (nonatomic,strong) NSMutableDictionary *signupDict;
@property (nonatomic,strong) NSMutableDictionary *FBlogindict;
@property (nonatomic,strong) NSArray *Location;
@property (nonatomic,strong) NSString *address;



-(void)registerMe:(NSDictionary*)dictParam completionBlock:(myflyCompletionBlock)pCompletionBlock;

-(void)login:(NSDictionary*)dictParam completionBlock:(myflyCompletionBlock)pCompletionBlock;

-(void)Facebook_login:(NSDictionary*)dictParam completionBlock:(myflyCompletionBlock)pCompletionBlock;

-(void)getLocattion:(NSDictionary*)dictParam url:(NSString*)strUrl completionBlock:(myflyCompletionBlock)pCompletionBlock;

@end
