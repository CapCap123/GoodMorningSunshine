//
//  CustomTableViewController.swift
//  Morning
//
//  Created by Capucine Chatard on 7/19/19.
//  Copyright © 2019 Capucine Chatard. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
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
        
        self.tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "CustomTableViewCell")
        //self.tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        loadRss()
    }

    
    func loadRss() {
        for i in 0 ... numberOfFeeds-1 {
            if let url = URL(string: RssFeed.link[i]) {
        // XmlParserManager instance/object/variable.
        _ = myParser.initWithURL(url)
        
        // Put feed in array.
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

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
  
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
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell
       // cell.CellImage.sizeToFit()
       // cell.CellImage.layoutIfNeeded()
        
        let card = feed[indexPath.row]
        
        cell.CellTitle.text = card.cardTitle
        cell.CellSubtitle.text = card.cardSubtitle
        
        // setup image
        if let url = URL(string: card.cardImageURL),  let data = NSData(contentsOf: url) {
            var cardImage = UIImage(data: data as Data)
        
        cardImage = resizeImage(image: cardImage! , toTheSize: CGSize(width: 250, height: 250))
        
        //let cellImageLayer: CALayer?  = cell.imageView?.layer
       // cellImageLayer!.cornerRadius = 35
       // cellImageLayer!.masksToBounds = true
        
       cell.CellImage.image = cardImage
        }
        
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

