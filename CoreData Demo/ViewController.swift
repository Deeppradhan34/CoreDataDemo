//
//  ViewController.swift
//  Core Data Demo
//
//  Created by Rob Percival on 21/06/2016.
//  Copyright © 2016 Appfish. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    var firstTime: Bool = false
    
    override func viewDidLoad() {
        
    }
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view, typically from a nib.
//
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate // UIApplication.shared().delegate as! AppDelegate is now UIApplication.shared.delegate as! AppDelegate
//
//        let context = appDelegate.persistentContainer.viewContext
//
//        let newUser = NSEntityDescription.insertNewObject(forEntityName: "Users", into: context)
//
//        newUser.setValue("kirsten", forKey: "username")
//        newUser.setValue("deed", forKey: "password")
//        newUser.setValue(35, forKey: "age")
//
//        do {
//
//            try context.save()
//
//            print("Saved")
//
//        } catch {
//
//            print("There was an error")
//
//        }
//
//    //   let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
//
//      //  request.returnsObjectsAsFaults = false
//        let r: NSManagedObjectModel = appDelegate.persistentContainer.managedObjectModel
//        let k = r.fetchRequestTemplate(forName: "Test")
//        let request = k!
//        print(k!)
//        do {
//
//            let results = try context.fetch(request)
//
//            if results.count > 0 {
//
//                for result in results as! [NSManagedObject] {
//
//                    if let username = result.value(forKey: "username") as? String {
//
//                        print(username)
//
//                    }
//
//                }
//
//
//            } else {
//
//                print("No results")
//
//            }
//
//
//        } catch {
//
//            print("Couldn't fetch results")
//
//        }

//    }
    
    override func viewDidAppear(_ animated: Bool) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(4), execute: {
            // Put your code which should be executed with a delay here
        
          Users.getUserDetail(withEmpid: 78)
          Company.fetchCompanyDetails(name: "DSD")
          Users.delegeteUser(withEmpID: 78)
          Users.getUserDetail(withEmpid: 78)
        })
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

