//
//  StorageManager.swift


import Foundation



import Foundation
import UIKit
import CoreData


protocol StorageHandler{
    func reportUserRegistered(status: String)
    func reportUserObtained(products: [NewsModel])
    func reportDeleted(indexPath: IndexPath?)
}

extension StorageHandler{
    func reportUserRegistered(status: String){
        
    }
    
    func reportUserObtained(products: [NewsModel]){
        
    }
    
    func reportDeleted(indexPath: IndexPath?){
        
    }
}


class StorageManager {
    
    
    
    var storageHandler: StorageHandler?
    var delegate : AppDelegate?
    private var context: NSManagedObjectContext?
    private static var storage: StorageManager?
    
    public static func StorageConnection() -> StorageManager{
        if storage == nil{
            //            FirebaseApp.configure()
            storage = StorageManager()
        }
        
        return storage!
    }
    
    init() {
        delegate = UIApplication.shared.delegate as? AppDelegate
        context = delegate?.persistentContainer.viewContext
        
    }
    
    
    
   
    
    
    public func addUser(news: NewsModel){
        if self.context != nil{
            let entity = NSEntityDescription.entity(forEntityName: "ANews", in: context!)
            let managedObject = NSManagedObject(entity: entity!, insertInto: context!)
            
            let values = news.getValues()
            
           
            do{
                try context?.save()
                if storageHandler != nil{
                    storageHandler?.reportUserRegistered(status: "Success")
                    
                }
            }
            catch let error{
                print("\(error.localizedDescription)")
                if storageHandler != nil{
                    storageHandler?.reportUserRegistered(status: error.localizedDescription)
                }
            }
        }
    }
    
    
    
    
    
    
    public func fetchAllUsers(){
        let request = NSFetchRequest<NSManagedObject>(entityName: "ANews")
        var fav = [NewsModel]()
        do{
            let users: [ANews] = try self.context?.fetch(request) as! [ANews]
            if users != nil{
                for user in users{
                    let author = user.value(forKey: "author") as? String
                    let title = user.value(forKey: "title") as? String
                    let detail = user.value(forKey: "detail") as? String
                    let url = user.value(forKey: "url") as? String
                    let image = user.value(forKey: "urlToImage") as? String
                    let date = user.value(forKey: "date") as? String
                    
                    let f = NewsModel()
                    f.author = author
                    f.title = title
                    f.details = detail
                    f.url = url
                    f.urlToImage = image
                    f.publishedAt = date
                    
                    fav.append(f)
                    
                }
                if storageHandler != nil{
                    //print(allusrs)
                    storageHandler?.reportUserObtained(products: fav)
                }
            }
        }
        catch _{
            if storageHandler != nil{
                storageHandler?.reportUserObtained(products: fav)
            }
        }
    }
    
    
    
}
