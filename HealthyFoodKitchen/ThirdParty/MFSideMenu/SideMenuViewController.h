//
//  SideMenuViewController.h
//  MFSideMenuDemoStoryboard
//
//  Created by Michael Frederick on 5/7/13.
//  Copyright (c) 2013 Michael Frederick. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import "AsyncImageView.h"
#import "PAAImageView.h"
@interface SideMenuViewController : UITableViewController<PAAImageViewDelegate>
{
    NSDictionary *dictUserData;
    UIImageView *cell_imageView;
    UILabel *cell_label;
    PAAImageView *imgAvtar ;
    NSArray *menuImgHighLight;
    NSArray *menuImg;
    NSArray *titles;
    int noOfRows;
    UILabel *lblUSerName;
    
}
-(void)tableViewSettings;
-(void)refreshTable;
@property (nonatomic, strong) MPMoviePlayerViewController *playerView;
@property (nonatomic,strong) NSString *avatarURL;
-(void)setAvatar:(NSString*)url;
@end
