//
//  Company+CoreDataProperties.swift
//  CoreData Demo
//
//  Created by DEEP PRADHAN on 14/10/18.
//  Copyright © 2018 Appfish. All rights reserved.
//

import Foundation
import CoreData

extension Company {
    public class func fetchRequest() -> NSFetchRequest<Company> {
        return NSFetchRequest<Company>(entityName: "Company")
    }
    
    @NSManaged public var companyname: String?
    @NSManaged public var empid: Int16
    @NSManaged public var name: String?
}

extension Company {
    
    class func addCompanyDetails(companyName: String, empid: Int, name: String) {
        if let privateContext = CoreDataManager.instanace.privateContext {
            privateContext.perform {
                let entity = NSEntityDescription.insertNewObject(forEntityName: "Company", into: privateContext) as! Company
                
                entity.companyname = companyName
                entity.empid = Int16(empid)
                entity.name = name
                CoreDataManager.instanace.savePrivateContext()
            }
        }
    }
    
    class func fetchCompanyDetails(name: String) {
        let fetchRequest: NSFetchRequest<Company> = Company.fetchRequest()
        do {
            let predicate = NSPredicate.init(format: "name == %@", name)
            fetchRequest.predicate = predicate
            if let results = try CoreDataManager.instanace.privateContext?.fetch(fetchRequest) as? [Company] {
                
                if (results.count > 0) {
                    for result in results {
                        print(result.name)
                        print(result.companyname)
                        print(result.empid)
                    }
                } else {
                    print("No results found")
                }
                //return results
            }
        } catch {
            
        }
    }
}
