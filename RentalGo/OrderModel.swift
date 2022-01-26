//
//  OrderModel.swift
//  Testing
//
//  Created by 2022M3 on 25/01/22.
//

import Foundation


class OrderModel {
    var image: String!
    var email: String!
    var price: String!
    var name: String!
    var isBooked: String!
    var docID: String!
    var isCancelled: String!
    
    init(image:String, email:String, price:String, name:String, isBooked:String,docID:String,isCancelled: String){
        self.image = image
        self.price = price
        self.isBooked = isBooked
        self.name = name
        self.email = email
        self.docID = docID
        self.isCancelled = isCancelled
    }
    
    init () {
    }
}
