//
//  WebViewController.m
//  Ajoulife
//
//  Created by  on 13. 5. 25..
//  Copyright (c) 2013년 __MyCompanyName__. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController

@synthesize ajouWebView;
@synthesize ajouNotice;
@synthesize ajouQuestion;



- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
   
    // 교내식당
    NSURL *url=[NSURL URLWithString:@"http://www.ajou.ac.kr/kr/life/food.jsp"];
    //http://www.ajou.ac.kr/kr/life/food.jsp
    //http://byuldang.ajou.ac.kr/mobile/M08/M08_050.es
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    [ajouWebView setScalesPageToFit:YES];
    [ajouWebView loadRequest:request];
    
    // 공지사항
    NSURL *urlNotice=[NSURL URLWithString:@"http://wo.to/board/board.php?id=a.3.phantazia"];
    NSURLRequest *requestNotice=[NSURLRequest requestWithURL:urlNotice];
    [ajouNotice setScalesPageToFit:NO];
    [ajouNotice loadRequest:requestNotice];
    
    //건의사항
    NSURL *urlQuestion=[NSURL URLWithString:@"http://wo.to/board/board.php?id=a.2.phantazia"];
    NSURLRequest *requestQuestion=[NSURLRequest requestWithURL:urlQuestion];
    [ajouQuestion setScalesPageToFit:NO];
    [ajouQuestion loadRequest:requestQuestion];
    
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewDidUnload {
    [self setAjouWebView:nil];
    [self setAjouNotice:nil];
    [self setAjouQuestion:nil];
    [super viewDidUnload];
}


@end
