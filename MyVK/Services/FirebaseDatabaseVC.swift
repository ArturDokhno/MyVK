//
//  FirebaseDatabaseVC.swift
//  12l_ArturDokhno
//
//  Created by Артур Дохно on 27.10.2021.
//

import UIKit
import FirebaseDatabase

class FirebaseDatabaseVC: UIViewController {
    
    let database = Database.database().reference()
    
    @IBAction func addNewEntry(_ sender: Any) {
        let object: [String: Any] = [
            "name": "Artur" as NSObject,
            "developer": "yes"
        ]
        database.child("somefing\(Int.random(in: 0...100))").setValue(object)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        database.child("apples").child("count").setValue(88)
     
        
        /*
        
        
        
        database.child("Artur").child("Age").setValue(29)
        
        database.observe(.value, with: { (snapshot) in
            guard let value = snapshot.value, snapshot.exists() else {
                print("Error with getting data")
                return
            }
            print("Value: \(value)")
        })
        
        database.child("somefing").observeSingleEvent(of: .value, with: { snapshot in
            guard let value = snapshot.value as? [String: Any] else {
                return
            }
            print("Value: \(value)")
        })
        
    }
    
}
