//
//  SSScanViewController.h
//  Scan&Share
//
//  Created by Karim CHEBBOUR on 16/05/13.
//  Copyright (c) 2013 Karim CHEBBOUR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZBarSDK.h"

@interface SSScanViewController : UIViewController <ZBarReaderViewDelegate>

@property (nonatomic, strong) IBOutlet ZBarReaderView *readerView;
@property (nonatomic, strong) NSString *eanToSend;
- (IBAction)testButtonPressed:(id)sender;


@end
