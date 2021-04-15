//
//  ViewController.swift
//  App Store Connect for macOS
//
//  Created by Aryan Sharma on 4/14/21.
//

import Cocoa
import WebKit

class ViewController: NSViewController, WKUIDelegate {
    
    @IBOutlet weak var BackButton: NSButton!
    
    @IBOutlet weak var ReloadButton: NSButton!
    
    @IBOutlet weak var ForwardButton: NSButton!
    
    @IBOutlet weak var webView: WKWebView!
    
    @IBOutlet weak var TitleLabel: NSTextField!
    
    @IBOutlet weak var HomeButton: NSButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        webView.uiDelegate = self
        
        webView.load("https://appstoreconnect.apple.com/")
        
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.title), options: .new, context: nil)
        
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.isLoading), options: .new, context: nil)
        
    }
    
    @IBAction func AppleButtonPressed(_ sender: Any) {
        webView.load("https://developer.apple.com/")
    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "title" {
            if let title = webView.title {
                TitleLabel.stringValue = title
            }
        }
    }
    
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        let a = NSAlert()
        a.messageText = "Hey, listen!"
        a.informativeText = message
        //   .alertFirstButtonReturn
        a.addButton(withTitle: "Ok")
        a.alertStyle = .warning
        var w: NSWindow?
        if let window = view.window{
            w = window
        }
        else if let window = NSApplication.shared.windows.first{
            w = window
        }
        if let window = w{
            a.beginSheetModal(for: window){ (modalResponse) in
                if modalResponse == .alertFirstButtonReturn {
                    print("Document deleted")
                }
            }
        }
        
    }
    
    func dialogOK(question: String, text: String) -> Bool {
        let alert = NSAlert()
        alert.messageText = question
        alert.informativeText = text
        alert.alertStyle = .warning
        alert.addButton(withTitle: "OK")
        //alert.addButton(withTitle: "Cancel")
        return alert.runModal() == .alertFirstButtonReturn
    }
    
    func dialogOKCancel(question: String, text: String) -> Bool {
        let alert = NSAlert()
        alert.messageText = question
        alert.informativeText = text
        alert.alertStyle = .warning
        alert.addButton(withTitle: "OK")
        alert.addButton(withTitle: "Cancel")
        return alert.runModal() == .alertFirstButtonReturn
    }
    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
            
        }
    }
    @IBAction func HomeButtonPressed(_ sender: Any) {
        webView.load("https://appstoreconnect.apple.com/")
    }
    
    @IBAction func BackButtonPressed(_ sender: Any) {
        webView.goBack()
    }
    
    @IBAction func ReloadButtonPressed(_ sender: Any) {
        webView.reload()
    }
    
    @IBAction func ForwardButtonPressed(_ sender: Any) {
        webView.goForward()
    }
}

extension WKWebView {
    func load(_ urlString: String) {
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            load(request)
        }
    }
}
