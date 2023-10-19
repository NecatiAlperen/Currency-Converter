//
//  ViewController.swift
//  CurrencyCoverterApp
//
//  Created by Necati Alperen IŞIK on 2.10.2023.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var dolarLabel: UILabel!
    @IBOutlet weak var euroLabel: UILabel!
    @IBOutlet weak var gramAltinLabel: UILabel!
    @IBOutlet weak var ceyrekAltinLabel: UILabel!
    @IBOutlet weak var gramGumusLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func getRates(_ sender: UIButton) {
        
        if let url = URL(string: "https://finans.truncgil.com/today.json") {
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    DispatchQueue.main.async {
                        print("Hata \(error.localizedDescription)")
                    }
                    return
                }
                
                guard let data = data else {
                    DispatchQueue.main.async {
                        print("Veri alınamadı.")
                    }
                    return
                }
                
                do {
                    if let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        DispatchQueue.main.async {
                            if let usdInfo = jsonResponse["USD"] as? [String: String], let usdRate = usdInfo["Satış"] {
                                self.dolarLabel.text = "Dolar : \(usdRate)"
                            }
                            
                            if let euroInfo = jsonResponse["EUR"] as? [String: String], let euroRate = euroInfo["Satış"] {
                                self.euroLabel.text = "Euro : \(euroRate)"
                            }
                            
                            if let gramAltinInfo = jsonResponse["gram-altin"] as? [String: String], let gramAltinRate = gramAltinInfo["Satış"] {
                                self.gramAltinLabel.text = "Gram Altın : \(gramAltinRate)"
                            }
                            
                            if let ceyrekAltinInfo = jsonResponse["ceyrek-altin"] as? [String: String], let ceyrekAltinRate = ceyrekAltinInfo["Satış"] {
                                self.ceyrekAltinLabel.text = "Çeyrek Altın : \(ceyrekAltinRate)"
                            }
                            
                            if let gumusInfo = jsonResponse["gumus"] as? [String: String], let gumusRate = gumusInfo["Satış"] {
                                self.gramGumusLabel.text = "Gram Gümüş : \(gumusRate)"
                            }
                        }
                    } else {
                        print("Döviz kuru bilgisi çıkartılamadı.")
                    }
                } catch {
                    print("JSON ayrıştırma hatası: \(error.localizedDescription)")
                }
            }
            task.resume()
        } else {
            print("Geçersiz URL.")
        }
    }
}
