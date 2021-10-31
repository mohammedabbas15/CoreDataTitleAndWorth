//
//  ViewController.swift
//  CoreDataTitleAndWorth
//
//  Created by Field Employee on 10/30/21.
//

/*
Use api to get data from backend and display
“title” and “worth”
on a table view from the consumed data stored in core data.
https://www.gamerpower.com/api/giveaways
Steps:
1. Consume data from the backend.
2. Store the consumed data in the core data
3. For displaying data on tableview display it from CoreData
Write a unit test case for the above implementation.
 */

import UIKit

class ViewController: UITableViewController {
    
    var games = [Game]()
    let networking = NetworkingService.shared
    let persistence = PersistentStorage.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        let urlPath = "https://www.gamerpower.com/api/giveaways"
        networking.request(urlPath) {[weak self] (result) in
            switch result {
            case .success(let data):
                do {
                    guard let jsonArray = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] else {return}
                    let gamesArray: [Game] = jsonArray.compactMap {
                        guard
                            let strongSelf = self,
                            let title = $0["title"] as? String,
                            let worth = $0["worth"] as? String
                            else {return nil}
                        let game = Game(context: strongSelf.persistence.context)
                        game.title = title
                        game.worth = worth
                        
                        return game
                    }
                    self?.games = gamesArray
                    DispatchQueue.main.async {
                        self?.persistence.save()
                        self?.tableView.reloadData()
                    }
                } catch {
                    print(error)
                }
            case .failure(let error): print(error)
            }
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return games.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = games[indexPath.row].title + " " + games[indexPath.row].worth
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.lineBreakMode = .byWordWrapping
        return cell
    }
}
