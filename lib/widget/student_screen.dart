import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:project_data/classes/student_queue_array.dart';
import 'package:project_data/classes/student_stack_array.dart';
import 'package:project_data/classes/students_data.dart';
import 'package:project_data/classes/students_linkedlist.dart';

class StudentScreen extends StatefulWidget {
  const StudentScreen({super.key});

  @override
  _StudentScreenState createState() => _StudentScreenState();
}

class _StudentScreenState extends State<StudentScreen> {
  TextEditingController nameCtrl = TextEditingController();
  TextEditingController gradeCtrl = TextEditingController();
  TextEditingController ageCtrl = TextEditingController();
  TextEditingController idCtrl = TextEditingController();
  TextEditingController searchCtrl = TextEditingController();

  StudentLinkedList list = StudentLinkedList();
  StudentStackArray stack = StudentStackArray(50);
  StudentQueue queue = StudentQueue(50);
  GlobalKey<FormState> formkey = GlobalKey();
  Student? selectedStudent;
  bool showUndo = false;
  var studentsBox = Hive.box<Student>('studentBox');
  @override
  void initState() {
    super.initState();
    // add student when open program
    for (var student in studentsBox.values) {
      list.add(student);
    }
    list.sortByGradeDesc();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: Text(
            "Management Students",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          ),
          centerTitle: true,
        ),
        body: Form(
          key: formkey,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: searchCtrl,
                            keyboardType: TextInputType.name,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                RegExp(r'[a-zA-Z]'),
                              ),
                            ],
                            decoration: InputDecoration(
                              labelText: "Search by name",
                              labelStyle: TextStyle(color: Colors.black),
                              prefixIcon: Icon(
                                Icons.search,
                                color: Colors.black,
                              ),

                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(32),
                                borderSide: BorderSide(color: Colors.green),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(32),
                              ),
                            ),
                            onChanged: (_) => setState(() {}),
                          ),
                        ),

                        SizedBox(width: 10),

                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                          ),
                          onPressed: () {
                            _searchStudent();
                            showUndo = false;
                            list.sortByGradeDesc();
                            searchCtrl.clear();
                          },
                          child: Text("Search"),
                        ),
                      ],
                    ),
                  ),

                  TextFormField(
                    controller: nameCtrl,
                    decoration: InputDecoration(
                      fillColor: Colors.grey.shade300,
                      filled: true,
                      labelText: "Name",
                      labelStyle: TextStyle(color: Colors.black),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32),
                        borderSide: BorderSide(color: Colors.green),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32),
                      ),
                    ),
                    keyboardType: TextInputType.name,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]')),
                    ],
                    validator: (value) {
                      if (value == null || value.isEmpty) return "Enter name";
                      return null;
                    },
                  ),
                  const SizedBox(height: 6),
                  TextFormField(
                    controller: gradeCtrl,
                    decoration: InputDecoration(
                      fillColor: Colors.grey.shade300,
                      filled: true,
                      labelText: "Grade",
                      labelStyle: TextStyle(color: Colors.black),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32),
                        borderSide: BorderSide(color: Colors.green),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    validator: (value) {
                      if (value == null || value.isEmpty) return "Enter grade";
                      if (int.tryParse(value) == null) {
                        return "Enter a valid number";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 6),
                  TextFormField(
                    controller: ageCtrl,
                    decoration: InputDecoration(
                      fillColor: Colors.grey.shade300,
                      filled: true,
                      labelText: "Age",
                      labelStyle: TextStyle(color: Colors.black),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32),
                        borderSide: BorderSide(color: Colors.green),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    validator: (value) {
                      if (value == null || value.isEmpty) return "Enter age";
                      if (int.tryParse(value) == null) {
                        return "Enter a valid number";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 6),
                  TextFormField(
                    controller: idCtrl,
                    decoration: InputDecoration(
                      fillColor: Colors.grey.shade300,
                      filled: true,
                      labelText: "ID",
                      labelStyle: TextStyle(color: Colors.black),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32),
                        borderSide: BorderSide(color: Colors.green),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    validator: (value) {
                      if (value == null || value.isEmpty) return "Enter ID";
                      if (int.tryParse(value) == null) {
                        return "Enter a valid number";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () async {
                      if (formkey.currentState!.validate()) {
                        Student newStudent = Student(
                          name: nameCtrl.text,
                          grade: int.parse(gradeCtrl.text),
                          age: int.parse(ageCtrl.text),
                          id: int.parse(idCtrl.text),
                        );
                        if (selectedStudent == null) {
                          // -------- Add Student --------
                          list.add(newStudent);
                          list.sortByGradeDesc();
                          stack.push(newStudent);
                          //queue.enqueue(newStudent);
                          studentsBox.add(newStudent); // safe in Hive
                        } else {
                          // -------- Update Student --------
                          newStudent.id = selectedStudent!.id;
                          list.update(selectedStudent!.id, newStudent);
                          await updateInHive(newStudent);
                          selectedStudent = null;
                          list.sortByGradeDesc();
                        }
                        showUndo = true;
                        // Clear
                        nameCtrl.clear();
                        gradeCtrl.clear();
                        ageCtrl.clear();
                        idCtrl.clear();
                        searchCtrl.clear();
                        setState(() {});
                      }
                    },
                    child: Text(selectedStudent == null ? "Add" : "Update"),
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      if (!stack.isEmpty() || studentsBox.isNotEmpty)
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                          ),
                          onPressed: () {
                            final lastIndex = studentsBox.length - 1;
                            final lastStudent = studentsBox.getAt(lastIndex);

                            if (lastStudent != null) {
                              // 2️⃣ احذفه من LinkedList
                              list.delete(lastStudent.id);

                              // 3️⃣ احذفه من Hive
                              studentsBox.deleteAt(lastIndex);

                              list.sortByGradeDesc();
                              setState(() {});
                            }
                          },
                          child: Text("Undo"),
                        ),
                      if (!queue.isEmpty() || studentsBox.isNotEmpty)
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                            foregroundColor: Colors.white,
                          ),
                          onPressed: () {
                            // 1️⃣ احصل على أول عنصر اتضاف (أول عنصر في Hive)
                            final firstStudent = studentsBox.getAt(0);

                            if (firstStudent != null) {
                              // 2️⃣ احذفه من LinkedList
                              list.delete(firstStudent.id);

                              // 3️⃣ احذفه من Hive
                              studentsBox.deleteAt(0);

                              // 4️⃣ رتب القائمة حسب الدرجة
                              list.sortByGradeDesc();
                              setState(() {});
                            }
                          },
                          child: Text("Dequeue"),
                        ),
                    ],
                  ),

                  SizedBox(height: 10),
                  Text(
                    "Students:",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    itemCount: list.getAll().length,
                    itemBuilder: (context, index) {
                      final student = list.getAll()[index];
                      return ListTile(
                        onTap: () {
                          selectedStudent = student;

                          nameCtrl.text = student.name;
                          gradeCtrl.text = student.grade.toString();
                          ageCtrl.text = student.age.toString();
                          idCtrl.text = student.id.toString();
                          showUndo = false;
                          setState(() {});
                        },

                        title: Text(
                          "${student.name} -- Grade: ${student.grade}",
                        ),
                        subtitle: Text(
                          "Age: ${student.age} || ID: ${student.id}",
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            list.delete(student.id);
                            deleteFromHive(student.id);
                            list.sortByGradeDesc();
                            setState(() {});
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _searchStudent() {
    String name = searchCtrl.text.trim();

    if (name.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Enter a name to search")));
      return;
    }

    Student? result = list.searchByName(name);

    if (result != null) {
      // رجّع البيانات إلى TextFields
      nameCtrl.text = result.name;
      gradeCtrl.text = result.grade.toString();
      ageCtrl.text = result.age.toString();
      idCtrl.text = result.id.toString();
      selectedStudent = result;
      setState(() {});
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Student found")));
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Student not found")));
    }
  }

  void deleteFromHive(int id) async {
    var box = Hive.box<Student>("studentBox");

    // search student in hive
    final index = box.values.toList().indexWhere((student) => student.id == id);
    // find student , delete
    if (index != -1) {
      await box.deleteAt(index);
    }
  }

  Future<void> updateInHive(Student updated) async {
    var box = Hive.box<Student>("studentBox");

    final index = box.values.toList().indexWhere(
      (student) => student.id == updated.id,
    );

    if (index != -1) {
      await box.putAt(index, updated);
    }
  }
}
