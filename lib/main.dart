import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notepad/dataView.dart';
import 'package:notepad/profile/const.dart';
import 'package:notepad/profile/data_show.dart';
import 'package:notepad/profile/profile.dart';

void main() async {
  //to initialize first before ui coming

  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox("note_box");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(scaffoldBackgroundColor: Color(0xFF808080)),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    _refreshItem();
  }

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  List<Map<String, dynamic>> _items = [];

  //reference
  final _noteBox = Hive.box("note_box");

  void _refreshItem() {
    final data = _noteBox.keys.map((key) {
      final item = _noteBox.get(key);

      return {
        "key": key,
        "name": item["name"],
        "description": item["description"]
      };
    }).toList();

    setState(() {
      _items = data.reversed.toList();
    });
  }

  Future<void> _createItem(Map<String, dynamic> newItem) async {
    await _noteBox.add((newItem));
    _refreshItem();
  }

  Future<void> _updateItem(int itemKey, Map<String, dynamic> item) async {
    await _noteBox.put(itemKey, item);
    _refreshItem();
  }

  Future<void> _deleteItem(int itemKey) async {
    await _noteBox.delete(itemKey);
    _refreshItem();

    //display a snackbar

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("An item has been deleted!")));
  }

  void _showForm(BuildContext ctx, int? itemKey) async {
    if (itemKey != null) {
      final existingItem =
          _items.firstWhere((element) => element["key"] == itemKey);
      _nameController.text = existingItem['name'];
      _descriptionController.text = existingItem['description'];
    }

    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: ctx,
      elevation: 5,
      isScrollControlled: true,
      builder: (_) => Container(
        decoration: BoxDecoration(
          color: Color(0xff808080),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(ctx).viewInsets.bottom,
            top: 15,
            left: 15,
            right: 15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                hintText: "Title",
                labelText: "Title",
                labelStyle: TextStyle(color: Color(0xffffA8B2D1)),
                border: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Color(0xffffA8B2D1), width: 2.0),
                  borderRadius: BorderRadius.circular(25.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  borderSide: BorderSide(width: 2.0, color: Color(0xffffA8B2D1)),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(
                fillColor: Color(0xffffA8B2D1),
                border: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Color(0xffffA8B2D1), width: 2.0),
                  borderRadius: BorderRadius.circular(25.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  borderSide: BorderSide(width: 2.0, color: Color(0xffffA8B2D1)),
                ),
                hintText: "Description",
                labelText: "Description",
                labelStyle: TextStyle(color: Color(0xffffA8B2D1)),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Color(0xffffA8B2D1))),
                  backgroundColor: Color(0xff808080),
                  foregroundColor: Color(0xffffA8B2D1)),
              onPressed: () async {
                if (itemKey == null) {
                  _createItem({
                    "name": _nameController.text,
                    "description": _descriptionController.text,
                  });
                }

                if (itemKey != null) {
                  _updateItem(itemKey, {
                    "name": _nameController.text.trim(),
                    "description": _descriptionController.text.trim(),
                  });
                }

                //clear text
                _nameController.text = "";
                _descriptionController.text = "";
//close bottom sheet
                Navigator.of(context).pop();
              },
              child: Text(itemKey == null ? "Create New" : "Update"),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfilePage()),
                );
              },
              icon: Icon(Icons.info_outlined,color: Color(0xffffA8B2D1),),
            ),
          ),
        ],
        systemOverlayStyle: SystemUiOverlayStyle(
          // Status bar color
          statusBarColor: Color(0xff808080),

          // Status bar brightness (optional)
          statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
          statusBarBrightness: Brightness.light, // For iOS (dark icons)
        ),
        backgroundColor: Color(0xff808080),
        title: Text(
          "Note Pad",
          style: myStyle(24, Color(0xffffA8B2D1),FontWeight.bold),
        ),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xff808080),
        child: Icon(Icons.add,color: Color(0xffffA8B2D1),size: 40,),
        onPressed: () => _showForm(context, null),
      ),
      body: ListView.builder(
          itemCount: _items.length,
          itemBuilder: (_, index) {
            final currentItem = _items[index];

            return Card(
              //color: Colors.orange.shade100,
              color: Color(0xff808080),
              margin: EdgeInsets.all(10),
              elevation: 3,
              child: ListTile(
                title: Text(currentItem['name']),
                subtitle: Text(
                  currentItem['description'.toString()],
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () {
                        _showForm(context, currentItem['key']);
                      },
                      icon: Icon(Icons.edit),
                    ),
                    IconButton(
                      onPressed: () {
                        _deleteItem(currentItem['key']);
                      },
                      icon: Icon(Icons.delete),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
