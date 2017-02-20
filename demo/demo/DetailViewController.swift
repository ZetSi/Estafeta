//
//  DetailViewController.swift
//  demo
//
//  Created by Andrey Zavaliy on 19.02.17.
//  Copyright © 2017 Estafeta. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var labelNumber: UILabel!
    @IBOutlet weak var labelPlannedStartDate: UILabel!
    @IBOutlet weak var labelPlannedEndDate: UILabel!
    @IBOutlet weak var labelActualStartDate: UILabel!
    @IBOutlet weak var labelActualEndDate: UILabel!
    @IBOutlet weak var labelVin: UILabel!
    @IBOutlet weak var labelModel: UILabel!
    @IBOutlet weak var labelModelCode: UILabel!
    @IBOutlet weak var labelBrand: UILabel!
    @IBOutlet weak var labelSurveyPoint: UILabel!
    @IBOutlet weak var labelCarrier: UILabel!
    @IBOutlet weak var labelDriver: UILabel!
    
    var dataItem: demoData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let newtitle = dataItem?.dataId {
            navigationItem.title = String(describing: newtitle)
        } else {
            navigationItem.title = ""
        }
        labelNumber.text = dataItem?.dataNumber
        labelPlannedStartDate.text = dataItem?.dataPlannedStartDate
        labelPlannedEndDate.text = dataItem?.dataPlannedEndDate
        labelActualStartDate.text = dataItem?.dataActualStartDate
        labelActualEndDate.text = dataItem?.dataActualEndDate
        labelVin.text = dataItem?.dataVin
        labelModel.text = dataItem?.dataModel
        labelModelCode.text = dataItem?.dataModelCode
        labelBrand.text = dataItem?.dataBrand
        labelSurveyPoint.text = dataItem?.dataSurveyPoint
        labelCarrier.text = dataItem?.dataCarrier
        labelDriver.text = dataItem?.dataDriver
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
