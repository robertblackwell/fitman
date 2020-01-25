//
//  ContentView.swift
//  Timed
//
//  Created by Brendon Blackwell on 08.01.20.
//  Copyright © 2020 Brendon Blackwell. All rights reserved.
//

import SwiftUI

struct LabelItem {
    var label: String;
    var id: Int;
}
fileprivate func mkLabels(exLabels: [String]) -> [LabelItem] {
    var res: [LabelItem] = []
    var ix: Int = 0
    for label in exLabels {
        let itm: LabelItem = LabelItem(label: label, id: ix)
        res.append(itm)
        ix += 1
    }
    return res
}
//
// picks the exercise session to run.
// Made into a separate View so that it is not updated by progress reporting
//
struct SessionPicker: View {

    var controller: ExerciseController
    var exLabels: [String]
    @Binding var selectedExerciseSet: Int

    var body: some View {
        let ar: [LabelItem] = mkLabels(exLabels: self.exLabels)
        return VStack(alignment: HorizontalAlignment.leading) {
        
            Picker(selection: $selectedExerciseSet, label: Text("Select Exercise Set from:")) {
                ForEach(ar, id: \.id) { item in
                    Text(item.label).tag(item.id)
                }
            }
        }
    }
}
