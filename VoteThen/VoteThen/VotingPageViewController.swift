//
//  VotingPageViewController.swift
//  VoteThen
//
//  Created by hongae  on 12/31/18.
//  Copyright © 2018 hongae . All rights reserved.
//

import UIKit


class VotingPageViewController: UIViewController{

    
    
    @IBOutlet weak var restart: UIButton!
    @IBOutlet weak var refresh: UIButton!
    @IBOutlet weak var Winner: UILabel!
    @IBOutlet weak var Counter: UILabel!
    @IBOutlet weak var SubmitButton: UIButton!
    
    @IBOutlet weak var count: UIButton!
    @IBOutlet weak var introbody: UITextView!
    @IBOutlet weak var ranked: UIButton!
    @IBOutlet weak var approval: UIButton!
    
    var Master = [String:Int]()
    var king:String = ""
    var tie:Bool = false
    var rankedcounter = 1
    
    var votetype = ""

    var BallotCount = 1
    var division:Int = 0
    var beginratio = Int((80/812)*UIScreen.main.bounds.height)
    
    //resets app
    @IBAction func restart(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        }
//    refreshbutton for ranked
    @IBAction func refresh(_ sender: Any) {
        rankedcounter = 1
        let blacklist = ["SubmitVote","ApprovalVote","RankedVote","newVote?", "CountVotes", "o"]
        
        for case let button as UIButton in self.view.subviews{ if blacklist.contains(button.currentTitle!) == false{
            button.tag = Master.count
            }}
        
        UIView.animate(withDuration: 1, animations: {
            self.refresh.transform = self.refresh.transform.rotated(by: CGFloat.pi)
            self.refresh.transform = self.refresh.transform.rotated(by: CGFloat.pi)
            for case let button as UIButton in self.view.subviews{
                if button !=  self.refresh {UIView.animate(withDuration: 1, animations: {
                    button.backgroundColor = UIColor.clear})
                }}
            for case let label as UILabel in self.view.subviews{
                if label !=  self.Counter && label.tag != 69{
                        UIView.animate(withDuration: 1, animations: {
                        label.removeFromSuperview()})
                }}
            
        
        })
    }
    
    
//fadeinandout
    override func viewDidAppear(_ animated:Bool){
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 1.5, animations: {
            self.ranked.alpha = 1
            self.approval.alpha = 1
        })
        
    }
//    Submit + ballot count
    
    @IBAction func SubmitVOte(_ sender: Any) {
        let blacklist = ["SubmitVote","ApprovalVote","RankedVote","newVote?", "CountVotes", "o"]
        rankedcounter = 1
        BallotCount += 1
        Counter.text = "#\(BallotCount)"

        if BallotCount == 3 {
            UIView.animate(withDuration: 1, animations: {
                self.count.frame = CGRect(x: 140, y: 625, width: 250, height: 25)
                self.count.alpha = 1
            })
        }

        
//        approvalballotoption
        
        if votetype == "a"{
            

            for case var button as UIButton in self.view.subviews{ if button.backgroundColor == UIColor.groupTableViewBackground && blacklist.contains(button.currentTitle!) == false{
                    print(button.currentTitle)
                    Master[button.currentTitle!]! += 1
                    button.tag = Master.count
                }
                UIView.animate(withDuration: 1, animations: {
                    button.backgroundColor = UIColor.clear})
                
            }
            
//            rankedballotoption
            
        }else{
            for case let button as UIButton in self.view.subviews{
                UIView.animate(withDuration: 1, animations: {
                    button.backgroundColor = UIColor.clear})
                if blacklist.contains(button.currentTitle!) == false{
                    print(button.currentTitle)
                    Master[button.currentTitle!]! += Master.count - button.tag
                }
            }
            
            for case let label as UILabel in self.view.subviews{
                if label !=  self.Counter && label != self.Winner {
                    UIView.animate(withDuration: 1, animations: {
                        label.removeFromSuperview()})
                }}
            let blacklist = ["SubmitVote","ApprovalVote","RankedVote","restart?", "CountVotes", "o"]
            
            for case let button as UIButton in self.view.subviews{ if blacklist.contains(button.currentTitle!) == false{
                button.tag = Master.count
                }}
        }
            print(Master)
        }
        

//    finish and count votes for approval
    @IBAction func Cound(_ sender: Any) {
        var score = 0
        
        for i in Master{
            if i.1 > score{
                self.king = i.0
                score = i.1
                tie = false
                        
            }else if i.1 == score{
                tie = true
                }
        }
        
        UIView.animate(withDuration: 1, animations: {
            for case let button as UIButton in self.view.subviews{
            button.alpha = 0
            self.Counter.alpha = 0
                }
        })
            
        if tie == false{
            clearMaster()
            self.Winner.text = self.king
            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                UIView.animate(withDuration: 1, animations: {
                    self.Winner.alpha = 1})
            }
            )
            DispatchQueue.main.asyncAfter(deadline: .now() + 4, execute: {
                UIView.animate(withDuration: 1, animations: {
                    self.restart.alpha = 1})
            }
            )
        }else{
            self.Winner.text = "Inconclusive"
            clearMaster()
            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                UIView.animate(withDuration: 1, animations: {
                    self.Winner.alpha = 1})})
            
            if votetype == "a"{
                    
                self.ranked.isEnabled = true
            }else{
                self.approval.isEnabled = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 4, execute: {
                UIView.animate(withDuration: 1, animations: {
                    self.Winner.alpha = 0})
            })
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: {
                
                if self.votetype == "a"{
                    UIView.animate(withDuration: 1, animations: {
                        self.ranked.alpha = 1
                        self.ranked.backgroundColor = UIColor.groupTableViewBackground
                    })
                }else{
                    UIView.animate(withDuration: 1, animations: {
                        self.approval.alpha = 1
                        self.approval.backgroundColor = UIColor.groupTableViewBackground
                    })
                    
                }
            })
        }
        
    }
        
        
        
        
    
    
//    makes button
    func makebutton(text:String, beginratio: Int, division:Int, width:Int)-> UIButton{
        
        var but:UIButton!
        but = UIButton()
        but.contentHorizontalAlignment = .left
        
        but.frame = CGRect(x: width, y: beginratio + division, width: 250, height: 25)
        
        but.addTarget(self, action: #selector(trigger), for: UIControl.Event.touchUpInside)
        but.setTitle(text, for: UIControl.State.normal)
        but.setTitleColor(UIColor.black, for: UIControl.State.normal)
        but.backgroundColor = UIColor.clear
        but.alpha = 0
        but.tag = Master.count
        self.view.addSubview(but)
        print(but.frame.minY)
        return but
        
    }
    
//    makes list
    public func makeList(_which:Bool){
        
        
        
        let width: Int = Int(0.16 * UIScreen.main.bounds.width)
        
        division = Int(Int(UIScreen.main.bounds.height * (550/812)) / (self.Master.count+1))
        
        if _which == true{
            for key in Master{
                var but = makebutton(text:key.key, beginratio: beginratio, division: division, width: width)
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    
                UIView.animate(withDuration: 1, animations: {
                    but.alpha = 1
                })
                })
                    beginratio += division

            }
        }
    }
//   list button action
    @objc func trigger(sender:UIButton){
        beginratio = Int((80/812)*UIScreen.main.bounds.height)

        if votetype == "a"{
            
            sender.backgroundColor = (sender.backgroundColor == UIColor.clear) ? UIColor.groupTableViewBackground : UIColor.clear
            self.view.addSubview(sender)
            
        }else{
            if sender.backgroundColor == UIColor.clear{
                sender.backgroundColor = UIColor.groupTableViewBackground
                
                sender.tag = rankedcounter
                
                var num:UILabel!
                num = UILabel()
                num.textColor = UIColor.black
                num.text = "\(rankedcounter)"
                num.frame = CGRect(x:295, y:-137 + sender.frame.maxY, width: 250, height: 250)
            
                rankedcounter += 1
                self.view.addSubview(num)
                
                
                
            }
        }
        
    }
    
//        clearmaster
    func clearMaster(){
        for i in Master.keys{
            Master[i] = 0
        }
    }
    
//    approval Voting
    
    @IBAction func approval(_ sender: Any) {
        clearMaster()
        beginratio = Int((80/812)*UIScreen.main.bounds.height)

        BallotCount = 1
        Counter.text = "#\(BallotCount)"
        votetype = "a"
        
        self.introbody.text = "You can vote for multiple choices"
        self.introbody.alpha = 0
        UIView.animate(withDuration: 1, animations: {
            self.ranked.alpha = 0    })
        
        DispatchQueue.main.asyncAfter(deadline: .now()+1, execute: {
                UIView.animate(withDuration: 1, animations: {
                    self.approval.alpha = 0
                })
            })
        
        self.approval.isEnabled = false
        self.ranked.isEnabled = false
        
        
        DispatchQueue.main.asyncAfter(deadline: .now()+2.5, execute: {
            UIView.animate(withDuration: 1, animations: {
                self.introbody.alpha = 1
                })
            })
        
        DispatchQueue.main.asyncAfter(deadline: .now()+4, execute:{
            UIView.animate(withDuration: 1, animations: {
                self.introbody.alpha = 0
            })
            }
        )
        
        
        DispatchQueue.main.asyncAfter(deadline: .now()+5, execute: {
            UIView.animate(withDuration: 1, animations: {
                self.Counter.alpha = 1
                self.SubmitButton.alpha = 1
            })
            
            self.makeList(_which : true)
            
        })}
    
    
//    ranked voting
    
    @IBAction func Ranked(_ sender: Any) {
        clearMaster()
        beginratio = Int((80/812)*UIScreen.main.bounds.height)
        votetype = "r"
        BallotCount = 1
        

        Counter.text = "#\(BallotCount)"
        
        self.introbody.text = "Rank in order of preference"
        self.introbody.alpha = 0
        if self.tie == false {
            UIView.animate(withDuration: 1, animations: {
            self.approval.alpha = 0
                })
            }
        DispatchQueue.main.asyncAfter(deadline: .now()+1, execute: {
            UIView.animate(withDuration: 1, animations: {
                self.ranked.alpha = 0
            })
        })
        
        self.approval.isEnabled = false
        self.ranked.isEnabled = false
        
        DispatchQueue.main.asyncAfter(deadline: .now()+2.5, execute: {
            UIView.animate(withDuration: 1, animations: {
                self.introbody.alpha = 1
            })
        })
        
        DispatchQueue.main.asyncAfter(deadline: .now()+4, execute: {
            UIView.animate(withDuration: 1, animations: {
                self.introbody.alpha = 0
            })
        })
       
        DispatchQueue.main.asyncAfter(deadline: .now()+5, execute: {
            UIView.animate(withDuration: 1, animations: {
                self.Counter.alpha = 1
                self.SubmitButton.alpha = 1
            })
            
        })
        DispatchQueue.main.asyncAfter(deadline: .now()+5, execute: {
            self.makeList(_which : true)
            UIView.animate(withDuration: 1, animations: {
                self.refresh.alpha = 1
            })

        })

        
        
        }
    }
