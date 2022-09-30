//
//  HomeViewModel.swift
//  redBiciFront
//
//  Created by Camilo Jiménez on 25/09/22.
//

import Foundation
import Alamofire
import FirebaseAuth
class HomeViewModel: ObservableObject {
    @Published public var bikes: [Bike] = []
    @Published public var user: User? = nil
    @Published public var didLoad: Bool = false
    
    //private var urlString = "http://localhost:3000/"
    private var urlString = "https://redbicisback.herokuapp.com/"
    func fetchBikes() {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        
        let request = AF.request(urlString+ActionAPI.list.rawValue, method: .get, encoding: JSONEncoding.default)

        request.responseDecodable(of: [User].self) { res in
                switch res.result {
                case let .success(data):
                    self.user = data.first(where: { user in
                        user.userId == userID
                    })
                    self.bikes = data[0].bikes
                    print(self.user)
                    self.didLoad = true
                case let .failure(error):
                  print(error)
            }
        }
    }
    
    fileprivate func request(_ url: URL, _ jsonData: Data) {
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        AF.request(request).responseJSON { (response) in
            print(response)
        }
    }
    
    fileprivate func sendToBack(_ bLenght: Int) {
        do {
            let params = try JSONEncoder().encode(user)
            let json = String(data: params, encoding: String.Encoding.utf8)
            var urlAction = urlString
            if bLenght > 0 {
                urlAction += ActionAPI.update.rawValue
            } else {
                urlAction += ActionAPI.create.rawValue
            }
            
            let url = URL(string: urlAction)!
            let jsonData = json!.data(using: .utf8, allowLossyConversion: false)!
            
            request(url, jsonData)
        } catch {
            print(error)
        }
    }
    
    func saveBike(_ bike: Bike) {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        let indexBike = bikes.firstIndex { $0.id == bike.id }
        let bLenght =  bikes.count
        
        if let index = indexBike {
            bikes[index] = bike
        } else {
            bikes.append(bike)
        }
        
        if user == nil {
            user = User(userId: userID, bikes: bikes)
        } else {
            user?.bikes = bikes
        }
        
        sendToBack(bLenght)
    }
    
    func deleteBike(_ bike: Bike) {
        let indexBike = bikes.firstIndex { $0.id == bike.id }
        
        if let index = indexBike {
            bikes.remove(at: index)
        }
        
        user?.bikes = bikes
        
        do {
            let params = try JSONEncoder().encode(user)
            let json = String(data: params, encoding: String.Encoding.utf8)
            let url = URL(string: urlString+ActionAPI.update.rawValue)!
            let jsonData = json!.data(using: .utf8, allowLossyConversion: false)!
            
            request(url, jsonData)
        } catch {
            print(error)
        }

    }
}

enum ActionAPI: StringLiteralType {
    case list = "list"
    case create = "create"
    case update = "update"
}
