//
//  CDAMarkdownViewController.m
//  ContentfulSDK
//
//  Created by Boris Bügling on 17/03/14.
//
//

#import <Bypass/Bypass.h>

#import "CDAMarkdownViewController.h"

@interface CDAMarkdownViewController ()

@property (nonatomic) UITextView* textView;

@end

#pragma mark -

@implementation CDAMarkdownViewController

-(void)setMarkdownText:(NSString *)markdownText {
    _markdownText = markdownText;
    
    BPDocument* document = [[BPParser new] parse:markdownText];
    BPAttributedStringConverter* converter = [BPAttributedStringConverter new];
    converter.displaySettings.quoteFont = [UIFont fontWithName:@"Marion-Italic"
                                                          size:[UIFont systemFontSize] + 1.0f];
    NSAttributedString* attributedText = [converter convertDocument:document];
    
    self.textView.attributedText = attributedText;
}

-(void)viewDidLoad {
    [super viewDidLoad];
    
    self.textView = [[UITextView alloc] initWithFrame:self.view.bounds];
    self.textView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.textView.editable = NO;
    self.textView.font = [UIFont systemFontOfSize:18.0];
    if ([self.textView respondsToSelector:@selector(textContainerInset)]) {
        self.textView.textContainerInset = UIEdgeInsetsMake(20.0, 10.0, 10.0, 20.0);
    }
    [self.view addSubview:self.textView];
    
    [self setMarkdownText:self.markdownText];
}

@end
