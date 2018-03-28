//
//  MasterViewController.swift
//  StretchMyHeader
//
//  Created by KevinT on 2018-03-27.
//  Copyright © 2018 KevinT. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

  var detailViewController: DetailViewController? = nil
  var objects = [Any]()
  
  var newsItemArray = [NewsItemModel.NewsItem]()
  
  var newsItemModel = NewsItemModel()
  
//  will change in viewDidLoad()
  private var kTableHeaderHeight: CGFloat = 0.0
  
  @IBOutlet weak var dateLabel: UILabel!
  @IBOutlet weak var headerView: UIView!
  
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
    
//    maybe automatic row height?
    tableView.rowHeight = UITableViewAutomaticDimension
    
//    clear and set headerview to tableview
    headerView = tableView.tableHeaderView
    tableView.tableHeaderView = nil
    tableView.addSubview(headerView)
    
//    IMPORTANT to header not cover news items
    kTableHeaderHeight = self.view.bounds.height/2
    
//    show the headerview before scrolling
    tableView.contentInset = UIEdgeInsets(top: kTableHeaderHeight, left: 0, bottom: 0, right: 0)
    
//    not sure if this is needed. no change in behavior of the header and news items
    tableView.contentOffset = CGPoint(x: 0, y: -kTableHeaderHeight)
    
    updateHeaderView(tableView: tableView)

    self.navigationController?.setNavigationBarHidden(true, animated: true)
    
    newsItemArray = newsItemModel.loadSampleNewsItems()
    
    let date = Date()
    let formatter = DateFormatter()
    formatter.dateFormat = "MMMM dd"  // format like "March 27"
    dateLabel.text = formatter.string(from: date)
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
  
  func updateHeaderView(tableView: UITableView) {
    var headerRect = CGRect(x: 0, y: -kTableHeaderHeight, width: tableView.bounds.width, height: kTableHeaderHeight)
    
//    change the header rect vertical origin and height according to the tableview vertical contentoffset
//    if tableview offset is less than header height
    if tableView.contentOffset.y < -kTableHeaderHeight {
      headerRect.origin.y = tableView.contentOffset.y
      headerRect.size.height = -tableView.contentOffset.y
    }
    headerView.frame = headerRect
  }
  
//  update header view when scrolled
  override func scrollViewDidScroll(_ scrollView: UIScrollView) {
    updateHeaderView(tableView: tableView)
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
//            let object = objects[indexPath.row] as! NSDate
            let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
//            controller.detailItem = object
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
    
//    custom cell
    var newsItemTableViewCell = NewsItemTableViewCell()
    
//    reuse cell of "Cell" identifier when loading table view cells
    newsItemTableViewCell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! NewsItemTableViewCell
    
//    go through each item in the array
    let newsItem = newsItemArray[indexPath.row]
    
    newsItemTableViewCell.categoryLabel.text = newsItem.category.rawValue
    
//    color code different categories of news
    newsItemModel.colorCategory(newsItem, newsItemTableViewCell)
    
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

  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableViewAutomaticDimension
  }
  
  override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableViewAutomaticDimension
  }

}

