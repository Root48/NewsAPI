//
//  SettingsOfFilterViewController.swift
//  123NewsAPI
//
//  Created by Admin on 24.05.2021.
//

import UIKit

//class Setting {
//
//    var category: [String]
//    var country: [String]
//
//    init(category:[String], country:[String]) {
//        self.category = category
//        self.country = country
//    }
//
//
//}
class SettingsOfFilterViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    
    @IBOutlet weak var pickerView: UIPickerView!
    
//    var settings = [Setting]()
    var inputArray = [String]()
    
    let categoryArray = ["business", "entertainment", "general", "health", "science", "sports", "technology"]
                            
    let countryArray = ["ae", "ar", "at", "au", "be", "bg", "br", "ca", "ch", "cn", "co", "cu", "cz", "de", "eg", "fr", "gb", "gr", "hk", "hu", "id", "ie", "il", "in", "it", "jp", "kr", "lt", "lv", "ma", "mx", "my", "ng", "nl", "no", "nz", "ph", "pl", "pt", "ro", "rs", "ru", "sa", "se", "sg", "si", "sk", "th", "tr", "tw", "ua", "us", "ve", "za"]
    
    let sourcesArray = ["Techcrunch", "Australian Financial Review", "USA Today", "NBC News", "ESPN", "The Guardian", "Fox Business", "Politico", "Motley Fool", "CNN", "Yahoo Entertainment", "Motley Fool", "NPR", "Fox News", "Google News", "New York Post", "PhoneArena", "Mavs Moneyball"]
    
    var category = ""
    var country = ""
    var sources = ""
    var selectedIndex = 0
    
    var didSelectCountry: ((String) -> Void)?
    var didSelectCategory: ((String) -> Void)?
    var didSelectSources: ((String) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView.delegate = self
        pickerView.dataSource = self
        inputArray = categoryArray
        self.category = categoryArray[0]
        //sourseName
    }
    
    @IBAction func SwichPickerView(_ sender: UISegmentedControl) {
        selectedIndex = sender.selectedSegmentIndex
        
        switch sender.selectedSegmentIndex {
        case 0:
            self.inputArray = self.categoryArray
            self.pickerView.reloadAllComponents()
        case 1:
            self.inputArray = self.countryArray
            self.pickerView.reloadAllComponents()
        case 2:
            self.inputArray = self.sourcesArray
            self.pickerView.reloadAllComponents()
        default:
            break
        }
    }
    
    @IBAction func didPressApply() {
        switch selectedIndex {
        case 0:
            didSelectCategory?(category)
        case 1:
            didSelectCountry?(country)
        case 2:
            didSelectSources?(sources)
        default:
            break
        }
    }
    
    @IBAction func ClearFilterButton(_ sender: UIButton) {
        self.category = ""
        self.country = ""
        self.sources = ""
        
        
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.inputArray.count
    }
   
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.inputArray[row]
    }
   
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch selectedIndex {
        case 0:
            category = categoryArray[row]
        case 1:
            country = countryArray[row]
        case 2:
            sources = sourcesArray[row]
        default:
            break
        }
    }
}
