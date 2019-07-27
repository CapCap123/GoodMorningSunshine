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
        2,
        1,
        3
    ]
    
    
    let link = [
    "https://www.newyorker.com/feed/cartoons/daily-cartoon",
    "https://www.comicsrss.com/rss/calvinandhobbes.rss",
    "https://weather-broker-cdn.api.bbci.co.uk/en/forecast/rss/3day/5128581"
    ]
    

    
    let itemIdentifier = [
    "item",
    "item",
    "item"
    ]
    
    let titleIdentifier = [
        "title",
        "title",
        "title"
    ]
    
    let subtitleIdentifier = [
    "description",
    "copyriht",
    ""
    ]
    
    let imageRssType = [
    "enclosure",
    "CDATA",
    "image"
    ]
    
    let imageIdentifier1 = [
        "media:thumbnail",
        "img",
        "image"
    ]
    
    let imageIdentifier2 = [
        "url",
        "src",
        "url"
    ]
    
    let postURLIdentifier = [
    "link",
    "link",
    "link"
    ]
    
}
