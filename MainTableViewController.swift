//
//  MainTableViewController.swift
//  20190705
//
//  Created by りさこ on 2019/07/05.
//  Copyright © 2019年 りさこ. All rights reserved.
//

import UIKit

class MainTableViewController: UITableViewController {
    
    // データ保存関係の変数
    // 公演
    var eventArray = [Event]()
    var genre: String?
    var program: String?
    var place: String?
    // 公演情報
    var date: String?
    var tickets: String?
    var price: String?
    var fee: String?
    var type: String?
    var seat: String?
    var status: Int?
    var statusArray = ["申込前", "抽選中", "入金待", "発券待", "発券済", "落選"]
    var partner: String?
    // チケット情報
    var platform: String?
    var owner: String?
    var toIssue: String?
    var applicationStart: String?
    var applicationEnd: String?
    var resultStart: String?
    var resultEnd: String?
    var paymentStart: String?
    var paymentEnd: String?
    var issueStart: String?
    var issueEnd: String?
    // etc
    var url: String?
    var memo: String?
    
    // 新規→保存ボタン押下時遷移
    @IBAction func addsaveToMainViewController (segue:UIStoryboardSegue) {
        let addViewController = segue.source as! AddTableViewController
        print("addViewController = \(addViewController)")
        
        // 値を渡す
        genre = addViewController.addedGenre
        program = addViewController.addedProgram
        date = addViewController.addedDate
        place = addViewController.addedPlace
        tickets = addViewController.addedTickets
        price = addViewController.addedPrice
        fee = addViewController.addedFee
        type = addViewController.addedType
        seat = addViewController.addedSeat
        status = addViewController.addedStatus
        partner = addViewController.addedPartner
        platform = addViewController.addedPlatform
        owner = addViewController.addedOwner
        toIssue = addViewController.addedToIssue
        applicationStart = addViewController.addedApplicationStart
        applicationEnd = addViewController.addedApplicationEnd
        resultStart = addViewController.addedResultStart
        resultEnd = addViewController.addedResultEnd
        paymentStart = addViewController.addedPaymentStart
        paymentEnd = addViewController.addedPaymentEnd
        issueStart = addViewController.addedIssueStart
        issueEnd = addViewController.addedIssueEnd
        url = addViewController.addedURL
        memo = addViewController.addedMemo
        
        // 配列に入力値を挿入。アンラップ処理いるんちゃう？
        let event = Event()
        event.genre = genre!
        event.program = program!
        event.date = date!
        event.place = place!
        event.tickets = tickets!
        event.price = price!
        event.fee = fee!
        event.type = type!
        event.seat = seat!
        event.status = status!
        event.partner = partner!
        event.platform = platform!
        event.owner = owner!
        event.toIssue = toIssue!
        event.applicationStart = applicationStart!
        event.applicationEnd = applicationEnd!
        event.resultStart = resultStart!
        event.resultEnd = resultEnd!
        event.paymentStart = paymentStart!
        event.paymentEnd = paymentEnd!
        event.issueStart = issueStart!
        event.issueEnd = issueEnd!
        event.url = url!
        event.memo = memo!
        
        self.eventArray.insert(event, at: 0)
        // テーブルに行が追加されたことをテーブルに通知
        self.tableView.insertRows(at: [IndexPath(row: 0, section: 0)],
                                  with: UITableView.RowAnimation.right)
        // userDefualtsの保存処理
        let userDefaults = UserDefaults.standard
        // Data型にシリアライズする
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: self.eventArray, requiringSecureCoding: true)
            userDefaults.set(data, forKey: "eventArray")
            userDefaults.synchronize()
        } catch {
            // エラー処理なし
        }
        self.tableView.reloadData()
        print("リロード完了")
    }
    
    // 編集→保存ボタン押下時遷移
    @IBAction func saveToMainViewController (segue:UIStoryboardSegue) {
        let detailViewController = segue.source as! DetailTableViewController
        print("編集→保存ボタン")
        if let indexPath = detailViewController.indexPath {
            print("index = \(indexPath)")
            
            // 配列に入力値を更新
            let event = Event()
            event.genre = detailViewController.editedGenre
            event.date = detailViewController.editeddate
            event.program = detailViewController.editedProgram
            event.place = detailViewController.editedPlace
            event.tickets = detailViewController.editedTickets
            event.price = detailViewController.editedPrice
            event.fee = detailViewController.editedFee
            event.type = detailViewController.editedType
            event.seat = detailViewController.editedSeat
            event.status = detailViewController.editedStatus
            event.partner = detailViewController.editedPartner
            
            event.platform = detailViewController.editedPlatform
            event.owner = detailViewController.editedOwner
            event.toIssue = detailViewController.editedToIssue
            event.applicationStart = detailViewController.editedApplicationStart
            event.applicationEnd = detailViewController.editedApplicationEnd
            event.resultStart = detailViewController.editedResultStart
            event.resultEnd = detailViewController.editedResultEnd
            event.paymentStart = detailViewController.editedPaymentStart
            event.paymentEnd = detailViewController.editedPaymentEnd
            event.issueStart = detailViewController.editedIssueStart
            event.issueEnd = detailViewController.editedIssueEnd
            event.url = detailViewController.editedURL
            event.memo = detailViewController.editedMemo
            
            self.eventArray[indexPath.row] = event
            
            // userDefualtsの保存処理
            let userDefaults = UserDefaults.standard
            // Data型にシリアライズする
            do {
                let data = try NSKeyedArchiver.archivedData(withRootObject: self.eventArray, requiringSecureCoding: true)
                userDefaults.set(data, forKey: "eventArray")
                userDefaults.synchronize()
            } catch {
                // エラー処理なし
            }
            self.tableView.reloadData()
            print("リロード完了")
        }
    }
    
    // 編集→削除ボタン押下時遷移
    @IBAction func deleteToMainViewController (segue:UIStoryboardSegue) {
        let detailViewController = segue.source as! DetailTableViewController
        print("編集→削除ボタン")
        if let indexPath = detailViewController.indexPath {
            // リストから削除
            eventArray.remove(at: indexPath.row)
            // データ保存。Data型にシリアライズする
            do {
                let data: Data = try NSKeyedArchiver.archivedData(withRootObject: eventArray, requiringSecureCoding: true)
                // UserDefaultsに保存
                let userDefaults = UserDefaults.standard
                userDefaults.set(data, forKey: "eventArray")
                userDefaults.synchronize()
            } catch {
                // エラー処理なし
            }
            self.tableView.reloadData()
            print("リロード完了")
        }
    }
    // キャンセルボタン押下時遷移
    @IBAction func unwindToMainViewController(_ segue:UIStoryboardSegue){}

    // 読み込み処理
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoadしたよ")
        let userDefaults = UserDefaults.standard
        // userDefaultsから読み込み
        if let storedEventArray = userDefaults.object(forKey: "eventArray") as? Data {
            do {
                if let unarchiveEventArray = try NSKeyedUnarchiver.unarchivedObject(ofClasses: [NSArray.self, Event.self], from: storedEventArray) as? [Event] {
                    eventArray.append(contentsOf: unarchiveEventArray)
                    //eventArray.date.sort { $0 < $1 }
                }
            } catch {
                // エラー処理なし
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        print("セクション数1")
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        print("セルの数= \(eventArray.count)")
        return eventArray.count
    }
    
    // セルの高さ
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      
        return 150.0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("セルの中身決めるよ")
        // 連続セルはサブクラスで接続する(MainTableViewCell)
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath) as! MainTableViewCell
        // 行番号に合ったイベントの情報を取得
        let event = eventArray[indexPath.row]
        cell.genreL.text = event.genre
        cell.programL.text = event.program
        cell.dateL.text = event.date
        print(event.place as Any)
        if let placetext = event.place {
            if placetext.isEmpty {
                cell.ticketsL.text = ""
            } else {
                var at = "@"
                at.append(placetext)
                cell.placeL.text = at
            }
        }
        if let ticketsText = event.tickets {
            if ticketsText.isEmpty {
                cell.ticketsL.text = ""
            } else {
                cell.ticketsL.text = ticketsText + "枚"
            }
        }
        if let priceText = event.price {
            if priceText.isEmpty {
                cell.priceL.text = ""
            } else {
                cell.priceL.text = priceText + "円"
            }
        }
        cell.typeL.text = event.type
        cell.seatL.text = event.seat
        if let unwrapStatus = event.status {
            cell.statusL.text = statusArray[unwrapStatus]
        } else {
            cell.statusL.text = ""
        }
        cell.partnerL.text = event.partner
        
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // 編集画面への受け渡し
        if segue.identifier == "edit" {
            print("prepare edit呼んだよ")
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let nav = segue.destination as! UINavigationController
                let detailViewController = nav.topViewController as! DetailTableViewController
                detailViewController.indexPath = indexPath
                print("indexPath = \(detailViewController.indexPath!)")
                let selectEvent = eventArray[indexPath.row]
                
                // 値渡し
                detailViewController.genre = selectEvent.genre
                detailViewController.program = selectEvent.program
                detailViewController.date = selectEvent.date
                detailViewController.place = selectEvent.place
                detailViewController.tickets = selectEvent.tickets
                detailViewController.price = selectEvent.price
                detailViewController.fee = selectEvent.fee
                detailViewController.type = selectEvent.type
                detailViewController.seat = selectEvent.seat
                detailViewController.status = selectEvent.status
                detailViewController.partner = selectEvent.partner
                
                detailViewController.platform = selectEvent.platform
                detailViewController.owner = selectEvent.owner
                detailViewController.toIssue = selectEvent.toIssue
                detailViewController.applicationStart = selectEvent.applicationStart
                detailViewController.applicationEnd = selectEvent.applicationEnd
                detailViewController.resultStart = selectEvent.resultStart
                detailViewController.resultEnd = selectEvent.resultEnd
                detailViewController.paymentStart = selectEvent.paymentStart
                detailViewController.paymentEnd = selectEvent.paymentEnd
                detailViewController.issueStart = selectEvent.issueStart
                detailViewController.issueEnd = selectEvent.issueEnd
                detailViewController.url = selectEvent.url
                detailViewController.memo = selectEvent.memo
            }
        }
        // 新規作成画面への受け渡し
        if segue.identifier == "add" {
            print("prepare addを呼んだよ")
            /*if let indexPath = self.tableView.indexPathForSelectedRow {
                print("indexPath= \(indexPath)")
                let nav = segue.destination as! UINavigationController
                let addViewController = nav.topViewController as! AddTableViewController
                addViewController.indexPath = indexPath
            }*/
            
            
        }
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
}

// 独自クラスをシリアライズする際には、NSObjectを継承しNSSecureCodingプロトコルに準拠する必要がある
class Event: NSObject, NSSecureCoding {
    
    static var supportsSecureCoding: Bool {
        return true
    }
    // 公演
    var genre: String?
    var program: String?
    var place: String?
    // 公演情報
    var date: String?
    var tickets: String?
    var price: String?
    var fee: String?
    var type: String?
    var seat: String?
    var status: Int?
    var partner: String?
    // チケット情報
    var platform: String?
    var owner: String?
    var toIssue: String?
    var applicationStart: String?
    var applicationEnd: String?
    var resultStart: String?
    var resultEnd: String?
    var paymentStart: String?
    var paymentEnd: String?
    var issueStart: String?
    var issueEnd: String?
    // etc
    var url: String?
    var memo: String?
    // コンストラクタ
    override init() {
    }
    // NSCodingプロトコルに宣言されているデシリアライズ処理。デコード処理とも呼ばれる
    required init?(coder aDecoder: NSCoder) {
        genre = aDecoder.decodeObject(forKey: "genre") as? String
        program = aDecoder.decodeObject(forKey: "program") as? String
        date = aDecoder.decodeObject(forKey: "date") as? String
        place = aDecoder.decodeObject(forKey: "place") as? String
        tickets = aDecoder.decodeObject(forKey: "tickets") as? String
        price = aDecoder.decodeObject(forKey: "price") as? String
        fee = aDecoder.decodeObject(forKey: "fee") as? String
        type = aDecoder.decodeObject(forKey: "type") as? String
        seat = aDecoder.decodeObject(forKey: "seat") as? String
        status = aDecoder.decodeObject(forKey: "status") as? Int
        partner = aDecoder.decodeObject(forKey: "partner") as? String
        
        platform = aDecoder.decodeObject(forKey: "platform") as? String
        owner = aDecoder.decodeObject(forKey: "owner") as? String
        toIssue = aDecoder.decodeObject(forKey: "toIssue") as? String
        applicationStart = aDecoder.decodeObject(forKey: "applicationStart") as? String
        applicationEnd = aDecoder.decodeObject(forKey: "applicationEnd") as? String
        resultStart = aDecoder.decodeObject(forKey: "resultStart") as? String
        resultEnd = aDecoder.decodeObject(forKey: "resultEnd") as? String
        paymentStart = aDecoder.decodeObject(forKey: "paymentStart") as? String
        paymentEnd = aDecoder.decodeObject(forKey: "paymentEnd") as? String
        issueStart = aDecoder.decodeObject(forKey: "issueStart") as? String
        issueEnd = aDecoder.decodeObject(forKey: "issueEnd") as? String
        url = aDecoder.decodeObject(forKey: "url") as? String
        memo = aDecoder.decodeObject(forKey: "memo") as? String
    }
    // NSCodingプロトコルに宣言されているシリアライズ処理。エンコード処理とも呼ばれる
    func encode(with aCoder: NSCoder) {
        aCoder.encode(genre, forKey: "genre")
        aCoder.encode(program, forKey: "program")
        aCoder.encode(date, forKey: "date")
        aCoder.encode(place, forKey: "place")
        aCoder.encode(tickets, forKey: "tickets")
        aCoder.encode(price, forKey: "price")
        aCoder.encode(fee, forKey: "fee")
        aCoder.encode(type, forKey: "type")
        aCoder.encode(seat, forKey: "seat")
        aCoder.encode(status, forKey: "status")
        aCoder.encode(partner, forKey: "partner")
        aCoder.encode(platform, forKey: "platform")
        aCoder.encode(owner, forKey: "owner")
        aCoder.encode(toIssue, forKey: "toIssue")
        aCoder.encode(applicationStart, forKey: "applicationStart")
        aCoder.encode(applicationEnd, forKey: "applicationEnd")
        aCoder.encode(resultStart, forKey: "resultStart")
        aCoder.encode(resultEnd, forKey: "resultEnd")
        aCoder.encode(paymentStart, forKey: "paymentStart")
        aCoder.encode(paymentEnd, forKey: "paymentEnd")
        aCoder.encode(issueStart, forKey: "issueStart")
        aCoder.encode(issueEnd, forKey: "issueEnd")
        aCoder.encode(url, forKey: "url")
        aCoder.encode(memo, forKey: "memo")
    }
}

