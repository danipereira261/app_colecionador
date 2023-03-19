//
//  Game-Image.swift
//  MeusJogos
//
//  Created by Felipe Castro on 08/03/23.
//

import UIKit

extension Game{
    var image: UIImage?{
        if let cover {
            return UIImage(data: cover)
        }else{
            return nil
        }
    }
}
