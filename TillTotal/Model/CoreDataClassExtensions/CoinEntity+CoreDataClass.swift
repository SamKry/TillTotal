//
//  CoinEntity+CoreDataClass.swift
//  TillTotal
//
//  Created by Samuel Kreyenbühl on 24.07.23.
//
//

import Foundation
import CoreData

@objc(CoinEntity)
public class CoinEntity: NSManagedObject {
    
    func setNumber(byNumber number:Int64){
        self.number = number
    }
    
    func setNumber(byTotal total:Double){
        self.number = Int64((total/value)+0.5)
    }
    
    func getTotal() -> Double{
        return value*Double(number)
    }
}
