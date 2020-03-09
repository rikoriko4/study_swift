//
//  AddTableViewController.swift
//  20190705
//
//  Created by りさこ on 2019/07/08.
//  Copyright © 2019年 りさこ. All rights reserved.
//

import UIKit

class AddTableViewController: UITableViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {
    
    
    // テキストフィールド接続
    @IBOutlet weak var genreTextField: UITextField!
    @IBOutlet weak var addProgramTextField: UITextField!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var placeTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var ticketsLabel: UILabel!
    @IBOutlet weak var ticketsPicker: UIPickerView!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var feeTextField: UITextField!
    @IBOutlet weak var typeTextField: UITextField!
    @IBOutlet weak var seatTextField: UITextField!
    @IBOutlet weak var statusSegment: UISegmentedControl!
    @IBOutlet weak var partnerTextField: UITextField!
    
    @IBOutlet weak var platformTextField: UITextField!
    @IBOutlet weak var ownerTextField: UITextField!
    @IBOutlet weak var toIssueTextField: UITextField!
    @IBOutlet weak var applicationStartLabel: UILabel!
    @IBOutlet weak var applicationStartPicker: UIDatePicker!
    @IBOutlet weak var applicationEndLabel: UILabel!
    @IBOutlet weak var applicationEndPicker: UIDatePicker!
    @IBOutlet weak var resultStartLabel: UILabel!
    @IBOutlet weak var resultStartPicker: UIDatePicker!
    @IBOutlet weak var resultEndLabel: UILabel!
    @IBOutlet weak var resultEndPicker: UIDatePicker!
    @IBOutlet weak var paymentStartLabel: UILabel!
    @IBOutlet weak var paymentStartPicker: UIDatePicker!
    @IBOutlet weak var paymentEndLabel: UILabel!
    @IBOutlet weak var paymentEndPicker: UIDatePicker!
    @IBOutlet weak var issueStartLabel: UILabel!
    @IBOutlet weak var issueStartPicker: UIDatePicker!
    @IBOutlet weak var issueEndLabel: UILabel!
    @IBOutlet weak var issueEndPicker: UIDatePicker!
    // etc
    @IBOutlet weak var URLTextField: UITextField!
    @IBOutlet weak var memoTextField: UITextField!
    
    // 公演
    var addedProgram: String?
    var addedGenre: String?
    var addedPlace: String?
    // 公演情報
    var addedDate: String?
    var addedPrice: String?
    var addedFee: String?
    var addedTickets: String?
    var tickets: String? //一時使用
    var ticketsArray:[Int] = ([Int])(1...10)
    var addedType: String?
    var addedSeat: String?
    var addedStatus: Int?
    var addedPartner: String?
    // チケット情報
    var addedPlatform: String?
    var addedOwner: String?
    var addedToIssue: String?
    var addedApplicationStart: String?
    var addedApplicationEnd: String?
    var addedResultStart: String?
    var addedResultEnd: String?
    var addedPaymentStart: String?
    var addedPaymentEnd: String?
    var addedIssueStart: String?
    var addedIssueEnd: String?
    // etc
    var addedURL: String?
    var addedMemo: String?
    
    var TextFieldArray: [UITextField] = []
    let dateFormatter = DateFormatter()
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ticketsPicker.dataSource = self
        ticketsPicker.delegate = self
        
        
        
        self.ticketsPicker.isHidden = true
        genreTextField.placeholder = "ジャンル"
        addProgramTextField.placeholder = "公演名"
        placeTextField.placeholder = "場所"
        
        setDateLabelText(datePicker.date)
        setUpDatePicker()
        priceTextField.keyboardType = UIKeyboardType.numberPad
        feeTextField.keyboardType = UIKeyboardType.numberPad
        memoTextField.placeholder = "メモ"
        URLTextField.placeholder = "URL"
        
        // textField全てにdelegateを設定（改行ボタンでキーボード閉じるため）
        TextFieldArray = [genreTextField, addProgramTextField, placeTextField, priceTextField, feeTextField, typeTextField, seatTextField, partnerTextField, platformTextField, ownerTextField, toIssueTextField, memoTextField]
        for fld in TextFieldArray {
            fld.delegate = self
        }
        
        // ドラッグしたらキーボード閉じる
        tableView.keyboardDismissMode = .onDrag
    }
    
    // 改行入力でキーボードを下げる
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return false
    }
    
    // 日付ラベル初期表示
    func setDateLabelText(_ date: Date) {
        print("setDateLabelTextメソッド")
        let today = NSDate() as Date
        let todayString: String = dateFormatter.string(from: today)
        if dateFormatter.string(from: date) == dateFormatter.string(from: today) {
            self.dateLabel.text = todayString
        } else {
            self.dateLabel!.text = dateFormatter.string(from: date)
        }
    }
    
    // datepicker初期設定
    func setUpDatePicker() {
        print("公演日picker初期設定")
        self.datePicker.isHidden = true
        self.datePicker.addTarget(self, action: #selector(onDidChangeDate(sender:)), for: .valueChanged)
        self.applicationStartPicker.isHidden = true
        self.applicationStartPicker.addTarget(self, action: #selector(changeApplicationStart(sender:)), for: .valueChanged)
        self.applicationEndPicker.isHidden = true
        self.applicationEndPicker.addTarget(self, action: #selector(changeApplicationEnd(sender:)), for: .valueChanged)
        self.resultStartPicker.isHidden = true
        self.resultStartPicker.addTarget(self, action: #selector(changeResultStart(sender:)), for: .valueChanged)
        self.resultEndPicker.isHidden = true
        self.resultEndPicker.addTarget(self, action: #selector(changeResultEnd(sender:)), for: .valueChanged)
        self.paymentStartPicker.isHidden = true
        self.paymentStartPicker.addTarget(self, action: #selector(changePaymentStart(sender:)), for: .valueChanged)
        self.paymentEndPicker.isHidden = true
        self.paymentEndPicker.addTarget(self, action: #selector(changePaymentEnd(sender:)), for: .valueChanged)
        self.issueStartPicker.isHidden = true
        self.issueStartPicker.addTarget(self, action: #selector(changeIssueStart(sender:)), for: .valueChanged)
        self.issueEndPicker.isHidden = true
        self.issueEndPicker.addTarget(self, action: #selector(changeIssueEnd(sender:)), for: .valueChanged)
        
    }
    
    // 公演日変更したとき
    @objc func onDidChangeDate(sender: UIDatePicker) {
        dateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "ydMMM HHmm", options: 0, locale: Locale(identifier: "ja_JP"))
        self.dateLabel.text = dateFormatter.string(from: datePicker.date)
    }
    // 申込開始日変更したとき
    @objc func changeApplicationStart(sender: UIDatePicker) {
        dateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "ydMMM HHmm", options: 0, locale: Locale(identifier: "ja_JP"))
        self.applicationStartLabel.text = dateFormatter.string(from: applicationStartPicker.date)
    }
    // 申込終了日変更したとき
    @objc func changeApplicationEnd(sender: UIDatePicker) {
        dateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "ydMMM HHmm", options: 0, locale: Locale(identifier: "ja_JP"))
        self.applicationEndLabel.text = dateFormatter.string(from: applicationEndPicker.date)
    }
    // 当落開始日変更したとき
    @objc func changeResultStart(sender: UIDatePicker) {
        dateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "ydMMM HHmm", options: 0, locale: Locale(identifier: "ja_JP"))
        self.resultStartLabel.text = dateFormatter.string(from: resultStartPicker.date)
    }
    // 当落終了日変更したとき
    @objc func changeResultEnd(sender: UIDatePicker) {
        dateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "ydMMM HHmm", options: 0, locale: Locale(identifier: "ja_JP"))
        self.resultEndLabel.text = dateFormatter.string(from: resultEndPicker.date)
    }
    // 入金開始日変更したとき
    @objc func changePaymentStart(sender: UIDatePicker) {
        dateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "ydMMM HHmm", options: 0, locale: Locale(identifier: "ja_JP"))
        self.paymentStartLabel.text = dateFormatter.string(from: paymentStartPicker.date)
    }
    // 入金終了日変更したとき
    @objc func changePaymentEnd(sender: UIDatePicker) {
        dateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "ydMMM HHmm", options: 0, locale: Locale(identifier: "ja_JP"))
        self.paymentEndLabel.text = dateFormatter.string(from: paymentEndPicker.date)
    }
    // 発券開始日変更したとき
    @objc func changeIssueStart(sender: UIDatePicker) {
        dateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "ydMMM HHmm", options: 0, locale: Locale(identifier: "ja_JP"))
        self.issueStartLabel.text = dateFormatter.string(from: issueStartPicker.date)
    }
    // 入金終了日変更したとき
    @objc func changeIssueEnd(sender: UIDatePicker) {
        dateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "ydMMM HHmm", options: 0, locale: Locale(identifier: "ja_JP"))
        self.issueEndLabel.text = dateFormatter.string(from: issueEndPicker.date)
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
   
    //PickerViewのコンポーネントの数を決めるメソッド
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if pickerView == ticketsPicker {
            print("ticketsPickerコンポーネント数")
            return 1
        } else {
            return 1
        }
    }
    //PickerViewのコンポーネント内の行数を決めるメソッド
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        print("ticketsPicker行数")
        return ticketsArray.count
    }
    //PickerViewのコンポーネントに表示するデータを決めるメソッド
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        print("ticketsPickerデータ")
        return String(ticketsArray[row]) + "枚"
    }
    // ドラムロール選択時
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("ticketsPickerドラムロール")
        self.ticketsLabel.text = String(ticketsArray[row]) + "枚"
        tickets = String(ticketsArray[row]) //枚数のみ保持
    }
    
     // セルの高さ
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 1 && indexPath.row == 2 {
            let height: CGFloat = datePicker.isHidden ? 0.0 : 200.0
            return height
        }
        if indexPath.section == 1 && indexPath.row == 4 {
            let height: CGFloat = ticketsPicker.isHidden ? 0.0 : 200.0
            return height
        }
        if indexPath.section == 2 && indexPath.row == 4 {
            let height: CGFloat = applicationStartPicker.isHidden ? 0.0 : 200.0
            return height
        }
        if indexPath.section == 2 && indexPath.row == 6 {
            let height: CGFloat = applicationEndPicker.isHidden ? 0.0 : 200.0
            return height
        }
        if indexPath.section == 2 && indexPath.row == 8 {
            let height: CGFloat = resultStartPicker.isHidden ? 0.0 : 200.0
            return height
        }
        if indexPath.section == 2 && indexPath.row == 10 {
            let height: CGFloat = resultEndPicker.isHidden ? 0.0 : 200.0
            return height
        }
        if indexPath.section == 2 && indexPath.row == 12 {
            let height: CGFloat = paymentStartPicker.isHidden ? 0.0 : 200.0
            return height
        }
        if indexPath.section == 2 && indexPath.row == 14 {
            let height: CGFloat = paymentEndPicker.isHidden ? 0.0 : 200.0
            return height
        }
        if indexPath.section == 2 && indexPath.row == 16 {
            let height: CGFloat = issueStartPicker.isHidden ? 0.0 : 200.0
            return height
        }
        if indexPath.section == 2 && indexPath.row == 18 {
            let height: CGFloat = issueEndPicker.isHidden ? 0.0 : 200.0
            return height
        }
        if indexPath.section == 3 && indexPath.row == 1 {
            return 200.0
        }
 
        return 50.0
    }

    // セルをタップしたときの設定
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("セルをタップ。indexPath = \(indexPath)")
        
        if indexPath.section == 0 && indexPath.row == 0 {
            // テキストフィールドをタップした時入力開始
            addProgramTextField.becomeFirstResponder()
        }
        // 公演日
        if indexPath.section == 1 && indexPath.row == 1 {
            self.ticketsPicker.isHidden = true
            // 公演日タップ時datePickerを表示させる
            if self.datePicker.isHidden == true {
                // 非表示の場合datePickerを表示させる
                UIView.animate(withDuration: 0.3, animations: { () -> Void in
                    // セルをリロード
                    self.tableView.beginUpdates()
                    self.datePicker.isHidden = !self.datePicker.isHidden
                    self.tableView.deselectRow(at: indexPath, animated: true) //選択解除（これないと審査通らないらしい）
                    self.tableView.endUpdates()
                })
                self.datePicker.isHidden = false
            } else {
                // datePicker表示時は非表示にする
                UIView.animate(withDuration: 0.3, animations: { () -> Void in
                    // セルをリロード
                    self.tableView.beginUpdates()
                    self.datePicker.isHidden = true
                    self.tableView.deselectRow(at: indexPath, animated: true)
                    self.tableView.endUpdates()
                })
            }
        }
        // 枚数ラベル
        if indexPath.section == 1 && indexPath.row == 3 {
            self.datePicker.isHidden = true
            // 枚数タップ時Pickerを表示させる
            if self.ticketsPicker.isHidden == true {
                // 非表示の場合datePickerを表示させる
                UIView.animate(withDuration: 0.3, animations: { () -> Void in
                    self.tableView.beginUpdates()
                    self.ticketsPicker.isHidden = !self.ticketsPicker.isHidden
                    self.tableView.deselectRow(at: indexPath, animated: true)
                    self.tableView.endUpdates()
                })
                self.ticketsPicker.isHidden = false
            } else {
                // datePicker表示時は非表示にする
                UIView.animate(withDuration: 0.3, animations: { () -> Void in
                    self.tableView.beginUpdates()
                    self.ticketsPicker.isHidden = true
                    self.tableView.deselectRow(at: indexPath, animated: true)
                    self.tableView.endUpdates()
                })
            }
        }
        //申込開始日ピッカー
        if indexPath.section == 2 && indexPath.row == 3 {
            if self.applicationStartPicker.isHidden == true {
                // 非表示の場合datePickerを表示させる
                UIView.animate(withDuration: 0.3, animations: { () -> Void in
                    self.tableView.beginUpdates()
                    self.applicationStartPicker.isHidden = !self.applicationStartPicker.isHidden
                    self.tableView.deselectRow(at: indexPath, animated: true)
                    self.tableView.endUpdates()
                })
                self.applicationStartPicker.isHidden = false
            } else {
                // 非表示にする
                UIView.animate(withDuration: 0.3, animations: { () -> Void in
                    self.tableView.beginUpdates()
                    self.applicationStartPicker.isHidden = true
                    self.tableView.deselectRow(at: indexPath, animated: true)
                    self.tableView.endUpdates()
                })
            }
        }
        //申込終了日ピッカー
        if indexPath.section == 2 && indexPath.row == 5 {
            if self.applicationEndPicker.isHidden == true {
                // 非表示の場合datePickerを表示させる
                UIView.animate(withDuration: 0.3, animations: { () -> Void in
                    self.tableView.beginUpdates()
                    self.applicationEndPicker.isHidden = !self.applicationEndPicker.isHidden
                    self.tableView.deselectRow(at: indexPath, animated: true)
                    self.tableView.endUpdates()
                })
                self.applicationEndPicker.isHidden = false
            } else {
                // 非表示にする
                UIView.animate(withDuration: 0.3, animations: { () -> Void in
                    self.tableView.beginUpdates()
                    self.applicationEndPicker.isHidden = true
                    self.tableView.deselectRow(at: indexPath, animated: true)
                    self.tableView.endUpdates()
                })
            }
        }
        //当落開始日ピッカー
        if indexPath.section == 2 && indexPath.row == 7 {
            if self.resultStartPicker.isHidden == true {
                // 非表示の場合datePickerを表示させる
                UIView.animate(withDuration: 0.3, animations: { () -> Void in
                    self.tableView.beginUpdates()
                    self.resultStartPicker.isHidden = !self.resultStartPicker.isHidden
                    self.tableView.deselectRow(at: indexPath, animated: true)
                    self.tableView.endUpdates()
                })
                self.resultStartPicker.isHidden = false
            } else {
                // 非表示にする
                UIView.animate(withDuration: 0.3, animations: { () -> Void in
                    self.tableView.beginUpdates()
                    self.resultStartPicker.isHidden = true
                    self.tableView.deselectRow(at: indexPath, animated: true)
                    self.tableView.endUpdates()
                })
            }
        }
        //当落終了日ピッカー
        if indexPath.section == 2 && indexPath.row == 9 {
            if self.resultEndPicker.isHidden == true {
                // 非表示の場合datePickerを表示させる
                UIView.animate(withDuration: 0.3, animations: { () -> Void in
                    self.tableView.beginUpdates()
                    self.resultEndPicker.isHidden = !self.resultEndPicker.isHidden
                    self.tableView.deselectRow(at: indexPath, animated: true)
                    self.tableView.endUpdates()
                })
                self.resultEndPicker.isHidden = false
            } else {
                // 非表示にする
                UIView.animate(withDuration: 0.3, animations: { () -> Void in
                    self.tableView.beginUpdates()
                    self.resultEndPicker.isHidden = true
                    self.tableView.deselectRow(at: indexPath, animated: true)
                    self.tableView.endUpdates()
                })
            }
        }
        //入金開始日ピッカー
        if indexPath.section == 2 && indexPath.row == 11 {
            if self.paymentStartPicker.isHidden == true {
                // 非表示の場合datePickerを表示させる
                UIView.animate(withDuration: 0.3, animations: { () -> Void in
                    self.tableView.beginUpdates()
                    self.paymentStartPicker.isHidden = !self.paymentStartPicker.isHidden
                    self.tableView.deselectRow(at: indexPath, animated: true)
                    self.tableView.endUpdates()
                })
                self.paymentStartPicker.isHidden = false
            } else {
                // 非表示にする
                UIView.animate(withDuration: 0.3, animations: { () -> Void in
                    self.tableView.beginUpdates()
                    self.paymentStartPicker.isHidden = true
                    self.tableView.deselectRow(at: indexPath, animated: true)
                    self.tableView.endUpdates()
                })
            }
        }
        //入金終了日ピッカー
        if indexPath.section == 2 && indexPath.row == 13 {
            if self.paymentEndPicker.isHidden == true {
                // 非表示の場合datePickerを表示させる
                UIView.animate(withDuration: 0.3, animations: { () -> Void in
                    self.tableView.beginUpdates()
                    self.paymentEndPicker.isHidden = !self.paymentEndPicker.isHidden
                    self.tableView.deselectRow(at: indexPath, animated: true)
                    self.tableView.endUpdates()
                })
                self.paymentEndPicker.isHidden = false
            } else {
                // 非表示にする
                UIView.animate(withDuration: 0.3, animations: { () -> Void in
                    self.tableView.beginUpdates()
                    self.paymentEndPicker.isHidden = true
                    self.tableView.deselectRow(at: indexPath, animated: true)
                    self.tableView.endUpdates()
                })
            }
        }
        //発券開始日ピッカー
        if indexPath.section == 2 && indexPath.row == 15 {
            if self.issueStartPicker.isHidden == true {
                // 非表示の場合datePickerを表示させる
                UIView.animate(withDuration: 0.3, animations: { () -> Void in
                    self.tableView.beginUpdates()
                    self.issueStartPicker.isHidden = !self.issueStartPicker.isHidden
                    self.tableView.deselectRow(at: indexPath, animated: true)
                    self.tableView.endUpdates()
                })
                self.issueStartPicker.isHidden = false
            } else {
                // 非表示にする
                UIView.animate(withDuration: 0.3, animations: { () -> Void in
                    self.tableView.beginUpdates()
                    self.issueStartPicker.isHidden = true
                    self.tableView.deselectRow(at: indexPath, animated: true)
                    self.tableView.endUpdates()
                })
            }
        }
        //発券終了日ピッカー
        if indexPath.section == 2 && indexPath.row == 17 {
            if self.issueEndPicker.isHidden == true {
                // 非表示の場合datePickerを表示させる
                UIView.animate(withDuration: 0.3, animations: { () -> Void in
                    self.tableView.beginUpdates()
                    self.issueEndPicker.isHidden = !self.issueEndPicker.isHidden
                    self.tableView.deselectRow(at: indexPath, animated: true)
                    self.tableView.endUpdates()
                })
                self.issueEndPicker.isHidden = false
            } else {
                // 非表示にする
                UIView.animate(withDuration: 0.3, animations: { () -> Void in
                    self.tableView.beginUpdates()
                    self.issueEndPicker.isHidden = true
                    self.tableView.deselectRow(at: indexPath, animated: true)
                    self.tableView.endUpdates()
                })
            }
        }
        
        
    }
    
    

    
    // MARK: - Table view data source

    /* datepickerのためコメントアウト
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    */

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

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
        print("prepare addsaveを呼んだよ")
        if segue.identifier == "addsave" {
            // 公演
            addedProgram = addProgramTextField.text
            addedGenre = genreTextField.text
            addedPlace = placeTextField.text
            // 公演情報
            addedStatus = statusSegment.selectedSegmentIndex
            addedDate = dateLabel.text
            if tickets != nil {
                addedTickets = tickets
            } else {
                addedTickets = ""
            }
            addedPrice = priceTextField.text
            addedFee = feeTextField.text
            addedType = typeTextField.text
            addedSeat = seatTextField.text
            addedPartner = partnerTextField.text
            // チケット情報
            addedPlatform = platformTextField.text
            addedOwner = ownerTextField.text
            addedToIssue = toIssueTextField.text
            addedApplicationStart = applicationStartLabel.text
            addedApplicationEnd = applicationEndLabel.text
            addedResultStart = resultStartLabel.text
            addedResultEnd = resultEndLabel.text
            addedPaymentStart = paymentStartLabel.text
            addedPaymentEnd = paymentEndLabel.text
            addedIssueStart = issueStartLabel.text
            addedIssueEnd = issueEndLabel.text
            // etc
            addedURL = URLTextField.text
            addedMemo = memoTextField.text
        }
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
