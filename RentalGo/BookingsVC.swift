import UIKit

class BookingsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.arrData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderCell", for: indexPath) as! OrderCell
        cell.configCell(data: self.arrData[indexPath.row])
        if self.arrData[indexPath.row].isCancelled == "1" {
            cell.btnViewDetails.isHidden = true
        }
        cell.btnViewDetails.addTarget(self, action: #selector(self.getOrderDetails(_:)), for: .touchUpInside)
        return cell
    }
    
    
    @objc func getOrderDetails (_ Sender : UIButton) {
        let tag = Sender.tag
        let data = self.arrData[tag]
        print(data.docID)
        self.cancelledOrderData(docID: data.docID)
        
    }
    
    
    @IBOutlet weak var tblOrder : UITableView!
    
    var arrData  : [OrderModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.getOrderData()
        // Do any additional setup after loading the view.
    }
    

    func getOrderData() {
        _ = AppDelegate.shared.db.collection(gOrder).whereField(gEmail, isEqualTo: GFunction.user.email.description).addSnapshotListener{ querySnapshot, error in
            
            guard let snapshot = querySnapshot else {
                print("Error fetching snapshots: \(error!)")
                return
            }
            self.arrData.removeAll()
            if snapshot.documents.count != 0 {
                for data in snapshot.documents {
                    let data1 = data.data()
                    if let price : String = data1[gPrice] as? String, let name: String = data1[gName] as? String, let image: String = data1[gImages] as? String, let isBooked : String = data1[gIsBooked] as? String, let email: String = data1[gEmail] as? String, let isCancelled : String = data1[gIsCancelled] as? String  {
                        self.arrData.append(OrderModel(image: image, email: email, price: price, name: name, isBooked: isBooked,docID: data.documentID,isCancelled: isCancelled))
                    }
                }
                self.tblOrder.delegate = self
                self.tblOrder.dataSource = self
                self.tblOrder.reloadData()
            }
        }
    }
    
    func cancelledOrderData(docID:String) {
        
        let ref = AppDelegate.shared.db.collection(gOrder).document(docID)
        //let washingtonRef = db.collection("cities").document("DC")

        ref.updateData([
            gIsCancelled : "1"
        ]){ err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "CancelledVC") as! CancelledVC
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
}



class OrderCell: UITableViewCell {
    @IBOutlet weak var imgHotel: UIImageView!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var btnViewDetails: UIButton!
    
    func configCell(data: OrderModel) {
        self.imgHotel.setImgWebUrl(url: data.image, isIndicator: true)
        self.lblName.text = data.name.description
        self.lblPrice.text = data.price.description
    }
}

