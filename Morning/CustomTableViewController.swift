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
       // CellImage.isHidden = true
        // Configure the view for the selected state
    }
    
   /* func setupImage(image: Bool) {
        if image == true {
        CellImage.isHidden = false
        } else {
        CellImage.isHidden = true
        }
    }*/
}

class CustomTableViewController: UITableViewController, XMLParserDelegate {
    let RssFeed = RssDetails()
    let CardDisplay = Display()
    let myParser = XMLParserManager()
    var feed: [Card] = []
    var selectedFeed: [Card] = []
    var elementName: String = String()
    
    var cardTitle = String()
    var cardSubtitle = String()
    var cardImageURL = String()
    var cardImage = UIImage ()
    
    let numberOfFeeds = 3
    let numberOfCells = 6
    
    let snooze = SnoozeViewController()
    let cellClass = CustomCell()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
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
        print(feed)
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

// setup cell
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! CustomCell
        cell.prepareForReuse()

// load cell content
        let card = feed[indexPath.row]
        cell.CellTitle.text = card.cardTitle
        cell.CellSubtitle.text = card.cardSubtitle
        
// load cell image
        let isImage: Bool = CardDisplay.image[indexPath.row]
        print(isImage)

        if isImage == false {
            cell.CellImage.isHidden = true
        } else {
            cell.CellImage.isHidden = false
        if let url = URL(string: card.cardImageURL),  let data = NSData(contentsOf: url) {
        let cardImage = UIImage(data: data as Data) // add stuff to handle gif images
        cell.CellImage.image = cardImage
        }
        }
        
        return cell
}

    /*
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
    */
    
    /* ADD REDIRECTION TO POST URL WEBVIEW WHEN CLICKING ON CELL
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: IndexPath) {
        print("You selected cell #\(indexPath.row)!")
        
        performSegue(withIdentifier: "SegueWebView", sender: self)
        
        func prepare(for segue: SegueWebView, sender: Any?) {
            if segue.identifier == "SegueWebView" {
                // Setup new view controller
            }
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
     
     // cardImage = resizeImage(image: cardImage! , toTheSize: CGSize(width: 354, height: 354))
     
     // let cardImageView = UIImageView(image: CellImage)
     // cardImageView.contentMode = .scaleAspectFit
     // let cellImageLayer: CALayer?  = cell.imageView?.layer
     // cellImageLayer!.cornerRadius = 35
     // cellImageLayer!.masksToBounds = true
     // cell.CellImage.sizeToFit()
     // cell.CellImage.layoutIfNeeded()
 */
}
