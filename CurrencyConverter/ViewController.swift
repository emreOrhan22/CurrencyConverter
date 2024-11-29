//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by Emre on 21.11.2024.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var audLabel: UILabel!
    
    
    @IBOutlet weak var cadLabel: UILabel!
    
    
    
    @IBOutlet weak var jpyLabel: UILabel!
    
    
    @IBOutlet weak var usdLabel: UILabel!
    
    
    
    @IBOutlet weak var tryLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func updateClick(_ sender: Any) {
        let url = URL(string:"http://data.fixer.io/api/latest?access_key=066ba26ab02572c7bf01f6ef2fb46be0")
        let session = URLSession.shared
        let task = session.dataTask(with: url!){data,response,error in
            if error != nil{
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
            }else{
                if data != nil {
                    do{
                        let jsonResponse  = try JSONSerialization.jsonObject(with: data!,
                                                                             options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String, Any>
                        DispatchQueue.main.async {
                            if let rates = jsonResponse["rates"] as? [String: Any]{
                                if let aud = rates["AUD"] as? Double{
                                    self.audLabel.text = "AUD: \(aud)"
                                }
                                if let cad = rates["CAD"] as? Double{
                                    self.cadLabel.text = "CAD: \(cad)"
                                }
                                if let jpy = rates["JPY"] as? Double{
                                    self.jpyLabel.text = "JPY: \(jpy)"
                                }
                                if let usd = rates["USD"] as? Double{
                                    self.usdLabel.text = "USD: \(usd)"
                                }
                                if let turkLirasi = rates["TRY"] as? Double{
                                    self.tryLabel.text = "TRY: \(turkLirasi)"
                                }
                            }
                        }
                    }catch{
                        print("ERROR")
                    }
                }
            }
        }
        task.resume()
        
    }
    
}
