//
//  FeedParser.m
//  May10
//
//  Created by Georges Labreche on 5/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FeedParser.h"

@implementation FeedParser

@synthesize includeMovieNews;
@synthesize includeTvNews;
@synthesize includeMusicNews;
@synthesize includeArtNews;
@synthesize includeBooksNews;
@synthesize includeIndustryNews;
@synthesize includeClickablesNews;

-(id) init{
    self = [super init];
    
    if(self){
        // We use this url to determing what catebory the entry we are parsoing belong to.
        // This urls aren't used for retrieving data.
        moviesUrlString = @"http://www.vulture.com/news/movies";
        tvUrlString = @"http://www.vulture.com/news/tv";
        musicUrlString = @"http://www.vulture.com/news/music";
        artUrlString = @"http://www.vulture.com/news/art";
        booksUrlString = @"http://www.vulture.com/news/books";
        industryUrlString = @"http://www.vulture.com/news/industry";
        clickablesUrlString = @"http://www.vulture.com/news/clickables";
        
        // This is the url we will be retrieving our entries from
        NSString *feedUrlString = @"http://www.vulture.com/rss/index.xml";
        
        // What type of content to include in the feed
        includeMovieNews = false;
        includeTvNews = false;
        includeMusicNews = false;
        includeArtNews = false;
        includeBooksNews = false;
        includeIndustryNews = false;
        includeClickablesNews = false;
        
        // Get data
        feedUrl = [[NSURL alloc]initWithString:feedUrlString];
        feedData = [self replaceUnsupportedCharactersAndHtmlEntitiesFromUrl:feedUrl];
        
        entries = [[NSMutableArray alloc]init];
 
    }
    
    return self;
}


// It appears that NSXMLParser will not support html entities like "&#039;" and some special characters.
// Need to use better suited parsing solution.
// Check out libxml2: http://cocoawithlove.com/2008/10/using-libxml2-for-parsing-and-xpath.html
// Or research for an RSS feed parsing library that polls and does caching: https://github.com/touchcode/TouchRSS
// In the meantime, use this temporarty string replacement solution
- (NSData *)replaceUnsupportedCharactersAndHtmlEntitiesFromUrl:(NSURL *)url {
    
    // get content retrieved from given url
    NSData *data = [[NSData alloc]initWithContentsOfURL:url];

    // Replace invalid xml characters with valid ones
    NSString *htmlCode = [[NSString alloc] initWithData:data encoding:NSISOLatin1StringEncoding];
    NSMutableString *temp = [NSMutableString stringWithString:htmlCode];
    
    [temp replaceOccurrencesOfString:@"&#039;" withString:@"'" options:NSLiteralSearch range:NSMakeRange(0, [temp length])];
    
     // This is not workin
    [temp replaceOccurrencesOfString:@"’" withString:@"'" options:NSLiteralSearch range:NSMakeRange(0, [temp length])];
    
    // Return data that should be xml valid now
    NSData *finalData = [temp dataUsingEncoding:NSISOLatin1StringEncoding];
    return finalData;
    
}

-(NSMutableArray *) parseFeed{
    
    // new list of entries. Clear array
    [entries removeAllObjects];
    
    // parse
    NSXMLParser *feedParser = [[NSXMLParser alloc]initWithData:feedData];
    [feedParser setDelegate:self];
    [feedParser parse];
    
    return entries;
}

-(NSMutableArray *) fetchAllNews{
    
    [self includeMovies:true
                     Tv:true
                  Music:true
                    Art:true 
                  Books:true
               Industry:true
             Clickables:true];
    
    return [self parseFeed];
}

-(NSMutableArray *) fetchMovies{
    
    [self includeMovies:true
                     Tv:false
                  Music:false
                    Art:false 
                  Books:false
               Industry:false
             Clickables:false];
    
    return [self parseFeed];
}

-(NSMutableArray *) fetchTV{
    
    [self includeMovies:false
                     Tv:true
                  Music:false
                    Art:false 
                  Books:false
               Industry:false
             Clickables:false];
    
    return [self parseFeed];
}

-(NSMutableArray *) fetchMusic{
    
    [self includeMovies:false
                     Tv:false
                  Music:true
                    Art:false 
                  Books:false
               Industry:false
             Clickables:false];
    
    return [self parseFeed];
}

-(NSMutableArray *) fetchArtAndBooks{
    
    [self includeMovies:false
                     Tv:false
                  Music:false
                    Art:true 
                  Books:true
               Industry:false
             Clickables:false];
    
    return [self parseFeed];
}

-(NSMutableArray *) fetchIndustry{
    
    [self includeMovies:false
                     Tv:false
                  Music:false
                    Art:false 
                  Books:false
               Industry:true
             Clickables:false];
    
    return [self parseFeed];
}

-(NSMutableArray *) fetchClickables{
    
    [self includeMovies:false
                     Tv:false
                  Music:false
                    Art:false 
                  Books:false
               Industry:false
             Clickables:true];
    
    return [self parseFeed];
}


- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict{
    
    // Set appropriate xml element processing flag.
    [self setProcessingFlagForElementName:elementName to:true];
    
    // We are about processing a new entry, let's initialise a new one.
    if(processingItem && entry == nil){
        entry = [[Entry alloc]init];
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    
    // We are done processing an entry, let's put the created entry in an array and reset it.
    if([elementName isEqualToString: @"item"] && processingItem){
        // Only add the entry if it's in the category we've selected for viewing.
        // Like if we are in the Movies catevory then we only want movies related articles
        
        if(includeMovieNews && entry.isMovieNews){
            [entries addObject:entry];
        }
        
        else if(includeTvNews && entry.isTvNews){
            [entries addObject:entry];
        }
        
        else if(includeMusicNews && entry.isMusicNews){
            [entries addObject:entry];
        }
        
        else if((includeArtNews || includeBooksNews) && (entry.isArtNews || entry.isBooksNews)){
            [entries addObject:entry];
        }
        
        else if(includeIndustryNews && entry.isIndustryNews){
            [entries addObject:entry];
        }
        
        else if(includeClickablesNews && entry.isClickablesNews){
            [entries addObject:entry];
        }
        
        entry = nil;
    }

    // Set appropriate xml element processing flag.
    [self setProcessingFlagForElementName:elementName to:false];
  
}

- (void)parser:(NSXMLParser *)parser foundCDATA:(NSData *)CDATABlock{
    if(processingContent){
        NSString *contentString = [[NSString alloc] initWithData:CDATABlock encoding:NSUTF8StringEncoding];
        
        // if content block is primary image url content block
        if([self string:contentString containsString:@"<img class=\"left\" src=\""]){
           
            NSString* imageUrlString = [self removeHtmlCharactersFromCDATABlockContent:(NSString*) contentString];
            entry.imageURL = [[NSURL alloc]initWithString:imageUrlString];
        }
        
        // if content block is "Read more posts by" content block
        else if([self string:contentString containsString:@"<p>Read more posts by <a href=\"http://nymag.com/author/"]){
            // Do nothing in this case for now.
        }
        
        // if content block is "Filed Under" content block
        else if([self string:contentString containsString:@"<p>Filed Under:"]){
            // Determine from this content block what category the entry is in.
            
            if([self string:contentString containsString:moviesUrlString]){
                entry.isMovieNews = true;
            }
            
            if([self string:contentString containsString:tvUrlString]){
                entry.isTvNews = true;
            }
            
            if([self string:contentString containsString:musicUrlString]){
                entry.isMusicNews = true;
            }
            
            if([self string:contentString containsString:artUrlString]){
                entry.isArtNews = true;
            }
            
            if([self string:contentString containsString:booksUrlString]){
                entry.isBooksNews = true;
            }
            
            if([self string:contentString containsString:industryUrlString]){
                entry.isIndustryNews = true;
            }
            
            if([self string:contentString containsString:clickablesUrlString]){
                entry.isClickablesNews = true;
            }
        }
        
        // Last case is that content block is actual article textual content block
        else{
            entry.articleContent = contentString;
        }
        
        //[entry.contentArray addObject:contentString];
    }
}
- (bool)string:(NSString*) string1 containsString:(NSString*) string2{
    NSRange range = [string1 rangeOfString : string2];
    
    if (range.location != NSNotFound) {
        return true;
    }else{
        return false;
    }
}
-(NSString *) removeHtmlCharactersFromCDATABlockContent:(NSString*) dataString{
    dataString = [dataString stringByReplacingOccurrencesOfString:@"<img class=\"left\" src=\"" withString:@""];
    dataString = [dataString stringByReplacingOccurrencesOfString:@"\" /><br />" withString:@""];
    
    return dataString;
}

// Processing characters in between a start and an end element tag e.g. <element>characters</element>
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    if(processingItem){
        if(processingTitle){
            entry.title = string;
        }
        
        if(processingAuthor){
            entry.author = string;
        }

        else if(processingLink){
            entry.link = string;
        }
        
        else if(processingPublicationDate){
            entry.publicationDate = string;
        }
    }
    
}

// Set flag value informing us what element we are processing
-(void) setProcessingFlagForElementName: (NSString *)elementName to: (bool) flag{
    if([elementName isEqualToString: @"item"]){
        processingItem = flag;
    }else if([elementName isEqualToString: @"title"]){
        processingTitle = flag && processingItem;
    }else if([elementName isEqualToString: @"author"]){
        processingAuthor = flag && processingItem;  
    }else if([elementName isEqualToString: @"description"]){
        processingContent = flag && processingItem;
    }else if([elementName isEqualToString: @"link"]){
        processingLink = flag && processingItem;
    }else if([elementName isEqualToString: @"pubDate"]){
        processingPublicationDate = flag && processingItem;
    }
}


// Set flags to indicate what category of news feed to display.
-(void) includeMovies:(bool) movies 
                   Tv:(bool) tv 
                Music:(bool) music 
                  Art:(bool) art 
                Books:(bool) books 
             Industry:(bool) industry 
           Clickables:(bool) clickables{
    
    includeMovieNews = movies;
    includeTvNews = tv;
    includeMusicNews = music;
    includeArtNews = art;
    includeBooksNews = books;
    includeIndustryNews = industry;
    includeClickablesNews = clickables;
    
}

@end
