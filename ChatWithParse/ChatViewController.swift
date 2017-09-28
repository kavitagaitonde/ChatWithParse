//
//  ChatViewController.swift
//  ChatWithParse
//
//  Created by Kavita Gaitonde on 9/27/17.
//  Copyright © 2017 Kavita Gaitonde. All rights reserved.
//

import UIKit
import ParseLiveQuery
import Parse

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var messageTextField: UITextField!
    
    @IBOutlet weak var tableView: UITableView!
    
    var client : ParseLiveQuery.Client!
    var subscription : Subscription<Message>!

    var messages: [Message] = [Message]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.loadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func loadData() {
        var messageQuery: PFQuery<Message> {
                return (Message.query()!
                    .whereKeyExists("text")
                    .includeKey("user")
                    .order(byAscending: "createdAt")) as! PFQuery<Message>
            }
            client = ParseLiveQuery.Client()
            subscription = client.subscribe(messageQuery)
                // handle creation events, we can also listen for update, leave, enter events
                .handle(Event.created) { _, message in
                    print("***** \(message["text"])")
                    self.messages.append(message)
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
    }

    @IBAction func sendClicked(_ sender: AnyObject) {
        print("###### \(messageTextField.text!)")
        let message = Message()
        message.text = messageTextField.text
        message.user = PFUser.current()
        message.saveInBackground(block: { (success, error) in
            if (success) {
                print("Message successfully saved!")
                self.loadData()
            } else {
                print("Error saving message!")
            }
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.messages.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell", for: indexPath)
        cell.textLabel?.text = self.messages[indexPath.row].text
        return cell
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
