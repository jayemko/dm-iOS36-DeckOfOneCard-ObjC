//
//  DVMCardViewController.swift
//  DeckOfOneCard-ObjC
//
//  Created by Jason Koceja on 9/29/20.
//  Copyright © 2020 Koceja. All rights reserved.
//

import UIKit

class DVMCardViewController: UIViewController {
    
    @IBOutlet weak var cardLabel: UILabel!
    @IBOutlet weak var cardImageView: UIImageView!
    @IBOutlet weak var drawNewCardButton: UIButton!
    
    var cards: [DVMCard] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        drawCard()
    }
    
    @IBAction func drawNewCardButtonTapped(_ sender: Any) {
        drawCard()
    }
    
    func updateViews(card: DVMCard, image: UIImage) {
        cardLabel.text = card.cardSuit
        cardImageView.image = image
    }
    
    func drawCard() {
        DVMCardController.shared().drawNewCard(1, completion: { (cards, error) in
            self.cards = cards
            guard let firstCard = self.cards.first else {return}
            DVMCardController.shared().fetchCardImage(for: firstCard) { (image, error) in
                DispatchQueue.main.async {
                    self.updateViews(card: firstCard, image: image)
                }
            }
        })
    }
    
}
