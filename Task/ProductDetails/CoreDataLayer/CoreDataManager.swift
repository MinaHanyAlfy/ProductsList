//
//  CoreDataManager.swift
//  Task
//
//  Created by John Doe on 2022-06-10.
//

import Foundation
import UIKit
import CoreData
public class CoreDataManager{
    
    static public let shared = CoreDataManager()
    
    let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    func saveProducts(products: Products){

        for product in products {
            
            if !isExist(id: product.id ?? 0){
                
                let prd = ProductCD(context: context())
                prd.id = Int64(product.id ?? 0)
                prd.productDescription = product.productDescription
                prd.price = Int64(product.price ?? 0)
                
                let img = ImageCD(context: context())
                img.width = Int64(product.image?.width ?? 0)
                img.height = Int64(product.image?.height ?? 0)
                img.url = product.image?.url
                
                prd.image = img
    
                do {
                    try context().save()
                    print("✅ Success")
                } catch let error as NSError {
                    print(error)
                }
                
            }
            
        }
        
        
    }
    
    func countProducts() -> Int{
        let context = context()
        let fetchRequest: NSFetchRequest<ProductCD> = ProductCD.fetchRequest()
        let objects = try! context.fetch(fetchRequest)
        
        return objects.count
    }
    
    func clearProducts() {
        let context = context()
        let fetchRequestProduct: NSFetchRequest<ProductCD> = ProductCD.fetchRequest()
        let objects = try! context.fetch(fetchRequestProduct)
        
        for obj in objects {
            context.delete(obj)
        }
        
        do {
            try context.save()
        } catch {
            print("❌ Error Delete Object")
        }
    }
    
    func getProducts() -> Products{
        let context = context()
        let fetchRequest: NSFetchRequest<ProductCD> = ProductCD.fetchRequest()
        let objects = try! context.fetch(fetchRequest)
        var products: Products = []
        for objc in objects {
            let product = Product(id: Int(objc.id), productDescription: objc.productDescription, image: Image(width: Int(objc.image?.width ?? 0), height: Int(objc.image?.height ?? 0), url: objc.image?.url), price: 5)

            products.append(product)
            
            
        }
        return products
    }
    
    
    func isExist(id: Int) -> Bool {
        
        let managedContext = context()
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "ProductCD")
        fetchRequest.fetchLimit =  1
        fetchRequest.predicate = NSPredicate(format: "id == %d" ,id)
        
        do {
            let count = try managedContext.count(for: fetchRequest)
            if count > 0 {
                return true
            }else {
                return false
            }
        }catch let error as NSError {
            print("❌ Could not fetch. \(error), \(error.userInfo)")
            return false
        }
    }
    
    
}
extension CoreDataManager{
    
    
    func context() ->  NSManagedObjectContext {
        let context = appDelegate.persistentContainer.viewContext
        return context
    }
    
    func save() {
        appDelegate.saveContext()
    }
    
    
}
