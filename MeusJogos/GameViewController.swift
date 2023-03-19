//
//  GameViewController.swift
//  MeusJogos
//
//  Created by Felipe Castro on 07/03/23.
//

import UIKit

class GameViewController: UIViewController {

    @IBOutlet weak var imageViewCover: UIImageView!
    @IBOutlet weak var lavelTitle: UILabel!
    @IBOutlet weak var labelPlataform: UILabel!
    @IBOutlet weak var labelPrice: UILabel!
    
    var game: Game?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        lavelTitle.text = game?.title
        labelPlataform.text = game?.plataform
        labelPrice.text = "R$ \(game?.price ?? 0.0)"
        imageViewCover.image = game?.image
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let gameFormViewController = segue.destination as? GameFormViewController else {return}
        gameFormViewController.game = game
    }
    
}
