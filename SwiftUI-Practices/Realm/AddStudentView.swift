//
//  AddStudentView.swift
//  MyCodes
//
//  Created by Htet Moe Phyu on 02/05/2023.
//

import SwiftUI
import RealmSwift

struct AddStudentView: View {
    @Environment(\.dismiss) var dismiss
    var studentToEdit : Student? = nil
    
    @State private var userId : String = ""
    @State private var userName : String = ""
    @State private var year : String = ""
    
    //realm
    @ObservedResults(Student.self) var students
    
    init(studentToEdit : Student? = nil){
        self.studentToEdit = studentToEdit
       
        if let studentToEdit = studentToEdit{
            _userId   = State(initialValue: studentToEdit.userID)
            _userName = State(initialValue: studentToEdit.userName)
            _year     = State(initialValue: studentToEdit.attendenceYear)
        }
    }
    
    var body: some View {
        
        Section{
            Form {
                TextField("Student id", text: $userId)
                TextField("Student name", text: $userName)
                TextField("Year", text : $year)
                
                Button(studentToEdit != nil ? "Update" : "Save") {
                    if studentToEdit != nil{
                        print("do update")
                        self.updateStudentInfo()
                    }
                    else{
                        self.saveNewStudent()
                    }
                    dismiss()
                }
                .frame(maxWidth : .infinity)
                .buttonStyle(.bordered)
            }
            
        } header: {
            Text(studentToEdit != nil ? "Edit student info" : "Add New Student")
        }
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
       
    }
    
    private func saveNewStudent(){
        let newStudent = Student()
        newStudent.userID   = userId
        newStudent.userName = userName
        newStudent.attendenceYear = year
        
        $students.append(newStudent)
    }
    
    private func updateStudentInfo(){
        if let studentToEdit = studentToEdit{
            do {
                let realm = try Realm()
                guard let objectToUpdate = realm.object(ofType: Student.self, forPrimaryKey: studentToEdit.userID) else{
                    return
                }
                
                try realm.write{
                    objectToUpdate.userName = userName
                    objectToUpdate.attendenceYear = year
                }
            } catch {
                print("Failed update student : \(error.localizedDescription)")
            }
        }
    }
}

struct AddStudentView_Previews: PreviewProvider {
    static var previews: some View {
        AddStudentView()
    }
}
