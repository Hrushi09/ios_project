import UIKit
class HotelModel : NSObject {
    var image : String
    var title : String
    var price : String
    var isBook : Bool
    
    init(image : String,title : String,price : String,isBook : Bool) {
        self.image = image
        self.title = title
        self.price = price
        self.isBook = isBook
    }
}

class DashboardVC: UIViewController,DataEnteredDelegate {
    func userDidConfirmBooking(isBook: Bool, hotelIndex: Int) {
        self.arrayHotels[hotelIndex].isBooked = isBook ? (1) : (0)
    }
    
    
    var arrayHotels : [HotelDataModel] = []
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getHotelIst()
//        self.arrayHotels = [
//            HotelModel(image: "hotel1", title: "Hotel 1", price: "500", isBook: false),
//            HotelModel(image: "hotel2", title: "Hotel 2", price: "400", isBook: false),
//            HotelModel(image: "hotel3", title: "Hotel 3", price: "300", isBook: false)
//        ]
        
    }
    
//    @IBAction func viewdetailsBtnAction(_ sender: Any) {
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "FullDetailsVC") as! FullDetailsVC
//        vc.detailImage = arrayHotels[0].image
//        vc.titleStr = arrayHotels[0].name
//        vc.priceStr = arrayHotels[0].price.description
//        arrayHotels[0].status == "Available" ? (vc.isBook = false) : (vc.isBook = true)
//        vc.hotelNumber = 0
//        vc.delegate = self
//        self.navigationController?.pushViewController(vc, animated: true)
//    }
//
//    @IBAction func viewdetailsBtnAction1(_ sender: Any) {
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "FullDetailsVC") as! FullDetailsVC
//        vc.detailImage = arrayHotels[1].image
//        vc.titleStr = arrayHotels[1].name
//        vc.priceStr = arrayHotels[1].price.description
//        arrayHotels[1].status == "Available" ? (vc.isBook = false) : (vc.isBook = true)
//        vc.hotelNumber = 1
//        vc.delegate = self
//        self.navigationController?.pushViewController(vc, animated: true)
//    }
//
//    @IBAction func viewdetailsBtnAction2(_ sender: Any) {
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "FullDetailsVC") as! FullDetailsVC
//        vc.detailImage = arrayHotels[2].image
//        vc.titleStr = arrayHotels[2].name
//        vc.priceStr = arrayHotels[2].price.description
//        arrayHotels[2].status == "Available" ? (vc.isBook = false) : (vc.isBook = true)
//        vc.hotelNumber = 2
//        vc.delegate = self
//        self.navigationController?.pushViewController(vc, animated: true)
//    }
    
//    @IBAction func btnViewBookingsTapped(_ sender: Any) {
//        let vc = storyboard?.instantiateViewController(withIdentifier: "BookingsVC") as! BookingsVC
//        for i in 0...2 {
//            if arrayHotels[i].isBooked == 1 {
//                vc.arrayShowItems.append(i)
//            }
//        }
//
//        if vc.arrayShowItems.isEmpty {
//            let refreshAlert = UIAlertController(title: "Booking Not Found", message: "You are not book any hotel", preferredStyle: UIAlertController.Style.alert)
//            refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
//                self.dismiss(animated: true , completion: nil)
//               }))
//            self.present(refreshAlert, animated: true, completion: nil)
//        } else {
//            self.navigationController?.pushViewController(vc, animated: true)
//        }
//
//    }
    
    
    func getHotelIst() {
        
        _ = AppDelegate.shared.db.collection(gHotel).addSnapshotListener{ querySnapshot, error in
            
            guard let snapshot = querySnapshot else {
                print("Error fetching snapshots: \(error!)")
                return
            }
            
            if snapshot.documents.count != 0 {
                for data in snapshot.documents {
                    let data1 = data.data()
                    if let price : String = data1[gPrice] as? String, let name: String = data1[gName] as? String, let image: String = data1[gImages] as? String, let isBooked : Int = data1[gIsBooked] as? Int, let status: String = data1[gstatus] as? String {
                        self.arrayHotels.append(HotelDataModel(name: name, status: status, isBooked: isBooked, image: image, rating: 4.5, price: price))
                    }
                }
            }else{

            }
        }
        
    }
}

