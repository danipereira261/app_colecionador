//
//  GamesTableViewController.swift
//  MeusJogos
//
//  Created by Felipe Castro on 05/03/23.
//

import UIKit
import CoreData

class GamesTableViewController: UITableViewController {
    
    var games: [Game] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //preste a aparecer
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("A tela de listagem de jogos esta preste a aparecer")
        loadGames()
        tableView.reloadData()
        
    }
    
    //apareceu
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("A tela de listagem de jogos apareceu")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard
            let gameViewController = segue.destination as? GameViewController,
            let row = tableView.indexPathForSelectedRow?.row
        else {return}
        gameViewController.game = games[row]
    }
    
    func loadGames(){
        let fetchRequest = Game.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        do{
            games = try context.fetch(fetchRequest)
        }catch{
            print(error)
        }
       
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return games.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let game = games[indexPath.row]

        cell.textLabel?.text = game.title
        cell.detailTextLabel?.text = game.plataform
        cell.imageView?.image = game.image

        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let game = games[indexPath.row]
            context.delete(game)
            try? context.save()
            games.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation

    */

}
