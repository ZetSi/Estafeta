//
//  demoData.swift
//  demo
//
//  Created by Andrey Zavaliy on 18.02.17.
//  Copyright © 2017 Estafeta. All rights reserved.
//

import UIKit

class demoData {
    var dataId : Int
    var dataNumber : String
    var dataPlannedStartDate : String
    var dataPlannedEndDate : String
    var dataActualStartDate : String
    var dataActualEndDate : String
    var dataVin : String
    var dataModel : String
    var dataModelCode : String
    var dataBrand : String
    var dataSurveyPoint : String
    var dataCarrier : String
    var dataDriver : String
    
    init (dataId : Int, dataNumber : String, dataPlannedStartDate : String, dataPlannedEndDate : String, dataActualStartDate : String, dataActualEndDate : String, dataVin : String, dataModel : String, dataModelCode : String, dataBrand : String, dataSurveyPoint : String, dataCarrier : String, dataDriver : String) {
        self.dataId = dataId
        self.dataNumber = dataNumber
        self.dataPlannedStartDate = dataPlannedStartDate
        self.dataPlannedEndDate = dataPlannedEndDate
        self.dataActualStartDate = dataActualStartDate
        self.dataActualEndDate = dataActualEndDate
        self.dataVin = dataVin
        self.dataModel = dataModel
        self.dataModelCode = dataModelCode
        self.dataBrand = dataBrand
        self.dataSurveyPoint = dataSurveyPoint
        self.dataCarrier = dataCarrier
        self.dataDriver = dataDriver
    }
}
