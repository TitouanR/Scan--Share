//
//  SSProductViewController.m
//  Scan&Share
//
//  Created by Titouan Rossier on 29/05/13.
//  Copyright (c) 2013 Karim CHEBBOUR. All rights reserved.
//

#import "SSProductViewController.h"



@interface SSProductViewController ()

@end

@implementation SSProductViewController

@synthesize product, menu, contentView, globalScrollView, showMenuButtonItem, addCommentButtonItem, ratingControl;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.  
    
    contentView = [[[NSBundle mainBundle] loadNibNamed:@"SSProductView" owner:self options:nil] objectAtIndex:0];
    
    contentView.backgroundColor  = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"background@2x.png"]];
   
    NSLog(@"width : %f and height : %f", self.view.frame.size.width, self.view.frame.size.height);
    
    contentView.delegate =self;
    
    //Loading NavBar Button
    
    
    
    // Show menu
    UIButton *showMenuButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [showMenuButton setFrame:CGRectMake(0, 0, 36, 28)];
    [showMenuButton addTarget:self action:@selector(showMenu:) forControlEvents:UIControlEventTouchUpInside];
    [showMenuButton setImage:[UIImage imageNamed:@"actionButton.png"] forState:UIControlStateNormal];
    showMenuButtonItem = [[UIBarButtonItem alloc] initWithCustomView:showMenuButton];
    
    // + 
    UIButton *addCommentButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [addCommentButton setFrame:CGRectMake(0, 0, 36, 28)];
    [addCommentButton addTarget:self action:@selector(addCommentButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [addCommentButton setImage:[UIImage imageNamed:@"plusButton.png"] forState:UIControlStateNormal];
   addCommentButtonItem = [[UIBarButtonItem alloc] initWithCustomView:addCommentButton];
    

    
    
    //Comments Table View
    contentView.commentCellNib = [UINib nibWithNibName:@"SSCommentCellUI" bundle:nil];
    contentView.commentsTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 460, 320, 352)];
    contentView.commentsTable.backgroundColor = [UIColor clearColor];
    contentView.commentsTable.delegate = self;
    contentView.commentsTable.dataSource = self;
    
    
    [self.contentView addSubview:contentView.commentsTable];
   
    UIImage *buttonImage = [[UIImage imageNamed:@"blueButton"]
                            resizableImageWithCapInsets:UIEdgeInsetsMake(18, 18, 18, 18)];
    UIImage *buttonImageHighlight = [[UIImage imageNamed:@"blueButtonHighlight"]
                                     resizableImageWithCapInsets:UIEdgeInsetsMake(18, 18, 18, 18)];
    // Set the background for any states you plan to use
    [contentView.rateButton setBackgroundImage:buttonImage forState:UIControlStateNormal]
    ;
    [contentView.rateButton setBackgroundImage:buttonImageHighlight forState:UIControlStateHighlighted];
    

    
    //Rating module
    
    ratingControl = [[AMRatingControl alloc] initWithLocation:CGPointMake(20, 160)
                                                                          emptyImage:[UIImage imageNamed:@"dot.png"]
                                                                          solidImage:[UIImage imageNamed:@"satr.png"]
                                                                        andMaxRating:5];

   // [ratingControl addTarget:self action:@selector(updateRating:) forControlEvents:UIControlEventEditingChanged];
    [self.contentView addSubview:ratingControl];
    
    
    
    
    self.view = contentView;
    
    
    
    
    
    
    
    
    //Init Menu
    REMenuItem *addToListItem = [[REMenuItem alloc] initWithTitle:@"Ajouter à ma liste"
                                                    subtitle:@"Pour faciliter vos courses"
                                                       image:[UIImage imageNamed:@"addToListIco.png"]
                                            highlightedImage:nil
                                                      action:^(REMenuItem *item) {
                                                          NSLog(@"Item: %@", item);
                                                      }];
    
    REMenuItem *shareItem = [[REMenuItem alloc] initWithTitle:@"Partager"
                                                       subtitle:@"Sur vos réseaux sociaux préférés"
                                                          image:[UIImage imageNamed:@"Icon_Explore"]
                                               highlightedImage:nil
                                                         action:^(REMenuItem *item) {
                                                             NSLog(@"Item: %@", item);
                                                         }];
    
    REMenuItem *showOccasions = [[REMenuItem alloc] initWithTitle:@"Voir les occasions"
                                                        subtitle:@""
                                                           image:[UIImage imageNamed:@"Icon_Activity"]
                                                highlightedImage:nil
                                                          action:^(REMenuItem *item) {
                                                              NSLog(@"Item: %@", item);
                                                        
                                                          }];
    
    REMenuItem *addOccasion = [[REMenuItem alloc] initWithTitle:@"Ajouter une occasion"
                                                          image:[UIImage imageNamed:@"Icon_Profile"]
                                               highlightedImage:nil
                                                         action:^(REMenuItem *item) {
                                                             NSLog(@"Item: %@", item);
                                                             
                                                         }];
    
    addToListItem.tag = 0;
    shareItem.tag = 1;
    showOccasions.tag = 2;
    addOccasion.tag = 3;
    
    menu = [[REMenu alloc] initWithItems:@[addToListItem, shareItem, showOccasions, addOccasion]];
    menu.cornerRadius = 4;
    menu.shadowRadius = 4;
    menu.shadowColor = [UIColor blackColor];
    menu.shadowOffset = CGSizeMake(0, 1);
    menu.shadowOpacity = 1;
    menu.imageOffset = CGSizeMake(5, -1);
    menu.waitUntilAnimationIsComplete = NO;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    //Set the VC title    
    self.title =product.name;
    
    //Set the navBar right button
    self.navigationItem.rightBarButtonItem = showMenuButtonItem;
    
    
    [contentView.nameLabel setText:product.name];
    
    NSData *imageData = [NSData alloc];
    //TODO check pk data != null 
   /* if (product.image.imageBuffer){
        NSLog(@"%@", product.image.imageBuffer);
        NSLog(@"Image data");
        imageData = product.image.imageBuffer;
    }
    else{*/
        
        NSURL *imageUrl = [NSURL URLWithString:product.image.imageURL];
        imageData = [NSData dataWithContentsOfURL:imageUrl];
    //}
    
    

(void)[contentView.thumbImage initWithImage:[UIImage imageWithData:imageData] ];
    
    [contentView.descriptionTextView setText:product.description];
   
    [contentView.rateLabel setText:[NSString stringWithFormat:@"Note : %@/5", product.rating]];
    
    UIImage *pictoImage;
    if (product.rating.integerValue <= 1.5 ){
        pictoImage = [UIImage imageNamed:@"pictoRateBad.png"];
    }
    else if (product.rating.integerValue >1.5 && product.rating.integerValue <=2.5 ){
        pictoImage = [UIImage imageNamed:@"pictoRateBof.png"];

    }
    else if(product.rating.integerValue >2.5 && product.rating.integerValue <=4 ){
        pictoImage = [UIImage imageNamed:@"pictoRateGood.png"];

    }
    else{
        pictoImage = [UIImage imageNamed:@"pictoRateVeryGood.png"];

    }
    
    (void)[contentView.pictoRateImage initWithImage:pictoImage];
}


- (void)viewDidUnload {
   
    [self setGlobalScrollView:nil];
    [super viewDidUnload];
}


- (IBAction)showMenu:(id)sender {
    if (menu.isOpen)
        return [menu close];
    
    [menu showFromRect:CGRectMake(0, 0, self.navigationController.view.frame.size.width, self.navigationController.view.frame.size.height)
                inView:self.view];
}

-(void)addCommentButtonPressed{
    [self performSegueWithIdentifier:@"addCommentModalSegue" sender:NULL];
}


-(void)buttonClicked:(UIButton*)button inView:(UIView*)view {
    
    
    if (button.tag == 0) //Comments button
    {
        CGRect myFrame = self.view.frame;
        NSLog(@"view.frame.origin.y = %f and height : %f", myFrame.origin.y, myFrame.size.height);
        myFrame.size.height = 812;
        if (myFrame.origin.y >= 0){
        
            myFrame.origin.y -= 396;
            [UIView animateWithDuration:0.3
                              delay:0.0
                            options: UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             self.view.frame = myFrame;
                             self.navigationItem.rightBarButtonItem = addCommentButtonItem;
                         }
                         completion:^(BOOL finished){
                           
                             [button setTitle:@"\u2191 Fiche Produit \u2191" forState:UIControlStateNormal];
                         }];
        }
        else{
        
            myFrame.origin.y += 396;
            [UIView animateWithDuration:0.3
                              delay:0.0
                            options: UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             self.view.frame = myFrame;
                             self.navigationItem.rightBarButtonItem = showMenuButtonItem;
                         }
                         completion:^(BOOL finished){
                             [button setTitle:@"\u2193 Commentaires \u2193" forState:UIControlStateNormal];
                             
                             //self.navigationItem.rightBarButtonItem
                         }];
        }
    }
    
    else if (button.tag == 1) //Rate button
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Noter ce produit" message:[NSString stringWithFormat:@"Vous souhaitez donner la note de %d à ce produit, est-ce qu'on valide?",ratingControl.rating] delegate:self cancelButtonTitle:@"Annuler" otherButtonTitles:@"Valider", nil];
        [alert show];
    }
    
}


-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    //u need to change 0 to other value(,1,2,3) if u have more buttons.then u can check which button was pressed.
    
    if (buttonIndex == 1) {
        
        //Send rate
        
        
    }
    
    
    
}

#pragma mark -
#pragma mark Table Data Source Methods


- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    
    return [product.comments count];
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView
        cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    
    static NSString *CommentCellTableIdentifier = @"commentCellIdentifier";
    static BOOL nibsRegistered = NO;
    
    if (!nibsRegistered) {
        UINib *nib = [UINib nibWithNibName:@"SSCommentCellUI" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:CommentCellTableIdentifier];
        nibsRegistered = YES;
    }
    
    SSCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:
                         CommentCellTableIdentifier];
    
   if(cell == nil)
    {
        NSLog(@"Cell nil");
        cell = [[contentView.commentCellNib instantiateWithOwner:self options:nil] objectAtIndex:0];
    }
    
    NSInteger row = [indexPath row];
    
        SSComment * comment = [product.comments objectAtIndex:row];
        
        [cell.contentLabel setNumberOfLines:1000];
        [cell.contentLabel setLineBreakMode:NSLineBreakByWordWrapping];
        CGSize labelSize = CGSizeMake(280.0, 20.0);
        
        
        labelSize = [comment.content sizeWithFont:[UIFont systemFontOfSize: 13.0] constrainedToSize: CGSizeMake(labelSize.width, 1000) lineBreakMode: NSLineBreakByWordWrapping];
        
        [cell.contentLabel sizeThatFits:labelSize];
        [cell.contentLabel setText:comment.content];
        
        [cell.authorDateLabel setText:[NSString stringWithFormat:@"%@, le %@",comment.author, comment.date ]];
    
        

    return cell;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = [indexPath row];
    NSString* content;
    CGSize labelSize = CGSizeMake(280.0, 20.0);
   
    content = [[product.comments objectAtIndex:row] content];
       labelSize = [content sizeWithFont:[UIFont systemFontOfSize: 13.0] constrainedToSize: CGSizeMake(labelSize.width, 1000) lineBreakMode: NSLineBreakByWordWrapping];
    
    return (30.0 + labelSize.height);
}

@end
