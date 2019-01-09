//
//  MenuViewController.swift
//  News
//
//  Created by Salman on 1/7/18.
//  Copyright © 2018 cannypope. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "bitcoin"{
            let vc = segue.destination as! ViewController
            vc.link = "https://newsapi.org/v2/everything?q=bitcoin&apiKey=4f3678e753a046af97cc99d9029ddd77"
        }
        else{
            let vc = segue.destination as! ViewController
            vc.link = "https://newsapi.org/v2/top-headlines?sources=bbc-news&apiKey=4f3678e753a046af97cc99d9029ddd77"
        }
    }
 

}
