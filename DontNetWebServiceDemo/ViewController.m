//
//  ViewController.m
//  DontNetWebServiceDemo
//
//  Created by Genie Technology on 21/04/16.
//  Copyright (c) 2016 Genie Soft Systems. All rights reserved.
//

#pragma mark-Library Installation

/*
 ...................Code Referd by This Site.........................
 
 http://highoncoding.com/Articles/809_Consuming__NET_Web_Services_in_an_iOS_Application.aspx
 
 ...................Import 3rd party library SBJSon and ASIHTTPRequest...................
 
 ///////// ................. See This Site Also.......... //////////
 
 http://www.monodevelop.com/
 
*/


#import "ViewController.h"
#import "ASIHTTPRequestConfig.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark- simple Hello World

/////////// A simple Hello World in .NET/////////
/*
 
 public class NotificationService : System.Web.Services.WebService
 
 {
 
 [WebMethod]
 
 public string HelloWorld()
 
 {
 
 return "Hello World";
 
 }
 }
 
*/

-(IBAction)submitButtonClicked:(id)sender
{
    
    NSURL *url = [NSURL URLWithString:@"http://127.0.0.1:8080/NotificationService.asmx/HelloWorld?"];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setRequestMethod:@"POST"];
    [request addRequestHeader:@"Content-Type" value:@"text/xml; charset=utf-8"];
    
    [request setDelegate:self];
    [request startAsynchronous];
}



#pragma mark-Web Method

/*
 [WebMethod]
 public string Greet(string deviceToken,string userName)
 {
    return deviceToken + ":" + userName;
 }
*/

-(IBAction)submit1ButtonClicked:(id)sender
{
    NSURL *url = [NSURL URLWithString:@"http://127.0.0.1:8080/NotificationService.asmx"];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setRequestMethod:@"POST"];
    [request addRequestHeader:@"Content-Type" value:@"text/xml; charset=utf-8"];
    [request addRequestHeader:@"SOAPAction" value:@"http://tempuri.org/HelloWorld"];
    
    
    NSString *soapMessage = [NSString stringWithFormat:
                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
                             
                             "<soap:Envelope
                                                 xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\"
                                                 xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\"
                                                 xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                             "<soap:Body>"
                             "<Greet xmlns=\"http://tempuri.org/\">"
                             "<deviceToken>some device token</deviceToken>"
                             "<userName>azamsharp</userName>"
                             "</Greet>"
                             "</soap:Body>"
                             "</soap:Envelope>"];
    
    NSString *messageLength = [NSString stringWithFormat:@"%lu",(unsigned long)[soapMessage length]];
    
    [request addRequestHeader:@"Content-Length" value:messageLength];
    
    [request appendPostData:[soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    
    [request setDelegate:self]; 
    [request startAsynchronous]; 
    
}

-(IBAction)submit2ButtonClicked:(id)sender
{
    
    
    NSURL *url = [NSURL URLWithString:@"http://127.0.0.1:8080/NotificationService.asmx/Greet"];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setRequestMethod:@"POST"];
    [request addRequestHeader:@"Content-Type" value:@"application/json"];
    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
                             
                             "<soap:Envelope
                                                 xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\"
                                                 xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\"
                                                 xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                             "<soap:Body>"
                             "<Greet xmlns=\"http://tempuri.org/\">"
                             "<deviceToken>some device token</deviceToken>"
                             "<userName>azamsharp</userName>"
                             "</Greet>"
                             "</soap:Body>"
                             "</soap:Envelope>"];
    NSString *messageLength = [NSString stringWithFormat:@"%lu",(unsigned long)[soapMessage length]];
    
    [request setPostValue:@"device token" forKey:@"deviceToken"];
    [request setPostValue:@"azamsharp" forKey:@"userName"];
    
    [request setDelegate:self];
    [request startAsynchronous];
}

#pragma mark-JSON Generic Handler
/*
 public class HighHandler : System.Web.IHttpHandler
{
 
    public virtual bool IsReusable
        {
            get
                {
                    return false;
                }
        }
 
 public virtual void ProcessRequest(HttpContext context)
    {
        var zombie = new Zombie() {Name = "John Doe"};
        var json = new JavaScriptSerializer();
        context.Response.Write(json.Serialize(zombie));
    }
}
*/

-(IBAction)submit3ButtonClicked:(id)sender
{
    
    NSURL *url = [NSURL URLWithString:@"http://www.highoncoding.com/highhandler.ashx"];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setRequestMethod:@"GET"];
    [request addRequestHeader:@"Content-Type" value:@"application/json"];
    
    NSString *soapMessage = [NSString stringWithFormat:
                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
                             
                             "<soap:Envelope
                                                 xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\"
                                                 xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\"
                                                 xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                             "<soap:Body>"
                             "<Greet xmlns=\"http://tempuri.org/\">"
                             "<deviceToken>some device token</deviceToken>"
                             "<userName>azamsharp</userName>"
                             "</Greet>"
                             "</soap:Body>"
                             "</soap:Envelope>"];
    
    NSString *messageLength = [NSString stringWithFormat:@"%lu",(unsigned long)[soapMessage length]];
    
    [request setDelegate:self];
    [request startAsynchronous];
    
    
}

#pragma mark-Using JSONO bject

/*
 public void ProcessRequest(HttpContext context)
 {
 var zombies = new List<Zombie>()
 {
 new Zombie() { Name = "John Doe",NoOfKills = 5},
 new Zombie() { Name = "Mary Kate", NoOfKills = 10},
 new Zombie() { Name = "Alex Lowe", NoOfKills = 2}
 };
 
 var zombie = new Zombie() {Name = "John Doe"};
 var json = new JavaScriptSerializer();
 
 
 context.Response.Write(json.Serialize(zombies));
 }
 */

-(IBAction)submit4ButtonClicked:(id)sender
{
    NSURL *url = [NSURL URLWithString:@"http://www.highoncoding.com/highhandler.ashx"];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setRequestMethod:@"GET"];
    [request addRequestHeader:@"Content-Type" value:@"application/json"];
    
    NSString *soapMessage = [NSString stringWithFormat:
                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
                             
                             "<soap:Envelope
                                                 xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\"
                                                 xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\"
                                                 xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                             "<soap:Body>"
                             "<Greet xmlns=\"http://tempuri.org/\">"
                             "<deviceToken>some device token</deviceToken>"
                             "<userName>azamsharp</userName>"
                             "</Greet>"
                             "</soap:Body>"
                             "</soap:Envelope>"];
    
    NSString *messageLength = [NSString stringWithFormat:@"%lu",(unsigned long)[soapMessage length]];
    
    [request setDelegate:self];
    [request startAsynchronous];
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    NSLog(@"status code %d",request.responseStatusCode);
    
    if(request.responseStatusCode == 200)
    {
        NSLog(@"success");
        NSString *responseString = [request responseString];
        NSLog(@"%@",responseString);
    }
    
    NSLog(@"request finished");
    NSLog(@"status code %d",request.responseStatusCode);
    
    if(request.responseStatusCode == 200)
    {
        NSLog(@"success");
        NSString *responseString = [request responseString];
        NSDictionary *dict = [responseString JSONValue];
        
        
        NSLog(@"%@",[dict valueForKey:@"Name"]);
    }
    
    NSLog(@"request finished");
    
    NSLog(@"status code %d",request.responseStatusCode);
    
    if(request.responseStatusCode == 200)
    {
        NSLog(@"success");
        NSString *responseString = [request responseString];
        NSArray *list = [responseString JSONValue];
        
        // iterate through the dict and populate the model
        
        for(NSDictionary *item in list)
        {
            Zombie *zombie = [[Zombie alloc] init];
            zombie.name = [item valueForKey:@"Name"];
            
            [self.zombies addObject:zombie];
        }
        
        
    }
    
    [zombieTableView reloadData];
    [zombieTableView setNeedsDisplay];
    
    NSLog(@"request finished");
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSError *error = [request error];
    NSLog(@"%@",error.localizedDescription);
    
    
}


@end
