//
//  NewsItemModel.swift
//  StretchMyHeader
//
//  Created by KevinT on 2018-03-27.
//  Copyright © 2018 KevinT. All rights reserved.
//

import UIKit

class NewsItemModel: NSObject {

  struct NewsItem {
    let category: NewsItemModel.ItemCategory // enum
    let headline: String
    
    init(itemCategory: NewsItemModel.ItemCategory, itemHeadline: String) {
      category = itemCategory
      headline = itemHeadline
    }
  }

  enum ItemCategory: String {
    case World = "World"
    case Americas = "Americas"
    case Europe = "Europe"
    case MiddleEast = "Middle East"
    case Africa = "Africa"
    case AsiaPacific = "Asia Pacific"
  }

  func loadSampleNewsItems() -> [NewsItem] {
    
    let newsItem1 = NewsItem(itemCategory: NewsItemModel.ItemCategory.World,
                             itemHeadline: "Climate change protests, divestments meet fossil fuels realities")
    
    let newsItem2 = NewsItem(itemCategory: NewsItemModel.ItemCategory.Europe,
                             itemHeadline: "Scotland's 'Yes' leader says independence vote is 'once in a lifetime'")
    
    let newsItem3 = NewsItem(itemCategory: NewsItemModel.ItemCategory.MiddleEast,
                             itemHeadline: "Airstrikes boost Islamic State, FBI director warns more hostages possible")
    
    let newsItem4 = NewsItem(itemCategory: NewsItemModel.ItemCategory.Africa,
                             itemHeadline: "Nigeria says 70 dead in building collapse; questions S. Africa victim claim")
    
    let newsItem5 = NewsItem(itemCategory: NewsItemModel.ItemCategory.AsiaPacific,
                             itemHeadline: "Despite UN ruling, Japan seeks backing for whale hunting")
    
    let newsItem6 = NewsItem(itemCategory: NewsItemModel.ItemCategory.Americas,
                             itemHeadline: "Officials: FBI is tracking 100 Americans who fought alongside IS in Syria")
    
    let newsItem7 = NewsItem(itemCategory: NewsItemModel.ItemCategory.World,
                             itemHeadline: "South Africa in $40 billion deal for Russian nuclear reactors")
    
    let newsItem8 = NewsItem(itemCategory: NewsItemModel.ItemCategory.Europe,
                             itemHeadline: "One million babies' created by EU student exchanges")
    
    var newsItemArray = [NewsItem]()
    newsItemArray += [newsItem1, newsItem2, newsItem3, newsItem4, newsItem5, newsItem6, newsItem7, newsItem8]
    return newsItemArray
  }
  
  func colorCategory(_ newsItem: NewsItem, _ newsItemTableViewCell: NewsItemTableViewCell) {
    switch newsItem.category {
    case ItemCategory.World:
      newsItemTableViewCell.categoryLabel.textColor = UIColor.red
    case ItemCategory.Europe:
      newsItemTableViewCell.categoryLabel.textColor = UIColor.green
    case ItemCategory.MiddleEast:
      newsItemTableViewCell.categoryLabel.textColor = UIColor.yellow
    case ItemCategory.Africa:
      newsItemTableViewCell.categoryLabel.textColor = UIColor.orange
    case ItemCategory.AsiaPacific:
      newsItemTableViewCell.categoryLabel.textColor = UIColor.purple
    default: // ItemCategory.Americas
      newsItemTableViewCell.categoryLabel.textColor = UIColor.blue
    }
  }
}
