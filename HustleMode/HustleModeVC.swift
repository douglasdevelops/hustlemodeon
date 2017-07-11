//
//  ViewController.swift
//  HustleMode
//
//  Created by Douglas Spencer on 7/11/17.
//  Copyright © 2017 Douglas Spencer. All rights reserved.
//

import UIKit
import AVFoundation

class HustleModeVC: UIViewController {
    
    @IBOutlet weak var imgBackGroundDarkBlue: UIImageView!
    @IBOutlet weak var vwCloudHolder: UIView!
    @IBOutlet weak var btnPowerUp: UIButton!
    @IBOutlet weak var imgRocket: UIImageView!
    @IBOutlet weak var lblHustleMode: UILabel!
    @IBOutlet weak var lblOn: UILabel!
    
    var Player: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
        vwCloudHolder.isHidden = true
        btnPowerUp.isUserInteractionEnabled = true

        
        lblHustleMode.alpha = 0.0
        lblOn.alpha = 0.0
        vwCloudHolder.alpha = 0.0
        
        lblHustleMode.isHidden = false
        lblOn.isHidden = false
        
        
        let Path = Bundle.main.path(forResource: "hustle-on", ofType: ".wav")!
        let url = URL(fileURLWithPath: Path)
        
        do {
            Player = try AVAudioPlayer(contentsOf: url)
            Player.prepareToPlay()
        } catch let error {
            print(error.localizedDescription)
        }
        
    }
    
    

    @IBAction func btnPowerUp_Tapped(_ sender: Any) {
        
        UIView.animate(withDuration: 0.2, animations: {
            self.btnPowerUp.alpha = 0.0
            self.imgBackGroundDarkBlue.alpha = 0.0
        }) { (complete) in
            UIView.animate(withDuration: 0.2, animations: {
                self.vwCloudHolder.isHidden = false
                self.vwCloudHolder.alpha = 1.0
            }, completion: { (complete) in
                UIView.animate(withDuration: 2.3, animations: {
                    self.Player.play()
                    self.imgRocket.frame = CGRect(x: 0, y: 120, width: 375, height: 402)
                }, completion: { (complete) in
                    UIView.animate(withDuration: 3.0, animations: {
                    }, completion: { (complete) in
                        UIView.animate(withDuration: 0.5, animations: {
                            self.lblHustleMode.alpha = 1.0
                            //self.lblHustleMode.animate(newText: self.lblHustleMode.text ?? "May the source be with you", characterDelay: 0.2, completion: )
                            self.lblHustleMode.animate(newText: self.lblHustleMode.text ?? "May the source be with you", characterDelay: 0.1, completion: { (finished, error) in
                                UIView.animate(withDuration: 1.5, animations: {
                                    self.lblOn.alpha = 1.0
                                })
                            })
                        }, completion: { (complete) in
                            print("All Animations Done")
                        })
                    })
                })
            })
        }
    }
}

extension UILabel {
    func animate(newText: String, characterDelay: TimeInterval, completion: @escaping (Bool, Error?) -> Void) {
        
        DispatchQueue.main.async {
            
            self.text = ""
            
            for (index, character) in newText.characters.enumerated() {
                DispatchQueue.main.asyncAfter(deadline: .now() + characterDelay * Double(index)) {
                    self.text?.append(character)
                }
                
            }
            
            completion(true,nil)
        }
    }
}

