//
//  CoreDataManager.swift
//  CoreData Demo
//
//  Created by DEEP PRADHAN on 14/10/18.
//  Copyright © 2018 Appfish. All rights reserved.
//

import Foundation
import CoreData

public class CoreDataManager {
    static let instanace = CoreDataManager()
    var mainContext: NSManagedObjectContext?
    var privateContext: NSManagedObjectContext?
    var objectModel: NSManagedObjectModel?
    var pesistenstStoreContainer: NSPersistentStoreCoordinator?
    var persistentStore: NSPersistentStore?
    
    private init() {
        self.mainContext = NSManagedObjectContext.init(concurrencyType: .mainQueueConcurrencyType)
        self.privateContext = NSManagedObjectContext.init(concurrencyType: .privateQueueConcurrencyType)
        self.objectModel = NSManagedObjectModel.mergedModel(from: nil)
        self.pesistenstStoreContainer = NSPersistentStoreCoordinator.init(managedObjectModel: self.objectModel!)
        self.mainContext?.persistentStoreCoordinator = self.pesistenstStoreContainer
        self.privateContext?.persistentStoreCoordinator = self.pesistenstStoreContainer
    }
    
    //FileName:
    var fileName = "company.sqlite"
    
    var directoryName: String {
        return NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
    }
    
    var applicationStoreUrl: URL {
        let storeUrl: URL = NSURL.init(fileURLWithPath: self.directoryName, isDirectory: true) as URL
        let fileManager = FileManager()
        if (!fileManager.fileExists(atPath: storeUrl.path)) {
            do {
                try fileManager.createDirectory(at: storeUrl, withIntermediateDirectories: true, attributes: nil)
            } catch {
                print("failed to create directory")
            }
        }
        return storeUrl
    }
    
    var storeUrl: URL {
        return applicationStoreUrl.appendingPathComponent(self.fileName, isDirectory: false)
    }
    
    private func loadStore() {
        do {
        let options = [NSMigratePersistentStoresAutomaticallyOption: NSNumber.init(value: 1), NSInferMappingModelAutomaticallyOption: NSNumber.init(value: 1) ]
        self.persistentStore = try
            self.pesistenstStoreContainer?.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: self.storeUrl, options: options)
        }
        catch {
            print("errro")
        }
    }
    
    public func setUp() {
        if (self.persistentStore == nil) {
            self.loadStore()
        }
    }
    
    //Save
    
     func saveMainContext() {
        if (self.mainContext != nil && self.mainContext!.hasChanges) {
            do {
                try self.mainContext?.save()
            } catch {
                print("failed to save the context")
            }
        }
    }
    
    public func savePrivateContext() {
        if (self.privateContext != nil && self.privateContext!.hasChanges) {
            do {
                try self.privateContext?.save()
            } catch {
                print("failed to save the context")
            }
        }
    }
}
