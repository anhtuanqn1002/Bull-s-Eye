//
//  ViewController.m
//  BullsEye
//
//  Created by Nguyen Van Anh Tuan on 10/29/15.
//  Copyright © 2015 Nguyen Van Anh Tuan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *targetLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *roundLabel;

@end

@implementation ViewController{
    int _currentValue;
    int _targetValue;
    int _score;
    int _round;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIImage* thumbImageNormal = [UIImage imageNamed:@"SliderThumb-Normal"];
    [self.slider setThumbImage:thumbImageNormal forState:UIControlStateNormal];
    
    UIImage* thumbImageHighlighted = [UIImage imageNamed:@"SliderThumb-Highlighted"];
    [self.slider setThumbImage:thumbImageHighlighted forState:UIControlStateHighlighted];
    
    UIImage* trackLeftImage = [[UIImage imageNamed:@"SliderTrackLeft"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 14, 0, 14)];
    [self.slider setMinimumTrackImage:trackLeftImage forState:UIControlStateNormal];
    
    UIImage* trackRightImage = [[UIImage imageNamed:@"SliderTrackRight"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 14, 0, 14)];
    [self.slider setMaximumTrackImage:trackRightImage forState:UIControlStateNormal];
    
    
    
    [self startNewGame];
    [self updateLabels];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)showAlert{
    int difference = abs(_currentValue - _targetValue);
    int points = 100 - difference;
    _score += points;
    
    NSString * title;
    if (difference == 0){
        title = @"Perfect!";
        points+=100;
    }else if (difference < 5){
        title = @"You almost had it!";
        if (difference == 1){
            points+= 50;
        }
    }else if (difference < 10){
        title = @"Pretty good!";
    }else{
        title = @"Not even close...";
    }
    
    _score += points;
    NSString *message = [NSString stringWithFormat:@"Your scored %d points",points];
    
    UIAlertView * alertView = [[UIAlertView alloc]
                               initWithTitle: title
                               message: message
                               delegate: self
                               cancelButtonTitle:@"OK"
                               otherButtonTitles:nil];
    [alertView show];
    
}
-(IBAction)sliderMoved:(UISlider*)slider{
    _currentValue = (int)lround(slider.value);
}

-(void)startNewRound{
    _round += 1;
    _targetValue = 1 + arc4random_uniform(100);
    _currentValue = 50;
    self.slider.value = _currentValue;
}

-(void)updateLabels{
    self.targetLabel.text = [NSString stringWithFormat:@"%i", _targetValue];
    self.scoreLabel.text = [NSString stringWithFormat:@"%i", _score];
    self.roundLabel.text = [NSString stringWithFormat:@"%i", _round];
}

-(void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex{
    [self startNewRound];
    [self updateLabels];
}

- (void)startNewGame {
    _score = 0;
    _round = 0;
    [self startNewRound];
}

- (IBAction)startOver:(id)sender {
    CATransition *transition = [CATransition animation];
    transition.type = kCATransitionFade;
    transition.duration = 1;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    
    [self startNewGame];
    [self updateLabels];
    
    [self.view.layer addAnimation:transition forKey:nil];
}

-(BOOL)prefersStatusBarHidden{
    return YES;
}

@end
