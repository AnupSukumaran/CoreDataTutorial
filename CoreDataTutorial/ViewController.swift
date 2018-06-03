//
//  ViewController.swift
//  CoreDataTutorial
//
//  Created by Sukumar Anup Sukumaran on 02/06/18.
//  Copyright © 2018 TechTonic. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var secondName: UITextField!
    
    @IBOutlet weak var SearchTexField: UITextField!
    
    @IBOutlet weak var searchResultLabel: UILabel!
    
    // we are make a magic scatch pad for the data you input.
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func saveUserButton(_ sender: Any) {
        
        if !(firstName.text?.isEmpty)! && !(secondName.text?.isEmpty)!{
            
            let newUser = NSEntityDescription.insertNewObject(forEntityName: "User", into: context)
            newUser.setValue(self.firstName!.text, forKey: "firstname")
            newUser.setValue(self.secondName!.text, forKey: "secondname")
            
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            
//            do{
//                try context.save()
//            }catch let error {
//                print("COREDATA ERROR = \(error.localizedDescription)")
//            }
            
        }else{
            print("Please fill the textfields")
        }
        
    }
    
    @IBAction func searchButton(_ sender: Any) {
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        let searchString = self.SearchTexField.text
        request.predicate = NSPredicate(format: "firstname = %@", searchString!)
        
        do {
            let result:[NSManagedObject] = try context.fetch(request) as! [NSManagedObject]
            if result.count > 0{
                
                let firstname = result[0].value(forKey: "firstname") as!String
                let lastname = result[0].value(forKey: "secondname") as! String
                
                self.searchResultLabel?.text =  firstname + " " + lastname
            }else {
                
                self.searchResultLabel?.text = "No User Found"
                
            }
            
//            for data in result as! [NSManagedObject] {
//                fName = data.value(forKey: "firstname") as! String
//                Lname = data.value(forKey: "secondname") as! String
//            }
//
//            self.searchResultLabel.text =
            
        } catch let error  {
            print("CoreData = \(error.localizedDescription)")
        }
        
    }
    
    
}

