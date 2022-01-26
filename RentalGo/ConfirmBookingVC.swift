import UIKit
import Cosmos

class ConfirmBookingVC: UIViewController {

    //MARK:- Outlet
    
    @IBOutlet weak var cosmosView: CosmosView!
    @IBOutlet weak var lblMsg : UILabel!
    @IBOutlet weak var btnContinue : UIButton!
    
    //MARK:- Class Variable
    
    //MARK:- Custom Method
    
    func setUpView(){
        self.applyStyle()
        self.cosmosView.didFinishTouchingCosmos =  { rating in
            self.btnContinue.isHidden = false
            self.lblMsg.isHidden = false
        }
    }
    
    func applyStyle(){
        
    }
    
    //MARK:- Action Method
    @IBAction func btnContinueTapped(_ sender: Any) {
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers
        for aViewController in viewControllers {
            if aViewController is HomeVC {
                self.navigationController!.popToViewController(aViewController, animated: true)
            }
        }
    }
    
    //MARK:- Delegates
    
    //MARK:- UILifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpView()
    }
}

