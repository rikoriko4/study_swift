//
//  DetailTableViewController.swift
//  20190705
//
//  Created by りさこ on 2019/07/05.
//  Copyright © 2019年 りさこ. All rights reserved.
//

import UIKit

class DetailTableViewController: UITableViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {

    // テキストフィールド接続
    @IBOutlet weak var genreTextField: UITextField!
    @IBOutlet weak var editProgramTextField: UITextField!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var placeTextField: UITextField!
    @IBOutlet weak var ticketsLabel: UILabel!
    @IBOutlet weak var ticketsPicker: UIPickerView!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var feeTextField: UITextField!
    @IBOutlet weak var typeTextField: UITextField!
    @IBOutlet weak var seatTextField: UITextField!
    @IBOutlet weak var statusSegment: UISegmentedControl!
    @IBOutlet weak var partnerTextField: UITextField!
    // チケット情報
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
    @IBOutlet weak var URLTextFiled: UITextField!
    @IBOutlet weak var linkButton: UIButton!
    @IBOutlet weak var memoTextField: UITextField!
    
    // 公演
    var genre: String?
    var program: String?
    var place: String?
    // 公演情報
    var date: String?
    var tickets: String?
    var ticketsArray:[Int] = ([Int])(1...10)
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
    
    var eventArray: Array<String> = []
    var editedGenre: String?
    var editedProgram: String?
    var editedPlace: String?
    // 公演情報
    var editeddate: String?
    var editedTickets: String?
    var editedPrice: String?
    var editedFee: String?
    var editedType: String?
    var editedSeat: String?
    var editedStatus: Int?
    var editedPartner: String?
    // チケット情報
    var editedPlatform: String?
    var editedOwner: String?
    var editedToIssue: String?
    var editedApplicationStart: String?
    var editedApplicationEnd: String?
    var editedResultStart: String?
    var editedResultEnd: String?
    var editedPaymentStart: String?
    var editedPaymentEnd: String?
    var editedIssueStart: String?
    var editedIssueEnd: String?
    // etc
    var editedURL: String?
    var editedMemo: String?
    
    var labelArray : [UILabel] = []
    var TextFieldArray: [UITextField] = []
    
    
    var indexPath: IndexPath?
    let dateFormatter = DateFormatter()
    
    // Safariでリンク先を開く
    @IBAction func pushButton(_ sender: UIButton) {
        if let unwrapUrl = url {
            let openUrl = URL(string: unwrapUrl)!
            if UIApplication.shared.canOpenURL(openUrl) {
                UIApplication.shared.open(openUrl)
            }
        }
    }
    
    @IBAction func deleteButton(_ sender: Any) {
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // フォント設定
        labelArray = [dateLabel, ticketsLabel, applicationStartLabel, applicationEndLabel, resultStartLabel, resultEndLabel, paymentStartLabel, paymentEndLabel, issueStartLabel, issueEndLabel]
        TextFieldArray = [genreTextField, editProgramTextField, placeTextField, priceTextField, feeTextField, typeTextField, seatTextField, partnerTextField, platformTextField, ownerTextField, toIssueTextField, memoTextField]
        for lbl in labelArray {
            lbl.font = UIFont.systemFont(ofSize: 15)
        }
        for fld in TextFieldArray {
            fld.font = UIFont.systemFont(ofSize: 15)
        }
        
        // 修正前入力値をテキストフィールドに設定
        if let unwrapGenre = genre, !unwrapGenre.isEmpty {
            genreTextField.text = genre
        } else {
            genreTextField.placeholder = "ジャンル"
        }
        if let unwrapProgram = program, !unwrapProgram.isEmpty {
            editProgramTextField.text = program
        } else {
            editProgramTextField.placeholder = "公演名"
        }
        if let unwrapPlace = place, !unwrapPlace.isEmpty {
            placeTextField.text = place
        } else {
            placeTextField.placeholder = "場所"
        }
        
        dateLabel.text = date
        if let unwrapTickets = tickets {
            ticketsLabel.text = String(unwrapTickets) + "枚"
        }
        setUpDatePicker()
        setUpTicketsPicker()
        priceTextField.keyboardType = UIKeyboardType.numberPad
        priceTextField.text = price
        feeTextField.text = fee
        feeTextField.keyboardType = UIKeyboardType.numberPad
        typeTextField.text = type
        seatTextField.text = seat
        if let unwrapStatus = status {
            statusSegment.selectedSegmentIndex = unwrapStatus
        }
        if let unwrapPartner = partner {
            partnerTextField.text = unwrapPartner
        }
        // チケット情報
        platformTextField.text = platform
        ownerTextField.text = owner
        toIssueTextField.text = toIssue
        applicationStartLabel.text = applicationStart
        applicationEndLabel.text = applicationEnd
        resultStartLabel.text = resultStart
        resultEndLabel.text = resultEnd
        paymentStartLabel.text = paymentStart
        paymentEndLabel.text = paymentEnd
        issueStartLabel.text = issueStart
        issueEndLabel.text = issueEnd
        // etc
        URLTextFiled.text = url
        
        URLTextFiled.keyboardType = UIKeyboardType.URL
        if let unwrapMemo = memo, !unwrapMemo.isEmpty {
            memoTextField.text = memo
        } else {
            memoTextField.placeholder = "メモ"
        }
        
        //textField全てにdelegateを設定（改行ボタンでキーボード閉じるため）
        TextFieldArray = [genreTextField, editProgramTextField, placeTextField, priceTextField, feeTextField, typeTextField, seatTextField, partnerTextField, platformTextField, ownerTextField, toIssueTextField, memoTextField]
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
    
    // datepicker初期設定
    func setUpDatePicker() {
        print("公演日picker初期設定")
        dateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "ydMMM HHmm", options: 0, locale: Locale(identifier: "ja_JP"))
        
        self.datePicker.isHidden = true
        self.datePicker.addTarget(self, action: #selector(onDidChangeDate(sender:)), for: .valueChanged)
        if let unwrapDate = date {
            if let dateD = dateFormatter.date(from: unwrapDate) {
                datePicker.setDate(dateD, animated: true)
            }
        }
        self.applicationStartPicker.isHidden = true
        self.applicationStartPicker.addTarget(self, action: #selector(changeApplicationStart(sender:)), for: .valueChanged)
        if let unwrapDate = applicationStart {
            if let dateD = dateFormatter.date(from: unwrapDate) {
                applicationStartPicker.setDate(dateD, animated: true)
            }
        }
        self.applicationEndPicker.isHidden = true
        self.applicationEndPicker.addTarget(self, action: #selector(changeApplicationEnd(sender:)), for: .valueChanged)
        if let unwrapDate = applicationEnd {
            if let dateD = dateFormatter.date(from: unwrapDate) {
                applicationEndPicker.setDate(dateD, animated: true)
            }
        }
        self.resultStartPicker.isHidden = true
        self.resultStartPicker.addTarget(self, action: #selector(changeResultStart(sender:)), for: .valueChanged)
        if let unwrapDate = resultStart {
            if let dateD = dateFormatter.date(from: unwrapDate) {
                resultStartPicker.setDate(dateD, animated: true)
            }
        }
        self.resultEndPicker.isHidden = true
        self.resultEndPicker.addTarget(self, action: #selector(changeResultEnd(sender:)), for: .valueChanged)
        if let unwrapDate = resultEnd {
            if let dateD = dateFormatter.date(from: unwrapDate) {
                resultEndPicker.setDate(dateD, animated: true)
            }
        }
        self.paymentStartPicker.isHidden = true
        self.paymentStartPicker.addTarget(self, action: #selector(changePaymentStart(sender:)), for: .valueChanged)
        if let unwrapDate = paymentStart {
            if let dateD = dateFormatter.date(from: unwrapDate) {
                paymentStartPicker.setDate(dateD, animated: true)
            }
        }
        self.paymentEndPicker.isHidden = true
        self.paymentEndPicker.addTarget(self, action: #selector(changePaymentEnd(sender:)), for: .valueChanged)
        if let unwrapDate = paymentEnd {
            if let dateD = dateFormatter.date(from: unwrapDate) {
                paymentEndPicker.setDate(dateD, animated: true)
            }
        }
        self.issueStartPicker.isHidden = true
        self.issueStartPicker.addTarget(self, action: #selector(changeIssueStart(sender:)), for: .valueChanged)
        if let unwrapDate = issueStart {
            if let dateD = dateFormatter.date(from: unwrapDate) {
                issueStartPicker.setDate(dateD, animated: true)
            }
        }
        self.issueEndPicker.isHidden = true
        self.issueEndPicker.addTarget(self, action: #selector(changeIssueEnd(sender:)), for: .valueChanged)
        if let unwrapDate = issueEnd {
            if let dateD = dateFormatter.date(from: unwrapDate) {
                issueEndPicker.setDate(dateD, animated: true)
            }
        }
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
    
    // 枚数初期設定
    func setUpTicketsPicker() {
        print("枚数picker初期設定 \(String(tickets!))")
        ticketsPicker.dataSource = self
        ticketsPicker.delegate = self
        self.ticketsPicker.isHidden = true
        
        if let unwrapTickets = tickets {
            let ticketsInt = Int(unwrapTickets)
            if let unwrapTicketsInt = ticketsInt {
                let setTickets = unwrapTicketsInt - 1
                print(setTickets)
                ticketsPicker.selectRow(setTickets, inComponent: 0, animated: false)
                //ticketsPicker.inputView = locationPickerView
            }
        }
    }
    
    //PickerViewのコンポーネントの数を決めるメソッド
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if pickerView == ticketsPicker {
            return 1
        } else {
            return 1
        }
    }
    
    //PickerViewのコンポーネント内の行数を決めるメソッド
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return ticketsArray.count
    }
    
    //PickerViewのコンポーネントに表示するデータを決めるメソッド
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(ticketsArray[row]) + "枚"
    }
    // ドラムロール選択時
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.ticketsLabel.text = String(ticketsArray[row]) + "枚"
        tickets = String(ticketsArray[row]) // 枚数のみ保持
    }
    
    // セルをタップしたときの設定
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 && indexPath.row == 0 {
            self.datePicker.isHidden = true
            editProgramTextField.becomeFirstResponder()
        }
        tableView.deselectRow(at: indexPath, animated: true)
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
                self.ticketsPicker.isHidden = true
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

    
    // セルの高さ
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 1 && indexPath.row == 2 {
            print("height変更")
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Table view data source

    /*
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }
    */

    /*
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
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
        print("prepare saveを呼んだよ")
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "save" {
            editedGenre = genreTextField.text
            editedProgram = editProgramTextField.text
            editeddate = dateLabel.text
            editedPlace = placeTextField.text
            if tickets != nil {
                editedTickets = tickets
            } else {
                editedTickets = ""
            }
            editedPrice = priceTextField.text
            editedFee = feeTextField.text
            editedType = typeTextField.text
            editedSeat = seatTextField.text
            editedStatus = statusSegment.selectedSegmentIndex
            editedPartner = partnerTextField.text
            // チケット情報
            editedPlatform = platformTextField.text
            editedOwner = ownerTextField.text
            editedToIssue = toIssueTextField.text
            editedApplicationStart = applicationStartLabel.text
            editedApplicationEnd = applicationEndLabel.text
            editedResultStart = resultStartLabel.text
            editedResultEnd = resultEndLabel.text
            editedPaymentStart = paymentStartLabel.text
            editedPaymentEnd = paymentEndLabel.text
            editedIssueStart = issueStartLabel.text
            editedIssueEnd = issueEndLabel.text
            // etc
            editedURL = URLTextFiled.text
            editedMemo = memoTextField.text
 
        }
    }
    

}
