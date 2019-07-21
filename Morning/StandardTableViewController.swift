//
//  TableViewController.swift
//  Morning
//
//  Created by Capucine Chatard on 7/17/19.
//  Copyright © 2019 Capucine Chatard. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController, XMLParserDelegate {
    let myParser = XMLParserManager()

    var feed: [Card] = []
    var elementName: String = String()
    var cardTitle = String()
    var cardSubtitle = String()
    var cardImageURL = String()
    var cardImage = UIImage ()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let path = Bundle.main.url(forResource: "Content", withExtension: "xml") {
            if let parser = XMLParser(contentsOf: path) {
                parser.delegate = self
                parser.parse()
                // Uncomment the following line to preserve selection between presentations
                // self.clearsSelectionOnViewWillAppear = false
                // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
                // self.navigationItem.rightBarButtonItem = self.editButtonItem
            }
        }
        loadData()
    }
    
    func loadData() {
        let url = URL(string: "https://www.newyorker.com/feed/cartoons/daily-cartoon")!
        loadRss(url)
    }
    
    func loadRss(_ data: URL) {
        // XmlParserManager instance/object/variable.
        _ = myParser.initWithURL(data)
        
        // Put feed in array.
        feed = myParser.feed
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return feed.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
       // cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "Cell")
    
        let card = feed[indexPath.row]
        
        cell.textLabel?.text = card.cardTitle
        cell.detailTextLabel?.text = card.cardSubtitle
        
        let url = URL(string: card.cardImageURL)
        let data = NSData(contentsOf: url!)
        var cardImage = UIImage(data: data! as Data)

        cardImage = resizeImage(image: cardImage! , toTheSize: CGSize(width: 900, height: 900))
        
        let cellImageLayer: CALayer?  = cell.imageView?.layer
        
        cellImageLayer!.cornerRadius = 35
        cellImageLayer!.masksToBounds = true
        
        cell.imageView?.image = cardImage
        

        return cell
    }
    
    
    func resizeImage(image:UIImage, toTheSize size:CGSize)->UIImage{
        
        let scale = CGFloat(max(size.width/image.size.width,
                                size.height/image.size.height))
        let width:CGFloat  = image.size.width * scale
        let height:CGFloat = image.size.height * scale;
        
        let rr:CGRect = CGRect(x: 0, y: 0, width: width, height: height)
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0);
        image.draw(in: rr)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext();
        return newImage!
    }
    
}
