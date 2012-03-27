//
//  ViewController.m
//  drawing
//  original drawing author kyoji
//  base on http://stackoverflow.com/questions/5076622/iphone-smooth-sketch-drawing-algorithm
//
//  Created by Htain Lin Shwe on 27/3/12.
//


#import "ViewController.h"
#import <CoreGraphics/CoreGraphics.h>

enum {
  Red_Color = 0,
  Green_Color = 1,
  Blue_Color = 2
};

enum {
  draw_brush = 0,
  erase_brush = 1
};

enum {
  small_size = 0,
  middle_size = 1,
  large_size = 2
};

@interface ViewController ()
@property (nonatomic,assign) CGPoint previousPoint1;
@property (nonatomic,assign) CGPoint previousPoint2;
@property (nonatomic,assign) CGPoint currentPoint;

CGPoint midPoint(CGPoint p1, CGPoint p2);

@end

@implementation ViewController
@synthesize previousPoint1;
@synthesize previousPoint2;
@synthesize currentPoint;
@synthesize imageView;
@synthesize colorSegment;
@synthesize drawingSegment;
@synthesize sizeSegment;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
  return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}


-(IBAction)clear:(id)sender {
  self.imageView.image = nil;
}
#pragma mark - Drawing
CGPoint midPoint(CGPoint p1, CGPoint p2)
{
  
  return CGPointMake((p1.x + p2.x) * 0.5, (p1.y + p2.y) * 0.5);
  
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
  
  NSLog(@"Touch Began");
  UITouch *touch = [touches anyObject];
  
  previousPoint1 = [touch previousLocationInView:self.view];
  previousPoint2 = [touch previousLocationInView:self.view];
  currentPoint = [touch locationInView:self.view];
  
  //touch and draw circle , for feel real drawing
  [self touchesMoved:touches withEvent:event];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
  
  NSLog(@"Touch Move");
  
  UITouch *touch = [touches anyObject];
  
  previousPoint2 = previousPoint1;
  previousPoint1 = [touch previousLocationInView:self.view];
  currentPoint = [touch locationInView:self.view];
  
  
  // calculate mid point
  CGPoint mid1 = midPoint(previousPoint1, previousPoint2); 
  CGPoint mid2 = midPoint(currentPoint, previousPoint1);
  
  UIGraphicsBeginImageContext(self.imageView.frame.size);
  CGContextRef context = UIGraphicsGetCurrentContext();

  
  [self.imageView.image drawInRect:CGRectMake(0, 0, self.imageView.frame.size.width, self.imageView.frame.size.height)];

  
  CGContextMoveToPoint(context, mid1.x, mid1.y);
  
  // Use QuadCurve is the key
  CGContextAddQuadCurveToPoint(context, previousPoint1.x, previousPoint1.y, mid2.x, mid2.y); 
  
  CGContextSetLineCap(context, kCGLineCapRound);

  
  //make a strok color
  if(colorSegment.selectedSegmentIndex== Red_Color)
  {
      CGContextSetRGBStrokeColor(context, 1.0, 0.0, 0.0, 1.0);
  }
  else if(colorSegment.selectedSegmentIndex == Green_Color)
  {
      CGContextSetRGBStrokeColor(context, 0.0, 1.0, 0.0, 1.0);
  }
  else if (colorSegment.selectedSegmentIndex == Blue_Color)
  {
      CGContextSetRGBStrokeColor(context, 0.0, 0.0, 1.0, 1.0);
  }
  
  //this is for erase
  if(drawingSegment.selectedSegmentIndex == erase_brush)
  {
    CGContextSetBlendMode(context,kCGBlendModeClear);
   
  }
  else {
    
    CGContextSetBlendMode(context,kCGBlendModeColor);
    
    
  }
  
  
  //size of stroke
  if(sizeSegment.selectedSegmentIndex ==small_size)
  {
    CGContextSetLineWidth(context, 2.0);
  }
  else if (sizeSegment.selectedSegmentIndex == middle_size)
  {
     CGContextSetLineWidth(context, 5.0);
  }
  else if (sizeSegment.selectedSegmentIndex == large_size)
  {
    CGContextSetLineWidth(context, 10.0);
  }
  
  CGContextStrokePath(context);
  
  self.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
  
  UIGraphicsEndImageContext();
  
  
}


@end
