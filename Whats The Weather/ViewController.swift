//
//  ViewController.swift
//  Whats The Weather
//
//  Created by Solayman Rana on 16/7/19.
//  Copyright © 2019 Solayman Rana. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var cityTextField: UITextField!
    
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBAction func getWeather(_ sender: Any) {
        
        if let url = URL (string: "https://www.weather-forecast.com/locations/"+cityTextField.text!.replacingOccurrences(of: " ", with: "-")+"/forecasts/latest") {
            let request = NSMutableURLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request as URLRequest){
            
            data, response, error in
            
            var message = ""
            
            if error != nil {
                
                print (error)
            } else {
                
                if let unWrappedData = data {
                    
                    let dataString = NSString (data: unWrappedData, encoding:  String.Encoding.utf8.rawValue)
                    var stringSaparator = "Dhaka Weather Today </h2>(1&ndash;3 days)</span><p class=\"b-forecast__table-description-content\"><span class=\"phrase\">"
                    
                    if let contentArray = dataString?.components(separatedBy: stringSaparator) {
                        if contentArray.count > 1 {
                            
                            stringSaparator = "</span>"
                            
                            let newContentArray = contentArray[1].components(separatedBy: stringSaparator)
                            
                            if newContentArray.count > 1 {
                                
                                message = newContentArray[0].replacingOccurrences(of: "&deg;", with: "°")
                                print (message)
                                
                            }
                            
                        }
                        
                    }
                    
                }
            }
            
            if message == "" {
                
                message = "The weather there couldn't be found. Please try again"
            }
            
            DispatchQueue.main.async(execute: {
                
                self.resultLabel.text = message
                
            })
            
        }
        
        task.resume()
        
        } else {
            
            resultLabel.text = "The weather there couldn't be found. Please try again"
        }
        
    }

        
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       

}

}
