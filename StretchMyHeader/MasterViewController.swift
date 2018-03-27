//
//  MasterViewController.swift
//  StretchMyHeader
//
//  Created by KevinT on 2018-03-27.
//  Copyright © 2018 KevinT. All rights reserved.
//

import UIKit

struct NewsItem {
  let category: String
  let headline: String
  
  init(itemCategory: String, itemHeadline: String) {
    category = itemCategory
    headline = itemHeadline
  }
}

class MasterViewController: UITableViewController {

  var detailViewController: DetailViewController? = nil
  var objects = [Any]()
  
  var newsItemArray = [NewsItem]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    navigationItem.leftBarButtonItem = editButtonItem

    let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(insertNewObject(_:)))
    navigationItem.rightBarButtonItem = addButton
    if let split = splitViewController {
        let controllers = split.viewControllers
        detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
    }
    
    loadSampleNewsItems()
  }

  override func viewWillAppear(_ animated: Bool) {
    clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
    super.viewWillAppear(animated)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  //MARK: Private Methods
  private func loadSampleNewsItems() {
    
    let newsItem1 = NewsItem(itemCategory: "World",
                        itemHeadline: "Climate change protests, divestments meet fossil fuels realities")
    
    let newsItem2 = NewsItem(itemCategory: "Europe",
                             itemHeadline: "Scotland's 'Yes' leader says independence vote is 'once in a lifetime'")
    
    let newsItem3 = NewsItem(itemCategory: "Middle East",
                             itemHeadline: "Airstrikes boost Islamic State, FBI director warns more hostages possible")
    
    let newsItem4 = NewsItem(itemCategory: "Africa",
                             itemHeadline: "Nigeria says 70 dead in building collapse; questions S. Africa victim claim")
    
    let newsItem5 = NewsItem(itemCategory: "Asia Pacific",
                             itemHeadline: "Despite UN ruling, Japan seeks backing for whale hunting")
    
    let newsItem6 = NewsItem(itemCategory: "Americas",
                             itemHeadline: "Officials: FBI is tracking 100 Americans who fought alongside IS in Syria")
    
    let newsItem7 = NewsItem(itemCategory: "World",
                             itemHeadline: "South Africa in $40 billion deal for Russian nuclear reactors")
    
    let newsItem8 = NewsItem(itemCategory: "Europe",
                             itemHeadline: "One million babies' created by EU student exchanges")

    newsItemArray += [newsItem1, newsItem2, newsItem3, newsItem4, newsItem5, newsItem6, newsItem7, newsItem8]
  }
  
  @objc
  func insertNewObject(_ sender: Any) {
    objects.insert(NSDate(), at: 0)
    let indexPath = IndexPath(row: 0, section: 0)
    tableView.insertRows(at: [indexPath], with: .automatic)
  }

  // MARK: - Segues

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "showDetail" {
        if let indexPath = tableView.indexPathForSelectedRow {
            let object = objects[indexPath.row] as! NSDate
            let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
            controller.detailItem = object
            controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
            controller.navigationItem.leftItemsSupplementBackButton = true
        }
    }
  }

  // MARK: - Table View

  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return newsItemArray.count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    var newsItemTableViewCell = NewsItemTableViewCell()
    newsItemTableViewCell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! NewsItemTableViewCell

//    let object = objects[indexPath.row] as! NSDate
//    cell.textLabel!.text = object.description
    let newsItem = newsItemArray[indexPath.row]
    newsItemTableViewCell.categoryLabel.text = newsItem.category
    newsItemTableViewCell.headlineLabel.text = newsItem.headline

    return newsItemTableViewCell
  }

  override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    // Return false if you do not want the specified item to be editable.
    return true
  }

  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
        objects.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
    } else if editingStyle == .insert {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
  }


}

