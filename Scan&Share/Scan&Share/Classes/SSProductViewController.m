//
//  SSProductViewController.m
//  Scan&Share
//
//  Created by Titouan Rossier on 29/05/13.
//  Copyright (c) 2013 Karim CHEBBOUR. All rights reserved.
//

#import "SSProductViewController.h"
#import "SSMapViewController.h"


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
   

    
    contentView.delegate =self;
    
    //Loading right navBar items
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
   
    
    //Init contentView buttons
    UIImage *buttonImage = [[UIImage imageNamed:@"blueButton"]
                            resizableImageWithCapInsets:UIEdgeInsetsMake(18, 18, 18, 18)];
    UIImage *buttonImageHighlight = [[UIImage imageNamed:@"blueButtonHighlight"]
                                     resizableImageWithCapInsets:UIEdgeInsetsMake(18, 18, 18, 18)];
    
    
    [contentView.rateButton setBackgroundImage:buttonImage forState:UIControlStateNormal]
    ;
    [contentView.showMapButton setBackgroundImage:buttonImageHighlight forState:UIControlStateHighlighted];
    [contentView.showMapButton setBackgroundImage:buttonImage forState:UIControlStateNormal]
    ;
    [contentView.showMapButton setBackgroundImage:buttonImageHighlight forState:UIControlStateHighlighted];

    //Rating control
    ratingControl = [[AMRatingControl alloc] initWithLocation:CGPointMake(18, 150)
                                                   emptyImage:[UIImage imageNamed:@"dot.png"]
                                                   solidImage:[UIImage imageNamed:@"satr.png"]
                                                 andMaxRating:5];
    
   
    
    
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
    
    menu = [[REMenu alloc] initWithItems:@[addToListItem, shareItem, showOccasions, addOccasion] andDelegate:self];
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
    
    if ([product.comments count] == 0) {
        //Hide the comments table when there is no comment
        contentView.commentsTable.hidden = YES;
        contentView.indicationNoCommentLabel.hidden = NO;
    }
    else{
        contentView.commentsTable.hidden = NO;
        contentView.indicationNoCommentLabel.hidden = YES;
    }
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

/**
  *  aroundMe: Display MapViewController for around me products
 **/

- (IBAction)aroundMe:(id)sender {
    [self performSegueWithIdentifier:@"searchResultToMapView" sender:self.product];
}

-(void)addCommentButtonPressed{
    [self performSegueWithIdentifier:@"addCommentModalSegue" sender:NULL];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([[segue identifier] isEqualToString:@"searchResultToMapView"]) {
        
        // Get the destination view controller
        SSMapViewController *mapViewController = [segue destinationViewController];
        
        // Get the product to send from (id)sender
        SSProduct *productToShow =(SSProduct*)sender;
        
        // Set the product object in the destination VC
        mapViewController.product = productToShow;
    }
}

-(void)buttonClicked:(UIButton*)button inView:(UIView*)view {
    NSLog( @"DELEGETE OK");
    
    if (button.tag == 0) //Comments button
    {
        CGRect myFrame = self.view.frame;
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
       UIAlertView *rate = [[UIAlertView alloc] initWithTitle:@"Noter le produit" message:[NSString stringWithFormat:@"Vous êtes sur le point de donner la note de %d à ce produit", ratingControl.rating] delegate:self cancelButtonTitle:@"Annuler" otherButtonTitles:@"Valider", nil];
        
        [rate show];
    }
    
    else if (button.tag == 2) //show map Button
    {
        [self performSegueWithIdentifier:@"productToMapPush" sender:nil];
        
    }
    
  
    
    
}

-(void)buttonClicked:(UIButton*)sender {
    //Share action
    if (sender.tag == 0){
        //Share by Facebook
    }
    
    else if(sender.tag == 1){
        //Share by Twitter
    }
    
    
    else if(sender.tag == 2){
        
        //Share by Mail
        
        
        if ([MFMailComposeViewController canSendMail])
        {
            MFMailComposeViewController *mailer = [[MFMailComposeViewController alloc] init];
            
            mailer.mailComposeDelegate = self;
            
            
            
            NSString *emailBody = [[NSString alloc]init];
            
            emailBody = [self.product name];
            emailBody = [emailBody stringByAppendingString:@"\n\n"];
            
            if ([self.product description]){
                
                
                emailBody = [emailBody stringByAppendingString:[self.product description]];
                emailBody = [emailBody stringByAppendingString:@"\n\n\n"];
            }
            NSString* postByString =@"Envoyé depuis Scan&Share";
            emailBody = [emailBody stringByAppendingString:postByString];
            [mailer setMessageBody:emailBody isHTML:NO];
            
            [self presentModalViewController:mailer animated:YES];
            
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Impossible d'envoyé le mail"
                                                            message:@ "Vous ne pouvez pas envoyer de mail..."
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK, dommage!"
                                                  otherButtonTitles: nil];
            [alert show];
        }
    }
}



#pragma mark - MFMailComposeController delegate


- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
	switch (result)
	{
		case MFMailComposeResultCancelled:
			NSLog(@"Mail cancelled: you cancelled the operation and no email message was queued");
			break;
		case MFMailComposeResultSaved:
			NSLog(@"Mail saved: you saved the email message in the Drafts folder");
			break;
		case MFMailComposeResultSent:
			NSLog(@"Mail send: the email message is queued in the outbox. It is ready to send the next time the user connects to email");
			break;
		case MFMailComposeResultFailed:
			NSLog(@"Mail failed: the email message was nog saved or queued, possibly due to an error");
			break;
		default:
			NSLog(@"Mail not sent");
			break;
	}
    
	[self dismissViewControllerAnimated:YES completion:nil];
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
