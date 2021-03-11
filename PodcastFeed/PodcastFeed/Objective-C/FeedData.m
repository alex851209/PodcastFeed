//
//  FeedData.m
//  PodcastFeed
//
//  Created by shuo on 2021/3/11.
//

#import "FeedData.h"

@implementation Episode
@synthesize title, content, pubDate, imageURL, mediaURL;
@end

@implementation Channel
@synthesize episodes, imageURL;
@end
