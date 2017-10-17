//
//  ViewController.swift
//  Airports
//
//  Created by Tobias Termeczky@hotmail.com on 17/10/2017.
//  Copyright © 2017 Tobias Termeczky@hotmail.com. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var tableData = [Airport]()
    var sections = [Section]()
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let adb = AirportDatabase.sharedInstance
        self.tableData = adb.getAirportsByIso("NL")!
        print(tableData.count)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

