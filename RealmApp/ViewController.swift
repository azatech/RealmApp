//
//  ViewController.swift
//  RealmApp
//
//  Created by Azat IOS on 21.10.17.
//  Copyright © 2017 azatech. All rights reserved.
//

import UIKit
import FirebaseDatabase
import RealmSwift

class TableViewController : UITableViewController {


    override func viewDidLoad() {
        grabData()
    }


    var users : Results<User>!
    func grabData() {
        let databaseReference = Database.database().reference()
        databaseReference.child("users").observe(.value, with: {
            snapshot in
            print(snapshot)

            for snap in snapshot.children.allObjects as! [DataSnapshot] {
                guard let dictionary = snap.value as? [String : AnyObject] else {
                    return
                }
                let name = dictionary["Name"] as? String
                let age  = dictionary["Age"]  as? Int

                let userToAdd  = User()
                userToAdd.name = name
                userToAdd.age.value  = age
                userToAdd.writeToRealm()

                self.reloadData()
            }
        })
    }

    func reloadData() {
        users = uiRealm.objects(User.self).sorted(byKeyPath: "age", ascending: true).filter("age")
//            .filter("name == 'Azat'")
        self.tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if users != nil {
            return users.count
        } else {
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init(style: .subtitle, reuseIdentifier: "main")

        cell.textLabel?.text = users[indexPath.row].name
        if let age = users [indexPath.row].age.value {
            cell.detailTextLabel?.text = String(describing: age)
        }
        return cell
    }
}
