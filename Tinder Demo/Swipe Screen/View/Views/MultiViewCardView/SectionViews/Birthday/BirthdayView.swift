//
//  BirthdayView.swift
//  Tinder Demo
//
//  Created by Colin Murphy on 10/26/20.
//

import UIKit

class BirthdayView: UIView {

    // MARK: - IBOutlets

    @IBOutlet weak private var contentView: UIView!
    @IBOutlet weak private var monthLabel: UILabel!
    @IBOutlet weak private var yearLabel: UILabel!
    @IBOutlet weak private var ageLabel: UILabel!

    // MARK: - Properties

    private var datePicker: UIDatePicker?
    private let formatter = DateFormatter()

    // MARK: - Inits

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    private func commonInit() {
        Bundle.main.loadNibNamed("BirthdayView", owner: self, options: nil)
        formatter.dateFormat = "yyyy-MM-dd"
    }

    // MARK: - Setup

    func setInfo(user: User) {

        guard let userBday = user.birth?.date else { return }
        let lastIndex = userBday.index(userBday.startIndex, offsetBy: 9)
        let bdayString = String(userBday[...lastIndex])
        guard let date = formatter.date(from: bdayString) else { return }

        if #available(iOS 14.0, *) {
            setupDatePicker(with: date)
        } else {
            addSubview(contentView)
            contentView.frame = bounds
            contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            #warning("setup for pre ios14")
        }
    }

    @available(iOS 14.0, *)
    private func setupDatePicker(with date: Date) {

        datePicker = UIDatePicker()
        guard let datePicker = datePicker else { return }
        datePicker.date = date
        datePicker.isUserInteractionEnabled = false
        datePicker.tintColor = .systemPink
        datePicker.preferredDatePickerStyle = .inline
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.frame = bounds
        addSubview(datePicker)

        NSLayoutConstraint.activate([
            datePicker.centerYAnchor.constraint(equalTo: centerYAnchor),
            datePicker.centerXAnchor.constraint(equalTo: centerXAnchor),
            datePicker.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            datePicker.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            datePicker.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            datePicker.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20)
        ])
    }
}
