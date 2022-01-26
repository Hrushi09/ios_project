


import UIKit

class ForgotPasswordVC: UIViewController {

    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtConfirmPassword: UITextField!
    
    
    var flag = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func resetBtnAction(_ sender: Any) {
        self.flag = true
        self.checkUser(email: (self.txtEmail.text?.trim())!, password: (self.txtPassword.text?.trim())!)
    }
    
    func checkUser(email:String,password:String) {
        
        _ = AppDelegate.shared.db.collection(gUser).whereField(gEmail, isEqualTo: email).addSnapshotListener{ querySnapshot, error in
            
            guard let snapshot = querySnapshot else {
                print("Error fetching snapshots: \(error!)")
                return
            }
            
            if snapshot.documents.count != 0 {
                let data = snapshot.documents[0]
                self.updatePAssword(docID: data.documentID, password: password)
                self.flag = false
            }else{
                if self.flag {
                    Alert.shared.showAlert(message: "Please enter valid email address !!!", completion: nil)
                    self.flag = false
                }
            }
        }
    }
    
    func updatePAssword(docID: String,password:String) {
        let ref = AppDelegate.shared.db.collection(gUser).document(docID)
        ref.updateData([
            gPassword : password
        ]){ err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
                self.navigationController?.popViewController(animated: true)
            }
        }
    }

}
