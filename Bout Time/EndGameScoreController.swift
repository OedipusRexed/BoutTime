//
//  EndGameScoreController.swift
//  Bout Time
//
//  Created by Aaron Revalee on 11/13/17.
//  Copyright © 2017 OedipusRexed. All rights reserved.
//

import Foundation
import UIKit

protocol EndGameScoreControllerDelegate {
    func reloadMainGame()
}

class EndGameScoreController: UIViewController {

    @IBOutlet weak var scoreLabel: UILabel!
    
    var score: Int?
    var delegate: EndGameScoreControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if let finalScore = score {
            scoreLabel.text = "\(finalScore)/6"
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
