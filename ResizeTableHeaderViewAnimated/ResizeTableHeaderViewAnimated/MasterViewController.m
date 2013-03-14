//
//  MasterViewController.m
//

#import "MasterViewController.h"

@interface MasterViewController()

@property (strong, nonatomic) IBOutlet UIView *headerView;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *removeHeaderButton;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *addHeaderButton;
@property (strong, nonatomic) IBOutlet UISwitch *animatedSwitch;
@property (readonly) BOOL isHeaderShown;
@property CGRect initialFrame;

@end

@implementation MasterViewController

#pragma mark - View lifecycle

- (void)viewDidLoad{
    [super viewDidLoad];
    self.initialFrame = self.headerView.frame;
    
    // Initially hide the header
    [self showHeader:NO animated:NO];
}

#pragma mark - Actions

- (IBAction)addHeaderTouched:(id)sender {
    [self showHeader:YES animated:self.animatedSwitch.on];
}

- (IBAction)removeHeaderTouched:(id)sender {
    [self showHeader:NO animated:self.animatedSwitch.on];
}

#pragma mark - Helpers

- (void) showHeader:(BOOL)show animated:(BOOL)animated{
    
    CGRect closedFrame = CGRectMake(0, 0, self.view.frame.size.width, 0);
    CGRect newFrame = show?self.initialFrame:closedFrame;
    
    if(animated){
        // The UIView animation block handles the animation of our header view
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.3];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        
        // beginUpdates and endUpdates trigger the animation of our cells
        [self.tableView beginUpdates];
    }
    
    self.headerView.frame = newFrame;
    [self.tableView setTableHeaderView:self.headerView];
    
    if(animated){
        [self.tableView endUpdates];
        [UIView commitAnimations];
    }

    self.navigationItem.rightBarButtonItem = self.isHeaderShown?self.removeHeaderButton:self.addHeaderButton;
}

#pragma mark - Getters

- (BOOL)isHeaderShown{
    return self.headerView.frame.size.height > 0;
}

@end
