
import UIKit	

class CreateProfileVC: UIViewController {

    @IBOutlet weak var txtname: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtConfirmPassword: UITextField!
    
    
    var flag = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func createBtnAction(_ sender: Any) {
        flag = false
        self.getExistingUser(email: (self.txtEmail.text?.trim())!, password: (self.txtPassword.text?.trim())!, fullName: self.txtname.text!)
    }
}



//MARK:- Extension for Login Function
extension CreateProfileVC {
    
    func createAccount(password:String,email:String,fullName:String) {
        var ref : DocumentReference? = nil
        
        ref = AppDelegate.shared.db.collection(gUser).addDocument(data:
            [ gPassword : password,
              gEmail: email,
               gfullName: fullName,
              gServerTime : FieldValue.serverTimestamp()
            ])
        {  err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
                GFunction.shared.firebaseLogin(data: email)
                GFunction.user = UserModel(fullName: fullName, email: email)
                UserDefaults.standard.set(true, forKey: UserDefaults.Keys.currentUser)
                UserDefaults.standard.set(email, forKey: UserDefaults.Keys.isEmail)
                UserDefaults.standard.synchronize()
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    func getExistingUser(email:String,password:String,fullName:String) {
    
        _ = AppDelegate.shared.db.collection(gUser).whereField(gEmail, isEqualTo: email).addSnapshotListener{ querySnapshot, error in
            
            guard let snapshot = querySnapshot else {
                print("Error fetching snapshots: \(error!)")
                return
            }
            
            if snapshot.documents.count == 0 {
                self.createAccount(password: password, email: email, fullName: fullName)
                self.flag = true
            }else{
                if !self.flag {
                    Alert.shared.showAlert(message: "UserName already exist !!!", completion: nil)
                    self.flag = true
                }
            }
        }
        
    }
}

