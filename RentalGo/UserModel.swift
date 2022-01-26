
import Foundation


class UserModel {
    var fullName: String!
    var email:String!
    
    init(fullName:String,email:String) {
        self.email = email
        self.fullName = fullName
    }
    
    init() {
        
    }
}
