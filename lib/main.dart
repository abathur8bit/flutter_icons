import 'package:flutter/material.dart';
import "icon_info.dart";

void main() {
  runApp(MyApp());
}

class SearchField extends StatelessWidget {
  final String label;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final double radius = 25;
  const SearchField({Key? key,required this.label,this.controller,this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0.0),
        child: TextField(
            onChanged: onChanged,
            controller: controller,
            decoration: InputDecoration(
                suffixIcon: const Icon(Icons.search),
                labelText: label,
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(radius),borderSide: BorderSide(color: Colors.grey.shade400)),
                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(radius),borderSide: const BorderSide(color: Colors.black)),
                fillColor: Colors.white,
                filled: false)));
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,   //show debug label at top right corner
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: IconGrid(),
    );
  }
}

class IconGrid extends StatefulWidget {
  @override
  IconGridState createState() => IconGridState();
}

class IconGridState extends State<IconGrid> {
  List icons = iconList;
  final TextEditingController controller = TextEditingController();

  void searchIcon(String query) {
    final result = iconList.where((icon) {
      final name = icon.name.toString().toLowerCase();
      final input = query.toLowerCase();
      return name.contains(input);
    }).toList();                      //create a new list of books based on name filter
    setState(() => icons = result);   // set our list to the new set of books
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body:Padding(padding:EdgeInsets.all(16.0),child:Column(children:<Widget>[
        SearchField(label: "Search icons",onChanged: searchIcon,controller: controller,),                 //custom text field
        Expanded(child:
          GridView.count(crossAxisCount: 24,
              children: List<Widget>.generate(icons.length,(i) => iconTileTiny(icons[i]))
          )
        )
      ])));
  }

  Widget iconTileTiny(IconInfo icon) {
    return IconButton(tooltip:icon.name,onPressed: () => iconPressed(icon),icon:icon.icon);
  }

  Widget iconTile(IconInfo icon) {
    // return IconButton(onPressed: () => iconPressed(icon),icon:icon.icon);
    return Padding(padding:EdgeInsets.all(5),child:
    Container(
      child: IconButton(tooltip:icon.name,onPressed: () => iconPressed(icon),icon:icon.icon),
      // decoration: BoxDecoration(
      //     color:Colors.black,
        // borderRadius: BorderRadius.circular(10),
        // border: Border.all(width:1)
      // )
    ));
  }

  void iconPressed(IconInfo icon) {
    setState(() {
      controller.text = icon.name;
    });
  }
}

