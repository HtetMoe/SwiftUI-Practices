//
//  StudentLists.swift
//  MyCodes
//
//  Created by Htet Moe Phyu on 02/05/2023.
//

import SwiftUI
import RealmSwift

struct StudentLists: View {
    //realm
    @ObservedResults(Student.self) var students
    
    @State private var showAddStudentView = false
    
    var body: some View {
        NavigationView {
            List{
                ForEach(students, id : \.userID) { student in
                    NavigationLink {
                        AddStudentView(studentToEdit: student)
                    } label: {
                        VStack(alignment : .leading){
                            Text(student.userID)
                            Text(student.userName)
                            Text(student.attendenceYear)
                        }
                    }

                }
                .onDelete(perform: $students.remove)
            }
            .sheet(isPresented: $showAddStudentView, content: {
                AddStudentView()
            })
            .navigationTitle("Student List")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement : .navigationBarTrailing){
                    Button {
                        showAddStudentView.toggle()
                    } label: {
                        Label("Add Student", systemImage: "plus")
                    }

                }
            }
        }
    }
}

struct StudentLists_Previews: PreviewProvider {
    static var previews: some View {
        StudentLists()
    }
}
