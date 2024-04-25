//
//  ViewController.swift
//  dieselappApi
//
//  Created by Olgun ‏‏‎‏‏‎ on 21.04.2024.
//
import Foundation
import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var markaLabel: UILabel!
    
    @IBOutlet weak var katkiliLabel: UILabel!
    @IBOutlet weak var benzinLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func getClicked(_ sender: Any) {
   

        let headers = [
          "content-type": "application/json",
          "authorization": "example"
        ]

        let request = NSMutableURLRequest(url: NSURL(string: "https://api.collectapi.com/gasPrice/turkeyGasoline?district=kadikoy&city=istanbul")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
          if (error != nil) {
            print("error")
          } else {
              do {
                  let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: []) as! [String: Any]
                  if let results = jsonResponse["result"] as? [[String: Any]] {
                      var markalar = [String]()
                      var benzinli = [String]()
                      var katkililar = [String]()
                      for result in results {
                          if let marka = result["marka"] as? String {
                              markalar.append(marka)
                          }
                          if let benzin = result["benzin"] as? String {
                              benzinli.append(benzin)
                          }
                          if let katkili = result["katkili"] as? String {
                              katkililar.append(katkili)
                          }
                      }
                      DispatchQueue.main.async {
                          if markalar.isEmpty == false {
                                 self.markaLabel.text = markalar[0]
                             }
                             if let benzin = benzinli.first, benzin.isEmpty == false {
                                 self.benzinLabel.text = benzinli[0]
                             }
                             if katkililar.isEmpty == false {
                                 self.katkiliLabel.text = katkililar[0]
                             }
                      }
                  } else {
                      print("Marka bilgisi bulunamadı.")
                  }
              } catch {
                  print("JSON parsing error: \(error)")
              }

          
          }
        })

        dataTask.resume()
    }
    
}

