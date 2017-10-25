//
//  ViewController.swift
//  Fruit_parsing
//
//  Created by 김종현 on 2017. 10. 21..
//  Copyright © 2017년 김종현. All rights reserved.
//

import UIKit

class ViewController: UIViewController, XMLParserDelegate {
    
    var item:[String:String] = [:]
    var elements:[[String:String]] = []
    var currentElement = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let strURL = "http://api.androidhive.info/pizza/?format=xml"
        
        if NSURL(string: strURL) != nil{
            if let parser = XMLParser(contentsOf: NSURL(string: strURL)! as URL){
            parser.delegate = self
                if parser.parse(){
                    print("parser success")
                    
                } else {
                    print("parser fail")
                }
        }
        }}
       /* if let path = Bundle.main.url(forResource: "Fruit", withExtension: "xml") {
        
            if let parser = XMLParser(contentsOf: path) {
                parser.delegate = self
                //print(path)
                
                if parser.parse() {
                    print("parsing success!")
                    print(elements)
                } else {
                    print("parsing failed!!")
                }
            }
        } else {
            print("xml file not found!!")
        }
 
    }
   */
    
    // parser가 시작 태그를 만나면 호출됩니다. Ex) <name>
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        
        print("elementName = \(elementName)")
        
        currentElement = elementName
        
        if elementName == "item" {
            item = [:]
        } else if elementName == "elements" {
            elements = []
        }
    }

    
    // 현재 태그에 담겨있는 string이 전달됩니다.
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        
        let data = string.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
        print("data =  \(data)")
        if !data.isEmpty {
            item[currentElement] = string
       
            print("currentElement = \(currentElement)")
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        if elementName == "item" {
            elements.append(item)
            print("item = \(item)")
            print("elements = \(elements)")
        }
    }
    
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print("failure error: ", parseError)
    }
}

