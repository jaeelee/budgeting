//
//  BudgetView.swift
//  ShrimpSlide
//
//  Created by jaeeun on 12/16/24.
//

import SwiftUI

struct BudgetView: View {
    @State private var currentMonth = Calendar.current.component(.month, from: Date())
    @State private var currentYear = Calendar.current.component(.year, from: Date())

    @Binding var showDatePicker: Bool

///
    @State private var annualSalary: String = ""
    @State private var monthlySalary: Double = 0.0
    @State private var isEditing: Bool = false

    @State private var budget: String = ""
    @State private var formattedBudget: String = ""

    @State private var expenseItemList: [String] = []
    @State private var newExpenseItem: String = ""
///

    var body: some View {
        NavigationView {
            VStack {
                // 여기에 예산 관련 내용을 표시
                TextField("예산을 입력하세요", text: $budget)
                    .keyboardType(.numberPad)
                    // .onChange(of: budget) { newValue in
                    //     // 원(₩) 표시 제거
                    //     let numberOnly = newValue.replacingOccurrences(of: "원", with: "")
                    //                         .replacingOccurrences(of: ",", with: "")
                        
                    //     // 숫자만 필터링
                    //     budget = numberOnly.filter { "0123456789".contains($0) }
                        
                    //     // 포맷팅 적용
                    //     if let number = Double(budget) {
                    //         let formatter = NumberFormatter()
                    //         formatter.numberStyle = .decimal
                    //         if let formatted = formatter.string(from: NSNumber(value: number)) {
                    //             formattedBudget = formatted + "원"
                    //         }
                    //     } else {
                    //         formattedBudget = ""
                    //     }
                    // }
                    .overlay(Rectangle().frame(height: 1).padding(.top, 35))
                    .foregroundColor(.gray)
                    // .disabled(true)

                    List {
                        ForEach($expenseItemList.indices, id: \.self) { index in
                            HStack{
                                Text("\(index + 1)")
                                
                                TextField("", text: $expenseItemList[index])
                                    .keyboardType(.numberPad)
                            }
                        }
                        .onDelete(perform: deleteExpenseItem)
                    }
                    .frame(minHeight:0)
                
                    Button(action: addExpenseItem){
                        Text("추가하기")
                            .foregroundColor(.white)
                            .padding(.horizontal, 15)
                            .padding(.vertical, 8)
                            .background(.blue)
                            .cornerRadius(8)
                    }
                    
                HStack {
                    TextField("연봉을 입력하세요 (단위: 만원)", text: $annualSalary)
                        .keyboardType(.numberPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .disabled(!isEditing)
                    
                    Button(action: {
                        if isEditing {
                            calculateMonthlySalary()
                        }
                        isEditing.toggle()
                    }) {
                        Text(isEditing ? "수정완료" : "수정하기")
                            .foregroundColor(.white)
                            .padding(.horizontal, 15)
                            .padding(.vertical, 8)
                            .background(isEditing ? Color.green : Color.blue)
                            .cornerRadius(8)
                    }
                }
                .padding()
                .hidden()
            
            

                if monthlySalary > 0 {
                    Text("예상 월급: \(String(format: "%.1f", monthlySalary))만원")
                        .font(.title2)
                        .padding()
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    HStack {
                        Button(action: { changeMonth(-1) }) {
                            Image(systemName: "chevron.left")
                        }
                        
                        Text(String(format: "%d년 %d월 예산", currentYear, currentMonth))
                            .font(.headline)
                            .onTapGesture {
                                showDatePicker.toggle()
                            }
                        
                        Button(action: { changeMonth(1) }) {
                            Image(systemName: "chevron.right")
                        }
                    }
                }
            }  
           
        }
    }
    
    private func changeMonth(_ value: Int) {
        var dateComponents = DateComponents()
        dateComponents.year = currentYear
        dateComponents.month = currentMonth
        
        if let date = Calendar.current.date(from: dateComponents),
           let newDate = Calendar.current.date(byAdding: .month, value: value, to: date) {
            currentMonth = Calendar.current.component(.month, from: newDate)
            currentYear = Calendar.current.component(.year, from: newDate)
        }
    }


    private func calculateMonthlySalary() {
        if let annual = Double(annualSalary) {
            monthlySalary = annual / 12
        }
    }

    // 카테고리 추가
    private func addExpenseItem() {
        expenseItemList.append(newExpenseItem)
    }
    // 카테고리 삭제
    private func deleteExpenseItem(at offsets: IndexSet) {
        expenseItemList.remove(atOffsets: offsets)
    }
    // 금액 포맷팅 함수
    // private func formatCurrency(value: String) -> String? {
    //     let numberFormatter = NumberFormatter()
    //     numberFormatter.numberStyle = .decimal
        
    //     if let number = Int(value) {
    //         return numberFormatter.string(from: NSNumber(value: number))
    //     }
    //     return nil
    // }

}

