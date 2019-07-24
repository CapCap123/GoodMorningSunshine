//
//  CustomTableViewController.swift
//  Morning
//
//  Created by Capucine Chatard on 7/19/19.
//  Copyright © 2019 Capucine Chatard. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {
    
    @IBOutlet weak var CellTitle: UILabel!
    @IBOutlet weak var CellSubtitle: UILabel!
    @IBOutlet weak var CellImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func setUpCell() { // todo
    }
}

class CustomTableViewController: UITableViewController, XMLParserDelegate {
    let RssFeed = RssDetails()
    let myParser = XMLParserManager()
    var feed: [Card] = []
    var selectedFeed: [Card] = []
    var elementName: String = String()
    
    var cardTitle = String()
    var cardSubtitle = String()
    var cardImageURL = String()
    var cardImage = UIImage ()
    
    let numberOfFeeds = 2
    let numberOfCells = 4

    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 300
        loadRss()
    }

// iterates parsing for all feeds
    func loadRss() {
        for i in 0 ... numberOfFeeds-1 {
            if let url = URL(string: RssFeed.link[i]) {
            _ = myParser.initWithURL(url)
            feed += myParser.feed
            }
        }
        tableView.reloadData()
        print(feed)
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

    /*
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
 */
  
    /*
    override func viewWillAppear(_ animated: Bool) {
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.rowHeight = UITableView.automaticDimension
    }
    func registerTableViewCells(){
      self.tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "CustomTableViewCell")
     CustomTableViewCell.self, forCellReuseIdentifier: "customCell")
    }
 */
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

// setup cell
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! CustomCell
        
        let card = feed[indexPath.row]
        cell.CellTitle.text = card.cardTitle
        cell.CellSubtitle.text = card.cardSubtitle
        
// setup image
        if let url = URL(string: card.cardImageURL),  let data = NSData(contentsOf: url) {
        var cardImage = UIImage(data: data as Data) // add stuff to handle gif images
        
        cardImage = resizeImage(image: cardImage! , toTheSize: CGSize(width: 250, height: 250))
            
        // let cardImageView = UIImageView(image: CellImage)
        // cardImageView.contentMode = .scaleAspectFit
        // let cellImageLayer: CALayer?  = cell.imageView?.layer
        // cellImageLayer!.cornerRadius = 35
        // cellImageLayer!.masksToBounds = true
        // cell.CellImage.sizeToFit()
        // cell.CellImage.layoutIfNeeded()
        
        cell.CellImage.image = cardImage
        }
        
// setup cell UI, to do in cell subClass?
        cell.setUpCell()
        
        return cell
}
    
// to redo based on image dimmensions, to place in cell subclass? do the same for titles and subtitles?
func resizeImage(image:UIImage, toTheSize size:CGSize)->UIImage{ // to redo
        
    let scale = CGFloat(max(size.width/image.size.width,
                                size.height/image.size.height))
    let width:CGFloat  = image.size.width * scale
    let height:CGFloat = image.size.height * scale;
    
    let rr:CGRect = CGRect(x: 8, y: 80, width: width, height: height)
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0);
        image.draw(in: rr)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext();
        return newImage!
}
    
    /* ADD REDIRECTION TO POST URL WEBVIEW WHEN CLICKING ON CELL
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: IndexPath) {
        print("You selected cell #\(indexPath.row)!")
        
        performSegue(withIdentifier: "SegueWebView", sender: self)
        
        func prepare(for segue: SegueWebView, sender: Any?) {
            if segue.identifier == "SegueWebView" {
                // Setup new view controller
            }
    }
 */
    
}
