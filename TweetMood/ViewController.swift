//
//  ViewController.swift
//  TweetMood
//
//  Created by iem on 01/12/2016.
//  Copyright © 2016 benjisora. All rights reserved.
//

import UIKit
import Social


class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var personalMessage: UITextField!
    @IBOutlet weak var pickerView: UIPickerView!

    let ACTIONS_COMP = 0;
    let MOODS_COMP = 1;
    
    var actions = ["dors", "mange", "galère", "joue", "m'ennuie", "suis occupé"];
    var moods = ["( _ _ )..zzZZ", "(⋆‿⋆)♨", "(・ヘ・)?", "o(≧▽≦)o", "(；￣Д￣)", "( ಥ ʖ̯ ಥ)"];
    
    
    override func viewDidLoad() {
        super.viewDidLoad();
        self.pickerView.dataSource = self;
        self.pickerView.delegate = self;
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning();
        // Dispose of any resources that can be recreated.
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2;
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if(component == ACTIONS_COMP){
            return actions.count;
        }else{
            return moods.count;
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if(component == ACTIONS_COMP){
            return actions[row];
        }else{
            return moods[row];
        }
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
    }
    
    @IBAction func buttonTweet(_ sender: UIButton) {
        
        var finaltweet = "";
        
        if (personalMessage.text != "") {
            if let message = personalMessage.text {
                finaltweet = message;
            }
        }else{
            let action = actions[pickerView.selectedRow(inComponent: ACTIONS_COMP)];
            let mood = moods[pickerView.selectedRow(inComponent: MOODS_COMP)];
            
            finaltweet = "Je " + action + " " + mood ;
        }
        
        NSLog(finaltweet);
        sendTweet(message: finaltweet);
    }
    
    @IBAction func UserTapGesture(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true);
    }
    
    // MARK: - TweetSending
    func sendTweet(message: String){
        if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeTwitter){
            // Compte lié, on poste
            let twitterController:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
            twitterController.setInitialText(message)
            self.present(twitterController, animated: true, completion: nil)
        } else {
            // Pas de compte lié, alerte
            let alert = UIAlertController(title: "Twitter Account", message: "Please login to your Twitter account.",preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }

}

