import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:ssj/api/get/goldschemedata.dart';
import 'package:ssj/util/constant.dart';
import 'package:http/http.dart' as http;

class DropDown extends StatefulWidget {
  const DropDown({super.key});

  @override
  State<DropDown> createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  List<String> items = ["Select Scheme Amount"];
  String? selectedItem = "Select Scheme Amount";

  Future<GoldSchemes>? _goldSchemes;

  Future<GoldSchemes> fetchGoldScheme() async {
    final response =
        await http.get(Uri.parse('$BASEURL/public/api/goldschemes'));

    if (response.statusCode == 200) {
      final goldSchemes = GoldSchemes.fromJson(jsonDecode(response.body));

      // Extract scheme amounts
      for (var scheme in goldSchemes.data) {
        for (var amount in scheme.schemeAmount) {
          if (scheme.id == 3) {
            //items.add(scheme.toString());
            items.add(amount.toString());
          }
        }
      }

      return goldSchemes;
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  void initState() {
    _goldSchemes = fetchGoldScheme();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              height: 200,
            ),
            Text(items.toString()),
            FutureBuilder<GoldSchemes>(
              future: _goldSchemes,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return Center(
                    child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        fillColor: Color(0xFFF5F5F5),
                        filled: true,
                      ),
                      value: selectedItem,
                      items: items
                          .map((item) => DropdownMenuItem<String>(
                                value: item,
                                child:
                                    Text(item, style: TextStyle(fontSize: 15)),
                              ))
                          .toList(),
                      onChanged: (item) => setState(() => selectedItem = item),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(
    MaterialApp(
      home: DropDown(),
    ),
  );
}
