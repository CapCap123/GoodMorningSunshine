//
//  snoozeViewController.swift
//  Morning
//
//  Created by Capucine Chatard on 7/18/19.
//  Copyright © 2019 Capucine Chatard. All rights reserved.
//

import UIKit

class SnoozeViewController: UIViewController {
    var mySoundManager = SoundManager()
    weak var myTimer: Timer!
    var timerTime = 10
    
    @IBOutlet weak var SnoozeSlider: UISlider!
    @IBOutlet weak var SnoozeButton: UIButton!
    @IBOutlet weak var timerField: UILabel!
    @IBOutlet weak var MorningButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timerField.text = "How much more sleep do you want?"
        SnoozeSlider.isHidden = false
        timerField.isHidden = false
        MorningButton.isHidden = false
        SnoozeButton.isHidden = false
        let sliderValue = Int(SnoozeSlider.value)
        SnoozeButton.setTitle("Wake me up in \(sliderValue) minutes", for: .normal)
        // Do any additional setup after loading the view.
}
    
    
    @IBAction func MorningSetUp(_ sender: Any) {
mySoundManager.playPlayer(wavSound: "BeachSound")

    }
    
    @IBAction func SnoozeTime(_ sender: UISlider) {
        let sliderValue = Int(sender.value)
        SnoozeButton.setTitle("Wake me up in \(sliderValue) minutes", for: .normal)
    }
    
    @IBAction func SnoozeValidation(_ sender: Any) {
        startTimer()
    }
    
    // TIMER
    func startTimer() {
        // make sure a timer is not already  running
        endTimer()
        // setup new timer
        self.timerTime = Int(SnoozeSlider.value*60)
        self.myTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    
    @objc func updateTime() {
        let seconds: Int = timerTime%60
        let minutes: Int = Int(timerTime/60)
        timerField.text = "\(String(format: "%02d:%02d", minutes, seconds)) left"
        
        if self.timerTime != 0 {
            self.timerTime -= 1
        } else {
            // end timer
            endTimer()
            timerField.text = "00:00"
            mySoundManager.playPlayer(wavSound: "LotsOfKisses")

        }
    }
    
    func endTimer() {
        myTimer?.invalidate()
    }
}
