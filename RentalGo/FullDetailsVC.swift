

import UIKit
import AppRating
protocol DataEnteredDelegate {
    func userDidConfirmBooking(isBook : Bool,hotelIndex:Int)
}

class FullDetailsVC: UIViewController {

    @IBOutlet weak var hotelprice: UILabel!
    @IBOutlet weak var hotelname: UILabel!
    @IBOutlet weak var fullimage: UIImageView!
    @IBOutlet weak var btnBook : UIButton!
    
    var data : HotelDataModel!
    var detailImage = String()
    var titleStr = String()
    var priceStr = String()
    var isBook = Bool()
    var hotelNumber = -1
    
    @IBAction func btnBookTapped(_ sender: Any) {
        self.orderHotel(data: self.data)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fullimage.setImgWebUrl(url: detailImage, isIndicator: true)
        hotelname.text = titleStr
        hotelprice.text = "\(priceStr)"
        if isBook {
            self.btnBook.isEnabled = false
            self.btnBook.backgroundColor = UIColor.gray
            self.btnBook.setTitle("Booked", for: .disabled)
            self.btnBook.isUserInteractionEnabled = false
        } else {
            self.btnBook.isUserInteractionEnabled = true
        }
    }
    
    func orderHotel(data: HotelDataModel){
        var ref : DocumentReference? = nil
        
        ref = AppDelegate.shared.db.collection(gOrder).addDocument(data:
                                                                    [ gName : data.name.description,
                                                                     gPrice : data.price.description,
                                                                     gEmail : GFunction.user.email,
              gIsBooked : "1",
                                                                     gImages: data.image.description,
                                                               gIsCancelled : "0",
                                                               gHotelNumber : hotelNumber.description,
              gServerTime : FieldValue.serverTimestamp()
            ])
        {  err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "ConfirmBookingVC") as! ConfirmBookingVC
                self.isBook = true
                self.navigationController?.pushViewController(vc, animated: true)
               
            }
        }
    }
}

