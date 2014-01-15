//
//  RSSVieiMasterViewController.m
//  viei_A5
//
//  Created by Vieira Jason 070569870 on 2/23/13.
//  Copyright (c) 2013 Jason Vieira. All rights reserved.
//

#import "CBCNewsFeed.h"
#import "CBCDetailView.h"
#import "RSSVieiChannel.h"
#import "RSSVieiItem.h"

/*
@interface CBCNewsFeed() {
    NSMutableArray *_objects;
}
@end
*/
@implementation CBCNewsFeed
- (void)awakeFromNib
{
    [super awakeFromNib];
    [self fetchEntries];
    
}

  
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    //self.title = @"CBC News Feed";
    [[self navigationItem] setRightBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray] ] animated:YES];
     
}

- (IBAction)done:(UIStoryboardSegue *)segue
{
    
    if ([[segue identifier] isEqualToString:@"CBCReturn"]) {
        [self dismissViewControllerAnimated:YES completion:NULL];
    }
    
}

- (IBAction)refreshFeed:(id)sender {
    [self fetchEntries];
}

- (void)fetchEntries
{
    // Create a new data container for the stuff that comes back from the service
    xmlData = [[NSMutableData alloc] init];
    // Construct a URL that will ask the service for what you want -
    // note we can concatenate literal strings together on multiple
    // lines in this way - this results in a single NSString instance
    NSURL *url = [NSURL URLWithString: @"http://rss.cbc.ca/lineup/topstories.xml"];
    // For Apple's Hot News feed, replace the line above with
    // NSURL *url = [NSURL URLWithString:@"http://www.apple.com/pr/feeds/pr.rss"];
    // Put that URL into an NSURLRequest
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    // Create a connection that will exchange this request for data from the URL
    connection = [[NSURLConnection alloc] initWithRequest:req delegate:self startImmediately:YES];
}

// This method will be called several times as the data arrives
- (void)connection:(NSURLConnection *)conn didReceiveData:(NSData *)data
{
    // Add the incoming chunk of data to the container we are keeping
    // The data always comes in the correct order
    [xmlData appendData:data];
}
- (void)connectionDidFinishLoading:(NSURLConnection *)conn
{
    // Create the parser object with the data received from the web service
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:xmlData];
    // Give it a delegate
	[parser setDelegate:self];
    // Tell it to start parsing - the document will be parsed and
    // the delegate of NSXMLParser will get all of its delegate messages
    // sent to it before this line finishes execution - it is blocking
    [parser parse];
    // The parser is done (it blocks until done), you can release it immediately
    
    // Print the dictionary NSLog(@"%@", xmlDictionary);
    xmlData = nil;
    // Get rid of the connection, no longer need it
    connection = nil;
    // Reload the table.. for now, the table will be empty.
    [[self tableView] reloadData];
    //NSLog(@"channel %@\n title %@\n desc %@\n", channel, [channel title], [channel shortDescription]);
}

- (void)connection:(NSURLConnection *)conn
  didFailWithError:(NSError *)error
{
    // Release the connection object, we're done with it
    //[connection release];
    connection = nil;
    // Release the xmlData object, we're done with it
    xmlData = nil;
    // Grab the description of the error object passed to us
    NSString *errorString = [NSString stringWithFormat:@"Fetch failed: %@", [error localizedDescription]];
    // Create and show an alert view with this error displayed
    UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Error"message:errorString delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [av show];
}

- (void)parser:(NSXMLParser *)parser
didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qualifiedName
    attributes:(NSDictionary *)attributeDict
{
    //NSLog(@"%@ found a %@ element", self, elementName);
    if ([elementName isEqual:@"channel"]) {
        // If the parser saw a channel, create new instance, store in our ivar
        channel = [[RSSVieiChannel alloc] init];
        // Give the channel object a pointer back to ourselves for later
        [channel setParentParserDelegate:self];
        // Set the parser's delegate to the channel object
        [parser setDelegate:channel];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table View

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[channel items] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"1"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    }
    RSSVieiItem *item = [[channel items] objectAtIndex:[indexPath row]];
    [[cell textLabel] setText:[item title]];
    
    dispatch_queue_t downloadQueue = dispatch_queue_create("ImageDownload", NULL);
    dispatch_async(downloadQueue, ^{
        
        NSCharacterSet *quoteSet = [NSCharacterSet characterSetWithCharactersInString:@"\""];
        
        NSString *imgSource=@"src=\"";
        
        NSString *imageURL;
                
        NSString *input = item.description;
        //NSLog(@"%@", input);
        
        NSScanner *theScanner = [NSScanner scannerWithString:input];

        [theScanner scanUpToString:imgSource intoString:NULL];
        [theScanner scanString:imgSource intoString:NULL];

        
        [theScanner scanUpToCharactersFromSet:quoteSet intoString:&imageURL];
        NSURL *imageLink = [NSURL URLWithString:imageURL];
        NSData *imageData = [NSData dataWithContentsOfURL:imageLink];
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [[cell imageView] setImage:[UIImage imageWithData:imageData]];
            [cell setNeedsLayout];
        });// main queue
    });//async

    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return NO;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{

    if ([[segue identifier] isEqualToString:@"pushCBCArticle"]) {
        //NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        //NSDate *object = _objects[indexPath.row];
        //[[segue destinationViewController] setDetailItem:object];
        CBCDetailView *detailViewController = [segue destinationViewController];
        detailViewController.item = [channel.items objectAtIndex:[self.tableView indexPathForSelectedRow].row];
    }
}

@end
