//
//  UsersViewController.swift
//  CoreDataTutorial
//
//  Created by Sukumar Anup Sukumaran on 02/06/18.
//  Copyright © 2018 TechTonic. All rights reserved.
//

import UIKit
import CoreData

class UsersViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var userArray:[User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.fetchData()
        self.tableView.reloadData()
    }

    func fetchData() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        do {
             userArray = try context.fetch(User.fetchRequest())
        } catch let error {
            print("COreDataError = \(error.localizedDescription)")
        }
        
        
    }
    
}

extension UsersViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let name = userArray[indexPath.row]
        cell.textLabel?.text = name.firstname! + " " + name.secondname!
        
        return cell
    }
    
}

extension UsersViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

        if editingStyle == .delete {
            let user = userArray[indexPath.row]
            context.delete(user)
            
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            // fetch is used to update the array for the table
            do{
                userArray = try context.fetch(User.fetchRequest())
            }catch let error {
                print("CDE = \(error.localizedDescription)")
            }
        }
        tableView.reloadData()
    }
    
}
