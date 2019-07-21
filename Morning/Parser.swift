//
//  Parser.swift
//  Morning
//
//  Created by Capucine Chatard on 7/18/19.
//  Copyright © 2019 Capucine Chatard. All rights reserved.
//

import Foundation
import UIKit

class XMLParserManager: NSObject, XMLParserDelegate {
    var parser = XMLParser()
    var rssFeed = RssDetails()
    var feed: [Card] = []
    var elementName: String = String()
    var feedNumber = 0
    
    var cardTitle = String()
    var cardSubtitle = String()
    var cardImageURL = String()
    var cardPostURL = String()
    
    // initilise parser
    func initWithURL(_ url :URL) -> AnyObject {
        startParse(url)
        return self
    }
    
    func startParse(_ url :URL) {
        feedNumber += 1
        feed = []
        parser = XMLParser(contentsOf: url)!
        parser.delegate = self
        parser.shouldProcessNamespaces = false
        parser.shouldReportNamespacePrefixes = false
        parser.shouldResolveExternalEntities = false
        parser.parse()
    }
    
func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
    self.elementName = elementName


    if elementName == rssFeed.itemIdentifier[feedNumber-1] {
        cardTitle = String()
        cardSubtitle = String()
        cardPostURL = String()
    }
    
        // parse image depending on how it appears in the feed: enclosure or image
    else if elementName == rssFeed.imageIdentifier1[feedNumber-1] {
        if rssFeed.imageRssType[feedNumber-1] == "enclosure" {
            cardImageURL = String()
            if let urlString = attributeDict[rssFeed.imageIdentifier2[feedNumber-1]] {
            cardImageURL.append(urlString)
            } else {
                print("malformed element: enclosure without thumbnail url attribute")
            }
        } else if rssFeed.imageRssType[feedNumber-1] == "image" {
            cardImageURL = String()
        }
    }
}

func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
    if elementName == rssFeed.itemIdentifier[feedNumber-1] {
        let card = Card(cardTitle: cardTitle, cardSubtitle: cardSubtitle, cardImageURL: cardImageURL, cardPostURL: cardPostURL)
        if feed.count < rssFeed.numberOfCells[feedNumber-1] {
        feed.append(card)
        }
    }
}

func parser(_ parser: XMLParser, foundCharacters string: String) {
    
    let data = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    
    if (!data.isEmpty) {
        if self.elementName == rssFeed.subtitleIdentifier[feedNumber-1] {
            cardSubtitle += data
        }  else if self.elementName == rssFeed.titleIdentifier[feedNumber-1] {
            cardTitle += data
        }   else if self.elementName == rssFeed.postURLIdentifier[feedNumber-1] {
            cardPostURL += data
        } else if self.elementName == rssFeed.imageIdentifier2[feedNumber-1] {
            cardImageURL += data
        }
    }
}
    
}
