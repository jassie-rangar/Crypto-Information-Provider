//
//  CurrencyNameViewController.swift
//  Crypto Info
//
//  Created by Jaskirat Singh on 05/04/18.
//  Copyright © 2018 jassie. All rights reserved.
//

import UIKit
import CoreData



class CurrencyNameViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var count = 0
    
    // MARK: IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    var cellPersist: Cell!
    
    let network = CryptoNetwork()
    var currencyName: [String] = []
    var priceUSD: [String] = []
    var symbol: [String] = []
    var change24H: [String] = []
    var change1H: [String] = []
    var change7D: [String] = []
    var rank: [String] = []
    
    
    var userArray: [Cell] = []
    var time = Timer()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true
        self.timer()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isHidden = true
        self.fetchData() 
        self.indicator.isHidden = true
        
        if ConnectionCheck.isConnectedToNetwork() == true
        {
            print("Internet connection OK")
        }
        else
        {
            print("Internet connection FAILED")
            let alert = UIAlertController(title: "Alert", message: "No Internet Connection!", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: { (action:UIAlertAction!) in
                print("you have pressed the Ok button")
            }))
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    func networking()
    {
        DispatchQueue.main.async
        {
            self.getData()
            { (success, fail, names, price, symb, change24h, ranking, change1h,change7d) in
                if !success
                {
                    DispatchQueue.main.async
                    {
                        self.indicator.stopAnimating()
                    }
                }
                else
                {
                    DispatchQueue.main.async
                    {
                        self.indicator.stopAnimating()
                        self.currencyName = names!
                        self.priceUSD = price!
                        self.symbol = symb!
                        self.change24H = change24h!
                        self.change1H = change1h!
                        self.change7D = change7d!
                        self.rank = ranking!
                        self.tableView.isHidden = false
                        self.tableView.reloadData()
                    }
                }
            }
            self.tableView.reloadData()
        }
    }
    
    @IBAction func Reload(_ sender: Any)
    {
        if ConnectionCheck.isConnectedToNetwork() == true
        {
            print("Internet connection OK")
        }
        else
        {
            print("Internet connection FAILED")
            let alert = UIAlertController(title: "Alert", message: "No Internet Connection!", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: { (action:UIAlertAction!) in
                print("you have pressed the Ok button")
            }))
            self.present(alert, animated: true, completion: nil)
        }
        
        self.indicator.isHidden = false
        self.indicator.startAnimating()
        self.networking()
        self.tableView.reloadData()
        self.count += 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if count == 0
        {
            return userArray.count
        }
        else
        {
            return currencyName.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        if count == 0
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
            let data = userArray[indexPath.row]
            cell.currencyName.text = data.currencyName!
            cell.symbol.text = data.symbol!
            return cell
            
        }
        
        else
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
            let name = currencyName[indexPath.row]
            let price = priceUSD[indexPath.row]
            let symb = symbol[indexPath.row]
            let change24 = change24H[indexPath.row]
            self.savetocore(name, symb)
            let pos = rank[indexPath.row]
            cell.currencyName.text = name
            cell.amount.text = "$ " + String(price)
            cell.symbol.text = symb
            cell.amountChanged.text = change24
            
            return cell
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let dollarArray: [String] = [change1H[indexPath.row], change24H[indexPath.row], change7D[indexPath.row], symbol[indexPath.row], currencyName[indexPath.row], priceUSD[indexPath.row]]
        performSegue(withIdentifier: "segue", sender: dollarArray)
        if let index = self.tableView.indexPathForSelectedRow
        {
            self.tableView.deselectRow(at: index, animated: true)
        }
    }
    
    func setup(enable: Bool)
    {
        self.tableView.isEditing = true
    }
    
    func timer()
    {
        time = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(self.countAgain), userInfo: nil, repeats: true)
    }
    
    func getData(_ completion: @escaping(_ done: Bool, _ error: String?, _ gotta: [String]?, _ price: [String]?, _ symbol: [String]?, _ change: [String]?, _ rank: [String]?,_  change1h: [String]?, _ change7day: [String]?)-> Void)
    {
        var crypto = CryptoNetwork()
        crypto.obtainData(completion: {
            error, info, price, symbol, change, rank, change1h,change7day in
            if error != nil
            {   DispatchQueue.main.async
                {
                    completion(false,error,nil,nil,nil,nil,nil,nil,nil)
                }
            }
            else
            {
                DispatchQueue.main.async
                {
                    completion(true, nil, info!, price!, symbol!,change!, rank!, change1h!, change7day!)
                }
            }
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        let seg = segue.destination as! CurrencyInfoViewController
        seg.arrayChange = (sender as? [String])!
    }
    
    @objc func countAgain()
    {
        self.networking()
        self.tableView.reloadData()
    }
    
}

extension CurrencyNameViewController
{
    
    func savetocore(_ name: String, _ symb: String)
    {
        let newSong = NSEntityDescription.insertNewObject(forEntityName: "Cell", into: self.context)
        newSong.setValue(name, forKey: "currencyName")
        newSong.setValue(symb, forKey: "symbol")
    
        do
        {
            try self.context.save()
        }
        catch
        {
            self.alert(message: "Problem saving it to app!!")
        }
    }
    
    func fetchData()
    {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        do
        {
            userArray = try context.fetch(Cell.fetchRequest())
            DispatchQueue.main.async
            {
                self.tableView.reloadData()
                self.tableView.isHidden = false
                self.indicator.stopAnimating()
            }
        }
        catch
        {
            alert(message: "Error loading Data")
        }
    }
    
    func alert(message:String )
    {
        DispatchQueue.main.async
        {
            if message == "The Internet connection appears to be offline."
            {
                let editor = self.storyboard!.instantiateViewController(withIdentifier: "internet")
                self.present(editor, animated: true, completion: nil)
            }
                
            else
            {
                
                let alertview = UIAlertController(title: "", message: message, preferredStyle: .alert)
                alertview.addAction(UIAlertAction(title: "Try Again!", style: .default, handler: {
                    action in
                    DispatchQueue.main.async
                    {
                        self.dismiss(animated: true, completion: nil)
                    }
                }))
                self.present(alertview, animated: true, completion: nil)
            }
        }
    }
    
}
