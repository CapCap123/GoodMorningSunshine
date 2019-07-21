//
//  File.swift
//  Morning
//
//  Created by Capucine Chatard on 7/20/19.
//  Copyright © 2019 Capucine Chatard. All rights reserved.
//

import Foundation

// Rss feed specifics, per feed
class RssDetails {
    
    let numberOfCells: [Int] = [
        1,
        3
    ]
    
    let link = [
    "https://www.newyorker.com/feed/cartoons/daily-cartoon",
    "https://weather-broker-cdn.api.bbci.co.uk/en/forecast/rss/3day/5128581"
    ]
    

    
    let itemIdentifier = [
    "item",
    "item"
    ]
    
    let titleIdentifier = [
        "title",
        "title"
    ]
    
    let subtitleIdentifier = [
    "description",
    ""
    ]
    
    let imageRssType = [
    "enclosure",
    "image"
    ]
    
    let imageIdentifier1 = [
        "media:thumbnail",
        "image"
    ]
    
    let imageIdentifier2 = [
        "url",
        "url"
    ]
    
    let postURLIdentifier = [
    "link",
    "link"
    ]
    
}
