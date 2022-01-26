

import UIKit

class SelectionCVC: UICollectionViewCell {
    
    @IBOutlet weak var imgVwPic: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
}

class SelectionVC: UIViewController {

    @IBOutlet weak var colVwList: UICollectionView!
    
    var appleData: AppleLoginModel!
    private let appleLoginManager: AppleLoginManager = AppleLoginManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    

    @IBAction func LoginBtnAction(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func CreateBtnAction(_ sender: Any) {let vc = self.storyboard?.instantiateViewController(withIdentifier: "CreateProfileVC") as! CreateProfileVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func AppleBtnAction(_ sender: Any) {
        self.appleLoginManager.performAppleLogin()
    }
  
}
extension SelectionVC: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SelectionCVC", for: indexPath) as! SelectionCVC
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.height)
    }
}


//MARK:- Apple Login
extension SelectionVC: AppleLoginDelegate {

    func appleLoginData(data: AppleLoginModel) {
        print("Social Id==>", data.socialId ?? "")
        print("First Name==>", data.firstName ?? "")
        print("Last Name==>", data.lastName ?? "")
        print("Email==>", data.email ?? "")
        print("Login type==>", data.loginType ?? "")
    }
    
}

