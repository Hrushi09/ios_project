import UIKit

class CancelledVC: UIViewController {

    
    @IBOutlet weak var btnContinue : UIButton!
    
    @IBAction func btnContinueClick(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withClass: HomeVC.self)
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.btnContinue.layer.cornerRadius = 15
        // Do any additional setup after loading the view.
    }
}

