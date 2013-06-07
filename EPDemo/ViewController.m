//  Copyright (c) 2013 Alexander Perepelitsyn. All rights reserved.

#import "ViewController.h"

NSString * const kDummyNotification = @"DummyNotification";

@interface ViewController ()

@property (nonatomic, assign) NSInteger count;

- (void)onSave:(NSNotification *)notif;

@end

@implementation ViewController

- (id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSNumber *countNumber = [[NSUserDefaults standardUserDefaults] objectForKey:@"countValue"];
    if (countNumber) {
        self.savedCountLabel.text = [NSString stringWithFormat:@"%i", [countNumber integerValue]];
    } else {
        self.savedCountLabel.text = @"-";
    }
    
    _count = [countNumber integerValue];
    
    self.currentCountLabel.text = [NSString stringWithFormat:@"%i", _count];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onSave:) name:kDummyNotification object:nil];
}

- (void)onSave:(NSNotification *)notif
{
    self.savedCountLabel.text = [NSString stringWithFormat:@"%i", [[notif object] integerValue]];
}

- (IBAction)incrementCount:(id)sender
{
    _count++;
    [self.currentCountLabel setText:[NSString stringWithFormat:@"%i", _count]];
}

- (IBAction)decrementCount:(id)sender
{
    _count--;
    [self.currentCountLabel setText:[NSString stringWithFormat:@"%i", _count]];
}

- (IBAction)saveCount:(id)sender;
{
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:self.count] forKey:@"countValue"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [[NSNotificationCenter defaultCenter] postNotificationName:kDummyNotification object:[NSNumber numberWithInt:_count]];
}

- (IBAction)resetCount:(id)sender
{
    _count = 0;
    [self.currentCountLabel setText:[NSString stringWithFormat:@"%i", _count]];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    self.currentCountLabel = nil;
    self.plusButton = nil;
    self.minusButton = nil;
    
    if ([self isViewLoaded] && self.view.window == nil) {
        self.view = nil;
    }
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
