import 'dart:io'; // Import library untuk input/output
import 'color.dart' as color;
import 'dart:async';

class Node {
  String?
      data; // Data yang disimpan dalam node, nullable untuk keamanan jika tidak ada data
  Node? next; // Pointer ke node berikutnya, juga nullable

  Node(this.data); // Constructor untuk inisialisasi node dengan data
}

Future<void> delay(int milliseconds) async {
  await Future.delayed(Duration(milliseconds: milliseconds));
}

void moveTo(int row, int col) {
  stdout.write('\x1B[${row};${col}H');
}

List<int> getScreenSize() {
  return [stdout.terminalColumns, stdout.terminalLines];
}

void clearLine(int row) {
  moveTo(row, 1); // Move to the beginning of the line
  stdout.write('\x1B[K'); // Clear the line
}

void clearScreen() {
  print("\x1B[2J\x1B[0;0H"); // clear entire screen, move cursor to 0;0
}

// Fungsi untuk traversing dan mencetak seluruh linked list
void traverseAndPrint(Node head) {
  int i = 1;
  Node? currentNode = head; // Mulai dari head (node pertama)
  while (currentNode != null) {
    stdout.write('${i}. ${currentNode.data}\n'); // Print data tiap node
    currentNode = currentNode.next; // Lanjut ke node berikutnya
    i++;
  }
}

// Fungsi untuk memasukkan node baru ke posisi tertentu
Node insertNodeAtPosition(Node head, Node newNode, int position) {
  // Jika posisi yang dimasukkan adalah pertama (head), update newNode menjadi head
  if (position == 1) {
    newNode.next = head;
    return newNode;
  }

  // Mulai dari head untuk mencari posisi yang diinginkan
  Node? currentNode = head;
  int i = 1;
  if (position != 0) {
    while (currentNode!.next != null && i < position - 1) {
      currentNode = currentNode.next; // Traverse ke posisi sebelumnya
      i++;
    }
  } else {
    while (currentNode!.next != null) {
      currentNode = currentNode.next; // Traverse ke posisi sebelumnya
      i++;
    }
  }

  // Sisipkan node baru di posisi yang ditarget
  newNode.next = currentNode.next;
  currentNode.next = newNode;

  return head; // Mengembalikan head yang baru
}

// Fungsi untuk menukar node pada posisi tertentu
Node swapNode(Node head, int pos1, int pos2) {
  if (pos1 == pos2)
    return head; // Jika posisi yang ditukar sama, tidak perlu swap

  // Mencari node pada posisi pos1
  Node? prevNode1 = null;
  Node? node1 = head;
  int i = 1;
  while (node1 != null && i < pos1) {
    prevNode1 = node1;
    node1 = node1.next;
    i++;
  }

  // Mencari node pada posisi pos2
  Node? prevNode2 = null;
  Node? node2 = head;
  i = 1;
  while (node2 != null && i < pos2) {
    prevNode2 = node2;
    node2 = node2.next;
    i++;
  }

  // Jika node1 atau node2 tidak ditemukan, kembalikan head
  if (node1 == null || node2 == null) return head;

  // Jika node1 tidak ada di posisi head, hubungkan node2 dengan node sebelum node1
  if (prevNode1 != null) {
    prevNode1.next = node2;
  } else {
    head = node2;
  }

  // Jika node2 tidak ada di posisi head, hubungkan node1 dengan node sebelum node2
  if (prevNode2 != null) {
    prevNode2.next = node1;
  } else {
    head = node1;
  }

  // Swap next pointers dari node1 dan node2
  Node? temp = node1.next;
  node1.next = node2.next;
  node2.next = temp;

  return head; // Mengembalikan head yang baru setelah swap
}

// Fungsi untuk menghapus node pada posisi tertentu
Node deleteNode(Node head, int position) {
  if (position == 1) {
    return head.next ??
        head; // Mengembalikan head baru setelah menghapus node pertama
  }

  // Mencari node pada posisi yang ingin dihapus
  Node? currentNode = head;
  Node? prevNode = null;
  int i = 1;
  while (currentNode != null && i < position) {
    prevNode = currentNode;
    currentNode = currentNode.next;
    i++;
  }

  // Jika node yang ingin dihapus ditemukan, hubungkan node sebelumnya dengan node setelahnya
  if (currentNode != null && prevNode != null) {
    prevNode.next = currentNode.next;
  }

  return head; // Mengembalikan head yang baru setelah menghapus node
}

Node activateLoop(Node head) {
  Node? currentNode = head;
  while (currentNode!.next != null) {
    currentNode = currentNode.next;
  }
  currentNode.next = head;
  return head;
}

// Fungsi untuk membuat linked list dari nama pengguna
Node createLinkedListFromName(String name) {
  Node head = Node(name[0].toString());
  for (int i = 1; i < name.length; i++) {
    insertNodeAtPosition(
        head, Node(name[i].toString()), i + 1); // Insert after the first node
  }
  activateLoop(head);
  return head;
}

Node? getNext(Node node) {
  return node.next;
}

void main() async {
  // Prompt user for their name
  stdout.write('Enter your name: ');
  String name = stdin.readLineSync()!;

  Node head = createLinkedListFromName(name);
  clearScreen();

  // Prompt user for the number of lines
  stdout.write('Enter the number of lines to display: ');
  int numLines = int.parse(stdin.readLineSync()!);

  String selectedColor = color.RESET;
  while (true) {
    Node? node = head;
    stdout.write(selectedColor);

    for (int j = 1; j <= numLines; j++) {
      // Use user-defined number of lines
      clearLine(j); // Clear the current line before writing new content
      if (j % 2 != 0) {
        for (int i = 1; i <= getScreenSize()[0]; i++) {
          moveTo(j, i);
          stdout.write(node!.data);
          node = getNext(node)!;
          await delay(15);
        }
      } else {
        for (int i = getScreenSize()[0]; i > 0; i--) {
          moveTo(j, i);
          stdout.write(node!.data);
          node = getNext(node)!;
          await delay(15);
        }
      }
    }
    selectedColor = color.getRandomColor(selectedColor);
  }
}
