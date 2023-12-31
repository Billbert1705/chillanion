//
//  Persistence.swift
//  SleepWell
//
//  Created by Muhammad Yusuf on 24/10/23.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    
    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()
    
    let container: NSPersistentContainer
    
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "SleepWell")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    func saveItem(user: UserModel) {
        let context = container.viewContext
        
        if let entity = NSEntityDescription.entity(forEntityName: "User", in: context) {
            let newUser = NSManagedObject(entity: entity, insertInto: context) as! User
            newUser.id = UUID()
            newUser.name = user.name
            newUser.sleepCycle = user.sleepCycle
            newUser.targetWakeUpTime = user.targetWakeUpTime
            newUser.bedTimeCommitment = user.bedTimeCommitment
            
            do {
                try context.save()
                print("Item saved successfully")
            } catch {
                print("Error saving item: \(error)")
            }
        }
    }
    
    func fetch() -> User {
        let context = container.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        
        do {
            let result = try context.fetch(request)
            if let firstResult = result.first {
                // Use firstResult, which is the first record in the entity
                return firstResult as! User
            } else {
                // Handle the case where no data is found
                print("No data found")
            }
        } catch {
            print("Error fetching user: \(error)")
        }
        
        return User()
    }
    
    func saveReminder(reminder: ReminderModel) {
        let context = container.viewContext
        
        if let entity = NSEntityDescription.entity(forEntityName: "Reminder", in: context) {
            let newReminder = NSManagedObject(entity: entity, insertInto: context) as! Reminder
            newReminder.id = UUID()
            newReminder.name = reminder.name
            newReminder.category = reminder.categroy
            newReminder.remindTime = reminder.remindTime
            newReminder.isRemind = reminder.isRemind
            
            do {
                try context.save()
                print("Item saved successfully")
            } catch {
                print("Error saving item: \(error)")
            }
        }
    }
    func fetchReminder(name: String) -> Reminder {
        let context = container.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Reminder")
        
        // Set up a predicate to filter by propertie
        
        let predicate = NSPredicate(format: "name == %@", name)
        request.predicate = predicate
        do {
            let result = try context.fetch(request)
            if let firstResult = result.first {
                // Use firstResult, which is the first record in the entity
                return firstResult as! Reminder
            } else {
                // Handle the case where no data is found
                print("No data found")
            }
        } catch {
            print("Error fetching user: \(error)")
        }
        
        return Reminder()
    }
}
