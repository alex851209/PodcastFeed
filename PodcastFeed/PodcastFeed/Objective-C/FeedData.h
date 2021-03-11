//
//  FeedData.h
//  PodcastFeed
//
//  Created by shuo on 2021/3/11.
//

#ifndef FeedData_h
#define FeedData_h

#import <Foundation/Foundation.h>

@protocol Episode
@end

@interface Episode: NSObject

@property (nonatomic, copy)NSString *title;
@property (nonatomic, copy)NSString *content;
@property (nonatomic, copy)NSString *imageURL;
@property (nonatomic, copy)NSString *mediaURL;
@property (nonatomic, copy)NSString *pubDate;

@end

@interface Channel: NSObject

@property (nonatomic, copy)NSString *imageURL;
@property (nonatomic)NSArray<Episode> *episodes;

@end

#endif /* FeedData_h */
