//
//  ViewController.swift
//  News
//
//  Created by Salman on 1/7/18.
//  Copyright © 2018 cannypope. All rights reserved.
//

import UIKit


class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var newsCollection: UICollectionView!
    var news = [NewsModel]()
    var selectedNews: NewsModel?
    var link = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ApiManager.sendGetRequest(url: self.link) { (error, data) in
            if let error = error{
                print(error.localizedDescription)
            }
            else{
                if let data = data{
                    do{
                        let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
                        //print(json)
                        if let objDic = json as? NSDictionary{
                            if let array = objDic["articles"] as? NSArray{
                                for item in array{
                                    if let aNews = item as? NSDictionary{
                                        let newsObj = NewsModel(dic: aNews)
                                        self.news.append(newsObj)
                                    }
                                }
                            }
                        }
                        DispatchQueue.main.async {
                            self.newsCollection.reloadData()
                        }
                    }
                    catch let err{
                        print(err.localizedDescription)
                    }
                }
            }
        }
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "web"{
            let vc = segue.destination as! WebViewController
            vc.link = selectedNews?.url
        }
    }
    
    private func showActionSheet(news: NewsModel){
        if let url = news.url{
            let objectsToShare = [url]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            self.present(activityVC, animated: true, completion: nil)
        }
    }


    func showAlertMenu(news: NewsModel){
        var alert = UIAlertController(title: "Menu", message: nil, preferredStyle: .actionSheet)
        let viewAction = UIAlertAction(title: "View", style: .default) { (action) in
            print("View")
            self.performSegue(withIdentifier: "web", sender: self)
            alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(viewAction)
        
        let saveAction = UIAlertAction(title: "Save", style: .default) { (action) in
            print("Save")
            alert.dismiss(animated: true, completion: nil)
            StorageManager.StorageConnection().addUser(news: news)
            DispatchQueue.main.async {
                MessageBox.Show(message: "Saved", title: "Success", view: self)
            }
        }
        alert.addAction(saveAction)
        
        let shareAction = UIAlertAction(title: "Share", style: .default) { (action) in
            print("Share")
            DispatchQueue.main.async {
                self.showActionSheet(news: news)
            }
            alert.dismiss(animated: true, completion: nil)
            
        }
        alert.addAction(shareAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default) { (action) in
            print("Cancel")
            alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.news.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "newsCell", for: indexPath) as! NewsCell
        let aNews = self.news[indexPath.item]
        if let author = aNews.author{
            cell.authorField.text = author
        }
        if let title = aNews.title{
            cell.titleField.text = title
        }
        if let date = aNews.publishedAt{
            cell.dateField.text = date
        }
        if let detail = aNews.details{
            cell.detailsField.text = detail
        }
        if let imageUrl = aNews.urlToImage{
            if aNews.image == nil{
                if let url : URL = URL(string: imageUrl){
                    cell.imageView.sd_setImage(with: url, completed: { (image, error, cache, url) in
                        self.news[indexPath.item].image = image
                    })
                }
            }
            else{
                cell.imageView.image = aNews.image!
            }
        }
        cell.menuAction = {
            self.selectedNews = aNews
            self.showAlertMenu(news: aNews)
        }
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 260)
    }
}

