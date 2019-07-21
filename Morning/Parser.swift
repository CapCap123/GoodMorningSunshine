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
    var postURL = String()
    
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
    
// This method is sent by the parser object when the start tag of "<item>" is encountered.

func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
    self.elementName = elementName


    if elementName == rssFeed.itemIdentifier[feedNumber-1] {
        print(feedNumber)
        cardTitle = String()
        cardSubtitle = String()
        postURL = String()
    }
    
    else if elementName == rssFeed.imageIdentifier1[feedNumber-1] {
        if feedNumber == 1 {
            if let urlString = attributeDict[rssFeed.imageIdentifier2[feedNumber-1]] {
            cardImageURL.append(urlString)
                print("NYImage")
            } else {
                print("malformed element: enclosure without thumbnail url attribute")
            }
        } else if feedNumber == 2 {
        print("weatherImageBS")
            cardImageURL = String()
    }
    }
    }

//     This method is sent by the parser object when the end tag of "</item>" is encountered.

func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
    if elementName == rssFeed.itemIdentifier[feedNumber-1] {
        let card = Card(cardTitle: cardTitle, cardSubtitle: cardSubtitle, cardImageURL: cardImageURL, postURL: postURL)
        print("OK")
        if feed.count < rssFeed.numberOfCells[feedNumber-1] {
        feed.append(card)
        }
    }
}

//     Here the actual parsing is executed. The title and author tags will be parsed and the corresponding properties will be initialized.
func parser(_ parser: XMLParser, foundCharacters string: String) {
    let data = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    

    if (!data.isEmpty) {
        if self.elementName == rssFeed.subtitleIdentifier[feedNumber-1] {
            cardSubtitle += data
        }  else if self.elementName == rssFeed.titleIdentifier[feedNumber-1] {
            cardTitle += data
        } else if self.elementName == rssFeed.imageIdentifier2[feedNumber-1] && cardImageURL == "" {
            cardImageURL += data
        }
    }
}
}
