//  Copyright (c) 2013 Alexander Perepelitsyn. All rights reserved.

#import <SenTestingKit/SenTestingKit.h>
#import "ViewController.h"
#import "FakeNotificationCenter.h"

@interface ViewControllerTests : SenTestCase
{
    ViewController *sut;
    FakeNotificationCenter *fakeNotificationCenter;
}
@end

@implementation ViewControllerTests

#pragma mark - setUp/tearDown

- (void)setUp
{
    [super setUp];
    
    sut = [[ViewController alloc] init];
    fakeNotificationCenter = [[FakeNotificationCenter alloc] init];
}

- (void)tearDown
{
    sut = nil;
    fakeNotificationCenter = nil;
    
    [super tearDown];
}

#pragma mark - IBOutlets

- (void)testCurrentCountLabelIsConnected
{
    // ACT
    [sut view];
    
    // ASSERT
    STAssertNotNil([sut currentCountLabel], @"");
}

- (void)testSavedCountLabelIsConnected
{
    // ACT
    [sut view];
    
    // ASSERT
    STAssertNotNil([sut savedCountLabel], @"");
}

- (void)testPlusButtonIsConnected
{
    // ACT
    [sut view];
    
    // ASSERT
    STAssertNotNil([sut plusButton], @"");
}

- (void)testMinusButtonIsConnected
{
    // ACT
    [sut view];
    
    // ASSERT
}

- (void)testSaveButtonIsConnected
{
    // ACT
    
    // ASSERT
    
}

- (void)testResetButtonIsConnected
{
    // ACT
    
    // ASSERT

}

#pragma mark - IBActions

- (void)testPlusButtonAction
{
    // ACT
    [sut view];
    
    // ASSERT
    STAssertTrue([[[sut plusButton] actionsForTarget:sut forControlEvent:UIControlEventTouchUpInside] containsObject:@"incrementCount:"], @"");
}

- (void)testMinusButtonAction
{
    // ACT
    [sut view];
    
    // ASSERT
    STAssertTrue([[[sut minusButton] actionsForTarget:sut forControlEvent:UIControlEventTouchUpInside] containsObject:@"decrementCount:"], @"");
}

- (void)testSaveButtonAction
{
    // ACT
    [sut view];
    
    // ASSERT

}

- (void)testResetButtonAction
{
    // ACT
    
    // ASSERT

}

- (void)testIncrementCountAddsOneToCountLabel
{
    // ARRANGE
    [sut view];
    
    // ACT
    [sut incrementCount:nil];
    
    // ASSERT
    STAssertEqualObjects([[sut currentCountLabel] text], @"1", @"");
}

- (void)testIncrementCountTwiceAddsTwoToCountLabel
{
    // ARRANGE

    
    // ACT
    
    // ASSERT

}

- (void)testDecrementCountSubstractsOneFromCountLabel
{
    // ARRANGE
    
    // ACT
    
    // ASSERT
    STAssertEqualObjects([[sut currentCountLabel] text], @"-1", @"");
}

- (void)testDecrementCountTwiceSubstractsTwoFromCountLabel
{
    // ARRANGE
    
    // ACT
    
    // ASSERT

}

#pragma mark - View Lifecycle

- (void)testViewUnloading {
    [sut view];
    STAssertNotNil([sut view], @"");
    
    [sut didReceiveMemoryWarning];
    // Note that while sut.view is nil here we cannot test that directly as accessing view will trigger a call to loadView. Instead use outlets or -isViewLoaded.
    STAssertNil([sut currentCountLabel], @"");
    STAssertFalse([sut isViewLoaded], @"");
    
    [sut view];
    STAssertNotNil([sut view], @"");
    STAssertTrue([sut isViewLoaded], @"");
}

- (void)testVCStartsObservingDummyNotificationInViewDidLoad1 // LISTEN
{
    // ARRANGE
    id mockNotificationCenter = [OCMockObject mockForClass:[NSNotificationCenter class]];
    [[mockNotificationCenter expect] addObserver:sut selector:@selector(onSave:) name:kDummyNotification object:[OCMArg isNil]];
    [sut setNotificationCenter:mockNotificationCenter];
    
    // ACT
    
    // ASSERT
    [mockNotificationCenter verify];
    
    // TEARDOWN
    sut.notificationCenter = nil;
}

#pragma mark - Notifications

- (void)testVCStartsObservingDummyNotificationInViewDidLoad2 // LISTEN
{
    // ACT
    [sut setNotificationCenter:fakeNotificationCenter];
    [sut viewDidLoad];
    
    // ASSERT

}

- (void)testSaveCountPostsDummyNotification // GENERATE
{
    // ARRANGE
    id mockNotificationCenter = [OCMockObject mockForClass:[NSNotificationCenter class]];
    
    // ACT
    
    // ASSERT
    [mockNotificationCenter verify];
    
    // TEARDOWN
    sut.notificationCenter = nil;
}

- (void)testThatDummyNotificationHandlerGetsCalled // REACT/GENERATE
{
    // ARRANGE


    [mockSut viewDidLoad]; // Invokes -addObserver:selector:name:object:
    
    // ACT
    [[NSNotificationCenter defaultCenter] postNotificationName:kDummyNotification object:nil];
    
    // ASSERT
    [mockSut verify];
}

- (void)testDummyNotificationHandlerDoesItsJob // REACT
{
    // ARRANGE
    id notificationMock = [OCMockObject mockForClass:[NSNotification class]];
    [[[notificationMock stub] andReturn:@11] object];
    id labelMock = [OCMockObject mockForClass:[UILabel class]];
    [[labelMock expect] setText:@"11"];
    [sut setSavedCountLabel:labelMock];
    
    // ACT
    
    // ASSERT

}

#pragma mark - NSUserDefaults

- (void)testCountValueIsLoadedFromUserDefaults
{
    // ARRANGE
    id mockDefaults = [OCMockObject mockForClass:[NSUserDefaults class]];
    [[[mockDefaults stub] andReturn:@8] objectForKey:@"countValue"];
    [sut setUserDefaults:mockDefaults];
    
    // ACT
    
    // ASSERT

}

- (void)testInitialCurrentCountValueLabelIsZero
{
    // ARRANGE
    id mockDefaults = [OCMockObject mockForClass:[NSUserDefaults class]];
    [[[mockDefaults stub] andReturn:nil] objectForKey:@"countValue"];
    [sut setUserDefaults:mockDefaults];
    
    // ACT
    [sut view]; // [self view] -> [self loadView] -> [vc viewDidLoad]
    
    // ASSERT
    STAssertEqualObjects([[sut currentCountLabel] text], @"0", @"");
}

- (void)testInitialSavedCountValueLabelIsDash
{
    // ARRANGE
    id mockDefaults = [OCMockObject mockForClass:[NSUserDefaults class]];

    
    // ACT
    [sut view]; // [self view] -> [self loadView] -> [vc viewDidLoad]
    
    // ASSERT
    STAssertEqualObjects([[sut savedCountLabel] text], @"-", @"");
}

- (void)testSaveCountButtonSavesCountValueToUserDefaults
{
    // ARRANGE
    
    // ACT
    [sut saveCount:nil];
    
    // ASSERT

}

@end
