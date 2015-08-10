//
//  ViewController.m
//  PlayingWithGyrosAndAccelerometers
//
//  Created by Michael Vilabrera on 8/10/15.
//  Copyright (c) 2015 Giving Tree. All rights reserved.
//

#import "ViewController.h"
#import <CoreMotion/CoreMotion.h>

double currentMaxAccelX;
double currentMaxAccelY;
double currentMaxAccelZ;
double currentMaxRotX;
double currentMaxRotY;
double currentMaxRotZ;

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *accX;
@property (weak, nonatomic) IBOutlet UILabel *accY;
@property (weak, nonatomic) IBOutlet UILabel *accZ;

@property (weak, nonatomic) IBOutlet UILabel *maxAccX;
@property (weak, nonatomic) IBOutlet UILabel *maxAccY;
@property (weak, nonatomic) IBOutlet UILabel *maxAccZ;

@property (weak, nonatomic) IBOutlet UILabel *rotX;
@property (weak, nonatomic) IBOutlet UILabel *rotY;
@property (weak, nonatomic) IBOutlet UILabel *rotZ;

@property (weak, nonatomic) IBOutlet UILabel *maxRotX;
@property (weak, nonatomic) IBOutlet UILabel *maxRotY;
@property (weak, nonatomic) IBOutlet UILabel *maxRotZ;

@property (nonatomic) CMMotionManager *motionManager;

- (IBAction)reset:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    currentMaxAccelX = 0;
    currentMaxAccelY = 0;
    currentMaxAccelZ = 0;
    
    currentMaxRotX = 0;
    currentMaxRotY = 0;
    currentMaxRotZ = 0;
    
    self.motionManager = [[CMMotionManager alloc] init];
    self.motionManager.accelerometerUpdateInterval = .2;
    self.motionManager.gyroUpdateInterval = .2;
    
    [self.motionManager startAccelerometerUpdatesToQueue:[NSOperationQueue currentQueue] withHandler:^(CMAccelerometerData *accelerometerData, NSError *error) {
        [self outputAccelertionData:accelerometerData.acceleration];
        if (error) {
            NSLog(@"%@", error);
        }
    }];
    
    [self.motionManager startGyroUpdatesToQueue:[NSOperationQueue currentQueue] withHandler:^(CMGyroData *gyroData, NSError *error) {
        [self outputRotationData:gyroData.rotationRate];
        }];
}

- (void)outputAccelertionData:(CMAcceleration)acceleration {
    self.accX.text = [NSString stringWithFormat:@"Acceleration In X: %.2fg", acceleration.x];
    if (fabs(acceleration.x) > fabs(currentMaxAccelX)) {
        currentMaxAccelX = acceleration.x;
    }
    self.accY.text = [NSString stringWithFormat:@"Acceleration In Y: %.2fg", acceleration.y];
    if (fabs(acceleration.y) > fabs(currentMaxAccelY)) {
        currentMaxAccelY = acceleration.y;
    }
    self.accZ.text = [NSString stringWithFormat:@"Acceleration In Z: %.2fg", acceleration.z];
    if (fabs(acceleration.z) > fabs(currentMaxAccelZ)) {
        currentMaxAccelZ = acceleration.z;
    }
    
    self.maxAccX.text = [NSString stringWithFormat:@"Max Acceleration in X: %.2fg", currentMaxAccelX];
    self.maxAccY.text = [NSString stringWithFormat:@"Max Acceleration in Y: %.2fg", currentMaxAccelY];
    self.maxAccZ.text = [NSString stringWithFormat:@"Max Acceleration in Z: %.2fg", currentMaxAccelZ];
}

- (void)outputRotationData:(CMRotationRate)rotation {
    self.rotX.text = [NSString stringWithFormat:@"Rotation About X: %.2fr/s", rotation.x];
    if (fabs(rotation.x) > fabs(currentMaxRotX)) {
        currentMaxRotX = rotation.x;
    }
    self.rotY.text = [NSString stringWithFormat:@"Rotation About Y: %.2fr/s", rotation.y];
    if (fabs(rotation.y) > fabs(currentMaxRotY)) {
        currentMaxRotY = rotation.y;
    }
    self.rotZ.text = [NSString stringWithFormat:@"Rotation About Z: %.2fr/s", rotation.z];
    if (fabs(rotation.z) > fabs(currentMaxRotZ)) {
        currentMaxRotZ = rotation.z;
    }
    
    self.maxRotX.text = [NSString stringWithFormat:@"Max Rotation About X: %.2f", currentMaxRotX];
    self.maxRotY.text = [NSString stringWithFormat:@"Max Rotation About Y: %.2f", currentMaxRotY];
    self.maxRotZ.text = [NSString stringWithFormat:@"Max Rotation About Z: %.2f", currentMaxRotZ];
}

- (IBAction)reset:(id)sender {
    currentMaxAccelX = 0;
    currentMaxAccelY = 0;
    currentMaxAccelZ = 0;
    
    currentMaxRotX = 0;
    currentMaxRotY = 0;
    currentMaxRotZ = 0;
}
@end
