//
//  DummyManager.swift
//  Hamsters
//
//  Created by jaesik pyeon on 11/23/23.
//

import Foundation


class DummyManager {
    static let shared = DummyManager()
    let coreDataManager = CoreDataManager.shared
    
    func insertMedicine() {
        var newMedicine: Medicine
        newMedicine = Medicine(name: "콘서타 - 월화수",
                                   capacity: "30",
                                   unit: "정",
                                   frequency: [.monday,.tuesday,.wednesday],
                                   alarms: [AlarmItem(date: Date(), isEnabled: true),AlarmItem(date: Date(), isEnabled: true)],
                                   freOption: .specificDay,
                                   sortedDays: "sortedDays")
        
        MedicinesManager.shared.addMedicine(newMedicine)
        
        newMedicine = Medicine(name: "콘서타- 매일",
                                   capacity: "30",
                                   unit: "정",
                               frequency: [.monday,.tuesday,.wednesday,.thursday,.friday,.saturday,.sunday],
                                   alarms: [AlarmItem(date: Date(), isEnabled: true),AlarmItem(date: Date(), isEnabled: true)],
                                    freOption: .everyDay,
                                   sortedDays: "sortedDays")
        
        MedicinesManager.shared.addMedicine(newMedicine)
        
        newMedicine = Medicine(name: "콘서타 - 목",
                                   capacity: "30",
                                   unit: "정",
                               frequency: [.thursday,.friday,.saturday,.sunday],
                                   alarms: [AlarmItem(date: Date(), isEnabled: true),AlarmItem(date: Date(), isEnabled: true)],
                               freOption: .specificDay,
                                   sortedDays: "sortedDays")
        
        MedicinesManager.shared.addMedicine(newMedicine)
    }
    
    func insertHistory() {
        for i in 0..<10 {
            guard let date = Calendar.current.date(byAdding: .day, value: -i, to: Date()) else { break }
            let hm = HistoryModel(id: UUID(), capacity: "C", name: "NAME\(i)", settingTime: date, timeTaken: Date(), unit: "정")
            TakensManager.shared.updateHistory(date: date, historyModel: hm)
        }

    }
    
    func insertDayRecords() {
        for i in 0..<10 {
            guard let date = Calendar.current.date(byAdding: .day, value: -i, to: Date()) else { break }
            let dayRecord = DayRecord(
                date: Calendar.current.startOfDay(for: date),
                conditionValues: [0.0,1.0,2.0,3.0],
                moodValues: [0.0,1.0,2.0,3.0],
                sleepingTime: 10,
                popularEffect: [.constipated,.cough,.cough],
                dangerEffect: [.auditoryHallucinations,.chestPain,.mania],
                weight: 50.0,
                amountOfSmoking: 3,
                amountOfCaffein: 3,
                isPeriod: false,
                amountOfAlcohol: 3,
                memo: "memo"
            )

            DayRecordsManager.shared.saveDayRecord(dayRecord)
        }

    }
}
