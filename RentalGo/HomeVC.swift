
//
//  HomeVC.swift
// 

import UIKit
import Cosmos

class HomeVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.arrData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HotelView", for: indexPath) as! HotelView
        cell.configCell(data: self.arrData[indexPath.row])
        cell.btnViewDetails.tag = indexPath.row
        cell.btnViewDetails.addTarget(self, action: #selector(self.getHotelDetails(_:)), for: .touchUpInside)
        return cell
    }
    
    
    @objc func getHotelDetails (_ Sender : UIButton) {
        let tag = Sender.tag
        let data = self.arrData[tag]
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "FullDetailsVC") as! FullDetailsVC
        vc.detailImage = data.image
        vc.titleStr = data.name
        vc.priceStr = data.price
        data.status == "Available" ? (vc.isBook = false) : (vc.isBook = true)
        vc.hotelNumber = tag + 1
        vc.data = data
        self.navigationController?.pushViewController(vc, animated: true)
    }

    
    
    @IBOutlet weak var tblHotel: UITableView!
    
    var arrData : [HotelDataModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getHotelIst()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func btnViewBookingsTapped(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "BookingsVC") as! BookingsVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnSignOutTapped(_ sender: Any) {
        UIApplication.shared.logoutAppUser()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }

}




class HotelView: UITableViewCell {
    @IBOutlet weak var imgHotel: UIImageView!
    @IBOutlet weak var VwRating: CosmosView!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var btnViewDetails: UIButton!
    
    func configCell(data: HotelDataModel) {
        self.imgHotel.setImgWebUrl(url: data.image, isIndicator: true)
        self.lblName.text = data.name.description
        self.lblPrice.text = data.price.description
        self.VwRating.rating = 3.90
    }
}


extension HomeVC {
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
                        self.arrData.append(HotelDataModel(name: name, status: status, isBooked: isBooked, image: image, rating: 4.5, price: price))
                    }
                }
                self.tblHotel.delegate = self
                self.tblHotel.dataSource = self
                self.tblHotel.reloadData()
            }
        }
        
    }
}
