//
//  CardViewController.swift
//  Project37
//
//  Created by Charles Martin Reed on 8/30/18.
//  Copyright © 2018 Charles Martin Reed. All rights reserved.
//

import UIKit

class CardViewController: UIViewController {
    
    //a weak ref to the ViewController class to enable bidirectional comms
    weak var delegate: ViewController!
    
    //MARK:- PROPERTIES
    //these are child image views that will contain images for card front and back
    var front: UIImageView!
    var back: UIImageView!
    
    //did the player choose the right card?
    var isCorrect = false

    override func viewDidLoad() {
        super.viewDidLoad()

        //Give the view a precise size of 100x140
        view.bounds = CGRect(x: 0, y: 0, width: 100, height: 140)
        
        //add the two image views, one for the card back and one for card front
        //when you call an image using named:, it uses the exact size of the image, which is also 100x140.
        front = UIImageView(image: UIImage(named: "cardBack"))
        back = UIImageView(image: UIImage(named: "cardBack"))
        
        view.addSubview(front)
        view.addSubview(back)
        
        //set front image view to be hidden by default
        front.isHidden = true
        
        //set the back image view to have alpha of 0, fading up to 1 with animation
        back.alpha = 0
        
        UIView.animate(withDuration: 0.2) {
            self.back.alpha = 1
        }
        
        //using a gesture recognizer to "feel" the star
        let tap = UITapGestureRecognizer(target: self, action: #selector(cardTapped))
        back.isUserInteractionEnabled = true
        back.addGestureRecognizer(tap)
        
    }
    
    //MARK: - Tap functions
    @objc func cardTapped() {
        //we pass this to the delegate, i.e, parent view controller, to prevent users from tapping on two cards at once and causing problems
        delegate.cardTapped(self)
    }
    
    @objc func wasntTapped() {
        UIView.animate(withDuration: 0.7) {
            //zoom down and fade away over 0.7 seconds
            self.view.transform = CGAffineTransform(scaleX: 0.00001, y: 0.00001)
            self.view.alpha = 0
        }
    }
    
    @objc func wasTapped() {
        //using transition(with:) to flip the card and then "swap" the images by hiding back and unhiding the front.
        UIView.transition(with: view, duration: 0.7, options: [.transitionFlipFromRight], animations: {
                [unowned self] in
                self.back.isHidden = true
                self.front.isHidden = false
        }, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   

}
