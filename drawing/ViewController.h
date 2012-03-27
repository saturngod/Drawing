//
//  ViewController.h
//  drawing
//
//  Created by Htain Lin Shwe on 27/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface ViewController : UIViewController
@property(nonatomic,retain) IBOutlet UIImageView *imageView;
@property(nonatomic,retain) IBOutlet UISegmentedControl *colorSegment;
@property(nonatomic,retain) IBOutlet UISegmentedControl *drawingSegment;
@property(nonatomic,retain) IBOutlet UISegmentedControl *sizeSegment;

-(IBAction)clear:(id)sender;
@end
