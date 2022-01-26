


import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    
    var flag = true
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func signinBtnAction(_ sender: Any) {
        self.flag = true
        
        self.loginUser(email: (self.txtEmail.text?.trim())!, password: (self.txtPassword.text?.trim())!)
    }
    
    @IBAction func forgotBtnAction(_ sender: Any) {let vc = self.storyboard?.instantiateViewController(withIdentifier: "ForgotPasswordVC") as! ForgotPasswordVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func loginUser(email:String,password:String) {
    
        _ = AppDelegate.shared.db.collection(gUser).whereField(gEmail, isEqualTo: email).whereField(gPassword, isEqualTo: password).addSnapshotListener{ querySnapshot, error in
            
            guard let snapshot = querySnapshot else {
                print("Error fetching snapshots: \(error!)")
                return
            }
            
            if snapshot.documents.count != 0 {
                let data1 = snapshot.documents[0].data()
                if let email : String = data1[gEmail] as? String, let name: String = data1[gfullName] as? String {
                    GFunction.shared.firebaseLogin(data: email)
                    GFunction.user = UserModel(fullName: name, email: email)
                    UserDefaults.standard.set(true, forKey: UserDefaults.Keys.currentUser)
                    UserDefaults.standard.set(email, forKey: UserDefaults.Keys.isEmail)
                    UserDefaults.standard.synchronize()
                    self.flag = false
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }else{
                if self.flag {
                    Alert.shared.showAlert(message: "Please check your credentials !!!", completion: nil)
                    self.flag = false
                }
            }
        }
        
    }
}

