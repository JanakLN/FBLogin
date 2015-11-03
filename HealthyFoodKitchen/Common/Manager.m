//
//  MyFlyManager.m
//  MyFly
//
//  Created by Mac User7 on 26/06/15.
//  Copyright (c) 2015 Mac User7. All rights reserved.
//

#import "Manager.h"

@interface Manager ()

@end

@implementation Manager
//@synthesize ;
+(id)sharedInstance
{
    static Manager *objManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        objManager = [[Manager alloc] init];
    });
    return objManager;
}

-(id)init
{
    self = [super init];
    
    _logindict   = [[NSMutableDictionary alloc]init];
    _signupDict  = [[NSMutableDictionary alloc]init];
    _FBlogindict = [[NSMutableDictionary alloc]init];
    _Location    = [[NSArray alloc] init];
    return self;
}


-(void)registerMe:(NSDictionary*)dictParam completionBlock:(myflyCompletionBlock)pCompletionBlock
{
    NSString *strRequestUrl = [kWebservice stringByAppendingString:@""];
    [Helper showGlobalProgressHUDWithTitle:@"Loading"];
    AFHTTPRequestOperationManager *operationManager = [AFHTTPRequestOperationManager manager];
    operationManager.responseSerializer = [AFJSONResponseSerializer serializer];
    operationManager.responseSerializer.acceptableContentTypes = [operationManager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    AFHTTPRequestOperation *operation = [operationManager POST:strRequestUrl parameters:dictParam success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [Helper dismissGlobalHUD];
        NSDictionary* dictResponse = [NSJSONSerialization
                                      JSONObjectWithData:operation.responseData //1
                                      options:kNilOptions
                                      error:nil];
        
        NSLog(@"%@",dictResponse);
        
        NSInteger intSuccess = [[dictResponse valueForKey:@"status"] integerValue];
        NSLog(@"%ld",(long)intSuccess);
        if (intSuccess == 1)
        {
            
            _signupDict = dictResponse.mutableCopy;
            
            // strUserId = [dictResponse valueForKey:@"user_id"];
            pCompletionBlock(1);
        }
        else if (intSuccess == 0){
            pCompletionBlock(0);
        }
        else{
            pCompletionBlock(2);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [Helper dismissGlobalHUD];
        pCompletionBlock(NO);
        NSLog(@"Failed %@",operation.responseString);
    }];
    [operation start];
}


-(void)login:(NSDictionary*)dictParam completionBlock:(myflyCompletionBlock)pCompletionBlock
{
    NSString *strRequestUrl = [kWebservice stringByAppendingString:@"Login"];
    [Helper showGlobalProgressHUDWithTitle:@"Loading"];
    AFHTTPRequestOperationManager *operationManager = [AFHTTPRequestOperationManager manager];
    operationManager.responseSerializer = [AFJSONResponseSerializer serializer];
    operationManager.responseSerializer.acceptableContentTypes = [operationManager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    AFHTTPRequestOperation *operation = [operationManager POST:strRequestUrl parameters:dictParam success:^(AFHTTPRequestOperation *operation, id responseObject)
                                         {
                                             [Helper dismissGlobalHUD];
                                             NSDictionary* dictResponse = [NSJSONSerialization
                                                                           JSONObjectWithData:operation.responseData //1
                                                                           options:kNilOptions
                                                                           error:nil];
                                             
                                             NSLog(@"%@",dictResponse);
                                             
                                             NSInteger intSuccess = [[dictResponse valueForKey:@"status"] integerValue];
                                             NSLog(@"status:%ld",(long)intSuccess);
                                             
                                             if (intSuccess == 1)
                                             {
                                                 _logindict = dictResponse.mutableCopy;
                                                 pCompletionBlock(1);
                                             }
                                             else if (intSuccess == 0){
                                                 pCompletionBlock(0);
                                             }
                                             else{
                                                 pCompletionBlock(2);
                                             }
                                             
                                         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                             [Helper dismissGlobalHUD];
                                             pCompletionBlock(NO);
                                             NSLog(@"Failed %@",operation.responseString);
                                         }];
    [operation start];
}
-(void)Facebook_login:(NSDictionary*)dictParam completionBlock:(myflyCompletionBlock)pCompletionBlock
{
    NSString *strRequestUrl = [kWebservice stringByAppendingString:@""];
    [Helper showGlobalProgressHUDWithTitle:@"Loading"];
    AFHTTPRequestOperationManager *operationManager = [AFHTTPRequestOperationManager manager];
    operationManager.responseSerializer = [AFJSONResponseSerializer serializer];
    operationManager.responseSerializer.acceptableContentTypes = [operationManager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    AFHTTPRequestOperation *operation = [operationManager POST:strRequestUrl parameters:dictParam success:^(AFHTTPRequestOperation *operation, id responseObject)
                                         {
                                             [Helper dismissGlobalHUD];
                                             NSDictionary* dictResponse = [NSJSONSerialization
                                                                           JSONObjectWithData:operation.responseData //1
                                                                           options:kNilOptions
                                                                           error:nil];
                                             
                                             NSLog(@"%@",dictResponse);
                                             
                                             NSInteger intSuccess = [[dictResponse valueForKey:@"status"] integerValue];
                                             NSLog(@"status:%ld",(long)intSuccess);
                                             
                                             if (intSuccess == 1)
                                             {
                                                 _FBlogindict = dictResponse.mutableCopy;
                                                 pCompletionBlock(1);
                                             }
                                             else if (intSuccess == 0){
                                                 pCompletionBlock(0);
                                             }
                                             else{
                                                 pCompletionBlock(2);
                                             }
                                             
                                         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                             [Helper dismissGlobalHUD];
                                             pCompletionBlock(NO);
                                             NSLog(@"Failed %@",operation.responseString);
                                         }];
    [operation start];
}

-(void)getLocattion:(NSDictionary*)dictParam url:(NSString *)strUrl completionBlock:(myflyCompletionBlock)pCompletionBlock{
    NSString *strRequestUrl =strUrl;
    //[Helper showGlobalProgressHUDWithTitle:@"Loading"];
    AFHTTPRequestOperationManager *operationManager = [AFHTTPRequestOperationManager manager];
    operationManager.responseSerializer = [AFJSONResponseSerializer serializer];
    operationManager.responseSerializer.acceptableContentTypes = [operationManager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    AFHTTPRequestOperation *operation = [operationManager POST:strRequestUrl parameters:dictParam success:^(AFHTTPRequestOperation *operation, id responseObject)
                                         {
                                             [Helper dismissGlobalHUD];
                                             NSDictionary* dictResponse = [NSJSONSerialization
                                                                           JSONObjectWithData:operation.responseData //1
                                                                           options:kNilOptions
                                                                           error:nil];
                                             
                                             NSLog(@"%@",dictResponse);
                                             
                                             NSString *status =[dictResponse valueForKey:@"status"];
                    
                                             if ([status isEqualToString:@"OK"]){
                                                 _Location = [responseObject valueForKey:@"results"];
                                                 _address = [[_Location objectAtIndex:1] valueForKey:@"formatted_address"];
                                                 pCompletionBlock(1);
                                             }else{
                                                 pCompletionBlock(0);
                                             }
                                             
                                         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                             //[Helper dismissGlobalHUD];
                                             pCompletionBlock(NO);
                                             NSLog(@"Failed %@",operation.responseString);
                                         }];
    [operation start];

}
@end
