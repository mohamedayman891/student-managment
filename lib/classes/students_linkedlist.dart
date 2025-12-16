import 'package:project_data/classes/students_data.dart';

class Node {
  Student student;
  Node? next;

  Node(this.student);
}

class StudentLinkedList {
  Node? head;

  // Add student at the list
  void add(Student s) {
    Node newNode = Node(s);
    if (head == null) {
      head = newNode;
    } else {
      Node current = head!;
      while (current.next != null) {
        current = current.next!;
      }
      current.next = newNode;
    }
  }

  void update(int id, Student newStudent) {
    Node? prev;
    Node? current = head;

    while (current != null) {
      if (current.student.id == id) {
        // تحديث بيانات الطالب
        current.student.name = newStudent.name;
        current.student.grade = newStudent.grade;
        current.student.age = newStudent.age;
        current.student.id = newStudent.id;

        // لو الترتيب يحتاج تغيير
        if ((prev != null && prev.student.grade < current.student.grade) ||
            prev == null && head!.student.grade < current.student.grade) {
          // إزالة Node الحالي من مكانه
          if (prev != null) {
            prev.next = current.next;
          } else {
            head = current.next;
          }

          // إعادة إدخاله في المكان الصحيح
          insertSortedNode(current);
        }

        return;
      }
      prev = current;
      current = current.next;
    }
  }

  void insertSortedNode(Node node) {
    if (head == null || head!.student.grade < node.student.grade) {
      node.next = head;
      head = node;
      // return;
    }

    Node? current = head;
    while (current!.next != null &&
        current.next!.student.grade >= node.student.grade) {
      current = current.next;
    }
    node.next = current.next;
    current.next = node;
  }

  // Delete student by ID
  bool delete(int id) {
    if (head == null) return false;

    if (head!.student.id == id) {
      head = head!.next;
      return true;
    }

    Node? current = head;
    while (current!.next != null) {
      if (current.next!.student.id == id) {
        current.next = current.next!.next;
        return true;
      }
      current = current.next;
    }
    return false;
  }

  //Linear Search student by name
  Student? searchByName(String name) {
    Node? current = head;
    while (current != null) {
      if (current.student.name.toLowerCase() == name.toLowerCase()) {
        return current.student;
      }
      current = current.next;
    }
    return null;
  }

  // --- SORTING(Bubble) BY GRADE (Descending) ---
  void sortByGradeDesc() {
    if (head == null || head!.next == null) return;

    bool swapped;
    do {
      swapped = false;
      Node? current = head;
      while (current!.next != null) {
        if (current.student.grade < current.next!.student.grade) {
          // Swap
          Student temp = current.student;
          current.student = current.next!.student;
          current.next!.student = temp;
          swapped = true;
        }
        current = current.next;
      }
    } while (swapped);
  }

  // Get all students as List
  List<Student> getAll() {
    // note array is List in dart
    List<Student> list = [];
    Node? current = head;
    while (current != null) {
      list.add(current.student);
      current = current.next;
    }
    return list;
  }
}
