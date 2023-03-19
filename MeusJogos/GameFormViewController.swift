//
//  GameFormViewController.swift
//  MeusJogos
//
//  Created by Felipe Castro on 07/03/23.
//

import UIKit

class GameFormViewController: UIViewController {

    @IBOutlet weak var textFiledTitle: UITextField!
    @IBOutlet weak var textFiledPlataform: UITextField!
    @IBOutlet weak var textFieldPrice: UITextField!
    @IBOutlet weak var imageViewCover: UIImageView!
    @IBOutlet weak var cadastrar: UIButton!
    
    var game: Game?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let game {
            textFiledTitle.text = game.title
            textFiledPlataform.text = game.plataform
            textFieldPrice.text = "\(game.price)"
            title = "Alteração"
            cadastrar.setTitle("Alterar", for: .normal)
            imageViewCover.image = game.image
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    
    @IBAction func selectCover(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        present(picker, animated: true)
    }
    
    @IBAction func save(_ sender: Any) {
        
        //se for nulo ele da um new
        let newGame = game ?? Game(context: context)
        newGame.title = textFiledTitle.text
        newGame.plataform = textFiledPlataform.text
        newGame.price = Double(textFieldPrice.text!) ?? 0.0
        newGame.cover = imageViewCover.image?.pngData()
        
        do{
            try context.save()
            navigationController?.popViewController(animated: true)
        }catch{
            print(error)
        }

    }
}


extension GameFormViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as? UIImage
        imageViewCover.image = image
        dismiss(animated: true)
    }
}

extension GameFormViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.resignFirstResponder()
        return true
    }
}
