//
//  UiViewController+Context.swift
//  MeusJogos
//
//  Created by Felipe Castro on 07/03/23.
//

import Foundation
import UIKit
import CoreData

extension UIViewController {
    
    var context:NSManagedObjectContext{
        (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }
    
}
