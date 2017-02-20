//
//  ViewController.swift
//  demo
//
//  Created by Andrey Zavaliy on 17.02.17.
//  Copyright © 2017 Estafeta. All rights reserved.
//

import UIKit

protocol MyProtocol: class
{
    func sendArrayToPreviousVC(myArray:[AnyObject])
}

class ViewController: UIViewController {

    @IBOutlet weak var textFieldName: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    var callback : (([demoData]) -> Void)?
    var myDataArr = [demoData]()
    
    weak var mDelegate:MyProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        textFieldName.text = "999@9F346DDB-8FF8-4F42-8221-6E03D6491756"
        textFieldPassword.text = "999"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func tapButtonLogin(_ sender: Any) {
        //print("Try login")
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        view.addSubview(activityIndicator)
        activityIndicator.frame = view.bounds
        activityIndicator.startAnimating()
        
        // set up the base64-encoded credentials
        let loginString = NSString(format: "%@:%@", textFieldName.text!, textFieldPassword.text!)
        let loginData: NSData = loginString.data(using: String.Encoding.utf8.rawValue)! as NSData
        let base64LoginString = loginData.base64EncodedString(options: NSData.Base64EncodingOptions.lineLength64Characters)
        
        // create the request
        let url = NSURL(string: "http://amt-demo.estafeta.org/api/mobilesurveytasks/gettestsurveytasks")!
        let request = NSMutableURLRequest(url: url as URL)
        request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        request.httpMethod="GET"
        
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest) {
            (data, response, error) -> Void in
            
            let httpResponse = response as! HTTPURLResponse
            
            if (httpResponse.statusCode == 200) {
                do {
                    if (data != nil){
                        var myDataArr = [demoData]()
                        
                        let jsonArr = try JSONSerialization.jsonObject(with: data!,options: .allowFragments) as! [[String: Any]]
                        for i in 0 ..< jsonArr.count{
                            let myData = demoData(dataId: 0, dataNumber: "", dataPlannedStartDate: "", dataPlannedEndDate: "", dataActualStartDate: "", dataActualEndDate: "", dataVin: "", dataModel: "", dataModelCode: "", dataBrand: "", dataSurveyPoint: "", dataCarrier: "", dataDriver: "")
                            if (jsonArr[i]["Id"] as? Int) != nil {
                                myData.dataId = jsonArr[i]["Id"] as! Int
                                if (jsonArr[i]["Number"] as? String) != nil {
                                    myData.dataNumber = jsonArr[i]["Number"] as! String
                                }
                                if (jsonArr[i]["PlannedStartDate"] as? String) != nil {
                                    myData.dataPlannedStartDate = jsonArr[i]["PlannedStartDate"] as! String
                                }
                                if (jsonArr[i]["PlannedEndDate"] as? String) != nil {
                                    myData.dataPlannedEndDate = jsonArr[i]["PlannedEndDate"] as! String
                                }
                                if (jsonArr[i]["ActualStartDate"] as? String) != nil {
                                    myData.dataActualStartDate = jsonArr[i]["ActualStartDate"] as! String
                                }
                                if (jsonArr[i]["ActualEndDate"] as? String) != nil {
                                    myData.dataActualEndDate = jsonArr[i]["ActualEndDate"] as! String
                                }
                                if (jsonArr[i]["Vin"] as? String) != nil {
                                    myData.dataVin = jsonArr[i]["Vin"] as! String
                                }
                                if (jsonArr[i]["Model"] as? String) != nil {
                                    myData.dataModel = jsonArr[i]["Model"] as! String
                                }
                                if (jsonArr[i]["ModelCode"] as? String) != nil {
                                    myData.dataModelCode = jsonArr[i]["ModelCode"] as! String
                                }
                                if (jsonArr[i]["Brand"] as? String) != nil {
                                    myData.dataBrand = jsonArr[i]["Brand"] as! String
                                }
                                if (jsonArr[i]["SurveyPoint"] as? String) != nil {
                                    myData.dataSurveyPoint = jsonArr[i]["SurveyPoint"] as! String
                                }
                                if (jsonArr[i]["Carrier"] as? String) != nil {
                                    myData.dataCarrier = jsonArr[i]["Carrier"] as! String
                                }
                                if (jsonArr[i]["Driver"] as? String) != nil {
                                    myData.dataDriver = jsonArr[i]["Driver"] as! String
                                }
                                myDataArr.append(myData)
                            }
                            
                        }
                        activityIndicator.removeFromSuperview()
                        print(myDataArr.count)
                        self.callback?(myDataArr)
                        //self.mDelegate?.sendArrayToPreviousVC(myArray: myDataArr)
                        
                        self.dismiss(animated: true, completion: nil)
                    } else{
                        activityIndicator.removeFromSuperview()
                        print("Data is empty")
                    }
                    
                } catch {
                    activityIndicator.removeFromSuperview()
                    print("Error with Json: \(error)")
                }
            }else{
                activityIndicator.removeFromSuperview()
                print("HTTP Error")
            }
        }
        task.resume()
    }
}

