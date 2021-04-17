//
//  TableViewController.swift
//  VinodTaskProjectTests
//
//  Created by Vinod K on 07/04/20.
// Copyright © 2020 Vinod K. All rights reserved.
//

import UIKit

struct Item {
    var Title: String
    var DateTime: String
    var webUrl: String
    var imageUrl: String
}

var selectedWebPage = "https://www.apple.com" //sample

class TableViewController: UITableViewController, XMLParserDelegate {
        var itemsArray: [Item] = []
    var items: [Item] = []
    var elementName: String = String()
    var Title = String()
    var DateTime = String()
    var webUrl = String()
    var imageUrl = String()
    
    @IBOutlet var rsstableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
      //parsing the data Xml parsing
        let path : NSURL = (NSURL(string:"https://thenextweb.com/feed"))!
        if let parser = XMLParser(contentsOf: path as URL) {
            parser.delegate = self
            parser.parse()
        }
    }
    
      //fetching the data from paring part
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
 
        if elementName == "item" {
            Title = String()
            DateTime = String()
            webUrl = String()
            imageUrl = String()
            
        }
        
        self.elementName = elementName
        
    }
    
      //adding to the model class
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "item" {
          
            let item = Item(Title: Title, DateTime: DateTime, webUrl: webUrl, imageUrl: imageUrl)
            items.append(item)
            itemsArray.append(item)
        }
    }
    
      //  fetching the ecah element from item
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        let data = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    
        if (!data.isEmpty) {
            if self.elementName == "title" {
                Title += data
            } else if self.elementName == "pubDate" {
                DateTime += data
            } else if self.elementName == "link" {
                webUrl += data
            }else if self.elementName == "description" {
                let greeting = data
                if let str = greeting.slice(from: "<img src=\"", to: "\"") {
                    var src = str.replacingOccurrences(of: "\"", with: "")
                    src = str.replacingOccurrences(of: "\"", with: "")
                    src = str.replacingOccurrences(of: " ", with: "")
                    imageUrl += src
                    print(src as Any,"str")
                    
                }else{
                    imageUrl += ""
                }
            }
        }
    }
    
    
    
    // MARK: - Table view Display item list
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // return the number of rows
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ItemTableViewCell
        cell.itemObject = items[indexPath.row]

        
        return cell
    }
    
    
    //selected link to show the webview
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let item = items[indexPath.row]
        
        selectedWebPage = item.webUrl
    }
    
    
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        scrollingFinished(scrollView: scrollView)
    }

    override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if decelerate {
            //didEndDecelerating will be called for sure
            return
        }
        else {
      
            scrollingFinished(scrollView: scrollView)
        }
    }

    // for inifnate loop data duplication adding items and reload
    func scrollingFinished(scrollView: UIScrollView) {
       // Your code
        
        for item in itemsArray {
            items.append(item);
        }
        rsstableView.reloadData()
    }
    
    
}

extension UIImage {
    convenience init?(url: URL?) {
        guard let url = url else { return nil }
        
        do {
            let data = try Data(contentsOf: url)
            self.init(data: data)
        } catch {
            print("Cannot load image from url: \(url) with error: \(error)")
            return nil
        }
    }
}

extension String {
    
    func slice(from: String, to: String) -> String? {
        
        return (range(of: from)?.upperBound).flatMap { substringFrom in
            (range(of: to, range: substringFrom..<endIndex)?.lowerBound).map { substringTo in
                String(self[substringFrom..<substringTo])
            }
        }  // test  jj
    }
}


