//
//  CollectionViewController.swift
//  demo
//
//  Created by Andrey Zavaliy on 18.02.17.
//  Copyright © 2017 Estafeta. All rights reserved.
//

import UIKit

final class CollectionViewController: UICollectionViewController {
    
    @IBOutlet weak var buttonSort: UIButton!
    // MARK: - Properties
    fileprivate let reuseIdentifier = "CollectionCell"
    fileprivate let sectionInsets = UIEdgeInsets(top: 5.0, left: 5.0, bottom: 5.0, right: 5.0)
    
    fileprivate var demoDataArrUnsort = [demoData]()
    fileprivate var demoDataArr = [demoData]()
    fileprivate let itemsPerRow: CGFloat = 3
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if demoDataArrUnsort.count == 0 {
            self.performSegue(withIdentifier: "toLogin", sender: self)
        }
    }
    
    @IBAction func tapSortArray(_ sender: UIButton) {
        if buttonSort.title(for: .normal) == "Sort" {
            buttonSort.setTitle("UnSort",for: .normal)
            demoDataArr = demoDataArrUnsort.sorted { $0.dataId < $1.dataId }
            DispatchQueue.main.async(){
                self.collectionView?.reloadData()
            }
        } else {
            buttonSort.setTitle("Sort",for: .normal)
            demoDataArr = demoDataArrUnsort
            DispatchQueue.main.async(){
                self.collectionView?.reloadData()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toLogin" {
            let viewControllerB = segue.destination as! ViewController
            viewControllerB.callback = { message in
                DispatchQueue.main.async {
                    self.buttonSort.setTitle("Sort",for: .normal)
                    self.demoDataArr = message
                    self.demoDataArrUnsort = message
                    //print(message)
                    self.collectionView?.reloadData()
                }
            }
        }
        if segue.identifier == "toDetail" {
            if let indexPath = getIndexPathForSelectedCell() {
                
                let detailData = demoDataArr[indexPath.row]
                
                let detailViewController = segue.destination as! DetailViewController
                detailViewController.dataItem = detailData
            }
        }
    }
    
    // MARK:- Selected Cell IndexPath
    func getIndexPathForSelectedCell() -> NSIndexPath? {
        
        var indexPath:NSIndexPath?
        
        if (collectionView?.indexPathsForSelectedItems!.count)! > 0 {
            indexPath = collectionView?.indexPathsForSelectedItems![0] as NSIndexPath?
        }
        return indexPath
    }
}

extension CollectionViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // 1
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        textField.addSubview(activityIndicator)
        activityIndicator.frame = textField.bounds
        activityIndicator.startAnimating()
        
        demoDataArr = [demoData]()
        for i in 0...demoDataArrUnsort.count-1 {
            var exists = false
            if String(demoDataArrUnsort[i].dataId).lowercased().range(of:textField.text!.lowercased()) != nil {
                exists = true
            } else {
                if demoDataArrUnsort[i].dataNumber.lowercased().range(of:textField.text!.lowercased()) != nil {
                    exists = true
                } else {
                    if demoDataArrUnsort[i].dataVin.lowercased().range(of:textField.text!.lowercased()) != nil {
                        exists = true
                    } else {
                        if demoDataArrUnsort[i].dataModel.lowercased().range(of:textField.text!.lowercased()) != nil {
                            exists = true
                        } else {
                            if demoDataArrUnsort[i].dataModelCode.lowercased().range(of:textField.text!.lowercased()) != nil {
                                exists = true
                            } else {
                                if demoDataArrUnsort[i].dataSurveyPoint.lowercased().range(of:textField.text!.lowercased()) != nil {
                                    exists = true
                                } else {
                                    if demoDataArrUnsort[i].dataCarrier.lowercased().range(of:textField.text!.lowercased()) != nil {
                                        exists = true
                                    } else {
                                        if demoDataArrUnsort[i].dataDriver.lowercased().range(of:textField.text!.lowercased()) != nil {
                                            exists = true
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
            if exists == true {
                demoDataArr.append(demoDataArrUnsort[i])
            }
        }
        if demoDataArr.count != 0 {
            buttonSort.setTitle("Full data",for: .normal)
            DispatchQueue.main.async(){
                self.collectionView?.reloadData()
            }
        } else {
            let alert = UIAlertController(title: "Search Error!", message: "have not results", preferredStyle: .alert)
            
            let alertAction = UIAlertAction(title: "Dismiss", style: .destructive, handler: nil)
            alert.addAction(alertAction)
            
            self.present(alert, animated: true, completion: nil)
            buttonSort.setTitle("Sort",for: .normal)
            demoDataArr = demoDataArrUnsort
            DispatchQueue.main.async(){
                self.collectionView?.reloadData()
            }
        }
        activityIndicator.removeFromSuperview()
        
        textField.text = nil
        textField.resignFirstResponder()
        return true
    }
}

// MARK: - UICollectionViewDataSource
extension CollectionViewController {
    //1
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    //2
    override func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        return demoDataArr.count
    }
    
    //3
    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier,
                                                      for: indexPath) as! CollectionCell
        //let dataItem = demoDataArr[(indexPath as NSIndexPath).section]
        
        let dataItem = demoDataArr[indexPath.row]
        //cell.backgroundColor = UIColor.gray

        cell.labelId.text = String(dataItem.dataId)
        cell.labelBrandModel.text = "\(dataItem.dataBrand) \(dataItem.dataModel)"
        cell.labelDriver.text = dataItem.dataNumber
        return cell
    }
}

extension CollectionViewController : UICollectionViewDelegateFlowLayout {
    //1
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        //2
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: 80)
    }
    
    //3
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    // 4
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}

