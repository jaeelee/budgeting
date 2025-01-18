//
//  ContentView.swift
//  ShrimpSlide
//
//  Created by jaeeun on 11/26/24.
//

import SwiftUI

struct ContentView: View {


    @State private var showDatePicker = false
    @State private var selectedDate = Date()
    @State private var selectedYear = Calendar.current.component(.year, from: Date())
    @State private var selectedMonth = Calendar.current.component(.month, from: Date())

    var body: some View {
        VStack(spacing: 20) {
            BudgetView(showDatePicker: $showDatePicker)
        }
        .sheet(isPresented: $showDatePicker) {
            NavigationView {
                    VStack {
                        HStack {
                            Text("월 선택")
                                .font(.system(size: 20)) // 텍스트 크기 조정
                                .padding(.leading)
                            Spacer()
                            Button("완료") {
                                showDatePicker = false
                            }
                            .padding(.trailing)
                        }
                        .padding(.vertical, 10)
                    
                        YearMonthPicker(
                            selectedYear: $selectedYear,
                            selectedMonth: $selectedMonth
                        )
                    }
            }
            .padding()
            .presentationDetents([.height(300)])
        }
    }
  
}

struct YearMonthPicker: UIViewRepresentable {
    @Binding var selectedYear: Int
    @Binding var selectedMonth: Int

    private let years = Array(2000...2100)
    private let months = Array(1...12)

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIView(context: Context) -> UIPickerView {
        let pickerView = UIPickerView()
        pickerView.delegate = context.coordinator
        pickerView.dataSource = context.coordinator

        // 초기 선택값 설정
        let initialYearIndex = years.firstIndex(of: selectedYear) ?? 0
        let initialMonthIndex = months.firstIndex(of: selectedMonth) ?? 0

        pickerView.selectRow(initialYearIndex, inComponent: 0, animated: false)
        pickerView.selectRow(initialMonthIndex, inComponent: 1, animated: false)

        return pickerView
    }

    func updateUIView(_ uiView: UIPickerView, context: Context) {}

    class Coordinator: NSObject, UIPickerViewDelegate, UIPickerViewDataSource {
        private let parent: YearMonthPicker

        init(_ parent: YearMonthPicker) {
            self.parent = parent
        }

        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 2 // 연, 월
        }

        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return component == 0 ? parent.years.count : parent.months.count
        }

        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return component == 0 ? "\(parent.years[row])년" : "\(parent.months[row])월"
        }

        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            if component == 0 {
                parent.selectedYear = parent.years[row]
            } else {
                parent.selectedMonth = parent.months[row]
            }
        }
    }
}

#Preview {
    ContentView()
}

/**
    
        VStack(spacing: 20) {
            Text("가계부")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            TextField("연봉을 입력하세요 (단위: 만원)", text: $annualSalary)
                .keyboardType(.numberPad)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button(action: calculateMonthlySalary) {
                Text("월급 계산하기")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            
            if monthlySalary > 0 {
                Text("예상 월급: \(String(format: "%.1f", monthlySalary))만원")
                    .font(.title2)
                    .padding()
            }
        }
        .padding()
    }
    
    private func calculateMonthlySalary() {
        if let annual = Double(annualSalary) {
            monthlySalary = annual / 12
        }
    }
}
**/
