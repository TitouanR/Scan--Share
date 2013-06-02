//
//  SSButtonSubViewProtocol.h
//  Scan&Share
//
//  Created by Titouan Rossier on 31/05/13.
//  Copyright (c) 2013 Karim CHEBBOUR. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SSButtonSubViewProtocol <NSObject>
 -(void)buttonClicked:(UIButton*)button inView:(UIView*)view;
@end
