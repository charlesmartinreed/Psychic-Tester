//
//  ViewController.swift
//  Project37
//
//  Created by Charles Martin Reed on 8/29/18.
//  Copyright © 2018 Charles Martin Reed. All rights reserved.
//

import UIKit
import GameplayKit

class ViewController: UIViewController {
    
    //MARK:- Properites
    //will hold all the card views
    var allCards = [CardViewController]()
    
    @IBOutlet weak var cardContainer: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCards()
        
    }
    
    //MARK:- Card functions
    @objc func loadCards() {
        //we'll use addChildViewController and didMove(toParentViewController:) to place view controllers within one another. This is called VIEW CONTROLLER CONTAINMENT.
        
        //renable user interaction - it is disabled in our cardTapped function
        view.isUserInteractionEnabled = true
        
        //begin by clearing out the old cards
        for card in allCards {
            //remove the view, then the view controller containment
            card.view.removeFromSuperview()
            card.removeFromParentViewController()
        }
        
        //clear the array
        allCards.removeAll(keepingCapacity: true)
        
        //assemble an array of positions where cards can go
        let positions = [
        CGPoint(x: 75, y: 85),
        CGPoint(x: 185, y: 85),
        CGPoint(x: 295, y: 85),
        CGPoint(x: 405, y: 85),
        CGPoint(x: 75, y: 235),
        CGPoint(x: 185, y: 235),
        CGPoint(x: 295, y: 235),
        CGPoint(x: 405, y: 235),
        ]
        
        //load 1 Zener card shapes for each of the 8 cards,
        let circle = UIImage(named: "cardCircle")!
        let cross = UIImage(named: "cardCross")!
        let lines = UIImage(named: "cardLines")!
        let square = UIImage(named: "cardSquare")!
        let star = UIImage(named: "cardStar")!
        
        
        // create an array of the images, one for each card, then shuffle it
        var images = [circle, circle, cross, cross, lines, lines, square, star]
        images = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: images) as! [UIImage]
        
        for (index, position) in positions.enumerated() {
           
            //loop over each card position and create a new card view controller
            let card = CardViewController()
            card.delegate = self
            
            //use view controller containment and also add the card's view to our cardContainer view
            addChildViewController(card)
            cardContainer.addSubview(card.view)
            card.didMove(toParentViewController: self)
            
            //position the card appropriately, then give it an image from our array
            card.view.center = position
            card.front.image = images[index]
            
            //if we just gave the new card the star image, mark this as the correct answer
            if card.front.image == star {
                card.isCorrect = true
            }
            
            //add the new card view controller to our array for easier tracking
            allCards.append(card)

            
        }
    }
    
    //MARK:- Tap functions
    func cardTapped(_ tapped: CardViewController) {
        //ensure that only one card can be tapped at a time by checking that something was tapped and then disabling anything else from being tapped.
        //perform is inherited from NSObject, allows us to easily call a method after delay OR in the background
        guard view.isUserInteractionEnabled == true else { return }
        view.isUserInteractionEnabled = false
        
        //loop through all cards in the allCards array
        for card in allCards {
            if card == tapped {
                //when tapped card is found, animate it to flip over, then fade away.
                card.wasTapped()
                card.perform(#selector(card.wasntTapped), with: nil, afterDelay: 1)
            } else {
                //animate all untapped cards to simply fade away
                card.wasntTapped()
            }
        }
        //reset game after two second to make more cards appear
        perform(#selector(loadCards), with: nil, afterDelay: 2)
    }


}

