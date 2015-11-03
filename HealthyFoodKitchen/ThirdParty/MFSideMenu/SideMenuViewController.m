//
//  SideMenuViewController.m
//  MFSideMenuDemo
//
//  Created by Michael Frederick on 3/19/12.

#import "SideMenuViewController.h"
#import "MFSideMenu.h"
#import "LoginVC.h"
#import "Common.h"
@implementation SideMenuViewController
#pragma mark -
#pragma mark - UITableViewDataSource


-(void)viewDidLoad{
    [self tableViewSettings];
    self.view.backgroundColor=[UIColor whiteColor];
    dictUserData = [[NSDictionary alloc] init];
    [super viewDidLoad];
}
-(void)viewDidLayoutSubviews{
    self.tableView.contentInset = UIEdgeInsetsMake(0.0f, 20.0f, 0.0f, 0.0f);
}
-(void)tableViewSettings
{
        menuImg =[[NSArray alloc] initWithObjects:@"btn_Preference.png",@"btn_Payment.png",@"btn_Favorite.png",@"btn_Help.png",@"btn_about.png",nil];
        menuImgHighLight =[[NSArray alloc] initWithObjects:@"btn_PreferenceSelected.png",@"btn_PaymentSelected.png",@"btn_FavoriteSelected.png",@"btn_HelpSelected.png",@"btn_aboutSelected.png", nil];
    titles=[[NSArray alloc] initWithObjects:@"Preference",@"Payment",@"Favorite Order",@"Help",@"About", nil];
    
    [self.view setBackgroundColor:[UIColor clearColor]];
    
    UIImageView *mainBG=[[UIImageView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:mainBG];
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 250, 135)];
    
    UIView *statusBar=[[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 20)];
    statusBar.backgroundColor=[Helper colorFromHexString:@"#BF3208"];
    //[headerView addSubview:statusBar];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 250, 130)];
    imageView.image=[UIImage imageNamed:@"3x_0063_Vector-Smart-Object.png"];
    [headerView addSubview:imageView];
    [self.view addSubview:headerView];
    
    imgAvtar = [[PAAImageView alloc] initWithFrame:CGRectMake(10, 30, 50, 50)];
    imgAvtar.delegate=self;
    [imgAvtar setBackgroundWidth:0];
    [imgAvtar setProgressColor:[UIColor grayColor]];
    [imgAvtar setBackgroundColor:[UIColor grayColor]];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *dictionaryData = [defaults objectForKey:KUserDetails];
    dictUserData = [[NSKeyedUnarchiver unarchiveObjectWithData:dictionaryData] mutableCopy];
    
    [imgAvtar setImageURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[dictUserData valueForKey:@"url"]]]];
    [imgAvtar setUserInteractionEnabled:YES];
    [headerView addSubview:imgAvtar];
    
    lblUSerName=[[UILabel alloc] initWithFrame:CGRectMake(10, 100, 150, 20)];
    lblUSerName.text=[dictUserData valueForKey:@"userName"];
    lblUSerName.textColor= [UIColor whiteColor];
    [lblUSerName setFont:[UIFont fontWithName:KRobotoMedium size:13]];
    [headerView addSubview:lblUSerName];
    
    CGRect bounds = [self.tableView bounds];
    NSLog(@"%f",self.tableView.contentSize.height);
    //    [self.tableView setBounds:CGRectMake(bounds.origin.x,
    //                                    bounds.origin.y,
    //                                    bounds.size.width,
    //                                    50 * [menuImg count]+70)];
    self.tableView.tableHeaderView = headerView;
    self.tableView.bounces=NO;
    if (self.tableView.contentSize.height < self.tableView.frame.size.height) {
        self.tableView.scrollEnabled = NO;
    }
    else {
        self.tableView.scrollEnabled = YES;
    }
    [self.tableView reloadData];
}
-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:YES];
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self tableViewSettings];
}
-(void)refreshTable
{
    [self.tableView reloadData];
    [self viewWillAppear:YES];
}
#pragma mark -
#pragma mark - tableview Methods

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.0f;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@""];
        cell.backgroundColor=[UIColor clearColor];
        
        cell_imageView=[[UIImageView alloc] initWithFrame:CGRectMake(8, 10, 30, 30)];
        [cell addSubview:cell_imageView];
        
        cell_label = [[UILabel alloc] initWithFrame:CGRectMake(55, 10, 150, 30)];
        cell_label.font=[UIFont fontWithName:KRobotoMedium size:13];
        cell_label.textColor=[UIColor grayColor];
        [cell addSubview:cell_label];
    }
    cell_imageView.image=[UIImage imageNamed:menuImg[indexPath.row]];
    cell_label.text=titles[indexPath.row];
    if(indexPath.row==selectedIndex){
        cell_imageView.image= [UIImage imageNamed:menuImgHighLight[selectedIndex]];
        cell_label.textColor=[UIColor orangeColor];
    }


    return cell;
}


#pragma mark -
#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
    
    selectedIndex=indexPath.row;
    if(indexPath.row==0){
        //ListenerViewController *HomeVC=[self.storyboard instantiateViewControllerWithIdentifier:@"NewSessionVC"];
        //NSArray *controllers = [NSArray arrayWithObject:HomeVC];
        //navigationController.viewControllers = controllers;
        //[self.tableView reloadData];
        [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
        
    }
    else if(indexPath.row==1){
       
    }
    else if(indexPath.row==2){
      
    }

    else if(indexPath.row==3){
       
    }
    else if(indexPath.row==4){
        

    }
    else if(indexPath.row==5){
     
    }
    
    [self tableViewSettings];
    
}
-(void)setAvatarURL:(NSString *)avatarURL{
    [imgAvtar setImageURL:[NSURL URLWithString:avatarURL]];
}
- (void)paaImageViewDidTapped:(id)view{
    NSLog(@"avatar clicked");
}
@end