//
//  FireBaseHelper.swift
//  VideoStream
//
//  Created by macbook_user on 10/19/17.
//  Copyright © 2017 macbook_user. All rights reserved.
//

import Foundation
import FirebaseDatabase

class FirebaseHelpers {
    var ref: DatabaseReference!
    static var finalResult : [Any] = []
    static var isComplete : Bool! = false
    
    init() {
        ref = Database.database().reference()
    }
    
    func fbCreate(tableName : String) {
        
    }
    
    func fbInsert(tableName : String, columnNames : [String], parameters : [String]) {
        
    }
    
    func fbUpdate(tableName : String, columnNames : [String], parameters : [String], isAnd : Bool) {
        
    }
    
    func fbDelete(tableName : String, columnNames : [String], parameters : [String], isAnd : Bool) {
        
    }
    
    func fbSelect(tableName : String, selectColumnNames : [String], columnNames : [String], parameters : [String], isAnd : Bool) {
        //let semaphore = DispatchSemaphore(value: 0) //creating a "closed" semaphore
        
        let tableRef = ref.child(tableName)
        
        tableRef.observe(.value, with: { snapshot in
            if snapshot.hasChildren() {
                print("Snapshot has \(snapshot.childrenCount) children")
                
                let records = snapshot.children
                for record in records {
                    print("Record = \(record)")
                    FirebaseHelpers.finalResult.append(record)
                }
                
                print("Final Result = \(FirebaseHelpers.finalResult)")
            }
            FirebaseHelpers.isComplete = true
            //print("Is Complete = \(Bool(FirebaseHelpers.isComplete))")
            //semaphore.signal()
        })
        
        /*DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            
        }
        
        //let timeout = dispatch_time_t(DispatchTime.now(), 2000)
        //let timeout = DispatchTime.init(uptimeNanoseconds: 10000000000)
        //let timeout = DispatchTime.distantFuture
        //let t : UInt64 = 3000
        
        //print("TEST = \(semaphore.wait(timeout: timeout))")
        if semaphore.wait(timeout: timeout) == DispatchTimeoutResult.timedOut { // waiting until semaphore conter becomes greater than 0
            print("timed out")
        }
        
        print("Final Result inside fbSelect = \(finalResult)")
        return finalResult*/
    }
}
