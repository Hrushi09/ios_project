


import Foundation


//0 : 2 elements
//  - key : "a3"
//  - value : Breakfast included
//▿ 1 : 2 elements
//  - key : "price"
//  - value : $65.30
//▿ 2 : 2 elements
//  - key : "image"
//  - value : https://www.catchit.com/hotels/picture/s/518/5/9/47994434.jpg
//▿ 3 : 2 elements
//  - key : "isBooked"
//  - value : 0
//▿ 4 : 2 elements
//  - key : "a4"
//  - value : Wifi
//▿ 5 : 2 elements
//  - key : "status"
//  - value : Available
//▿ 6 : 2 elements
//  - key : "name"
//  - value : Empire State
//▿ 7 : 2 elements
//  - key : "a2"
//  - value : AC & TV
//▿ 8 : 2 elements
//  - key : "a1"
//  - value : Parking


class HotelDataModel {
    var name: String!
    var status: String!
    var isBooked: Int!
    var image: String!
    var rating: Float!
    var price: String!
    
    
    init(name:String,status:String,isBooked: Int, image:String, rating: Float, price:String) {
        self.name = name
        self.status = status
        self.isBooked = isBooked
        self.image = image
        self.rating = rating
        self.price = price
    }
    
    init() {
        
    }
}
