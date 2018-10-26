
//  Users+CoreDataProperties.swift
//  CoreData Demo
//
//  Created by DEEP PRADHAN on 14/10/18.
//  Copyright © 2018 Appfish. All rights reserved.
//

import Foundation
import CoreData

extension Users {
    public class func fetchRequest() -> NSFetchRequest<Users> {
        return NSFetchRequest<Users>(entityName: "Users")
    }
    
    @NSManaged public var age: Int16
    @NSManaged public var empid: Int16
}

extension Users {
    
    class func saveDetails(age: Int, empid: Int) {
        if let privateContext = CoreDataManager.instanace.privateContext {
            privateContext.perform {
                //let entity = NSEntityDescription.entity(forEntityName: "Users", in: privateContext) as! Users
                let entity = NSEntityDescription.insertNewObject(forEntityName: "Users", into: privateContext) as! Users
                entity.age = Int16(age)
                entity.empid = Int16(empid)
                CoreDataManager.instanace.savePrivateContext()
            }
        }
    }
    
    class func getUserDetail(withEmpid: Int16)  {
        let fetchRequest: NSFetchRequest<Users> = Users.fetchRequest()
        do {
            let predicate = NSPredicate.init(format: "empid = %d", withEmpid)
            fetchRequest.predicate = predicate
            if let results = try CoreDataManager.instanace.privateContext?.fetch(fetchRequest) as? [Users] {
                
                if (results.count > 0) {
                    for result in results {
                        print(result.age)
                        print(result.empid)
                    }
                } else {
                    print("No results found")
                }
                //return results
            }
        } catch {
            print("error")
        }
    }
    
    class func delegeteUser(withEmpID: Int16) {
        let fetchRequest: NSFetchRequest<Users> = Users.fetchRequest()
        do {
            let predicate = NSPredicate.init(format: "empid = %d", withEmpID)
            fetchRequest.predicate = predicate
            if let results = try CoreDataManager.instanace.privateContext?.fetch(fetchRequest) as? [Users] {
                
                if (results.count > 0) {
                    
                    for result in results {
                        let resultData: NSManagedObject = result
                         CoreDataManager.instanace.privateContext?.delete(resultData)
                         CoreDataManager.instanace.savePrivateContext()
                    }
                }
            }
        } catch {
            print("error")
        }
    }
}
