//
//  ViewController.swift
//  Morning
//
//  Created by Capucine Chatard on 7/18/19.
//  Copyright © 2019 Capucine Chatard. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var mySoundManager = SoundManager()
    
    
    @IBOutlet weak var morningHeader: UILabel!
    @IBOutlet weak var morningButton: UIButton!
    @IBOutlet weak var snoozeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func launchMorningSetUp(_ sender: Any) {
        mySoundManager.playPlayer(wavSound: "BeachSound")
    }
    
    @IBAction func snoozeSetUp(_ sender: Any) {
        mySoundManager.playPlayer(wavSound: "BlowKiss")
    }
}
